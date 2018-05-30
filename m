Received: from eggs.gnu.org ([2001:4830:134:3::10]:47072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNy6a-0008M7-4c
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNy6Z-0000QV-61
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:13:20 -0400
Date: Wed, 30 May 2018 12:12:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180530121259.74bc4234.cohuck@redhat.com>
In-Reply-To: <20180528232719.4721-10-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-10-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/21] target: Do not include
 "exec/exec-all.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open
	list:S390" <qemu-s390x@nongnu.org>

On Mon, 28 May 2018 20:27:07 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Code change produced with:
>     $ git grep '#include "exec/exec-all.h"' | \
>       cut -d: -f-1 | \
>       xargs egrep -L "(cpu_address_space_init|cpu_loop_|tlb_|tb_|GETPC|si=
nglestep|TranslationBlock)" | \
>       xargs sed -i.bak '/#include "exec\/exec-all.h"/d'
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  bsd-user/qemu.h                        | 1 -
>  target/arm/arm_ldst.h                  | 1 -
>  hw/i386/kvmvapic.c                     | 1 -
>  target/arm/arm-powerctl.c              | 1 -
>  target/arm/crypto_helper.c             | 1 -
>  target/arm/iwmmxt_helper.c             | 1 -
>  target/arm/neon_helper.c               | 1 -
>  target/arm/psci.c                      | 1 -
>  target/arm/vec_helper.c                | 1 -
>  target/cris/cpu.c                      | 1 -
>  target/hppa/helper.c                   | 1 -
>  target/hppa/int_helper.c               | 1 -
>  target/i386/hax-all.c                  | 1 -
>  target/i386/hax-mem.c                  | 1 -
>  target/i386/hax-windows.c              | 1 -
>  target/i386/hvf/hvf.c                  | 1 -
>  target/i386/hvf/x86_task.c             | 1 -
>  target/i386/whpx-all.c                 | 1 -
>  target/lm32/cpu.c                      | 1 -
>  target/m68k/cpu.c                      | 1 -
>  target/moxie/cpu.c                     | 1 -
>  target/moxie/mmu.c                     | 1 -
>  target/openrisc/cpu.c                  | 1 -
>  target/ppc/int_helper.c                | 1 -
>  target/s390x/cpu.c                     | 1 -
>  target/s390x/diag.c                    | 1 -
>  target/s390x/helper.c                  | 1 -
>  target/tilegx/cpu.c                    | 1 -
>  target/xtensa/core-dc232b.c            | 1 -
>  target/xtensa/core-dc233c.c            | 1 -
>  target/xtensa/core-de212.c             | 1 -
>  target/xtensa/core-fsf.c               | 1 -
>  target/xtensa/core-sample_controller.c | 1 -
>  target/xtensa/cpu.c                    | 1 -
>  tcg/tcg-op-vec.c                       | 1 -
>  target/xtensa/import_core.sh           | 1 -
>  36 files changed, 36 deletions(-)
>=20

However you arrived at it, this looks sane, so

Acked-by: Cornelia Huck <cohuck@redhat.com>
