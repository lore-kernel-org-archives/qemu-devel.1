Received: from eggs.gnu.org ([2001:4830:134:3::10]:34166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbj8B-0001ra-EV
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbj85-0006mo-DG
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:27:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cbj85-0006mk-6x
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:26:57 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 153B3C05AA41
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 07:26:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1486569864-17005-1-git-send-email-armbru@redhat.com>
	<1486569864-17005-2-git-send-email-armbru@redhat.com>
	<6aa70c19-2c6a-a865-756d-3c10f47bbd35@redhat.com>
Date: Thu, 09 Feb 2017 08:26:54 +0100
In-Reply-To: <6aa70c19-2c6a-a865-756d-3c10f47bbd35@redhat.com> (Eric Blake's
	message of "Wed, 8 Feb 2017 13:21:22 -0600")
Message-ID: <87vasjakox.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] numa: Turn simple union NumaOptions
 into a flat union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/08/2017 10:04 AM, Markus Armbruster wrote:
>> Simple unions are simpler than flat unions in the schema, but more
>> complicated in C and on the QMP wire: there's extra indirection in C
>> and extra nesting on the wire, both pointless.  They're best avoided
>> in new code.
>> 
>> NumaOptions isn't new, but it's only used internally, not in QMP.
>> Convert it to a flat union.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  numa.c           | 4 ++--
>>  qapi-schema.json | 8 ++++++++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>> 
>
>> +++ b/qapi-schema.json
>> @@ -5545,6 +5545,12 @@
>>              'events' : [ 'InputEvent' ] } }
>>  
>>  ##
>> +# @NumaOptionsType:
>> +##
>
> Do we want a 'Since: 2.1' designation (since the enum has effectively
> existed, even if implicitly, for as long as NumaOptions has been around)?

Version tracking is useful only for things visible external interfaces,
which this is not.  Tool support to require it for external and reject
it for internal stuff would be nice.  Until then, we need to rely on
review to get external stuff tracked properly.

Tracking internal stuff is busywork.  If we think it's less work than
deciding internal vs. external, we can slap on "Since:" blindly.

> With or without that extra line,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
