Received: from eggs.gnu.org ([2001:4830:134:3::10]:42416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds4f1-0007KR-Sa
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds4ey-0005eG-MZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:12:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds4ey-0005dn-GN
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:12:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1DD7356F6
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:12:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170811145601.GP2554@redhat.com> (Daniel P. Berrange's message
	of "Fri, 11 Aug 2017 15:56:01 +0100")
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-8-quintela@redhat.com>
	<20170811145601.GP2554@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 13 Sep 2017 12:12:39 +0200
Message-ID: <87d16uewko.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 07/19] migration: Create
 x-multifd-threads parameter
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
> On Tue, Aug 08, 2017 at 06:26:17PM +0200, Juan Quintela wrote:
>> Indicates the number of threads that we would create.  By default we
>> create 2 threads.
>>  # 	migrated and the destination must already have access to the
>>  # 	same backing chain as was used on the source.  (since 2.10)
>>  #
>> +# @x-multifd-threads: Number of threads used to migrate data in
>> +#                     parallel. This is the same number that the
>> +#                     number of sockets used for migration.
>> +#                     The default value is 2 (since 2.11)
>
> The feature is called "multifd" but we're configuring number of threads,
> with the implicit suggestion that number of threads == number of sockets.
>
> I wonder if its better to call this  "x-multifd-connections" so that it
> is explicit that we're determining the number of socket connections.
>
> This leaves room for adapting code to use a different number of threads,
> but same number of sockets. eg with post-copy, there's potential to have
> 2 threads for each socket (1 reading, 1 writing).

Changed to channels, is that ok for you?

Later, Juan.
