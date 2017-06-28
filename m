Received: from eggs.gnu.org ([2001:4830:134:3::10]:60379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ8AH-00089o-4Y
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ8AG-0005r0-Cd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQ8AG-0005qe-6j
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:17:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E93178047E
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 08:17:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170622103333.GA2624@work-vm> (David Alan Gilbert's message of
	"Thu, 22 Jun 2017 11:33:34 +0100")
References: <20170621102005.18701-1-quintela@redhat.com>
	<20170621102005.18701-4-quintela@redhat.com>
	<20170622103333.GA2624@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 10:17:26 +0200
Message-ID: <87lgoc7ch5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/5] migration: Create
 load_setup()/cleanup() methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We need to do things at load time and at cleanup time.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 

>>  
>> +    qemu_loadvm_state_cleanup();
>
> Where does the equivalent happen for postcopy?
> Do you need to add a call at the bottom of postcopy_ram_listen_thread?
>

I think yes, but it is not completely clear how we can arrive there that
way.

It appears that I still should put more things into load_cleanup() hooks
:p

Later, Juan.
