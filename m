Received: from eggs.gnu.org ([209.51.188.92]:45820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1h1sDJ-0002Cu-RZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1h1sDJ-0007E7-5Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:33:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1h1sDI-0007DL-VI
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:33:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C03F30D78BC
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 12:25:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20190306152812.GF2727@work-vm> (David Alan Gilbert's message of
	"Wed, 6 Mar 2019 15:28:13 +0000")
References: <20190227110812.2185-1-quintela@redhat.com>
	<20190227110812.2185-4-quintela@redhat.com>
	<20190306152812.GF2727@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 07 Mar 2019 13:28:47 +0100
Message-ID: <87o96m3m2o.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We need to send this field when we add compression support.  As we are
>> still on x- stage, we can do this kind of changes.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> OK, so that kind of makes sense - in that what you want to do is read
> the whole compressed chunk in one go.
>
> Consider it might be a good idea to add some spare entries here;
> say a uint64_t dummy[4] so that if you need any more fields in the
> future it'll be easy to add them without breaking compatibility.

We have a version field, so ... we can handle it relatively gratiously,
but I see your point.

How many?

Later, Juan.
