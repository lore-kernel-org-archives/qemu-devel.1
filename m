Received: from eggs.gnu.org ([2001:4830:134:3::10]:39608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXNwB-0005pd-PU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXNw6-0001Y9-Tz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:32:59 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXNw6-0001Xl-Mp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:32:54 -0400
Received: by mail-wr0-x232.google.com with SMTP id a10so18419400wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:32:54 -0700 (PDT)
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170717230025.GD2585@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170717230025.GD2585@lemon>
Date: Tue, 18 Jul 2017 09:32:51 +0100
Message-ID: <87d18y87rg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 00/23] Current Travis Queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Mon, 07/17 15:48, Alex Bennée wrote:
>> Hi,
>>
>> This is the current status of the travis/next patch queue. The
>> includes updates from Paolo to allow parallelism while testing in the
>> docker environment. I've extended the travis image so we can actually
>> run our travis.py script in the Travis image.
>>
>> There are also a number of updates from Phillipe which add a bunch of
>> additional cross compile targets to our shippable setup. The cachinfo
>> patch is temporary and won't make the pull as it is already queued in
>> Richard's tcg-next.
>>
>> I'm currently trying to catch one of our Travis hangs in the act
>> (postcopy-test) but it seems to be very much a heavy load race
>> condition which annoyingly stops happening once you try and get
>> debugging tools on it. This is the reason I've updated the travis
>> docker image to include the debug tools ;-)
>>
>> As long as there are no screams of outrage I'll roll a pullreq for
>> softfreeze tomorrow.
>
> Renaming of debian to debian9 seems backward incompatible. We don't care that
> much, but I'd like to see a commit message justifying the change. Otherwise it
> looks good to go (minus the cachinfo patch, of course).

Well originally we were basing off debian-stable but we got caught out
by the new release. With this series we have most things off the latest
stable (Debian 9 - aka Stretch) but one or two builds are based of old
stable (Debian 8 - aka Jessie) and using the embedian hacks we had
before.

I think for this it's mostly a matter of clarity.

--
Alex Bennée
