Received: from eggs.gnu.org ([2001:4830:134:3::10]:53133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGRu9-00057H-L5
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGRu4-0006Iu-Qq
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:20:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGRu4-0006Il-IW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:20:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEECE7F6C8
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 15:20:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170601124109.GO2083@work-vm> (David Alan Gilbert's message of
	"Thu, 1 Jun 2017 13:41:09 +0100")
References: <20170531103509.22021-1-quintela@redhat.com>
	<20170531103509.22021-7-quintela@redhat.com>
	<20170601124109.GO2083@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 01 Jun 2017 17:20:43 +0200
Message-ID: <87wp8v7n04.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 06/10] migration: Export tls.c functions
 in its own file
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
>> Just for the functions exported from tls.c.  Notice that we can't
>> remove the migration/migration.h include from tls.c because it access
>> directly MigrationState for the tls params.

>> +++ b/migration/tls.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * QEMU migration TLS support
>> + *
>> + * Copyright (c) 2015 Red Hat, Inc.
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + *
>> + */
>
> Can you clarify why this is LGPLv2 or later please?
> Is this to follow the io/* rather than the migration/migration.h it came
> out of.

THis is the license of tls.c

And this are only the two functions that are exported from that file, so
....

And anyways, this code is posterior to the cut-off when everything new
is GPL2 or later.

Or I am missing something?

Later, Juan.


>
> Anyway, I did see Dan's post saying it was OK to update licenses, but
> it's worth a comment in the commit message as to why.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>
> Dave
>
>> +
>> +#ifndef QEMU_MIGRATION_TLS_H
>> +#define QEMU_MIGRATION_TLS_H
>> +
>> +#include "io/channel.h"
>> +
>> +void migration_tls_channel_process_incoming(MigrationState *s,
>> +                                            QIOChannel *ioc,
>> +                                            Error **errp);
>> +
>> +void migration_tls_channel_connect(MigrationState *s,
>> +                                   QIOChannel *ioc,
>> +                                   const char *hostname,
>> +                                   Error **errp);
>> +#endif
>> -- 
>> 2.9.4
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
