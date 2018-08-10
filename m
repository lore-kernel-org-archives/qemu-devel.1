Received: from eggs.gnu.org ([2001:4830:134:3::10]:35308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo44z-0005Dv-98
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo44u-0000xt-E3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:51:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fo44u-0000xK-8M
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:51:28 -0400
Date: Fri, 10 Aug 2018 11:51:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180810095125.wql4spr5vb7x6m2v@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-24-git-send-email-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533815202-11967-24-git-send-email-liran.alon@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 23/29] vmsvga: Implement initial support
 for rgb-alpha cursors
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

> +#ifdef HW_MOUSE_ACCEL
> +            vmsvga_rgba_cursor_define(s, &cursor);
> +            break;
> +#else
> +            args = 0;
> +            goto badcmd;
> +#endif

Hmm, do we want keep this #ifdef ?

In case it is useful to disable hardware cursor support for some reason
(which I doubt) this should be a runtime not a compile time option.  So,
feel free to drop this to simplify the code.

cheers,
  Gerd
