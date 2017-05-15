Received: from eggs.gnu.org ([2001:4830:134:3::10]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dACVD-0002wi-R3
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dACV8-0005JR-V7
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dACV8-0005Iu-PC
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:41:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C23637E65
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 09:41:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <0bbb5f93-83bb-47b9-e7dd-d0824f3d8b61@redhat.com> (Eric Blake's
	message of "Fri, 12 May 2017 14:52:14 -0500")
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-2-quintela@redhat.com>
	<0bbb5f93-83bb-47b9-e7dd-d0824f3d8b61@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 11:41:07 +0200
Message-ID: <87pofafoek.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Create block capabilities
 for shared and enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 05/11/2017 11:32 AM, Juan Quintela wrote:
>> Those two capabilities were added through the command line.  Notice that
>> we just created them.  This is just the boilerplate.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> 
>> --
>> 
>> Make migrate_set_block_* take a boolean argument.
>
> Question - do we support the orthogonal selection of all 4 combinations
> under HMP 'migrate' (no argument, -b alone, -i alone, -b and -i
> together), or are there only 3 actual states? If the latter, should we
> represent this as a single enum-valued property, rather than as two
> independent boolean properties?

{ 'enum': 'MigrationCapability',
  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }


My understanding is that we can only have boolean capabilities here.
Or, how could we put a non-boolean capability?

There are three states as far as I can see.

Later, Juan.
