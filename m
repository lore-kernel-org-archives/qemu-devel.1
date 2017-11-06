Received: from eggs.gnu.org ([2001:4830:134:3::10]:44491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1eBWdl-0005nj-TH
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1eBWdl-0000NW-0I
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:55:54 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:56028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1eBWdk-0000NF-Ot
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:55:52 -0500
Received: by mail-wr0-x244.google.com with SMTP id l8so7148548wre.12
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 17:55:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cb94e9b2-d7c6-68ab-bb25-42f7d8113e03@advancedtelematic.com>
References: <cb94e9b2-d7c6-68ab-bb25-42f7d8113e03@advancedtelematic.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 6 Nov 2017 09:55:50 +0800
Message-ID: <CAEUhbmVTaJmL1jG8aBPPcJ-d+vKba8xhLgc=+7Fd8HHUvVW+-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [U-Boot] Support of latest qemux86-64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Gerasimov <anton@advancedtelematic.com>, qemu-devel@nongnu.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>

+QEMU dev list

On Fri, Nov 3, 2017 at 10:07 PM, Anton Gerasimov
<anton@advancedtelematic.com> wrote:
> Hi all,
>
> I'm trying to use u-boot (v2017.01) with qemu-system-x86_64 v2.10.0 and
> run into a "trying to execute code outside of RAM or ROM at xxxxx"
> issue. It happens both when I build and use u-boot as a bios and as EFI
> payload, just the addresses in the error message are different. On qemu
> v2.5.0 at least EFI option works fine.
>
> I understand that it can be (and probably is) a QEMU issue, but maybe
> someone on the list already encountered it and knows a workaround or has
> successfully used u-boot with QEMU >=2.10.0 and can share their experience.
>

Yes, I just tested latest U-Boot x86 ROM image with QEMU 2.9.1 and
2.10.1. The same U-Boot ROM image boots with 2.9.1 but not with
2.10.1.

I built U-Boot as follows:

$ make qemu-x86_defconfig
$ make

Does anyone have any hints?

Regards,
Bin
