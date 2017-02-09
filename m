Received: from eggs.gnu.org ([2001:4830:134:3::10]:44407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cblUF-0006Q4-6e
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cblUE-0002qN-MF
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:57:59 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cblUE-0002qD-Cp
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:57:58 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v186so75211196wmd.0
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 01:57:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Feb 2017 09:57:36 +0000
Message-ID: <CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 9 February 2017 at 09:42, Andrew Jones <drjones@redhat.com> wrote:
> I see Peter and you are discussing what to document here. IMO,
> we should simply state -nodefaults provides us a base mach-virt
> board with no peripherals.

The thing about saying that is that it's not actually
correct -- you get the UART, etc etc peripherals whether
you say -nodefaults or not. I agree that listing them
in multiple places isn't a good idea though. Maybe
there's some wording that will work here.

thanks
-- PMM
