Received: from eggs.gnu.org ([2001:4830:134:3::10]:33178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo3yT-0000vY-RG
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo3yP-0000jl-9S
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:44:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fo3yP-0000hG-4F
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:44:45 -0400
Date: Fri, 10 Aug 2018 11:44:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180810094442.xw35jufoq7ygtujo@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-4-git-send-email-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533815202-11967-4-git-send-email-liran.alon@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 03/29] vmsvga: Explictly mark deprecated
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>

On Thu, Aug 09, 2018 at 02:46:16PM +0300, Liran Alon wrote:
> From: Leonid Shatz <leonid.shatz@oracle.com>
> 
> These commands are neither mentioned nor documented in VMware SVGA
> development-kit and Linux vmware-svga driver source code.
> Thus, they should be subject to future deletion, if not encountered in practice.

Well, as far I know qemu is compatible to a rather old version of the
vmware svga.  The xorg-x11-drv-vmware driver can handle the device just
fine, so I guess it is worth checking whenever there is more information
about these commands in the driver source code.

First, maybe the driver actually uses these commands on old devices
(when the kms driver doesn't load due to missing capabilities).

Second, being more specific than just "deprecated" would be useful if
possible (command replaced by $foo in device revision $bar).  That goes
into the "nice to have" bucket though.

cheers,
  Gerd
