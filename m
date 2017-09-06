Received: from eggs.gnu.org ([2001:4830:134:3::10]:34333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpdvQ-0004bH-1y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpdvL-0005vc-1y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:15:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpdvK-0005vK-Rw
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:15:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFBCBC049D7F
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 17:15:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1504696921.git.mprivozn@redhat.com>
	<6f78df0d8af98d89bdae1d189c0e21ba7ca3ead9.1504696921.git.mprivozn@redhat.com>
	<a0f4b8e2-cdc3-e342-0cd2-3b144ad5cc7f@redhat.com>
Date: Wed, 06 Sep 2017 19:15:32 +0200
In-Reply-To: <a0f4b8e2-cdc3-e342-0cd2-3b144ad5cc7f@redhat.com> (Eric Blake's
	message of "Wed, 6 Sep 2017 10:39:18 -0500")
Message-ID: <8760cvsq8b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/3] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 09/06/2017 06:24 AM, Michal Privoznik wrote:
>> Currently, the only time that users can set watchdog action is at
>> the start as all we expose is this -watchdog-action command line
>> argument. This is suboptimal when users want to plug the device
>> later via monitor. Alternatively, they might want to change the
>> action for already existing device on the fly.
>> 
>> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1447169
>> 
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>  hw/watchdog/watchdog.c | 8 +++++++-
>>  qapi-schema.json       | 9 +++++++++
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>> 
>
>> +++ b/qapi-schema.json
>> @@ -3143,3 +3143,12 @@
>>  # Since 2.9
>>  ##
>>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> +
>> +##
>> +# @watchdog-set-action:
>> +#
>> +# Set watchdog action
>> +#
>> +# Since 2.11
>> +##
>> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
>
> Markus went to some effort to sort the documentation output; is plopping
> this at the end of the file the best location?

This patch won't regress any of my work, as I only moved stuff out of
qapi-schema-json, I didn't reorder within.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>
