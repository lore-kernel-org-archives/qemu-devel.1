Received: from eggs.gnu.org ([2001:4830:134:3::10]:40714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=584ccea7e=roger.pau@citrix.com>)
	id 1eonQn-0001BX-Mz
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=584ccea7e=roger.pau@citrix.com>)
	id 1eonQk-0006p1-F6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:44:49 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:49639
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=584ccea7e=roger.pau@citrix.com>)
	id 1eonQg-0006Yp-MS
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:44:46 -0500
Date: Thu, 22 Feb 2018 09:44:25 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20180222094425.w27zstn5e44jiipn@MacBook-Pro-de-Roger.local>
References: <20180124141848.3969-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180124141848.3969-1-marmarek@invisiblethingslab.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] intel_iommu: allow updating
 FEADDR and FEUADDR with one 64bit write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org

On Wed, Jan 24, 2018 at 03:18:48PM +0100, Marek Marczykowski-Górecki wrote:
> Allow updating those two adjacent 32bit fields with one 64bit write.
> This fixes qemu crash when booting Xen inside.
>
> See discussion on Xen side of the thing here:
> http://xen.markmail.org/message/6mrmemrnmhxvaxba

Xen code is wrong, see:

https://marc.info/?l=xen-devel&m=150511273303712

Roger.
