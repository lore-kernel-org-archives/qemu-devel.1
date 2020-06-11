Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E188C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652462063A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGiTL+rR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652462063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLAd-00087T-M4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1jjIra-00011j-Cm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:47:06 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:42235)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1jjIrZ-0003Sm-EV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:47:05 -0400
Received: by mail-io1-xd44.google.com with SMTP id d5so5420705ios.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ZkiIg1uFn+dMQhhmS7GB9r4W5JJIeV6//+14vUA/9b4=;
 b=iGiTL+rR7Sl6frPvOrbhP2xLWX+0exRIQUIsk/HPZNpitYCdFNhejyvo4OjhiT3ebc
 vzZpiilteLzai+KOIIEY3XPz6AZJTBbKpXS9D+Oq/e5xZgIT0sQsehTJyNgmEfF62tHp
 Ek6OX6dnN4kNS2Ww9oNX5Zz0x8ZbNTB4ijCSz9zKLbuPH0GU20TYJsv99nLBhzBZSuZy
 LXkrMMr9Alrq/OxJ9NhMkkw5+7mK9BOZrNM65OBWBt7t3pyI83YNuJmTjz24SRFBatSK
 meMTFPk9gOAYnding7+doQ3IF7wkkvk11sGPOzO6LgOWWQaxUUA0i5UBNhkdcyXdVGEP
 m77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ZkiIg1uFn+dMQhhmS7GB9r4W5JJIeV6//+14vUA/9b4=;
 b=hMlAe1OktECZ2GkSToXYsraNd6FwHHq2vmNLGzzKi1BtkKU6Yew0DoI1PSPpYsiaVV
 zfH28/8Vlz9A/8MnCUuK2r3BEJQ0LkSj5TPAKKRMtPjq9Y1uTh+Lbp+Rnr86KNBkaFgy
 dMJFLGOdiCUIsPE+LYj3XAicdEEHZ9QMmRFrtC1OTOOyk/7hMH6+37kYXe2U+tQQw38D
 jhX0x45jaNbWf3QM1BgQKl7jYecBYeXO/esT6Zgwyd0J6zfGjjw+jj4m1J1f5M2eLe1S
 cP0SwxKGmW9tdLJKJlOAUFPrKeD9CaYLHwb/Y5cNWx/vtzS7GbPoCQSzfiuh5FRKqsE+
 94WA==
X-Gm-Message-State: AOAM530xwvXmkNB/ZnHRkDyEPjiACnlmoGXMyeADhGJOk91Y+0qem24T
 8Y+t+fhRSY87gDJJViM+BUxyvzsS8IlVbvwKsDJ23hG2LfTTgqE=
X-Google-Smtp-Source: ABdhPJyO9FR9sobLPdMw+xKHkNOnIbK3zaXwbGIgKr4pvTTluveWM/HcbMJ4K5COZWf/kbgAyJW3gbjyQvq+JXL4rJY=
X-Received: by 2002:a02:810:: with SMTP id 16mr2252230jac.17.1591865216918;
 Thu, 11 Jun 2020 01:46:56 -0700 (PDT)
MIME-Version: 1.0
From: Haibo Xu <haibo.xu@linaro.org>
Date: Thu, 11 Jun 2020 16:46:45 +0800
Message-ID: <CAJc+Z1Eb815hroFPY+9Ai_9hh=+eje+X2ENtGj9XA+_F0XUPqg@mail.gmail.com>
Subject: Core dump happened when starting a VM on arm64 server
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2020 07:14:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: drjones@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I met a qemu core dump issue when starting a VM with cpu feature
"pmu=on" on an arm server.
The commands to start the machine is:

  ./qemu-system-aarch64 \
           -cpu host,pmu=on -M virt,accel=kvm,gic-version=3 -nographic
-m 2048M \
           -kernel ./Image \
           -initrd /boot/initrd.img-5.6.0-rc2+ \
           -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
           -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
           -device virtio-blk-device,drive=hd0


And here is the stack dump:

 Core was generated by `./qemu-system-aarch64 -cpu host,pmu=on -M
virt,accel=kvm,gic-version=3 -nograph'.
 Program terminated with signal SIGSEGV, Segmentation fault.
 #0  kvm_ioctl (s=0x0, type=type@entry=44547) at
/root/Downloads/qemu-git/accel/kvm/kvm-all.c:2509
 2509        ret = ioctl(s->fd, type, arg);
 [Current thread is 1 (Thread 0xffffa5108010 (LWP 22057))]
 (gdb) bt
 #0  0x0000aaaadc432950 in kvm_ioctl (s=0x0, type=type@entry=44547) at
/root/Downloads/qemu-git/accel/kvm/kvm-all.c:2509
 #1  0x0000aaaadc432adc in kvm_check_extension (s=<optimized out>,
extension=extension@entry=126) at
/root/Downloads/qemu-git/accel/kvm/kvm-all.c:866
 #2  0x0000aaaadc541ff0 in kvm_arm_pmu_supported (cpu=<optimized out>)
at /root/Downloads/qemu-git/target/arm/kvm.c:212
 #3  0x0000aaaadc53a08c in arm_set_pmu (obj=<optimized out>,
value=<optimized out>, errp=0xfffff2fba6b0) at
/root/Downloads/qemu-git/target/arm/cpu.c:1113
 #4  0x0000aaaadc88facc in property_set_bool (obj=0xaaab0b61a0f0,
v=<optimized out>, name=<optimized out>, opaque=0xaaab0b627690,
errp=0xfffff2fba6b0)
     at /root/Downloads/qemu-git/qom/object.c:2162
 #5  0x0000aaaadc892af4 in object_property_parse
(obj=obj@entry=0xaaab0b61a0f0, string=<optimized out>,
name=0xaaab0b527d00 "pmu", errp=errp@entry=0xfffff2fba6b0)
     at /root/Downloads/qemu-git/qom/object.c:1552
 #6  0x0000aaaadc892bbc in object_apply_global_props
(obj=0xaaab0b61a0f0, props=0xaaab0b473a60, errp=0xaaaadd003930
<error_fatal>)
     at /root/Downloads/qemu-git/qom/object.c:410
 #7  0x0000aaaadc891a64 in object_post_init_with_type
(ti=0xaaab0b20e9f0, obj=0xaaab0b61a0f0) at
/root/Downloads/qemu-git/qom/object.c:383
 #8  0x0000aaaadc891a64 in object_initialize_with_type
(data=data@entry=0xaaab0b61a0f0, size=<optimized out>,
type=type@entry=0xaaab0b212a40)
     at /root/Downloads/qemu-git/qom/object.c:517
 #9  0x0000aaaadc891ba4 in object_new_with_type (type=0xaaab0b212a40)
at /root/Downloads/qemu-git/qom/object.c:681
 #10 0x0000aaaadc4bfd10 in machvirt_init (machine=0xaaaadd003930
<error_fatal>) at /root/Downloads/qemu-git/hw/arm/virt.c:1804
 #11 0x0000aaaadc69ec5c in machine_run_board_init
(machine=0xaaab0b47e950) at
/root/Downloads/qemu-git/hw/core/machine.c:1132
 #12 0x0000aaaadc51f50c in qemu_init (argc=<optimized out>,
argv=<optimized out>, envp=<optimized out>) at
/root/Downloads/qemu-git/softmmu/vl.c:4347
 #13 0x0000aaaadc3d2abc in main (argc=<optimized out>, argv=<optimized
out>, envp=<optimized out>) at
/root/Downloads/qemu-git/softmmu/main.c:48
 (gdb)


The root cause is in the arm_get_pmu() operation which was introduced
in ae502508f83.
After deleting the KVM feature probe operation in this function, the
issue can be fixed.

 diff --git a/target/arm/cpu.c b/target/arm/cpu.c
 index 3801e25b79..ff18db8fd4 100644
 --- a/target/arm/cpu.c
 +++ b/target/arm/cpu.c
 @@ -1110,10 +1110,6 @@ static void arm_set_pmu(Object *obj, bool
value, Error **errp)
      ARMCPU *cpu = ARM_CPU(obj);

      if (value) {
 -        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
 -            error_setg(errp, "'pmu' feature not supported by KVM on
this host");
 -            return;
 -        }
          set_feature(&cpu->env, ARM_FEATURE_PMU);
      } else {
          unset_feature(&cpu->env, ARM_FEATURE_PMU);


According to the Qemu document(docs/system/arm/cpu-features.rst), the
pmu is turned on by default when using KVM mode on a V8 host machine,
which means the pmu=on is redundant when starting a VM with PMU support.

  target/arm/kvm64.c
  672     /*
  673      * We can assume any KVM supporting CPU is at least a v8
  674      * with VFPv4+Neon; this in turn implies most of the other
  675      * feature bits.
  676      */
  677     features |= 1ULL << ARM_FEATURE_V8;
  678     features |= 1ULL << ARM_FEATURE_NEON;
  679     features |= 1ULL << ARM_FEATURE_AARCH64;
  680     features |= 1ULL << ARM_FEATURE_PMU;
  681     features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;

But I think we need a better way to handle this when "pmu=on" is
present in the command line, not just trigger a core dump(qemu binary
was built from the current master branch).
Any comments?

Regards,
Haibo

