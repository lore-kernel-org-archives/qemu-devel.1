Received: from eggs.gnu.org ([2001:4830:134:3::10]:55489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUlIU-00077l-98
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUlIT-00064l-CA
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:25:26 -0500
Date: Fri, 29 Dec 2017 11:25:16 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229032516.GA27028@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 06/20] iscsi: Switch
 iscsi_allocmap_update() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert all uses of
> the allocmap (no semantic change).  Callers that already had bytes
> available are simpler, and callers that now scale to bytes will be
> easier to switch to byte-based in the future.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
