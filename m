Received: from eggs.gnu.org ([2001:4830:134:3::10]:54093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7vaQ-0004dT-Mm
	for qemu-devel@nongnu.org; Mon, 08 May 2017 23:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7vaM-00009g-Mi
	for qemu-devel@nongnu.org; Mon, 08 May 2017 23:13:18 -0400
Date: Tue, 9 May 2017 00:13:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170509031306.GY3482@thinpad.lan.raisama.net>
References: <20170508205735.23444-1-ehabkost@redhat.com>
	<149428405745.258.3104767309694984726@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149428405745.258.3104767309694984726@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] arch_init: Move soundhw code to
 hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, hpoussin@reactos.org, agraf@suse.de, qemu-ppc@nongnu.org, kraxel@redhat.com, david@gibson.dropbear.id.au

On Mon, May 08, 2017 at 03:54:18PM -0700, no-reply@patchew.org wrote:
[...]
> === OUTPUT BEGIN ===
> Checking PATCH 1/3: audio: Move arch_init audio code to hw/audio/soundhw.c...
> ERROR: suspect code indent for conditional statements (8, 13)
> #240: FILE: hw/audio/soundhw.c:76:
> +        if (soundhw_count) {
> +             printf("Valid sound card names (comma separated):\n");
> 
> ERROR: suspect code indent for conditional statements (13, 17)
> #242: FILE: hw/audio/soundhw.c:78:
> +             for (c = soundhw; c->name; ++c) {
> +                 printf ("%-11s %s\n", c->name, c->descr);
> 
> ERROR: space prohibited between function name and open parenthesis '('
> #243: FILE: hw/audio/soundhw.c:79:
> +                 printf ("%-11s %s\n", c->name, c->descr);
> 
> ERROR: else should follow close brace '}'
> #252: FILE: hw/audio/soundhw.c:88:
> +    }
> +    else {
> 
> ERROR: else should follow close brace '}'
> #281: FILE: hw/audio/soundhw.c:117:
> +                }
> +                else {
> 
> WARNING: line over 80 characters
> #299: FILE: hw/audio/soundhw.c:135:
> +    ISABus *isa_bus = (ISABus *) object_resolve_path_type("", TYPE_ISA_BUS, NULL);
> 
> WARNING: line over 80 characters
> #300: FILE: hw/audio/soundhw.c:136:
> +    PCIBus *pci_bus = (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NULL);
> 
> total: 5 errors, 2 warnings, 320 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

The style problems are not in new code, but in code being moved
to another file. If anybody wants to volunteer to fix those
issues, they should be addressed in follow-up patches.

-- 
Eduardo
