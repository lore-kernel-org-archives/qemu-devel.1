Received: from eggs.gnu.org ([209.51.188.92]:53543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grk0x-0002ZE-0C
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grk0v-00083T-Qg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:46:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grk0v-00082b-50
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:46:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B06EC5856F
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 13:46:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-17-armbru@redhat.com>
	<0e7c814c-5d82-e9c0-3d53-bcc576019b65@redhat.com>
	<20190207122950.GA1854@andariel.pipo.sk>
Date: Thu, 07 Feb 2019 14:46:41 +0100
In-Reply-To: <20190207122950.GA1854@andariel.pipo.sk> (Peter Krempa's message
	of "Thu, 7 Feb 2019 13:29:50 +0100")
Message-ID: <87wombd83i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [libvirt] [PATCH v3 16/17] qmp: Deprecate
 query-events in favor of query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, libvirt-list@redhat.com, qemu-devel@nongnu.org

Peter Krempa <pkrempa@redhat.com> writes:

> On Wed, Feb 06, 2019 at 12:42:05 -0600, Eric Blake wrote:
>> Adding libvirt in cc
>> 
>> On 2/6/19 12:17 PM, Markus Armbruster wrote:
>> > query-events doesn't reflect compile-time configuration.  Instead of
>> > fixing that, deprecate the command in favor of query-qmp-schema.
>> > 
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  monitor.c            | 5 +++++
>> >  qapi/misc.json       | 7 +++++--
>> >  qemu-deprecated.texi | 5 +++++
>> >  3 files changed, 15 insertions(+), 2 deletions(-)
>> 
>> Libvirt uses query-events; we'll need to patch libvirt to start relying
>> on query-qmp-schema before this deprecation cycle can complete (although
>> I'm in favor of making the change).
>
> Patches to use 'query-qmp-schema' output rather than 'query-events' in
> libvirt:
>
> https://www.redhat.com/archives/libvir-list/2019-February/msg00298.html
>
> You can start the deprecation clock.

Awesome!
