Received: from eggs.gnu.org ([2001:4830:134:3::10]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPrvK-0000wA-Is
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPrvG-0004gq-HZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:57:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPrvG-0004eh-Bc
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DCA2FEF10
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 14:56:57 +0000 (UTC)
Date: Tue, 27 Jun 2017 11:56:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627145655.GA12152@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498536619-14548-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 03/10] vl: clean up global property
 registerations
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


On Tue, Jun 27, 2017 at 12:10:12PM +0800, Peter Xu wrote:
> It's not that clear on how the global properties are registered to
> global_props (and also its priority relationship). Let's provide a
> single function to be called in main() for that, with comment to explain
> it a bit.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

On subject: s/registerations/registration/

With this fixed:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
