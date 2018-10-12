Received: from eggs.gnu.org ([2001:4830:134:3::10]:40165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAtn6-0006RN-FW
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAtn3-0003KH-BP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAtn1-0003D2-34
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C039C30D47D8
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 09:31:08 +0000 (UTC)
Date: Fri, 12 Oct 2018 11:31:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181012093107.xikqvacxhqq7n6bv@sirius.home.kraxel.org>
References: <1539271305-20671-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539271305-20671-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/display/cirrus_vga: Add CONFIG option
 for "isa-cirrus-vga"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Oct 11, 2018 at 05:21:45PM +0200, Thomas Huth wrote:
> In downstream distros like RHEL we'd like to disable some of the "legacy"
> devices of QEMU. The ISA version of the Cirrus VGA device is one of these
> legacy devices. So let's make the build process a little bit more flexible
> here by putting the Cirrus ISA code into a separate file and by providing
> a proper CONFIG_VGA_CIRRUS_ISA switch which can be used to disable
> this device.

We already have a CONFIG_VGA_ISA, how about adding it there instead?

cheers,
  Gerd
