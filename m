Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4BV-0008Hg-Kp
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4BU-0005G7-Cq
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:58:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fo4BU-0005Fb-6u
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:58:16 -0400
Date: Fri, 10 Aug 2018 11:58:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180810095812.2jzit2fnbk7fnkcu@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-29-git-send-email-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533815202-11967-29-git-send-email-liran.alon@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 28/29] vmsvga: Introduce new function for
 reporting device capabilities
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

> +#ifdef HW_RECT_ACCEL
> +    caps |= SVGA_CAP_RECT_COPY;
> +#endif
> +#ifdef HW_FILL_ACCEL
> +    caps |= SVGA_CAP_RECT_FILL;
> +#endif

Same with these #ifdefs.  I think we should either make them runtime
options or just drop them.

cheers,
  Gerd
