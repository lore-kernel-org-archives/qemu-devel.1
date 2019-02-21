Received: from eggs.gnu.org ([209.51.188.92]:44742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwl3L-0007Dr-Tf
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwkoo-0006nk-QS
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:39:03 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwkoo-0006jk-Kw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:39:02 -0500
Received: by mail-ot1-x343.google.com with SMTP id n8so44360653otl.6
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 01:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org> <87sgwh5wef.fsf@dusky.pond.sub.org>
In-Reply-To: <87sgwh5wef.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 09:38:37 +0000
Message-ID: <CAFEAcA8gHp-VD05x9Q1V3_K29wsMeZD1SdM+PDteOXcAE3QHwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/10] pflash: Macro PFLASH_BUG() is used
 just once, expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On Thu, 21 Feb 2019 at 09:22, Markus Armbruster <armbru@redhat.com> wrote:
> Double-checking... you want me to keep goto reset_flash, like this:
>
> @@ -623,8 +617,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>                  pfl->wcycle = 0;
>                  pfl->status |= 0x80;
>              } else {
> -                DPRINTF("%s: unknown command for \"write block\"\n", __func__);
> -                PFLASH_BUG("Write block confirm");
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "unknown command for \"write block\"\n");
>                  goto reset_flash;
>              }
>              break;

Yes. (We seem to handle most kinds of guest errors in programming
the flash by reset_flash.)

thanks
-- PMM
