Received: from eggs.gnu.org ([2001:4830:134:3::10]:34032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejb7w-00076h-5B
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejb7v-0006oz-Dn
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:35:52 -0500
Date: Thu, 8 Feb 2018 09:35:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180208013544.GC24289@lemon.usersys.redhat.com>
References: <20180207163622.29935-1-pbonzini@redhat.com>
	<20180207163622.29935-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207163622.29935-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] scsi: add unrealize method for SCSI
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

On Wed, 02/07 17:36, Paolo Bonzini wrote:
> The next patch will introduce a different unrealize implementation
> for scsi-block.  Compared to the code before commit fb7b5c0df6
> ("scsi: devirtualize unrealize of SCSI devices", 2014-10-31), the
> common code for all SCSI devices is kept in scsi-bus.c.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
