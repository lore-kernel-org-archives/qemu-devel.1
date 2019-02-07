Received: from eggs.gnu.org ([209.51.188.92]:55245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grk80-0005Sj-48
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grk7z-0003NW-BQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:54:08 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:43997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grk7z-0003N8-6y
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:54:07 -0500
Received: by mail-ot1-x330.google.com with SMTP id a11so18235931otr.10
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 05:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
	<20190207132935.ijtfsiafpfggugiz@function>
	<CAJ+F1CLc0kK30ZVOkksfSBNTbooYGv-Pf1AYwKAntVB4-QUiYQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLc0kK30ZVOkksfSBNTbooYGv-Pf1AYwKAntVB4-QUiYQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 13:53:55 +0000
Message-ID: <CAFEAcA-T95DTfW=DRSnf8jpBCjECUM4OStUak5SPaer2JwsU0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv3 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 7 Feb 2019 at 13:53, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> I am also unable to reproduce yet. Any hint on how to reproduce?
>
> I wonder if this is related to __USE_MINGW_ANSI_STDIO somehow (could
> be, although glib doesn't use the same functions, the compiler might
> not know the difference)

I do the windows builds using the https://mxe.cc/ cross tools and
libs.

thanks
-- PMM
