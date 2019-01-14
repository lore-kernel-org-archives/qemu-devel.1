Received: from eggs.gnu.org ([209.51.188.92]:60074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj6q7-0007Cj-9i
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj6bB-0006c0-8V
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:04:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj6b8-0006Mx-6l
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:04:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 240C433BE4
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 18:04:15 +0000 (UTC)
Date: Mon, 14 Jan 2019 16:04:10 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114180410.GZ4500@habkost.net>
References: <1545225205-7227-1-git-send-email-thuth@redhat.com>
	<87h8f9efa9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8f9efa9.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc/ivshmem: Remove deprecated
 "ivshmem" legacy device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Wed, Dec 19, 2018 at 03:56:30PM +0100, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > It's been marked as deprecated in QEMU v2.6.0 already, so really nobody
> > should use the legacy "ivshmem" device anymore (but use ivshmem-plain or
> > ivshmem-doorbell instead). Time to remove the deprecated device now.
> >
> > Belatedly also update a mention of the deprecated "ivshmem" in the file
> > docs/specs/ivshmem-spec.txt to "ivshmem-doorbell". Missed in commit
> > 5400c02b90b ("ivshmem: Split ivshmem-plain, ivshmem-doorbell off ivshmem").
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Who should merge this?

-- 
Eduardo
