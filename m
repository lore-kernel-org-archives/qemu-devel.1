Received: from eggs.gnu.org ([209.51.188.92]:36008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gp8xp-0003ab-1W
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gp8xm-0006gt-88
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:48:50 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gp8xm-0006f5-2I
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:48:50 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so2264299oth.7
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 01:48:49 -0800 (PST)
MIME-Version: 1.0
References: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
	<1544173675-14217-3-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9mF+WiPLW4yyv1aEMLTg2QK2krZvxyjCSsMziJtzx3Ug@mail.gmail.com>
	<CAHmQWvCw5ndod93WqLXDgGxDERtRM3ee_qiLA+S34Y9X2JFvVQ@mail.gmail.com>
	<CAFEAcA_+UhU56D7Yx5K8+=DbtUiiV8V7sX2UgxFKSkScUypxFg@mail.gmail.com>
	<20190130092321.1ddbd29a@Igors-MacBook-Pro.local>
In-Reply-To: <20190130092321.1ddbd29a@Igors-MacBook-Pro.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 09:48:37 +0000
Message-ID: <CAFEAcA_i0dXNUfzKGBgn=riupWtBa=pGYYtY8LUqHdrf6YzbvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] hw/arm: add Arm SBSA reference
 machine, devices part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Wed, 30 Jan 2019 at 08:23, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 29 Jan 2019 15:26:29 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Oh, I see now. I think this is a bug in boot.c and we should
> > fix it by making the "this is a firmware boot" code path also
> > do the arm_load_dtb() call. I'll send a patch.
> pls, CC me on it as well.
>
> I'm interested in it from hotplug + reboot perspective,
> where we have a changed/bigger DTB on reboot as it contains new devices (cpus|memory)
>
> loading rom like now doesn't work nice in case of reboot.

OK, but I don't think it will help you there, because all it
does (after a pile of refactoring) is make the firmware-boot
code path go through the if() clause at the bottom of
arm_load_kernel() that calls arm_load_dtb().

thanks
-- PMM
