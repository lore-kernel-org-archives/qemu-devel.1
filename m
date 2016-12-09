Received: from eggs.gnu.org ([2001:4830:134:3::10]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cFKUG-0005qi-Cn
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cFKUC-0003nW-6w
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:41:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cFKUB-0003n7-UP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:41:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9CSepb056914
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 07:41:08 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277ru1mrxw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:41:08 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 9 Dec 2016 12:41:04 -0000
Date: Fri, 9 Dec 2016 13:40:54 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1481285870-3396-11-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-11-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161209134054.4b679d81.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 10/20] s390x: Move CPU files to target/
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Fri,  9 Dec 2016 13:17:40 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                       | 8 ++++----
>  Makefile.objs                                     | 2 +-
>  {target-s390x => target/s390x}/Makefile.objs      | 2 +-
>  {target-s390x => target/s390x}/arch_dump.c        | 0
>  {target-s390x => target/s390x}/cc_helper.c        | 0
>  {target-s390x => target/s390x}/cpu-qom.h          | 0
>  {target-s390x => target/s390x}/cpu.c              | 0
>  {target-s390x => target/s390x}/cpu.h              | 0
>  {target-s390x => target/s390x}/cpu_features.c     | 0
>  {target-s390x => target/s390x}/cpu_features.h     | 0
>  {target-s390x => target/s390x}/cpu_features_def.h | 0
>  {target-s390x => target/s390x}/cpu_models.c       | 0
>  {target-s390x => target/s390x}/cpu_models.h       | 0
>  {target-s390x => target/s390x}/fpu_helper.c       | 0
>  {target-s390x => target/s390x}/gdbstub.c          | 0
>  {target-s390x => target/s390x}/gen-features.c     | 0
>  {target-s390x => target/s390x}/helper.c           | 0
>  {target-s390x => target/s390x}/helper.h           | 0
>  {target-s390x => target/s390x}/insn-data.def      | 0
>  {target-s390x => target/s390x}/insn-format.def    | 0
>  {target-s390x => target/s390x}/int_helper.c       | 0
>  {target-s390x => target/s390x}/interrupt.c        | 0
>  {target-s390x => target/s390x}/ioinst.c           | 0
>  {target-s390x => target/s390x}/kvm.c              | 0
>  {target-s390x => target/s390x}/machine.c          | 0
>  {target-s390x => target/s390x}/mem_helper.c       | 0
>  {target-s390x => target/s390x}/misc_helper.c      | 0
>  {target-s390x => target/s390x}/mmu_helper.c       | 0
>  {target-s390x => target/s390x}/trace-events       | 8 ++++----
>  {target-s390x => target/s390x}/translate.c        | 0
>  30 files changed, 10 insertions(+), 10 deletions(-)
>  rename {target-s390x => target/s390x}/Makefile.objs (94%)
>  rename {target-s390x => target/s390x}/arch_dump.c (100%)
>  rename {target-s390x => target/s390x}/cc_helper.c (100%)
>  rename {target-s390x => target/s390x}/cpu-qom.h (100%)
>  rename {target-s390x => target/s390x}/cpu.c (100%)
>  rename {target-s390x => target/s390x}/cpu.h (100%)
>  rename {target-s390x => target/s390x}/cpu_features.c (100%)
>  rename {target-s390x => target/s390x}/cpu_features.h (100%)
>  rename {target-s390x => target/s390x}/cpu_features_def.h (100%)
>  rename {target-s390x => target/s390x}/cpu_models.c (100%)
>  rename {target-s390x => target/s390x}/cpu_models.h (100%)
>  rename {target-s390x => target/s390x}/fpu_helper.c (100%)
>  rename {target-s390x => target/s390x}/gdbstub.c (100%)
>  rename {target-s390x => target/s390x}/gen-features.c (100%)
>  rename {target-s390x => target/s390x}/helper.c (100%)
>  rename {target-s390x => target/s390x}/helper.h (100%)
>  rename {target-s390x => target/s390x}/insn-data.def (100%)
>  rename {target-s390x => target/s390x}/insn-format.def (100%)
>  rename {target-s390x => target/s390x}/int_helper.c (100%)
>  rename {target-s390x => target/s390x}/interrupt.c (100%)
>  rename {target-s390x => target/s390x}/ioinst.c (100%)
>  rename {target-s390x => target/s390x}/kvm.c (100%)
>  rename {target-s390x => target/s390x}/machine.c (100%)
>  rename {target-s390x => target/s390x}/mem_helper.c (100%)
>  rename {target-s390x => target/s390x}/misc_helper.c (100%)
>  rename {target-s390x => target/s390x}/mmu_helper.c (100%)
>  rename {target-s390x => target/s390x}/trace-events (91%)
>  rename {target-s390x => target/s390x}/translate.c (100%)

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
