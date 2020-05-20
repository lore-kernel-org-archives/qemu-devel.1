Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E162C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 03:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01737204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 03:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="B1xWxps4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01737204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbFlR-0002jL-3A
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 23:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbFkb-0001xD-DI
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:50:37 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f]:42672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbFkZ-00027T-E7
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:50:36 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id m18so425712vkk.9
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 20:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WZ2Cx1qDlKPn8s2JGOAqSUZcAd9EcK3TmrDTrm6cmMk=;
 b=B1xWxps4ILOfDTqkllsAaU1bnp8apdgnS7ncMwvi53N2HVjY3xSlMetri7GE2qMdSY
 sbd6rK3Mz7ZxYPsUuSITRBwAGlRGOlZ/jlWx+t6CyuBN3c2B4ICmADyR3MOg5mgF+bcA
 qIsgFD6hcx5tlQ4hOKw9qCqYRaXG/qJBzbSh73OksmSalNQWHaRZyazitXufVGgdCGCh
 Tw9r629/LpzuFkg2yodwzhSZX9ewLQwH0VBd2SbsC1Zi+oLiojB5mksNieOvBUvuUba4
 ipthV8LD8zybGTmQYRTCcDWpv6IMni0qPShk0Dpqj+3xnKtf+Oo7z0J1mqzsH+udLMwD
 4nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WZ2Cx1qDlKPn8s2JGOAqSUZcAd9EcK3TmrDTrm6cmMk=;
 b=nyfl33xa/N2nKqOShxv9pyV/aAmfqRTSmRHbCKRiNdgOdWRZ2C58vuaTnBTyJUJMr+
 h3D0EmaHgq8eXWHvstvFWxBKYtWGdMK3+vZxQWbr0MwPokA3+Gugx8DhzFMCAwdBeAb7
 rJRP90RPQI00TACUI4UlTJdksQJR23mN639wGkN2ttTk7+S7KKQppxGg4GaIw32OCeU8
 p5UzaK4VYOCvnmFnLMf0hroUqLXdqLV9HuwoMnHFYpAd+iTVzwChumb8dXgAdH1vBrwV
 nNmjKr6B1A6CM5J9C/MVki9rTYK1I1EXl4Pcyxv7rQgcpo4dpvmODVA/qcz1ZTg33mgl
 t5UQ==
X-Gm-Message-State: AOAM533sWYgGzWmHc7ygo3U6LLWzypZQKLNJ+zrC5eDt7eknmLjsHh92
 NHIy6mVYYiuwz9Fpj6qlRg5gMa1tXEvqjiCGzCG3SA==
X-Google-Smtp-Source: ABdhPJwbnHo+ueVxRdqpAEyfWqfNZMUY3Tm4POtULpJDP4ljN67iwx2tsP6SpHM1EnX2tOSYz6YBaSkrIuEmhi/7mDc=
X-Received: by 2002:a1f:ab4f:: with SMTP id u76mr2444850vke.62.1589946632379; 
 Tue, 19 May 2020 20:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
 <20200514151600.GO2787@work-vm>
 <CAHckoCxc2XTA3ckU0sq-BmbZZFtfAY_GaEOW46XFzfZ2qXjeMQ@mail.gmail.com>
 <20200514153129.GP2787@work-vm>
 <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
In-Reply-To: <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Wed, 20 May 2020 11:50:21 +0800
Message-ID: <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=fengli@smartx.com; helo=mail-vk1-xa2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Any update about this issue?

Thanks,
Feng Li

Li Feng <fengli@smartx.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8814=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=
=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:31=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > * Li Feng (fengli@smartx.com) wrote:
> > > Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2020=E5=B9=B45=
=E6=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:16=E5=86=99=E9=
=81=93=EF=BC=9A
> > > >
> > > > * Li Feng (fengli@smartx.com) wrote:
> > > > > EXSi CPU is : Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
> > > > > This is my vm, I run qemu in it.
> > > >
> > > > Do you know what the real hardware is?
> > > What information do you need? I could send it out.
> > > The EXSi version: VMware ESXi, 6.5.0, 5969303
> >
> > VMWare is saying to the guest it's an E5-2640 v3; is that what
> > your real CPU is?
>
> Yes, I confirm that the real CPU is indeed this version and VMWare is rig=
ht.
>
> >
> > Dave
> >
> > > >
> > > > Dave
> > > >
> > > > > (base) 20-05-14 15:32:50 root@31_216:~  lscpu
> > > > > Architecture:          x86_64
> > > > > CPU op-mode(s):        32-bit, 64-bit
> > > > > Byte Order:            Little Endian
> > > > > CPU(s):                16
> > > > > On-line CPU(s) list:   0-15
> > > > > Thread(s) per core:    1
> > > > > Core(s) per socket:    1
> > > > > Socket(s):             16
> > > > > NUMA node(s):          1
> > > > > Vendor ID:             GenuineIntel
> > > > > CPU family:            6
> > > > > Model:                 63
> > > > > Model name:            Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
> > > > > Stepping:              2
> > > > > CPU MHz:               2599.998
> > > > > BogoMIPS:              5199.99
> > > > > Virtualization:        VT-x
> > > > > Hypervisor vendor:     VMware
> > > > > Virtualization type:   full
> > > > > L1d cache:             32K
> > > > > L1i cache:             32K
> > > > > L2 cache:              256K
> > > > > L3 cache:              20480K
> > > > > NUMA node0 CPU(s):     0-15
> > > > > Flags:                 fpu vme de pse tsc msr pae mce cx8 apic se=
p
> > > > > mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss sysc=
all
> > > > > nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtop=
ology
> > > > > tsc_reliable nonstop_tsc cpuid pni pclmulqdq vmx ssse3 fma cx16 p=
cid
> > > > > sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave av=
x
> > > > > f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single
> > > > > tpr_shadow vnmi ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> > > > > invpcid xsaveopt arat
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Feng Li
> > > > >
> > > > > Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2020=E5=B9=
=B45=E6=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:52=E5=86=99=
=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> > > > > > > Cc'ing David/Paolo in case they have a clue...
> > > > > > >
> > > > > > > On 5/14/20 1:27 PM, Li Feng wrote:
> > > > > > > > Dear all,
> > > > > > > >
> > > > > > > > I have encountered a weird crash.
> > > > > > > > I remember before a few days it works well and I rebase my =
code from upstream.
> > > > > > > >
> > > > > > > > This is the command:
> > > > > > > > /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable=
-kvm
> > > > > > > > -device virtio-balloon -cpu host -smp 4 -m 2G -drive
> > > > > > > > file=3D/root/html/fedora-10g.img,format=3Draw,cache=3Dnone,=
aio=3Dnative,if=3Dnone,id=3Ddrive-virtio-disk1
> > > > > > > > -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk=
1,id=3Dvirtio-disk1,bootindex=3D1
> > > > > > > > -device virtio-net,netdev=3Dnw1,mac=3D00:11:22:EE:EE:10 -ne=
tdev
> > > > > > > > tap,id=3Dnw1,script=3Dno,downscript=3Dno,ifname=3Dtap0 -ser=
ial mon:stdio
> > > > > > > > -nographic -object
> > > > > > > > memory-backend-file,id=3Dmem0,size=3D2G,mem-path=3D/dev/hug=
epages,share=3Don
> > > > > > > > -numa node,memdev=3Dmem0 -vnc 0.0.0.0:100 -machine usb=3Don=
,nvdimm -device
> > > > > > > > usb-tablet -monitor unix:///tmp/a.socket,server,nowait -dev=
ice
> > > > > > > > virtio-serial-pci,id=3Dvirtio-serial0,max_ports=3D16 -chard=
ev
> > > > > > > > socket,id=3Dchannel1,path=3D/tmp/helloworld1,server,nowait =
-device
> > > > > > > > virtserialport,chardev=3Dchannel1,name=3Dcom.redhat.rhevm.v=
dsm1,bus=3Dvirtio-serial0.0,id=3Dport1
> > > > > > > > -qmp tcp:0.0.0.0:2234,server,nowait
> > > > > > > > qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fe=
fff00036dfb
> > > > > > > > qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:269=
5:
> > > > > > > > kvm_buf_set_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->n=
msrs' failed.
> > > > > >
> > > > > > 48f is MSR_IA32_VMX_TRUE_EXIT_CTLS
> > > > > > I've not got a note of seeing that one before.
> > > > > >
> > > > > > > > This is the commit record:
> > > > > > > > *   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-=
tracking
> > > > > > > > branch 'remotes/kevin/tags/for-upstream' into staging (3 da=
ys ago)
> > > > > > > > <Peter Maydell>
> > > > > > > > |\
> > > > > > > > | * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_tru=
ncate (3
> > > > > > > > days ago) <Eric Blake>
> > > > > > > > | * dbc636e791 - vhdx: Rework truncation logic (3 days ago)=
 <Eric Blake>
> > > > > > > > | * bda4cdcbb9 - parallels: Rework truncation logic (3 days=
 ago) <Eric Blake>
> > > > > > > > | * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for trunc=
ate (3 days
> > > > > > > > ago) <Eric Blake>
> > > > > > > > | * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for =
truncate (3
> > > > > > > > days ago) <Eric Blake>
> > > > > > > > | * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for trunc=
ate (3 days
> > > > > > > > ago) <Eric Blake>
> > > > > > > >
> > > > > > > > I run this qemu in a VM base on EXSi.
> > > > > > > >
> > > > > > > > Does anyone have the same issue?
> > > > > >
> > > > > > cc'ing in Vitaly since he knows VMWare stuff.
> > > > > >
> > > > > > What's your host CPU?
> > > > > >
> > > > > > Dave
> > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Feng Li
> > > > > > > >
> > > > > > >
> > > > > > --
> > > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > > >
> > > > >
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >

