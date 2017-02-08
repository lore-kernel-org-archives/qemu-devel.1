Received: from eggs.gnu.org ([2001:4830:134:3::10]:50733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbY6v-0000xs-58
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbY6u-0002xu-Fn
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:41:01 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbY6u-0002x7-9g
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:41:00 -0500
Received: by mail-wm0-x233.google.com with SMTP id c85so210372655wmi.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 11:41:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c88bca35-58b1-1df3-116f-3a1786376ca8@redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
	<c88bca35-58b1-1df3-116f-3a1786376ca8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Feb 2017 19:40:38 +0000
Message-ID: <CAFEAcA_4kLzOR_a2+Oj=tfZ4cjk77Gm3MXDjXhUzrDePVmkezg@mail.gmail.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Andrew Jones <drjones@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 8 February 2017 at 19:23, Laszlo Ersek <lersek@redhat.com> wrote:
> On 02/08/17 19:32, Peter Maydell wrote:
>> Would making UEFI a
>> more "official" rom image in pc-bios/ help to
>> harmonise things, or just introduce yet another
>> possibility to the mix?
>
> On one hand, it would be the best possible solution. I believe we've
> been thinking on-and-off about bundling OVMF and ArmVirtQemu with QEMU,
> since FatPkg in edk2 became free software. (... Because Microsoft
> graciously liberated the license, after Intel worked with them for a
> looong time on that. Kudos again to both companies!)
>
> On the other hand, upstream edk2 doesn't do releases (not in the "whole
> community stabilization / soft freeze / hard freeze / merge window
> closed" sense anyway). So Gerd -- because it would fall under Gerd's
> maintainership I think -- would have to deal with yet another project
> like iPXE (no releases). It's up to him, I guess.

Yes, since I don't personally have the time or expertise this
definitely comes down to "does whoever would be doing
the work think it's a good idea or not".

thanks
-- PMM
