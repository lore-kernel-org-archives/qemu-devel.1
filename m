Received: from eggs.gnu.org ([2001:4830:134:3::10]:52783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGRsj-0003yq-Hz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGRse-0005s6-KM
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:19:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGRse-0005rx-EA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:19:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FFE0C05689C
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 15:19:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170601122132.GK2083@work-vm> (David Alan Gilbert's message of
	"Thu, 1 Jun 2017 13:21:33 +0100")
References: <20170531103509.22021-1-quintela@redhat.com>
	<20170531103509.22021-3-quintela@redhat.com>
	<20170601122132.GK2083@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 01 Jun 2017 17:19:15 +0200
Message-ID: <871sr391n0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/10] migration: Split qemu-file.h
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
>> Split the file into public and internal interfaces.  I have to rename
>> the external one because we can't have two include files with the same
>> name in the same directory.  Build system gets confused.  The only
>> exported functions are the ones that handle basic types.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Hmm, ok, but I'd like to make qemu-file-types.h private eventually;
> we're down to 193 qemu_put_b*'s outside of migration - of those 72 will
> go when Halil's set goes in.


Be my guest O:-)

I was just trying to make sure that the other stuff is not used outside.

Later, Juan.
