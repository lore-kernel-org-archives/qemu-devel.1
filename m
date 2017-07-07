Received: from eggs.gnu.org ([2001:4830:134:3::10]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTP5w-0007T9-Cl
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTP5t-0007jM-BK
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:58:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTP5t-0007he-2b
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:58:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170630133139.7907-1-vadim.galitsyn@profitbricks.com>
	<20170630133139.7907-2-vadim.galitsyn@profitbricks.com>
	<87lgo0900x.fsf@dusky.pond.sub.org> <20170707080646.GA2101@work-vm>
Date: Fri, 07 Jul 2017 10:58:29 +0200
In-Reply-To: <20170707080646.GA2101@work-vm> (David Alan Gilbert's message of
	"Fri, 7 Jul 2017 09:06:47 +0100")
Message-ID: <87k23k39oq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] hmp,
 qmp: introduce memory-size-summary commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mohammed Gamal <mohammed.gamal@profitbricks.com>, Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, qemu-devel@nongnu.org, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>, Igor Mammedov <imammedo@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Sorry for the late review, got a bit overwhelmed...
>> 
>> Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:
>> 
>> > Commands above provide the following memory information in bytes:
>> >
>> >   * base-memory - amount of unremovable memory specified
>> >     with '-m' option at the start of the QEMU process.
>> >
>> >   * hotpluggable-memory - amount of memory that was hot-plugged.
>> >     If target does not have CONFIG_MEM_HOTPLUG enabled, no
>> >     value is reported.
>> >
>> >   * balloon-actual-memory - size of the memory that remains
>> >     available to the guest after ballooning, as reported by the
>> >     guest. If the guest has not reported its memory, this value
>> >     equals to @base-memory + @hot-plug-memory. If ballooning
>> >     is not enabled, no value is reported.
>> >
>> > NOTE:
>> >
>> >     Parameter @balloon-actual-memory reports the same as
>> >     "info balloon" command when ballooning is enabled. The idea
>> >     to have it in scope of this command(s) comes from
>> >     https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html.
[...]
>> >  hmp-commands-info.hx                               | 17 ++++++++++++
>> >  hmp.c                                              | 23 ++++++++++++++++
>> >  hmp.h                                              |  1 +
>> >  hw/mem/pc-dimm.c                                   |  6 +++++
>> >  include/hw/mem/pc-dimm.h                           |  1 +
>> >  qapi-schema.json                                   | 28 +++++++++++++++++++
>> >  qmp.c                                              | 31 ++++++++++++++++++++++
>> >  stubs/Makefile.objs                                |  2 +-
>> >  stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} |  5 ++++
>> >  9 files changed, 113 insertions(+), 1 deletion(-)
>> >  rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (60%)
>> 
>> No test coverage?
>> 
>> I prefer to add pairs of QMP / HMP commands in separate patches, QMP
>> first, for easier review.  This patch seems small enough to tolerate
>> adding them in a single patch.  But do consider splitting if you have to
>> respin.
>
> The HMP tester scans all 'info' commands so it's not needed for the HMP
> side.

Correct.  I want a similar test for QMP, but I'm not asking Vadim to
provide it :)
