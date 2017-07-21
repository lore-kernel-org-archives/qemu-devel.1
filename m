Received: from eggs.gnu.org ([2001:4830:134:3::10]:41379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYTja-0004T7-7U
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYTjX-0006Fg-5c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:56:30 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:37425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYTjW-0006Eo-Uk
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:56:27 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 33so23234613wrz.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 01:56:26 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-4-alex.bennee@linaro.org>
	<d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
	<1ff55ec6-b8e5-8696-7472-0ac22073ddf4@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1ff55ec6-b8e5-8696-7472-0ac22073ddf4@redhat.com>
Date: Fri, 21 Jul 2017 09:56:23 +0100
Message-ID: <87ziby6udk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 03/23] softfloat3c: dos2unix
 all files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Thomas Huth <thuth@redhat.com> writes:

> On 20.07.2017 20:59, Richard Henderson wrote:
>> On 07/20/2017 05:04 AM, Alex Bennée wrote:
>>> This is a massive but mechanical patch, the result of:
>>>
>>>    (cd fpu/softfloat3c; and find . | xargs dos2unix)
>>>    (cd include/fpu/softfloat3c; and dos2unix *)
>>>
>>> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
>>> ---
>>
>> Really shouldn't this have been part of the import?
>
> +1
> It's only a whitespace change, so please squash it in the previous patch
> instead. (You could mention this in the patch description that line
> endings have been changed to unix mode)

Sure - I just wanted to be clear of the steps I took should I want to do
it from scratch again.

One thing playing in my mind against moving to SoftFloat3c is the
inscrutability of the upstream. It's nice there has been a new release
with new features but there isn't a source repository or as far as I can
tell a development list. It is basically as far as I can tell a one man
project albeit backed by academic funding.

That said the license change in 3 does mean it would be a lot easier to
incorporate fixes and updates if and when upstream release new versions.

--
Alex Bennée
