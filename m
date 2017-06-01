Received: from eggs.gnu.org ([2001:4830:134:3::10]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGRvu-0006uX-O3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGRvp-0006cz-Qn
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGRvp-0006cj-Hx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:22:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EF483DBE1
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 15:22:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170601124631.GR2083@work-vm> (David Alan Gilbert's message of
	"Thu, 1 Jun 2017 13:46:32 +0100")
References: <20170531103509.22021-1-quintela@redhat.com>
	<20170531103509.22021-8-quintela@redhat.com>
	<20170601124631.GR2083@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 01 Jun 2017 17:22:33 +0200
Message-ID: <87shjj7mx2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 07/10] migration: Export rdma.c
 functions in its own file
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
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  4 ----
>>  migration/migration.c         |  1 +
>>  migration/rdma.c              |  1 +
>>  migration/rdma.h              | 25 +++++++++++++++++++++++++
>>  4 files changed, 27 insertions(+), 4 deletions(-)
>>  create mode 100644 migration/rdma.h
>> 
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index 29fda5b..8d29bc9 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -153,10 +153,6 @@ void qemu_start_incoming_migration(const char
>> *uri, Error **errp);
>>  
>>  uint64_t migrate_max_downtime(void);
>>  
>> -void rdma_start_outgoing_migration(void *opaque, const char
>> *host_port, Error **errp);
>> -
>> -void rdma_start_incoming_migration(const char *host_port, Error **errp);
>> -
>>  void migrate_fd_error(MigrationState *s, const Error *error);
>>  
>>  void migrate_fd_connect(MigrationState *s);
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6e11db2..3face58 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -21,6 +21,7 @@
>>  #include "exec.h"
>>  #include "fd.h"
>>  #include "socket.h"
>> +#include "rdma.h"
>>  #include "migration/migration.h"
>>  #include "savevm.h"
>>  #include "qemu-file-channel.h"
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 4cb5bf8..fab30ea 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -17,6 +17,7 @@
>>  #include "qapi/error.h"
>>  #include "qemu-common.h"
>>  #include "qemu/cutils.h"
>> +#include "rdma.h"
>>  #include "migration/migration.h"
>>  #include "qemu-file.h"
>>  #include "exec/cpu-common.h"
>> diff --git a/migration/rdma.h b/migration/rdma.h
>> new file mode 100644
>> index 0000000..de2ba09
>> --- /dev/null
>> +++ b/migration/rdma.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * RDMA protocol and interfaces
>> + *
>> + * Copyright IBM, Corp. 2010-2013
>> + * Copyright Red Hat, Inc. 2015-2016
>> + *
>> + * Authors:
>> + *  Michael R. Hines <mrhines@us.ibm.com>
>> + *  Jiuxing Liu <jl@us.ibm.com>
>> + *  Daniel P. Berrange <berrange@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * later.  See the COPYING file in the top-level directory.
>> + *
>> + */
>
> Hmm, are we allowed to v2-or-later that?  migration.h is v2

That is the header file of rdma.c

And we only have two functions exported from that file, so I think that
it is a safe assumption that they are covered by that copyright.

Later, Juan.
