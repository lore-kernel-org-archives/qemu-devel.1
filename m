Received: from eggs.gnu.org ([2001:4830:134:3::10]:38775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopB5-0004OV-IZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopB4-0003Ka-Lv
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:36:43 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:43116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eopB4-0003KD-GG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:36:42 -0500
Received: by mail-ot0-x22a.google.com with SMTP id q12so4318293otg.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 03:36:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 11:36:21 +0000
Message-ID: <CAFEAcA81znRMb_iV2jx4488CYuv=HGijZnkTpcDcGA2-LvWaWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 February 2018 at 11:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> The following changes since commit a6e0344fa0e09413324835ae122c4cadd78902=
31:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-requ=
est' into staging (2018-02-20 14:05:00 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-softfloat-refactor-210218=
-1
>
> for you to fetch changes up to c13bb2da9eedfbc5886c8048df1bc1114b285fb0:
>
>   fpu/softfloat: re-factor sqrt (2018-02-21 10:21:54 +0000)
>
> ----------------------------------------------------------------
> This is the re-factor of softfloat:
>
>   - shared common code path float16/32/64
>   - well commented and easy to follow code
>   - added a bunch of float16 support
>
> While some operations are slower the key ones exercised by the
> floating point dbt-bench are the same: https://i.imgur.com/oXNJNql.png

Applied, thanks.

-- PMM
