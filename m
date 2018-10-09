Received: from eggs.gnu.org ([2001:4830:134:3::10]:37350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9r9d-0004Se-BN
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9r9Z-0007B6-Oz
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:30:23 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:43863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9r9Z-0007Ah-C0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:30:21 -0400
Received: by mail-ot1-x32a.google.com with SMTP id k9so1378946otl.10
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 05:30:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9c3mhox.fsf@linaro.org>
References: <20181008152059.17503-1-alex.bennee@linaro.org>
	<CAAdtpL7gSaza9RVY4f_e4NbXCC+J1YKiR0AS4TRExgiTauw0kQ@mail.gmail.com>
	<87o9c3mhox.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 13:29:59 +0100
Message-ID: <CAFEAcA8AopmZhRE2JQiHUo9whbsnr3KeJK+=+ZZ1Tkva-a47+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .travis.yml: split MacOSX builds and
 reduce target list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 9 October 2018 at 13:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>> I'd also add another entry with --enable-user.
>
> Ohh, does MacOSX use the bsd-user machinery?

No. It used to have its own darwin-user, but we removed
that some years ago because it was unmaintained and broken.

thanks
-- PMM
