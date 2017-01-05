Received: from eggs.gnu.org ([2001:4830:134:3::10]:40724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCEL-0003yW-Cl
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCEK-0000Ps-JT
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:53:37 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:34381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPCEK-0000Pn-Ey
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:53:36 -0500
Received: by mail-ua0-x232.google.com with SMTP id 34so345255367uac.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 09:53:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b26ad55255a5ce744d2efda4773a2dc1a298a3a2.1481121503.git.julian@codesourcery.com>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b26ad55255a5ce744d2efda4773a2dc1a298a3a2.1481121503.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 17:53:15 +0000
Message-ID: <CAFEAcA-8iBjkWwdvm3uYc26bAwvG7=9_rpw=j_ze05XuTq=S-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] ARM big-endian system-mode gdbstub
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2016 at 14:49, Julian Brown <julian@codesourcery.com> wrote:
> When debugging a big-endian (either BE8 or BE32) executable, GDB uses
> a big-endian byte ordering for its remote protocol.  The gdb stub
> code in QEMU needs to interpret data in host (little-endian) order in
> arm_cpu_gdb_read_register and arm_cpu_gdb_write_register, so this patch
> arranges to byte-swap the data to/from GDB in those cases.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> ---
>  target-arm/gdbstub.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

More compile errors:

In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/gdbstub.c:24:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/include/exec/softmmu-arm-semi.h=
:106:14:
error: =E2=80=98softmmu_lock_user=E2=80=99 defined but not used
[-Werror=3Dunused-function]
 static void *softmmu_lock_user(CPUArchState *env,
              ^
/home/petmay01/linaro/qemu-from-laptop/qemu/include/exec/softmmu-arm-semi.h=
:118:14:
error: =E2=80=98softmmu_lock_user_string=E2=80=99 defined but not used
[-Werror=3Dunused-function]
 static char *softmmu_lock_user_string(CPUArchState *env, target_ulong addr=
)
              ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/gdbstub.c:24:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/include/exec/softmmu-arm-semi.h=
:136:13:
error: =E2=80=98softmmu_unlock_user=E2=80=99 defined but not used
[-Werror=3Dunused-function]
 static void softmmu_unlock_user(CPUArchState *env, void *p, target_ulong a=
ddr,
             ^

Missing "inline"s, I think.

thanks
-- PMM
