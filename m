Received: from eggs.gnu.org ([2001:4830:134:3::10]:52498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1eX-000413-Qo
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1eS-0003ZH-UC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB1eS-0003Z4-Ow
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:18:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 772CC85543
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:18:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <ca163777-4ffe-4361-eace-98eab28d6781@redhat.com> (Eric Blake's
	message of "Wed, 17 May 2017 10:54:44 -0500")
References: <20170517153812.21993-1-quintela@redhat.com>
	<20170517153812.21993-4-quintela@redhat.com>
	<ca163777-4ffe-4361-eace-98eab28d6781@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 18:18:08 +0200
Message-ID: <87o9urbgov.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, armbru@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 05/17/2017 10:38 AM, Juan Quintela wrote:
>> We have change in the previous patch to use migration capabilities for
>> it.  Notice that we continue using the old command line flags from
>> migrate command from the time being.  Remove the set_params method as
>> now it is empty.
>> 
>> For savevm, one can't do a:
>> 
>> savevm -b/-i foo
>> 
>> but now one can do:
>> 
>> migrate_set_capability block on
>> savevm foo
>> 
>> And we can't use block migration. We could disable block capability
>> unconditionally, but it would not be much better.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> ---
>> - Maintain shared/enabled dependency (Xu suggestion)
>> - Now we maintain the dependency on the setter functions
>> - improve error messages
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> This second S-o-b gets stripped, but the one that counts is in place
> (I've made the same mistake before, as well - doing 'git commit --amend
> -s' on a commit where I already had a --- separator)

And this time I *really* remove the -s from my git-format-patch alias.
I dropped that last week on the terminal, rebooted the machine and
..... magic ... got the old alias O:-)

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks
