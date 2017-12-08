Received: from eggs.gnu.org ([2001:4830:134:3::10]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eNJt6-0003F8-NM
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eNJt3-0000Zo-JZ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:44:28 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eNJt3-0000ZT-Bx
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:44:25 -0500
Received: by mail-wm0-x236.google.com with SMTP id f206so3531000wmf.5
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 06:44:24 -0800 (PST)
References: <20171206152845.8215-1-alex.bennee@linaro.org>
	<CAFEAcA_o2F8fSmKYxgd5ueVxuQksxWu2hKrMd7529QTW=moUig@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_o2F8fSmKYxgd5ueVxuQksxWu2hKrMd7529QTW=moUig@mail.gmail.com>
Date: Fri, 08 Dec 2017 14:44:22 +0000
Message-ID: <87wp1xqny1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.11] target/sh4/translate.c: fix TCG
 leak during gusa sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 6 December 2017 at 15:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> This fixes bug #1735384 while running java under qemu-sh4. When debug
>> was enabled it showed a problem with TCG temps. Once fixed I was able
>> to run java -version normally.
>>
>
> I don't think this merits holding up 2.11, which has already
> had what I hope is its final release candidate.

Fair enough.

Aurelien,

Are you going to pick this patch up via your tree for the post-release fixe=
s?

--
Alex Benn=C3=A9e
