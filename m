Received: from eggs.gnu.org ([2001:4830:134:3::10]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1db4D7-00047u-DI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1db4D2-0001gf-Rq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:17:41 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1db4D2-0001gN-Li
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:17:36 -0400
Received: by mail-wm0-x235.google.com with SMTP id e199so18488210wmd.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:17:36 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Fri, 28 Jul 2017 14:10:41 +0200
Message-Id: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
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
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

Hi Guys,

This thread is a continuation of discussion from:
  http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01565.html

I will post changes list here in cover letter.

v5:
 * hmp: Updated description and '.help' message for
   'info memory-size-summary' command.

 * hmp: Removed '-' characters from
   'info memory-size-summary' output.

 * Dropped ballooned memory information.

 * get_existing_hotpluggable_memory_size() assumed
   to never fail; routine now has no arguments and
   returns uint64_t; in case if target does not support
   memory hotplug, (uint64_t)-1 is returned.

 * MemoryInfo structure:
   * Removed @balloon-actual-memory field.
   * Field @hotpluggable-memory renamed
     to @hotunpluggable-memory.
   * Updated description for fields.

 * qmp: Updated description for
   query-memory-size-summary.

 * Patch v4 splitted into series.

v4:
 * Commands "info memory" and "query-memory" were renamed
   to "info memory-size-summary" and "query-memory-size-summary"
   correspondingly.
 * Descriptions for both commands as well as MemoryInfo structure
   fields were updated/renamed according to
   http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05972.html.
 * In MemoryInfo structure following fields are now optional:
   hotpluggable-memory and balloon-actual-memory.
 * Field "hotpluggable-memory" now not displayed in HMP if target
   has no CONFIG_MEM_HOTPLUG enabled.
 * Field "balloon-actual-memory" now not displayed in HMP if
   ballooning not enabled.
 * qapi_free_MemoryInfo() used in order to free corresponding memory
   instead of g_free().
 * #ifdef CONFIG_MEM_HOTPLUG was removed and replaced with stubs/ approach.
   get_exiting_hotpluggable_memory_size() function was introduced in
   hw/mem/pc-dimm.c (available for all targets which have CONFIG_MEM_HOTPLUG
   enabled). For other targets, there is a stub in stubs/qmp_pc_dimm.c.
   In addition, stubs/qmp_pc_dimm_device_list.c was renamed to
   stubs/qmp_pc_dimm.c in order to reflect actual source file content.
 * Commit message was updated in order to reflect what was changed.

v3:
 * Use PRIu64 instead of 'lu' when printing results via HMP.
 * Report zero hot-plugged memory instead of reporting error
   when target architecture has no CONFIG_MEM_HOTPLUG enabled.

v2:
 * Fixed build for targets which do not have CONFIG_MEM_HOTPLUG
   enabled.

Best regards,
Vadim
