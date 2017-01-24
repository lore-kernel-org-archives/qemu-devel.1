Received: from eggs.gnu.org ([2001:4830:134:3::10]:57013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cW0Q8-00005U-SS
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cW0Q7-0003Wf-Sb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:41:56 -0500
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:33481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cW0Q7-0003WT-Lc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:41:55 -0500
Received: by mail-io0-x236.google.com with SMTP id v96so70849125ioi.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:41:53 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <20170124092820.23832-1-cornelia.huck@de.ibm.com>
References: <20170124092820.23832-1-cornelia.huck@de.ibm.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Tue, 24 Jan 2017 13:41:32 +0100
Message-ID: <CAP_ceTwZW-13b7wtnWZ3kGbERuqMfXO1DswyTP-PS4OXeHuEFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/kvm: include hw_accel.h instead of
 kvm.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, jfrei@linux.vnet.ibm.com, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 24, 2017 at 10:28 AM, Cornelia Huck
<cornelia.huck@de.ibm.com> wrote:
>
> Commit b394662 ("kvm: move cpu synchronization code") switched
> to hw_accel.h instead of kvm.h, but missed s390x, resulting in
>
>   CC      s390x-softmmu/target/s390x/kvm.o
> /home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98kvm_sclp_s=
ervice_call=E2=80=99:
> /home/cohuck/git/qemu/target/s390x/kvm.c:1034:5: error: implicit declarat=
ion of function =E2=80=98cpu_synchronize_state=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]
>      cpu_synchronize_state(CPU(cpu));
>      ^
> /home/cohuck/git/qemu/target/s390x/kvm.c:1034:5: error: nested extern dec=
laration of =E2=80=98cpu_synchronize_state=E2=80=99 [-Werror=3Dnested-exter=
ns]
> /home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98sigp_initi=
al_cpu_reset=E2=80=99:
> /home/cohuck/git/qemu/target/s390x/kvm.c:1628:5: error: implicit declarat=
ion of function =E2=80=98cpu_synchronize_post_reset=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
>      cpu_synchronize_post_reset(cs);
>      ^
> /home/cohuck/git/qemu/target/s390x/kvm.c:1628:5: error: nested extern dec=
laration of =E2=80=98cpu_synchronize_post_reset=E2=80=99 [-Werror=3Dnested-=
externs]
> /home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98sigp_set_p=
refix=E2=80=99:
> /home/cohuck/git/qemu/target/s390x/kvm.c:1665:5: error: implicit declarat=
ion of function =E2=80=98cpu_synchronize_post_init=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
>      cpu_synchronize_post_init(cs);
>      ^
> /home/cohuck/git/qemu/target/s390x/kvm.c:1665:5: error: nested extern dec=
laration of =E2=80=98cpu_synchronize_post_init=E2=80=99 [-Werror=3Dnested-e=
xterns]
> cc1: all warnings being treated as errors
> /home/cohuck/git/qemu/rules.mak:64: recipe for target 'target/s390x/kvm.o=
' failed
>
> Fix this.
>
> Fixes: b394662 ("kvm: move cpu synchronization code")
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>


Acked-by: Vincent Palatin <vpalatin@chromium.org>

Sorry for the miss.


>
> ---
>  target/s390x/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 3ac29f92b3..5ad0acbc82 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -32,7 +32,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
> -#include "sysemu/kvm.h"
> +#include "sysemu/hw_accel.h"
>  #include "hw/hw.h"
>  #include "sysemu/device_tree.h"
>  #include "qapi/qmp/qjson.h"
> --
> 2.11.0
>
