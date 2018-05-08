Received: from eggs.gnu.org ([2001:4830:134:3::10]:37534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxMO-0000H9-BR
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxMK-0005x7-DW
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:48:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fFxMK-0005wu-8m
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:48:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C84944182D59
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 07:48:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180412130932.GG2704@work-vm> (David Alan Gilbert's message of
	"Thu, 12 Apr 2018 14:09:33 +0100")
References: <20180404112731.5922-1-quintela@redhat.com>
	<20180404112731.5922-5-quintela@redhat.com>
	<20180412130932.GG2704@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 09:50:43 +0200
Message-ID: <87vabya8mk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 4/8] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> It will be used to store the uri parameters. We want this only for
>> tcp, so we don't set it for other uris.  We need it to know what port
>> is migration running.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>> 
>> This used to be uri parameter, but it has so many troubles to
>> reproduce that it don't just make sense.
>> 
>> This used to be a port parameter.  I was asked to move to
>> SocketAddress, done.
>> I also merged the setting of the migration tcp port in this one
>> because now I need to free the address, and this makes it easier.
>> This used to be x-socket-address with a single direction, now it is a
>> list of addresses.
>
> Is there a reason it's a parameter rather than just an entry in
> MigrationInfo?

Done.

I think that we *should* create a migration instance also on destination
side, it is so much different adding things one side than the other.

Later, Juan.
