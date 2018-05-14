Received: from eggs.gnu.org ([2001:4830:134:3::10]:51706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIJ92-0007Px-PP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIJ8z-0001sD-Hp
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIJ8z-0001rX-CL
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:28:25 -0400
Date: Mon, 14 May 2018 16:28:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180514192819.GA25013@localhost.localdomain>
References: <20180514164156.27034-1-babu.moger@amd.com>
	<20180514164156.27034-3-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514164156.27034-3-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v9 2/7] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net

On Mon, May 14, 2018 at 11:41:51AM -0500, Babu Moger wrote:
> The property legacy-cache will be used to control the cache information.
> If user passes "-cpu legacy-cache" then older information will
> be displayed even if the hardware supports new information. Otherwise
> use the statically loaded cache definitions if available.
> 
> Renamed the previous cache structures to legacy_*. If there is any change in
> the cache information, then it needs to be initialized in builtin_x86_defs.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued, thanks.

-- 
Eduardo
