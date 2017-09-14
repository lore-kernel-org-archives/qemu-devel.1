Received: from eggs.gnu.org ([2001:4830:134:3::10]:60190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsQyS-0005CM-72
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsQyM-00067p-6K
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsQyL-00066o-T5
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:02:14 -0400
Date: Thu, 14 Sep 2017 12:02:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170914120207.2dafdbfc@nial.brq.redhat.com>
In-Reply-To: <CAPHE7NpcDn4oOxZV4Bhz1P15HDg2sc0JftBtojaGSOTvm3=cHQ@mail.gmail.com>
References: <20170829153022.27004-1-vadim.galitsyn@profitbricks.com>
	<CAPHE7NpcDn4oOxZV4Bhz1P15HDg2sc0JftBtojaGSOTvm3=cHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/3] hmp, qmp: 'info memory_size_summary',
 'query-memory-size-summary', 'info numa' updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Thu, 14 Sep 2017 11:35:36 +0200
Vadim Galitsyn <vadim.galitsyn@profitbricks.com> wrote:

> Hi Guys,
> 
> Could you please let me know if you have an update on this topic?
Series looks good to me.
so with comments I've made fixed up

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> Thank you,
> Vadim
> 
> On Tue, Aug 29, 2017 at 5:30 PM, Vadim Galitsyn <
> vadim.galitsyn@profitbricks.com> wrote:  
> 
> > Hi Guys,
> >
> > Sorry for the delay. This is continuation of
> >   http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02937.html.
> >
> > I tried to update all the things according to your input
> > regarding to v6 series. I am attaching all the versions
> > history here in cover letter.
> >
> > Best regards,
> > Vadim
> >
> > v7:
> >  * hmp: 'info numa': 'struct numa_node_mem' ->
> >    'struct NumaNodeMem' (Eric);
> >
> >  * hmp: 'info numa': 'numa_node_mem.node_hotpluggable_mem' ->
> >    'NumaNodeMem.node_plugged_mem' (in order to follow the same
> >    naming schema as in the rest patches from this series);
> >
> >  * hmp: hmp_info_memory_size_summary() no longer
> >    uses &error_abort (David);
> >
> >  * qmp: documented when @plugged-memory info is omitted (Eric);
> >
> >  * qmp: added example usage of @query-memory-size-summary (Eric);
> >
> >  * qmp: 'Since: 2.10.0' -> 'Since: 2.11.0' (Eric);
> >
> >  * All commit messages updated according to Eric's recomendation.
> >
> > v6:
> >  * qmp: Renamed get_existing_hotpluggable_memory_size() ->
> >    get_plugged_memory_size();
> >
> >  * qmp: Renamed MemoryInfo.hotunpluggable_memory ->
> >    MemoryInfo.plugged_memory;
> >
> >  * qmp: Dropped superfluous parenthesis around the
> >    comparison while evaluating MemoryInfo.has_plugged_memory.
> >
> >  * hmp: Renamed 'info memory-size-summary' ->
> >    'info memory_size_summary'
> >
> > v5:
> >  * hmp: Updated description and '.help' message for
> >    'info memory-size-summary' command.
> >
> >  * hmp: Removed '-' characters from
> >    'info memory-size-summary' output.
> >
> >  * Dropped ballooned memory information.
> >
> >  * get_existing_hotpluggable_memory_size() assumed
> >    to never fail; routine now has no arguments and
> >    returns uint64_t; in case if target does not support
> >    memory hotplug, (uint64_t)-1 is returned.
> >
> >  * MemoryInfo structure:
> >    * Removed @balloon-actual-memory field.
> >    * Field @hotpluggable-memory renamed
> >      to @hotunpluggable-memory.
> >    * Updated description for fields.
> >
> >  * qmp: Updated description for
> >    query-memory-size-summary.
> >
> >  * Patch v4 splitted into series.
> >
> > v4:
> >  * Commands "info memory" and "query-memory" were renamed
> >    to "info memory-size-summary" and "query-memory-size-summary"
> >    correspondingly.
> >  * Descriptions for both commands as well as MemoryInfo structure
> >    fields were updated/renamed according to
> >    http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05972.html.
> >  * In MemoryInfo structure following fields are now optional:
> >    hotpluggable-memory and balloon-actual-memory.
> >  * Field "hotpluggable-memory" now not displayed in HMP if target
> >    has no CONFIG_MEM_HOTPLUG enabled.
> >  * Field "balloon-actual-memory" now not displayed in HMP if
> >    ballooning not enabled.
> >  * qapi_free_MemoryInfo() used in order to free corresponding memory
> >    instead of g_free().
> >  * #ifdef CONFIG_MEM_HOTPLUG was removed and replaced with stubs/ approach.
> >    get_exiting_hotpluggable_memory_size() function was introduced in
> >    hw/mem/pc-dimm.c (available for all targets which have
> > CONFIG_MEM_HOTPLUG
> >    enabled). For other targets, there is a stub in stubs/qmp_pc_dimm.c.
> >    In addition, stubs/qmp_pc_dimm_device_list.c was renamed to
> >    stubs/qmp_pc_dimm.c in order to reflect actual source file content.
> >  * Commit message was updated in order to reflect what was changed.
> >
> > v3:
> >  * Use PRIu64 instead of 'lu' when printing results via HMP.
> >  * Report zero hot-plugged memory instead of reporting error
> >    when target architecture has no CONFIG_MEM_HOTPLUG enabled.
> >
> > v2:
> >  * Fixed build for targets which do not have CONFIG_MEM_HOTPLUG
> >    enabled.
> >
> >
> >  
