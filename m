Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnTBF-0003Bk-42
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnTBE-0001BX-Ag
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:50:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnTBE-0001Ai-4S
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D31F35C807
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 16:50:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170313163744.GL4799@redhat.com> (Daniel P. Berrange's message
	of "Mon, 13 Mar 2017 16:37:44 +0000")
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-7-quintela@redhat.com>
	<20170313163744.GL4799@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Mar 2017 17:50:41 +0100
Message-ID: <87k27tunmm.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/16] migration: Create x-multifd-threads
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
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Mon, Mar 13, 2017 at 01:44:24PM +0100, Juan Quintela wrote:
>> Indicates the number of threads that we would create.  By default we
>> create 2 threads.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index d21934b..b7cb26d 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -985,13 +985,17 @@
>>  # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
>>  #          periodic mode. (Since 2.8)
>>  #
>> +# @x-multifd-threads: Number of threads used to migrate data in parallel
>> +#                     The default value is 2 (since 2.9)
>> +#
>>  # Since: 2.4
>>  ##
>>  { 'enum': 'MigrationParameter',
>>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
>>             'cpu-throttle-initial', 'cpu-throttle-increment',
>>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>> -           'downtime-limit', 'x-checkpoint-delay' ] }
>> +           'downtime-limit', 'x-checkpoint-delay',
>> +           'x-multifd-threads'] }
>>  
>>  ##
>>  # @migrate-set-parameters:
>> @@ -1054,6 +1058,10 @@
>>  #
>>  # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
>>  #
>> +#
>> +# @x-multifd-threads: Number of threads used to migrate data in parallel
>> +#                     The default value is 2 (since 2.9)
>> +#
>
> Presumably, the number of threads is the same as the number of sockets
> opened ? It is probably useful to make it explicit that increasing
> threads also causes increased number of TCP sockets to be opened.

Yeap.  1 socket by thread.  I will make that explicit.

Thanks, Juan.
