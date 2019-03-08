Received: from eggs.gnu.org ([209.51.188.92]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2EPF-00020u-Kk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2EPA-0001SD-Rp
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:15:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2EPA-0001F5-JI
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:15:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AA8081E18
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 12:15:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<20190308103532.GF12318@stefanha-x1.localdomain>
Date: Fri, 08 Mar 2019 13:15:01 +0100
In-Reply-To: <20190308103532.GF12318@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 8 Mar 2019 10:35:32 +0000")
Message-ID: <87imwtef5m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, Feb 22, 2019 at 03:32:54PM +0000, Stefan Hajnoczi wrote:
>> QMP clients can usually detect the presence of features via schema
>> introspection.  There are rare features that do not involve schema
>> changes and are therefore impossible to detect with schema
>> introspection.
>> 
>> This patch adds the query-qemu-capabilities command.  It returns a list
>> of capabilities that this QEMU supports.
>> 
>> The decision to make this a command rather than something statically
>> defined in the schema is intentional.  It allows QEMU to decide which
>> capabilities are available at runtime, if necessary.
>> 
>> This new interface is necessary so that QMP clients can discover that
>> migrating disk image files is safe with cache.direct=off on Linux.
>> There is no other way to detect whether or not QEMU supports this.
>> 
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Peter Krempa <pkrempa@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  qapi/misc.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  qmp.c          | 18 ++++++++++++++++++
>>  2 files changed, 60 insertions(+)
>
> Markus: query-qemu-features is no longer needed by the page cache
> invalidation feature since a related QMP schema change is being made now
> and clients can detect the feature via that change.
>
> I'm inclined to leave this patch series for now.  Later someone can pick
> it up again if there is a feature that cannot be detected via a schema
> change.

Mekse sense.  I figure we'll likely want the command at some point.  And
that's when we should add it.  Hold on to your git branch until then.
