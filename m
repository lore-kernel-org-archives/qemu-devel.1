Received: from eggs.gnu.org ([2001:4830:134:3::10]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cbsWS-0008Rb-8Y
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cbsWP-0002oo-0q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:28:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cbsWO-0002oY-Rn
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:28:40 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10782935F7
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 17:28:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <03f9756e-971f-3b30-36d6-4b65d859479e@redhat.com> (Eric Blake's
	message of "Thu, 2 Feb 2017 09:06:11 -0600")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-7-git-send-email-quintela@redhat.com>
	<03f9756e-971f-3b30-36d6-4b65d859479e@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 09 Feb 2017 18:28:37 +0100
Message-ID: <87vasjnuii.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/17] migration: Create x-multifd-threads
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 01/23/2017 03:32 PM, Juan Quintela wrote:
>> Indicates the number of threads that we would create.  By default we
>> create 2 threads.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>
>> +++ b/qapi-schema.json
>> @@ -981,13 +981,17 @@
>>  # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
>>  #          periodic mode. (Since 2.8)
>>  #
>> +# @x-multifd-threads: Number of threads used to migrate data in parallel
>> +#                     The default value is 2 (since 2.9)
>
>
>> +#
>> +# @x-multifd-threads: Number of threads used to migrate data in parallel
>> +#                     The default value is 1 (since 2.9)
>
> So which is it? I understand why you document it twice (one for setting
> the value, and one for listing the current setting), but not why you
> have two different defaults.

Because of copy & paste, and only updating one of the places.

Move both of them to 2.

Thanks, Juan.
