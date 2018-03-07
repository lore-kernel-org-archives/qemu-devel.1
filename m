Received: from eggs.gnu.org ([2001:4830:134:3::10]:36523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etVa6-00053r-Ni
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etVa5-000119-GX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:41:54 -0500
Date: Wed, 7 Mar 2018 10:41:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307104149.3e4da203.cohuck@redhat.com>
In-Reply-To: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] s390x/sclp: 64 bit event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Fri, 23 Feb 2018 18:42:55 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> Until 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
> we only supported 32bit sclp event masks, even though the archiecture
> allows the guests to set up sclp event masks up to 1021 bytes in length.
> With that patch the behaviour was almost compliant, but some issues were
> still remaining, in particular regarding the handling of selective reads
> and migration.
> 
> This patchset fixes migration and the handling of selective reads, and
> puts in place the support for 64-bit sclp event masks internally.
> 
> A new property of the sclp-event device switches between the 32bit masks
> and the compliant behaviour. The property is bound to the machine
> version, so older machines keep the old broken behaviour, allowing for
> migration, but the default is the compliant implementation.
> 
> Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")

Thanks, applied 1+2 (only patch 1 is needed for the fix.)
