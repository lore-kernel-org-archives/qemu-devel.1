Received: from eggs.gnu.org ([2001:4830:134:3::10]:50151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cFKK6-0006gW-Gm
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cFKK0-00009J-Mf
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:30:46 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:57792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1cFKK0-00006n-7w
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:30:40 -0500
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-18-git-send-email-thuth@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <f799a151-782b-2945-453c-4a16d21abdc2@mail.uni-paderborn.de>
Date: Fri, 9 Dec 2016 13:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <1481285870-3396-18-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/20] tricore: Move CPU files to target/
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

On 12/09/2016 01:17 PM, Thomas Huth wrote:
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                          | 2 +-
>  {target-tricore => target/tricore}/Makefile.objs     | 0
>  {target-tricore => target/tricore}/cpu-qom.h         | 0
>  {target-tricore => target/tricore}/cpu.c             | 0
>  {target-tricore => target/tricore}/cpu.h             | 0
>  {target-tricore => target/tricore}/csfr.def          | 0
>  {target-tricore => target/tricore}/fpu_helper.c      | 0
>  {target-tricore => target/tricore}/helper.c          | 0
>  {target-tricore => target/tricore}/helper.h          | 0
>  {target-tricore => target/tricore}/op_helper.c       | 0
>  {target-tricore => target/tricore}/translate.c       | 0
>  {target-tricore => target/tricore}/tricore-defs.h    | 0
>  {target-tricore => target/tricore}/tricore-opcodes.h | 0
>  13 files changed, 1 insertion(+), 1 deletion(-)
>  rename {target-tricore => target/tricore}/Makefile.objs (100%)
>  rename {target-tricore => target/tricore}/cpu-qom.h (100%)
>  rename {target-tricore => target/tricore}/cpu.c (100%)
>  rename {target-tricore => target/tricore}/cpu.h (100%)
>  rename {target-tricore => target/tricore}/csfr.def (100%)
>  rename {target-tricore => target/tricore}/fpu_helper.c (100%)
>  rename {target-tricore => target/tricore}/helper.c (100%)
>  rename {target-tricore => target/tricore}/helper.h (100%)
>  rename {target-tricore => target/tricore}/op_helper.c (100%)
>  rename {target-tricore => target/tricore}/translate.c (100%)
>  rename {target-tricore => target/tricore}/tricore-defs.h (100%)
>  rename {target-tricore => target/tricore}/tricore-opcodes.h (100%)
> 

Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
    Bastian
