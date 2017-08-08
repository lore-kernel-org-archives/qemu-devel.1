Received: from eggs.gnu.org ([2001:4830:134:3::10]:39458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df09h-0001nM-3Z
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df09f-0003Yf-Vw
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:46:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df09f-0003Wn-QN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:46:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A84E94A705
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 08:46:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170719160030.GF3500@work-vm> (David Alan Gilbert's message of
	"Wed, 19 Jul 2017 17:00:30 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-6-quintela@redhat.com>
	<20170719160030.GF3500@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 10:46:15 +0200
Message-ID: <87fud2bg6g.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 05/17] migration: Create
 x-multifd-threads parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Indicates the number of threads that we would create.  By default we
>> create 2 threads.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Also needs updating DEFINE_PROP stuff - and if Markus' qapi patch lands.

Done.

>>  #
>>  # @return-path: If enabled, migration will use the return path even
>>  #               for precopy. (since 2.10)
>> +#
>>  # @x-multifd: Use more than one fd for migration (since 2.10)
>>  #
>>  # Since: 1.2
>> @@ -910,6 +911,7 @@
>>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>>             'block', 'return-path', 'x-multifd'] }
>> +
>
> Escapee from previous patch.

Done.

>
>>  ##
>>  # @MigrationCapabilityStatus:
>>  #
>> @@ -1026,13 +1028,19 @@
>>  # 	migrated and the destination must already have access to the
>>  # 	same backing chain as was used on the source.  (since 2.10)
>>  #
>> +# @x-multifd-threads: Number of threads used to migrate data in
>> +#                     parallel. This is the same number that the
>> +#                     number of sockets used for migration.
>> +#                     The default value is 2 (since 2.10)
>> +#
>
> That did make me think for a moment; I guess '2' makes sense once you've
> set the x-multifd capability on.  The other possibility would be to
> remove the capability and just rely on the threads > 1

I think this is the same that xbzrle cache size.  It has a default
value.  But we only used it when we set the capability.

I think that it makes the code more ortogonal with the others, no?

Later, Juan.
