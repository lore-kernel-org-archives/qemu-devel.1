Received: from eggs.gnu.org ([2001:4830:134:3::10]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cjpn3-0002ge-Q2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cjpn0-0003Hv-Iv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:10:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1cjpn0-0003Gs-De
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:10:42 -0500
Date: Fri, 3 Mar 2017 17:10:39 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20170303161039.GB7496@redhat.com>
References: <20170303113255.28262-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303113255.28262-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Mar 03, 2017 at 11:32:55AM +0000, Daniel P. Berrange wrote:
> When using a memory-backend object with prealloc turned on, QEMU
> will memset() the first byte in every memory page to zero. While
> this might have been acceptable for memory backends associated
> with RAM, this corrupts application data for NVDIMMs.
> 
> Instead of setting every page to zero, read the current byte
> value and then just write that same value back, so we are not
> corrupting the original data. Directly write the value instead
> of memset()ing it, since there's no benefit to memset for a
> single byte write.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> 
> Changed in v3:

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Thanks,
Andrea
