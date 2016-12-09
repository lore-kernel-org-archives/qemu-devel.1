Received: from eggs.gnu.org ([2001:4830:134:3::10]:52005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cFKSF-0007oV-MC
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cFKSB-0003Ig-OH
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:39:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cFKSB-0003IV-Fn
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:39:07 -0500
Date: Fri, 9 Dec 2016 10:39:04 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161209123903.GP4027@thinpad.lan.raisama.net>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-8-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481285870-3396-8-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/20] i386: Move CPU files to target/
 folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Fri, Dec 09, 2016 at 01:17:37PM +0100, Thomas Huth wrote:
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  MAINTAINERS                                          | 4 ++--
>  Makefile.objs                                        | 2 +-
>  hw/i386/acpi-build.c                                 | 2 +-
>  hw/i386/kvm/apic.c                                   | 2 +-
>  hw/intc/ioapic.c                                     | 2 +-
>  hw/misc/hyperv_testdev.c                             | 2 +-
>  scripts/analyze-inclusions                           | 6 +++---
>  {target-i386 => target/i386}/Makefile.objs           | 0
>  {target-i386 => target/i386}/TODO                    | 0
>  {target-i386 => target/i386}/arch_dump.c             | 0
>  {target-i386 => target/i386}/arch_memory_mapping.c   | 0
>  {target-i386 => target/i386}/bpt_helper.c            | 0
>  {target-i386 => target/i386}/cc_helper.c             | 0
>  {target-i386 => target/i386}/cc_helper_template.h    | 0
>  {target-i386 => target/i386}/cpu-qom.h               | 0
>  {target-i386 => target/i386}/cpu.c                   | 0
>  {target-i386 => target/i386}/cpu.h                   | 0
>  {target-i386 => target/i386}/excp_helper.c           | 0
>  {target-i386 => target/i386}/fpu_helper.c            | 0
>  {target-i386 => target/i386}/gdbstub.c               | 0
>  {target-i386 => target/i386}/helper.c                | 0
>  {target-i386 => target/i386}/helper.h                | 0
>  {target-i386 => target/i386}/hyperv.c                | 0
>  {target-i386 => target/i386}/hyperv.h                | 0
>  {target-i386 => target/i386}/int_helper.c            | 0
>  {target-i386 => target/i386}/kvm-stub.c              | 0
>  {target-i386 => target/i386}/kvm.c                   | 0
>  {target-i386 => target/i386}/kvm_i386.h              | 0
>  {target-i386 => target/i386}/machine.c               | 0
>  {target-i386 => target/i386}/mem_helper.c            | 0
>  {target-i386 => target/i386}/misc_helper.c           | 0
>  {target-i386 => target/i386}/monitor.c               | 0
>  {target-i386 => target/i386}/mpx_helper.c            | 0
>  {target-i386 => target/i386}/ops_sse.h               | 0
>  {target-i386 => target/i386}/ops_sse_header.h        | 0
>  {target-i386 => target/i386}/seg_helper.c            | 0
>  {target-i386 => target/i386}/shift_helper_template.h | 0
>  {target-i386 => target/i386}/smm_helper.c            | 0
>  {target-i386 => target/i386}/svm.h                   | 0
>  {target-i386 => target/i386}/svm_helper.c            | 0
>  {target-i386 => target/i386}/trace-events            | 2 +-
>  {target-i386 => target/i386}/translate.c             | 0
>  42 files changed, 11 insertions(+), 11 deletions(-)
>  rename {target-i386 => target/i386}/Makefile.objs (100%)
>  rename {target-i386 => target/i386}/TODO (100%)
>  rename {target-i386 => target/i386}/arch_dump.c (100%)
>  rename {target-i386 => target/i386}/arch_memory_mapping.c (100%)
>  rename {target-i386 => target/i386}/bpt_helper.c (100%)
>  rename {target-i386 => target/i386}/cc_helper.c (100%)
>  rename {target-i386 => target/i386}/cc_helper_template.h (100%)
>  rename {target-i386 => target/i386}/cpu-qom.h (100%)
>  rename {target-i386 => target/i386}/cpu.c (100%)
>  rename {target-i386 => target/i386}/cpu.h (100%)
>  rename {target-i386 => target/i386}/excp_helper.c (100%)
>  rename {target-i386 => target/i386}/fpu_helper.c (100%)
>  rename {target-i386 => target/i386}/gdbstub.c (100%)
>  rename {target-i386 => target/i386}/helper.c (100%)
>  rename {target-i386 => target/i386}/helper.h (100%)
>  rename {target-i386 => target/i386}/hyperv.c (100%)
>  rename {target-i386 => target/i386}/hyperv.h (100%)
>  rename {target-i386 => target/i386}/int_helper.c (100%)
>  rename {target-i386 => target/i386}/kvm-stub.c (100%)
>  rename {target-i386 => target/i386}/kvm.c (100%)
>  rename {target-i386 => target/i386}/kvm_i386.h (100%)
>  rename {target-i386 => target/i386}/machine.c (100%)
>  rename {target-i386 => target/i386}/mem_helper.c (100%)
>  rename {target-i386 => target/i386}/misc_helper.c (100%)
>  rename {target-i386 => target/i386}/monitor.c (100%)
>  rename {target-i386 => target/i386}/mpx_helper.c (100%)
>  rename {target-i386 => target/i386}/ops_sse.h (100%)
>  rename {target-i386 => target/i386}/ops_sse_header.h (100%)
>  rename {target-i386 => target/i386}/seg_helper.c (100%)
>  rename {target-i386 => target/i386}/shift_helper_template.h (100%)
>  rename {target-i386 => target/i386}/smm_helper.c (100%)
>  rename {target-i386 => target/i386}/svm.h (100%)
>  rename {target-i386 => target/i386}/svm_helper.c (100%)
>  rename {target-i386 => target/i386}/trace-events (94%)
>  rename {target-i386 => target/i386}/translate.c (100%)
[...]

-- 
Eduardo
