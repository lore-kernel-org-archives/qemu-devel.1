Received: from eggs.gnu.org ([2001:4830:134:3::10]:60744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBNyb-00011d-Pw
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBNyW-00042v-RD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBNyW-00042m-L0
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:08:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FCB38047A
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:08:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170518154820.GC13699@redhat.com> (Daniel P. Berrange's message
	of "Thu, 18 May 2017 16:48:20 +0100")
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-4-quintela@redhat.com>
	<20170518154407.GG2467@work-vm> <20170518154820.GC13699@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 18 May 2017 18:08:22 +0200
Message-ID: <87shk287wp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/9] migration: Export qemu-file-channel.c
 functions in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Thu, May 18, 2017 at 04:44:08PM +0100, Dr. David Alan Gilbert wrote:

>> OK, similar copyright - but slightly different problem.
>> These two lines come from include/migration/qemu-file.h;
>> they were both added by Daniel in a9cfeb33bb23a81.
>> The qemu-file.h header however has the old Fabrice copyright
>> with a 3 paragraph copyright rather than the GPLv2.
>> 
>> So, Authors, and copyright need changing - not sure what the
>> right way to do the copyright is.  Personally I'd ask Dan really
>> nicely to let it be GPL v2 or newer, but the quicker answer I think
>> is to take the header from qemu-file.h
>
> That is of course fine. Anything I contribute is under Red Hat copyright,
> and so as another Red Hat employee, you're free to change the license on
> any code I wrote [1]
>
> Regards,
> Daniel
>
> [1] unless I put a comment about having copied the code from another source

/*
 * QEMU live migration channel operations
 *
 * Copyright Red Hat, Inc. 2016
 *
 * Authors:
 *  Daniel P. Berrange <berrange@redhat.com>
 *
 * This work is licensed under the terms of the GNU GPL, version 2.  See
 * the COPYING file in the top-level directory.
 *
 * Contributions after 2012-01-13 are licensed under the terms of the
 * GNU GPL, version 2 or (at your option) any later version.
 */

Putting that one for channel operations and qemu-file-chanel operations
(changing the 1st line).

Later, Juan.
