Received: from eggs.gnu.org ([2001:4830:134:3::10]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=513001ac0=anthony.perard@citrix.com>)
	id 1eP9Fz-0005Sf-Bx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=513001ac0=anthony.perard@citrix.com>)
	id 1eP9Fv-0003W3-FY
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:47:39 -0500
Received: from smtp.citrix.com ([66.165.176.89]:30216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=513001ac0=anthony.perard@citrix.com>)
	id 1eP9Fv-0003Vi-9A
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:47:35 -0500
Date: Wed, 13 Dec 2017 15:01:51 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171213150151.GF2216@perard.uk.xensource.com>
References: <20171212141044.2582-1-berrange@redhat.com>
	<20171212141044.2582-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171212141044.2582-5-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/4] hw: convert XenInput keyboard to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Tue, Dec 12, 2017 at 02:10:44PM +0000, Daniel P. Berrange wrote:
> Replace the scancode2linux table with an automatically
> generated table. In doing so, the XenFB keyboard
> handler is also converted to the modern InputEvent
> framework.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

FYI, I think that is done by <20171103115631.15175-3-owen.smith@citrix.com>.
([PATCH v5 2/4] xenfb: Use Input Handlers directly)

-- 
Anthony PERARD
