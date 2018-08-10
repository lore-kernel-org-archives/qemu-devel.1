Received: from eggs.gnu.org ([2001:4830:134:3::10]:37082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4DK-0000rS-SF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4DH-0006Aj-0y
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:00:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fo4DG-0006AY-Ry
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:00:06 -0400
Date: Fri, 10 Aug 2018 12:00:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180810100005.3ttvqgaz7sc3iajj@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-7-git-send-email-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533815202-11967-7-git-send-email-liran.alon@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 06/29] vmsvga: Fix parse of
 SVGA_CMD_UPDATE_VERBOSE to consider additional opaque cookie
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

  Hi,

> +            if (cmd == SVGA_CMD_UPDATE_VERBOSE)
> +                vmsvga_fifo_read(s);

Code style.  qemu wants braces unconditionally.  There might be more of
this in following patches.  You can use scripts/checkpatch.pl to check.

cheers,
  Gerd
