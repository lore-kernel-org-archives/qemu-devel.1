Received: from eggs.gnu.org ([2001:4830:134:3::10]:49503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cFKGH-0001sk-DR
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cFKGC-00077B-Rd
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:26:48 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:58087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cFKGC-00075m-Gd
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:26:44 -0500
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-4-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8e021a31-a090-8b8e-5978-10e541051441@vivier.eu>
Date: Fri, 9 Dec 2016 13:26:04 +0100
MIME-Version: 1.0
In-Reply-To: <1481285870-3396-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/20] m68k: Move CPU files to target/
 folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Le 09/12/2016 à 13:17, Thomas Huth a écrit :
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                | 2 +-
>  include/hw/m68k/mcf.h                      | 2 +-
>  {target-m68k => target/m68k}/Makefile.objs | 0
>  {target-m68k => target/m68k}/cpu-qom.h     | 0
>  {target-m68k => target/m68k}/cpu.c         | 0
>  {target-m68k => target/m68k}/cpu.h         | 0
>  {target-m68k => target/m68k}/gdbstub.c     | 0
>  {target-m68k => target/m68k}/helper.c      | 0
>  {target-m68k => target/m68k}/helper.h      | 0
>  {target-m68k => target/m68k}/m68k-semi.c   | 0
>  {target-m68k => target/m68k}/op_helper.c   | 0
>  {target-m68k => target/m68k}/qregs.def     | 0
>  {target-m68k => target/m68k}/translate.c   | 0
>  13 files changed, 2 insertions(+), 2 deletions(-)
>  rename {target-m68k => target/m68k}/Makefile.objs (100%)
>  rename {target-m68k => target/m68k}/cpu-qom.h (100%)
>  rename {target-m68k => target/m68k}/cpu.c (100%)
>  rename {target-m68k => target/m68k}/cpu.h (100%)
>  rename {target-m68k => target/m68k}/gdbstub.c (100%)
>  rename {target-m68k => target/m68k}/helper.c (100%)
>  rename {target-m68k => target/m68k}/helper.h (100%)
>  rename {target-m68k => target/m68k}/m68k-semi.c (100%)
>  rename {target-m68k => target/m68k}/op_helper.c (100%)
>  rename {target-m68k => target/m68k}/qregs.def (100%)
>  rename {target-m68k => target/m68k}/translate.c (100%)

Acked-by: Laurent Vivier <laurent@vivier.eu>
