Received: from eggs.gnu.org ([209.51.188.92]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEydl-00031F-6G
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEydk-0000Ha-C5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:02:57 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEydk-0000HC-6g
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:02:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id k21so8854334otf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190412152619.23542-1-thuth@redhat.com>
In-Reply-To: <20190412152619.23542-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 17:02:43 +0100
Message-ID: <CAFEAcA9kXdUH3vkGLfEe+CFuD=S9XFEaWGNETre7gYOx5epFpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>

On Fri, 12 Apr 2019 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>
> These machines depend on the deprecated bluetooth subsystem. In case we
> finally decide to remove the bluetooth subsystem, we likely need to
> remove the n800 and n810 machines, too, so mark them now as deprecated.

...we could just remove the bluetooth devices from the boards?

thanks
-- PMM
