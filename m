Received: from eggs.gnu.org ([2001:4830:134:3::10]:60147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIyGp-0000aM-GA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIyGj-0002ll-HW
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:18:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIyGj-0002kS-Bm
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:18:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D2226AAF5
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 14:18:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170608133906.12737-5-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Thu, 8 Jun 2017 10:39:05 -0300")
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-5-ehabkost@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 08 Jun 2017 16:18:34 +0200
Message-ID: <8760g6bm11.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/5] migration: Don't try to set *errp
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> wrote:
> Assigning directly to *errp is not valid, as errp may be NULL,
> &error_fatal, or &error_abort.  Use error_propagate() instead.
>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>

queued

Thanks.
