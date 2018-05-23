Received: from eggs.gnu.org ([2001:4830:134:3::10]:34842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLJGb-0001Na-Vy
	for qemu-devel@nongnu.org; Tue, 22 May 2018 22:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLJGb-0005gZ-5N
	for qemu-devel@nongnu.org; Tue, 22 May 2018 22:12:41 -0400
Date: Wed, 23 May 2018 10:12:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180523021235.GA31322@lemon.usersys.redhat.com>
References: <20180522201056.1442-1-pbonzini@redhat.com>
	<20180522201056.1442-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522201056.1442-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] sheepdog: cleanup repeated expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, qemu-block@nongnu.org

On Tue, 05/22 22:10, Paolo Bonzini wrote:
> The expression "SD_INODE_SIZE - sizeof(inode.data_vdi_id)" already has a macro
> defined for the same value (though with a nicer definition using offsetof).
> Replace it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
