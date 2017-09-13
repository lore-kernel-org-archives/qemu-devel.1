Received: from eggs.gnu.org ([2001:4830:134:3::10]:49246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds4rL-00042p-5e
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds4rF-0006YA-IR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds4rF-0006Xr-Br
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:25:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 517E5883C2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:25:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170811150302.GQ2554@redhat.com> (Daniel P. Berrange's message
	of "Fri, 11 Aug 2017 16:03:02 +0100")
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-9-quintela@redhat.com>
	<20170811150302.GQ2554@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 13 Sep 2017 12:25:19 +0200
Message-ID: <878thievzk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 08/19] migration: Create x-multifd-group
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Tue, Aug 08, 2017 at 06:26:18PM +0200, Juan Quintela wrote:
>> Indicates how many pages we are going to send in each batch to a multifd
>> thread.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> --
>> 
>> Be consistent with defaults and documentation
>> Use new DEFINE_PROP_*
>> @@ -1117,6 +1120,9 @@
>>  #                     number of sockets used for migration.
>>  #                     The default value is 2 (since 2.11)
>>  #
>> +# @x-multifd-group: Number of pages sent together to a thread
>> +#                   The default value is 16 (since 2.11)
>
> Bikesheeding - how about  "x-multifd-page-count"  ?  'group' didn't
> give me much idea what it was controlling until reading the docs.

Done, thanks.

I was about to change it to pages, but once here, the length don't
matter.

Later, Juan.
