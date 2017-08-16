Received: from eggs.gnu.org ([2001:4830:134:3::10]:58462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrOJ-0001Hm-GN
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrOG-0004o7-G4
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhrOG-0004nD-9z
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:01:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<20170728121044.15488-3-vadim.galitsyn@profitbricks.com>
	<20170815095114.014299c2@nial.brq.redhat.com>
	<CAPHE7Nrr9Y-F37PWS=rTS5hak09-_3v_R-T7KG+zQuy2L8U0jg@mail.gmail.com>
Date: Wed, 16 Aug 2017 08:01:11 +0200
In-Reply-To: <CAPHE7Nrr9Y-F37PWS=rTS5hak09-_3v_R-T7KG+zQuy2L8U0jg@mail.gmail.com>
	(Vadim Galitsyn's message of "Tue, 15 Aug 2017 17:43:00 +0200")
Message-ID: <87d17wf3vc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/3] qmp: introduce
 query-memory-size-summary command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:

> Hi Guys,
>
> Thank you for the input!
>
>> "hotunpluggable" is ugly.  What about just "pluggable"?
>
> Markus, I think "pluggable" is a bit misleading here. Some people can take
> it like a maximum amount of memory that can be hot-added to a guest (i.e.,
> difference between static memory size and value specified with "-m
> ...,maxmem=XXX"). I would say:
>
>   mem_info->plugged_memory = get_plugged_memory_size();
>
> ..since it reflects actual amount which was already hot-added. Agree?

I like it.  Thanks!

[...]
