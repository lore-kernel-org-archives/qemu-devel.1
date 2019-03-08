Received: from eggs.gnu.org ([209.51.188.92]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2LAa-0001dS-8t
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2LAZ-0000U1-HT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2LAZ-0000TK-Ay
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:28:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B8DA2D7F5
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 19:28:34 +0000 (UTC)
Date: Fri, 8 Mar 2019 19:28:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190308192829.GL2834@work-vm>
References: <20190227110812.2185-1-quintela@redhat.com>
	<20190227110812.2185-4-quintela@redhat.com>
	<20190306152812.GF2727@work-vm> <87o96m3m2o.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o96m3m2o.fsf@trasno.org>
Subject: Re: [Qemu-devel] [PATCH v3 3/8] multifd: Create new
 next_packet_size field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> We need to send this field when we add compression support.  As we are
> >> still on x- stage, we can do this kind of changes.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >
> > OK, so that kind of makes sense - in that what you want to do is read
> > the whole compressed chunk in one go.
> >
> > Consider it might be a good idea to add some spare entries here;
> > say a uint64_t dummy[4] so that if you need any more fields in the
> > future it'll be easy to add them without breaking compatibility.
> 
> We have a version field, so ... we can handle it relatively gratiously,
> but I see your point.
> 
> How many?

<rolls dice>

4

Now don't use them all at once!

Dave
 
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
