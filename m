Received: from eggs.gnu.org ([2001:4830:134:3::10]:51943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euLbc-00070o-2H
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euLbX-00089d-2N
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:14:56 -0500
Received: from smtp.citrix.com ([66.165.176.89]:3601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euLbW-00088T-Sq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:14:51 -0500
Date: Fri, 9 Mar 2018 17:14:48 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180309171448.GL1921@perard.uk.xensource.com>
References: <1520513551-19851-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1520513551-19851-1-git-send-email-igor.druzhinin@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen-pvdevice: Introduce a simplistic
 xen-pvdevice save state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org, paul.durrant@citrix.com, mst@redhat.com, pbonzini@redhat.com

On Thu, Mar 08, 2018 at 12:52:31PM +0000, Igor Druzhinin wrote:
> This should help to avoid problems with accessing the device after
> migration/resume without PV drivers. Older systems will acquire
> the new record when migrated which should not change their state for
> worse.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
