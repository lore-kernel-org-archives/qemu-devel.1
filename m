Received: from eggs.gnu.org ([2001:4830:134:3::10]:40639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f7yt6-0005w8-Ja
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f7yt2-0000wo-Ki
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:49:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f7yt2-0000vX-BT
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:49:16 -0400
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<20180406151752.10854-5-christophe.lyon@st.com>
	<CAFEAcA8MHx0cPhhNAj_HwgmDL0DG9koNSZ-6Ob17A8u2=girZA@mail.gmail.com>
From: Christophe Lyon <christophe.lyon@st.com>
Message-ID: <cb4bd044-add0-2c83-9d36-2838a482f631@st.com>
Date: Mon, 16 Apr 2018 09:49:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MHx0cPhhNAj_HwgmDL0DG9koNSZ-6Ob17A8u2=girZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC 4/4] linux-user: ARM-FDPIC: Add arm get
 tls syscall support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 13/04/2018 17:03, Peter Maydell wrote:
> On 6 April 2018 at 16:17, Christophe Lyon <christophe.lyon@st.com> wrot=
e:
>> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
>> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
>>
>> diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_s=
yscall.h
>> index 94e2a42..afc0772 100644
>> --- a/linux-user/arm/target_syscall.h
>> +++ b/linux-user/arm/target_syscall.h
>> @@ -16,6 +16,7 @@ struct target_pt_regs {
>>   #define ARM_NR_breakpoint (ARM_NR_BASE + 1)
>>   #define ARM_NR_cacheflush (ARM_NR_BASE + 2)
>>   #define ARM_NR_set_tls   (ARM_NR_BASE + 5)
>> +#define ARM_NR_get_tls    (ARM_NR_BASE + 6)
>>
>>   #define ARM_NR_semihosting       0x123456
>>   #define ARM_NR_thumb_semihosting  0xAB
>> diff --git a/linux-user/main.c b/linux-user/main.c
>> index 00810d6..1814578 100644
>> --- a/linux-user/main.c
>> +++ b/linux-user/main.c
>> @@ -720,6 +720,9 @@ void cpu_loop(CPUARMState *env)
>>                           case ARM_NR_breakpoint:
>>                               env->regs[15] -=3D env->thumb ? 2 : 4;
>>                               goto excp_debug;
>> +                        case ARM_NR_get_tls:
>> +                            env->regs[0] =3D cpu_get_tls(env);
>> +                            break;
>>                           default:
>>                               gemu_log("qemu: Unsupported ARM syscall:=
 0x%x\n",
>>                                        n);
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> This is a bug fix unrelated to FDPIC, I think.
>=20

Right, I'll resubmit it with an updated commit message.

> thanks
> -- PMM
> .
>=20
