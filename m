Received: from eggs.gnu.org ([2001:4830:134:3::10]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhwDQ-0004hr-N0
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhwDP-0001oi-Me
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:10:24 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dhwDP-0001m5-H4
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:10:23 -0400
Received: by mail-wr0-x230.google.com with SMTP id b65so12536513wrd.0
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 04:10:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d17wf3vc.fsf@dusky.pond.sub.org>
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<20170728121044.15488-3-vadim.galitsyn@profitbricks.com>
	<20170815095114.014299c2@nial.brq.redhat.com>
	<CAPHE7Nrr9Y-F37PWS=rTS5hak09-_3v_R-T7KG+zQuy2L8U0jg@mail.gmail.com>
	<87d17wf3vc.fsf@dusky.pond.sub.org>
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Wed, 16 Aug 2017 13:10:02 +0200
Message-ID: <CAPHE7Np83SgbjQpTvX52Dep6fBnXMFG4sw2rynLTHVgz6sZMpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Hi Guys,

Thanks again! Just sent patch v6 which takes into account comments you left.

Best regards,
Vadim


On Wed, Aug 16, 2017 at 8:01 AM, Markus Armbruster <armbru@redhat.com>
wrote:

> Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:
>
> > Hi Guys,
> >
> > Thank you for the input!
> >
> >> "hotunpluggable" is ugly.  What about just "pluggable"?
> >
> > Markus, I think "pluggable" is a bit misleading here. Some people can
> take
> > it like a maximum amount of memory that can be hot-added to a guest
> (i.e.,
> > difference between static memory size and value specified with "-m
> > ...,maxmem=XXX"). I would say:
> >
> >   mem_info->plugged_memory = get_plugged_memory_size();
> >
> > ..since it reflects actual amount which was already hot-added. Agree?
>
> I like it.  Thanks!
>
> [...]
>
