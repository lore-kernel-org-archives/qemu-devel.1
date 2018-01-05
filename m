Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eXH8b-000110-Qc
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 20:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eXH8a-0005hn-Vq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 20:49:37 -0500
Date: Fri, 5 Jan 2018 09:49:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180105014927.GA8592@lemon.usersys.redhat.com>
References: <20180104024228.11780-1-famz@redhat.com>
	<9b5c0137-837a-99ee-7887-996c5dba69fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5c0137-837a-99ee-7887-996c5dba69fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't deference in_buf if NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

On Thu, 01/04 11:41, Eric Blake wrote:
> On 01/03/2018 08:42 PM, Fam Zheng wrote:
> > scsi_disk_emulate_command passes in_buf=NULL and in_len=0 in the
> > REQUEST_SENSE branch. Inline the fixed_in evaluation and put it after
> > the in_len test.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  scsi/utils.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Does this patch duplicate
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04964.html ?

Yes. Thanks for pointing out this.

Fam
