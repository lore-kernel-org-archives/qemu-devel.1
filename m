Received: from eggs.gnu.org ([2001:4830:134:3::10]:42255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cR3ON-0008E3-SA
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cR3OJ-0004Yi-Vk
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:51:39 -0500
References: <1483802623-5507-1-git-send-email-hpoussin@reactos.org>
	<1483802623-5507-5-git-send-email-hpoussin@reactos.org>
	<3ae2a0f5-6bf0-c6f6-5852-6aff7bf8791a@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <d5360409-c701-8656-2115-e9247a97efcb@reactos.org>
Date: Tue, 10 Jan 2017 21:51:18 +0100
MIME-Version: 1.0
In-Reply-To: <3ae2a0f5-6bf0-c6f6-5852-6aff7bf8791a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 4/4] prep: add IBM RS/6000
 7020 (40p) machine emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Giancarlo Teodori <gteodori@gmail.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Le 09/01/2017 =C3=A0 13:25, Thomas Huth a =C3=A9crit :
>  Hi,
>
> On 07.01.2017 16:23, Herv=C3=A9 Poussineau wrote:
>> Machine supports both Open Hack'Ware and OpenBIOS.
>> Open Hack'Ware is the default because OpenBIOS is currently unable to =
boot
>> PReP boot partitions or PReP kernels.
>>
>> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>> ---
>>  default-configs/ppc-softmmu.mak |   1 +
>>  hw/ppc/prep.c                   | 229 +++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 230 insertions(+)

[...]

>
> This currently does not compile on a ppc64 host where CONFIG_KVM is set=
:
>
> hw/ppc/prep.c: In function =E2=80=98ibm_40p_init=E2=80=99:
> hw/ppc/prep.c:872:9: error: implicit declaration of function =E2=80=98k=
vmppc_get_tbfreq=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>          fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, kvmppc_get_tbfreq())=
;
>          ^
> hw/ppc/prep.c:872:9: error: nested extern declaration of =E2=80=98kvmpp=
c_get_tbfreq=E2=80=99 [-Werror=3Dnested-externs]
> hw/ppc/prep.c:874:9: error: implicit declaration of function =E2=80=98k=
vmppc_get_hypercall=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>          kvmppc_get_hypercall(env, hypercall, 16);
>          ^
> hw/ppc/prep.c:874:9: error: nested extern declaration of =E2=80=98kvmpp=
c_get_hypercall=E2=80=99 [-Werror=3Dnested-externs]
>
> You need to #include "kvm_ppc.h" to get the prototype of the
> kvmppc_get_tbfreq() function.

Done
