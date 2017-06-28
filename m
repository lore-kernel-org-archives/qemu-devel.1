Received: from eggs.gnu.org ([2001:4830:134:3::10]:35569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQHyV-0003sk-46
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQHyS-0008Hr-39
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQHyR-0008Go-Qr
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD92961B92
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:45:58 +0000 (UTC)
Date: Wed, 28 Jun 2017 15:45:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170628184555.GM12152@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-9-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498536619-14548-9-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 08/10] migration: move
 skip_section_footers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 12:10:17PM +0800, Peter Xu wrote:
> Move it into MigrationState, revert its meaning and renaming it to
> send_section_footer, with a property bound to it. Same trick is played
> like previous patches.
> 
> Removing savevm_skip_section_footers().
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
