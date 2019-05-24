Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06577C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5F220851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5F220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9c5-0001uc-2Y
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:47:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hU9aK-00014H-L3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hU9aJ-0000F7-0y
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:46:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hU9aI-0000ER-Pa
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:46:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA81930ADC8F;
	Fri, 24 May 2019 12:46:05 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-245.rdu2.redhat.com
	[10.10.120.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B41568D82;
	Fri, 24 May 2019 12:46:00 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
	<20181102171638.24069-9-peter.maydell@linaro.org>
	<3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
Message-ID: <f37074a0-4cc2-2f4d-815b-e5e3389b7077@redhat.com>
Date: Fri, 24 May 2019 14:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 24 May 2019 12:46:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/24/19 14:33, Laszlo Ersek wrote:
> Hi,
>
> On 11/02/18 18:16, Peter Maydell wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> When populating id registers from kvm, on a host that doesn't support
>> aarch32 mode at all, neither arm_div nor jazelle will be supported eit=
her.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-id: 20181102102025.3546-1-richard.henderson@linaro.org
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/cpu.h |  5 +++++
>>  target/arm/cpu.c | 15 +++++++++++++--
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 8e6779936eb..b5eff79f73b 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -3296,6 +3296,11 @@ static inline bool isar_feature_aa64_fp16(const=
 ARMISARegisters *id)
>>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) =3D=3D 1;
>>  }
>>
>> +static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >=3D 2;
>> +}
>> +
>>  static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
>>  {
>>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) !=3D 0;
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 8f16e96b6c8..784a4c2dfcc 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -774,6 +774,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>>      CPUARMState *env =3D &cpu->env;
>>      int pagebits;
>>      Error *local_err =3D NULL;
>> +    bool no_aa32 =3D false;
>>
>>      /* If we needed to query the host kernel for the CPU features
>>       * then it's possible that might have failed in the initfn, but
>> @@ -820,6 +821,16 @@ static void arm_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>>              set_feature(env, ARM_FEATURE_V7VE);
>>          }
>>      }
>> +
>> +    /*
>> +     * There exist AArch64 cpus without AArch32 support.  When KVM
>> +     * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
>> +     * Similarly, we cannot check ID_AA64PFR0 without AArch64 support=
.
>> +     */
>> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>> +        no_aa32 =3D !cpu_isar_feature(aa64_aa32, cpu);
>> +    }
>> +
>>      if (arm_feature(env, ARM_FEATURE_V7VE)) {
>>          /* v7 Virtualization Extensions. In real hardware this implie=
s
>>           * EL2 and also the presence of the Security Extensions.
>> @@ -829,7 +840,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>>           * Security Extensions is ARM_FEATURE_EL3.
>>           */
>> -        assert(cpu_isar_feature(arm_div, cpu));
>> +        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
>
> The assertion above fails on my AArch64 host (APM Mustang A3). Meaning
> that my host CPU supports AArch32, but lacks "arm_div".
>
> (My understanding is that this commit, i.e., 0f8d06f16c9d, relaxed the
> assert originally added in commit 7e0cf8b47f0e ("target/arm: Convert
> division from feature bits to isar0 tests", 2018-10-24). Can we relax i=
t
> even further?
>
> Better yet: can we rework the code to emit a warning, rather than
> aborting QEMU? Assertions are not the best tool IMHO for catching
> unusual (or slightly non-conformant / early) hardware.)

To clarify, I intended to launch a 32-bit ARM guest (with KVM
acceleration) on my AArch64 host.

Libvirt generated the following QEMU command line:

LC_ALL=3DC \
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin \
QEMU_AUDIO_DRV=3Dnone \
/opt/qemu-installed-optimized/bin/qemu-system-aarch64 \
  -name guest=3Df28.32bit,debug-threads=3Don \
  -S \
  -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qem=
u/domain-2-f28.32bit/master-key.aes \
  -machine virt-4.1,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff,gic-versi=
on=3D2 \
  -cpu host,aarch64=3Doff \
  -drive file=3D/root/QEMU_EFI.fd.padded,if=3Dpflash,format=3Draw,unit=3D=
0,readonly=3Don \
  -drive file=3D/var/lib/libvirt/qemu/nvram/f28.32bit_VARS.fd,if=3Dpflash=
,format=3Draw,unit=3D1 \
  -m 8192 \
  -realtime mlock=3Doff \
  -smp 8,sockets=3D8,cores=3D1,threads=3D1 \
  -uuid d525042e-1b37-4058-86ca-c6a2086e8485 \
  -no-user-config \
  -nodefaults \
  -chardev socket,id=3Dcharmonitor,fd=3D27,server,nowait \
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
  -rtc base=3Dutc \
  -no-shutdown \
  -boot strict=3Don \
  -device pcie-root-port,port=3D0x8,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,m=
ultifunction=3Don,addr=3D0x1 \
  -device pcie-root-port,port=3D0x9,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,a=
ddr=3D0x1.0x1 \
  -device pcie-root-port,port=3D0xa,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,a=
ddr=3D0x1.0x2 \
  -device pcie-root-port,port=3D0xb,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,a=
ddr=3D0x1.0x3 \
  -device pcie-root-port,port=3D0xc,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,a=
ddr=3D0x1.0x4 \
  -device pcie-root-port,port=3D0xd,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,a=
ddr=3D0x1.0x5 \
  -device qemu-xhci,id=3Dusb,bus=3Dpci.1,addr=3D0x0 \
  -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.2,addr=3D0x0 \
  -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 \
  -drive file=3D/var/lib/libvirt/images/f28.32bit.root.qcow2,format=3Dqco=
w2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,werror=3Denospc,cache=3Dwriteback,dis=
card=3Dunmap \
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Dd=
rive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,write-cache=3Don \
  -drive file=3D/var/lib/libvirt/images/f28.32bit.home.qcow2,format=3Dqco=
w2,if=3Dnone,id=3Ddrive-scsi0-0-0-1,werror=3Denospc,cache=3Dwriteback,dis=
card=3Dunmap \
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,drive=3Dd=
rive-scsi0-0-0-1,id=3Dscsi0-0-0-1,write-cache=3Don \
  -netdev tap,fd=3D29,id=3Dhostnet0,vhost=3Don,vhostfd=3D30 \
  -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:6f:d1=
:c8,bus=3Dpci.4,addr=3D0x0,romfile=3D \
  -chardev pty,id=3Dcharserial0 \
  -serial chardev:charserial0 \
  -chardev socket,id=3Dcharchannel0,fd=3D31,server,nowait \
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchan=
nel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
  -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 \
  -device usb-kbd,id=3Dinput1,bus=3Dusb.0,port=3D2 \
  -vnc 127.0.0.1:0 \
  -device virtio-gpu-pci,id=3Dvideo0,max_outputs=3D1,bus=3Dpci.5,addr=3D0=
x0 \
  -object rng-random,id=3Dobjrng0,filename=3D/dev/urandom \
  -device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,max-bytes=3D1048576,peri=
od=3D1000,bus=3Dpci.6,addr=3D0x0 \
  -msg timestamp=3Don

and then I got:

> qemu-system-aarch64: /root/src/upstream/qemu/target/arm/cpu.c:986:
> arm_cpu_realizefn: Assertion `no_aa32 || ({ ARMCPU *cpu_ =3D (cpu);
> isar_feature_arm_div(&cpu_->isar); })' failed.

QEMU was built at commit 8dc7fd56dd4f ("Merge remote-tracking branch
'remotes/philmd-gitlab/tags/fw_cfg-20190523-pull-request' into staging",
2019-05-23).

Thanks
Laszlo

