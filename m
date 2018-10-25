Received: from eggs.gnu.org ([2001:4830:134:3::10]:45666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFdMZ-0001Y0-K5
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFdMW-0002Ry-9B
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFdMU-0002PN-7u
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E29115561
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 10:59:25 +0000 (UTC)
Date: Thu, 25 Oct 2018 16:29:13 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181025085256.20522-4-kraxel@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810251627260.11480@xnncv>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

+-- On Thu, 25 Oct 2018, Gerd Hoffmann wrote --+
| While being at it deprecate cirrus too.
| 
| Reason (short version): use stdvga instead.
| Verbose version:
|     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful
| 
| Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
| ---
|  hw/display/cirrus_vga.c     | 2 ++
|  hw/display/cirrus_vga_isa.c | 2 ++
|  qemu-deprecated.texi        | 4 ++++
|  3 files changed, 8 insertions(+)
| 
| diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
| index d9b854d..2f16ba9 100644
| --- a/hw/display/cirrus_vga.c
| +++ b/hw/display/cirrus_vga.c
| @@ -3024,6 +3024,8 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
|      dc->vmsd = &vmstate_pci_cirrus_vga;
|      dc->props = pci_vga_cirrus_properties;
|      dc->hotpluggable = false;
| +    dc->deprecation_reason =
| +        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful";
|  }
|  
|  static const TypeInfo cirrus_vga_info = {
| diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
| index fa10b74..c2d853c 100644
| --- a/hw/display/cirrus_vga_isa.c
| +++ b/hw/display/cirrus_vga_isa.c
| @@ -81,6 +81,8 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
|      dc->realize = isa_cirrus_vga_realizefn;
|      dc->props = isa_cirrus_vga_properties;
|      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
| +    dc->deprecation_reason =
| +        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful";
|  }
|  
|  static const TypeInfo isa_cirrus_vga_info = {
| diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
| index 7951a4f..1b1d434 100644
| --- a/qemu-deprecated.texi
| +++ b/qemu-deprecated.texi
| @@ -120,6 +120,10 @@ or ``ivshmem-doorbell`` device types.
|  
|  Has known buffer overflow.
|  
| +@subsection cirrus (since 3.1)
| +
| +Use stdvga instead (-vga std or -device VGA).
| +
|  @section System emulator machines
|  
|  @subsection pc-0.10 and pc-0.11 (since 3.0)
| 

Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
