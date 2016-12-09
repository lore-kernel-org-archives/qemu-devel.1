Received: from eggs.gnu.org ([2001:4830:134:3::10]:53330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cFOHs-0003cp-IB
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cFOHo-0003qA-JY
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:44:44 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cFOHo-0003py-Fp
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:44:40 -0500
Received: by mail-qt0-f196.google.com with SMTP id m48so2671037qta.2
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 08:44:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-5-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d97adbfc-d860-5038-c48e-4dd7aa2144bb@twiddle.net>
Date: Fri, 9 Dec 2016 08:43:34 -0800
MIME-Version: 1.0
In-Reply-To: <1481285870-3396-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/20] alpha: Move CPU files to target/
 folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

On 12/09/2016 04:17 AM, Thomas Huth wrote:
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                  | 2 +-
>  hw/alpha/alpha_sys.h                         | 2 +-
>  {target-alpha => target/alpha}/Makefile.objs | 0
>  {target-alpha => target/alpha}/STATUS        | 0
>  {target-alpha => target/alpha}/cpu-qom.h     | 0
>  {target-alpha => target/alpha}/cpu.c         | 0
>  {target-alpha => target/alpha}/cpu.h         | 0
>  {target-alpha => target/alpha}/fpu_helper.c  | 0
>  {target-alpha => target/alpha}/gdbstub.c     | 0
>  {target-alpha => target/alpha}/helper.c      | 0
>  {target-alpha => target/alpha}/helper.h      | 0
>  {target-alpha => target/alpha}/int_helper.c  | 0
>  {target-alpha => target/alpha}/machine.c     | 0
>  {target-alpha => target/alpha}/mem_helper.c  | 0
>  {target-alpha => target/alpha}/sys_helper.c  | 0
>  {target-alpha => target/alpha}/translate.c   | 0
>  {target-alpha => target/alpha}/vax_helper.c  | 0
>  17 files changed, 2 insertions(+), 2 deletions(-)
>  rename {target-alpha => target/alpha}/Makefile.objs (100%)
>  rename {target-alpha => target/alpha}/STATUS (100%)
>  rename {target-alpha => target/alpha}/cpu-qom.h (100%)
>  rename {target-alpha => target/alpha}/cpu.c (100%)
>  rename {target-alpha => target/alpha}/cpu.h (100%)
>  rename {target-alpha => target/alpha}/fpu_helper.c (100%)
>  rename {target-alpha => target/alpha}/gdbstub.c (100%)
>  rename {target-alpha => target/alpha}/helper.c (100%)
>  rename {target-alpha => target/alpha}/helper.h (100%)
>  rename {target-alpha => target/alpha}/int_helper.c (100%)
>  rename {target-alpha => target/alpha}/machine.c (100%)
>  rename {target-alpha => target/alpha}/mem_helper.c (100%)
>  rename {target-alpha => target/alpha}/sys_helper.c (100%)
>  rename {target-alpha => target/alpha}/translate.c (100%)
>  rename {target-alpha => target/alpha}/vax_helper.c (100%)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
