Received: from eggs.gnu.org ([2001:4830:134:3::10]:37637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK6ZL-0005uA-HB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK6ZD-0002sX-Rz
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:59:13 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK6ZB-00025C-BL
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:59:10 -0500
Received: by mail-oi1-x241.google.com with SMTP id j202-v6so11659332oih.10
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 10:59:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <12974ebb-09de-c6e9-1dd7-5199a8ae6b05@redhat.com>
References: <1541528230-31817-1-git-send-email-thuth@redhat.com>
	<c0febf9a-f098-112d-9c8d-c320cc66b04a@redhat.com>
	<12974ebb-09de-c6e9-1dd7-5199a8ae6b05@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 18:58:44 +0000
Message-ID: <CAFEAcA-B74FQgj3COyGZ_SAAvSUA6=OaLdy5--NoAgHgEGZkpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for the 'collie'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2018 at 18:52, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-11-06 19:49, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/11/18 19:17, Thomas Huth wrote:
>>> There is no active maintainer, but since Peter is picking up
>>> patches via qemu-arm@nongnu.org, I think we could at least use
>>> "Odd Fixes" as status here.
>>
>> This looks more as "Orphan" to me...
>
> I'll leave it up to Peter for the final decision...

I think we're not very consistent[*] in our usage of the various
statuses in the MAINTAINERS file. I guess "Odd Fixes" makes
sense in that, well, if you send a patch to this
code and cc me I'll review it and put it in the tree. (This
is true of any of the arm boards we have.)

[*] We have one thing tagged Orphan, which is bsd-user/,
and some things tagged Odd Fixes with no listed maintainer,
and some things tagged Odd Fixes which are in practice more
like Orphan (for instance sh4), and we list "fpu/" as
Odd Fixes despite having given it a pretty thorough
overhaul very recently, and so on...

If you wanted a mechanizable rule, you could try something
like "every file which is in status Odd Fixes or better
must list with M: at least one named individual who has
submitted a pull request in the last nine months" :-)

thanks
-- PMM
