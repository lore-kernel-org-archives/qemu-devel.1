Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF217C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A25206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="1chRWMWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A25206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZG8C-0005nj-OP
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZG7K-0004nu-9z
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:49:50 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31]:35534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZG7F-0007F3-Pz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:49:49 -0400
Received: by mail-vs1-xe31.google.com with SMTP id 62so2263800vsi.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SWbvPh9CSGM9VvrIp/EOM1ZVbm0OY20lqU2NgHyxY50=;
 b=1chRWMWP4tk/0JUGRvxnq4HYjtAboTNnxKYOdSMfe3lh/FD3J4GTDxa39AcSQNDnHM
 GGVZ10LQDrHaqZrHFyxsEsAQ39azmn1vwTU3En+B1lfghcOHODdu84Ij8X6KZGqonJYF
 fOP3tmbwKaL4zkGtPeIyg2eEcPF9eNHA2PCEU8YE1O/eazrLoz2ZmdTzaq72dycyIPaB
 /a739AEAAV/555ZAGSKs17/j9PwISt+84BzOjbFkeZ2I8jz9VDDJTteixguKB/Uopa43
 GIKKDJ+0M71NX81TTg2tQUSc3r09O6+zYbtYR8Uo/mDbBt/1bqPPcPsg5KP05cH+blKe
 kqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SWbvPh9CSGM9VvrIp/EOM1ZVbm0OY20lqU2NgHyxY50=;
 b=RzsDj9UJ647sX91tlxBvztv7wGjFu52ObK23rB2dkVd0ciDuu08aOzaEIGyXX+w63Z
 R/fQ3yNJdP1BGo9wEvwpO+aWQIOiDXEvH98WgKguEBDpBMoGs+s5c85qrJ1mMh0XsXZb
 qRQfkqxRXGOo6CEVua5hHVFW+NkIX2LVgcUD/8WgJf2l06ljvB4UhbYegcRzl0cRezvt
 gxMZXojmwvIFXJRpL0L3XFCGI50yt/h6UY4aXaiA1mcquwNnW73V8ueMY5rw3D3hGUvC
 cDWYwXP53qN1gvTsl18BPK4pftYS0oy0PFQ3U7gexPuKF1erkzVNGUueHAqdZRR0luh8
 Uwog==
X-Gm-Message-State: AOAM533ksE1iuMxyTkmvxVW2OsR5332ng+SRbYyzdAkiudqEnSAOEi9j
 woJGYCm2NCVfKvzeT4gjRkVjLaUbCGOOlz8KScDgmg==
X-Google-Smtp-Source: ABdhPJxFJ6j0LtBzd5ZWzVv/SsjachJ0hYbGkgD+zC5z0vwhkz74ibfBaxL6pCvcLim4kKB96gFeEnaV1uHumgXS+mU=
X-Received: by 2002:a67:fc46:: with SMTP id p6mr4195232vsq.169.1589471383767; 
 Thu, 14 May 2020 08:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
 <20200514151600.GO2787@work-vm>
 <CAHckoCxc2XTA3ckU0sq-BmbZZFtfAY_GaEOW46XFzfZ2qXjeMQ@mail.gmail.com>
 <20200514153129.GP2787@work-vm>
In-Reply-To: <20200514153129.GP2787@work-vm>
From: Li Feng <fengli@smartx.com>
Date: Thu, 14 May 2020 23:49:31 +0800
Message-ID: <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::e31;
 envelope-from=fengli@smartx.com; helo=mail-vs1-xe31.google.com
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

Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=
=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:31=E5=86=99=E9=81=93=
=EF=BC=9A
>
> * Li Feng (fengli@smartx.com) wrote:
> > Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=
=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:16=E5=86=99=E9=81=
=93=EF=BC=9A
> > >
> > > * Li Feng (fengli@smartx.com) wrote:
> > > > EXSi CPU is : Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
> > > > This is my vm, I run qemu in it.
> > >
> > > Do you know what the real hardware is?
> > What information do you need? I could send it out.
> > The EXSi version: VMware ESXi, 6.5.0, 5969303
>
> VMWare is saying to the guest it's an E5-2640 v3; is that what
> your real CPU is?

Yes, I confirm that the real CPU is indeed this version and VMWare is right=
.

>
> Dave
>
> > >
> > > Dave
> > >
> > > > (base) 20-05-14 15:32:50 root@31_216:~  lscpu
> > > > Architecture:          x86_64
> > > > CPU op-mode(s):        32-bit, 64-bit
> > > > Byte Order:            Little Endian
> > > > CPU(s):                16
> > > > On-line CPU(s) list:   0-15
> > > > Thread(s) per core:    1
> > > > Core(s) per socket:    1
> > > > Socket(s):             16
> > > > NUMA node(s):          1
> > > > Vendor ID:             GenuineIntel
> > > > CPU family:            6
> > > > Model:                 63
> > > > Model name:            Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
> > > > Stepping:              2
> > > > CPU MHz:               2599.998
> > > > BogoMIPS:              5199.99
> > > > Virtualization:        VT-x
> > > > Hypervisor vendor:     VMware
> > > > Virtualization type:   full
> > > > L1d cache:             32K
> > > > L1i cache:             32K
> > > > L2 cache:              256K
> > > > L3 cache:              20480K
> > > > NUMA node0 CPU(s):     0-15
> > > > Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
> > > > mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscal=
l
> > > > nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopol=
ogy
> > > > tsc_reliable nonstop_tsc cpuid pni pclmulqdq vmx ssse3 fma cx16 pci=
d
> > > > sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> > > > f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single
> > > > tpr_shadow vnmi ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> > > > invpcid xsaveopt arat
> > > >
> > > > Thanks,
> > > >
> > > > Feng Li
> > > >
> > > > Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2020=E5=B9=B4=
5=E6=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:52=E5=86=99=E9=
=81=93=EF=BC=9A
> > > > >
> > > > > * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> > > > > > Cc'ing David/Paolo in case they have a clue...
> > > > > >
> > > > > > On 5/14/20 1:27 PM, Li Feng wrote:
> > > > > > > Dear all,
> > > > > > >
> > > > > > > I have encountered a weird crash.
> > > > > > > I remember before a few days it works well and I rebase my co=
de from upstream.
> > > > > > >
> > > > > > > This is the command:
> > > > > > > /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-k=
vm
> > > > > > > -device virtio-balloon -cpu host -smp 4 -m 2G -drive
> > > > > > > file=3D/root/html/fedora-10g.img,format=3Draw,cache=3Dnone,ai=
o=3Dnative,if=3Dnone,id=3Ddrive-virtio-disk1
> > > > > > > -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk1,=
id=3Dvirtio-disk1,bootindex=3D1
> > > > > > > -device virtio-net,netdev=3Dnw1,mac=3D00:11:22:EE:EE:10 -netd=
ev
> > > > > > > tap,id=3Dnw1,script=3Dno,downscript=3Dno,ifname=3Dtap0 -seria=
l mon:stdio
> > > > > > > -nographic -object
> > > > > > > memory-backend-file,id=3Dmem0,size=3D2G,mem-path=3D/dev/hugep=
ages,share=3Don
> > > > > > > -numa node,memdev=3Dmem0 -vnc 0.0.0.0:100 -machine usb=3Don,n=
vdimm -device
> > > > > > > usb-tablet -monitor unix:///tmp/a.socket,server,nowait -devic=
e
> > > > > > > virtio-serial-pci,id=3Dvirtio-serial0,max_ports=3D16 -chardev
> > > > > > > socket,id=3Dchannel1,path=3D/tmp/helloworld1,server,nowait -d=
evice
> > > > > > > virtserialport,chardev=3Dchannel1,name=3Dcom.redhat.rhevm.vds=
m1,bus=3Dvirtio-serial0.0,id=3Dport1
> > > > > > > -qmp tcp:0.0.0.0:2234,server,nowait
> > > > > > > qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7feff=
f00036dfb
> > > > > > > qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
> > > > > > > kvm_buf_set_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nms=
rs' failed.
> > > > >
> > > > > 48f is MSR_IA32_VMX_TRUE_EXIT_CTLS
> > > > > I've not got a note of seeing that one before.
> > > > >
> > > > > > > This is the commit record:
> > > > > > > *   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-tr=
acking
> > > > > > > branch 'remotes/kevin/tags/for-upstream' into staging (3 days=
 ago)
> > > > > > > <Peter Maydell>
> > > > > > > |\
> > > > > > > | * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_trunc=
ate (3
> > > > > > > days ago) <Eric Blake>
> > > > > > > | * dbc636e791 - vhdx: Rework truncation logic (3 days ago) <=
Eric Blake>
> > > > > > > | * bda4cdcbb9 - parallels: Rework truncation logic (3 days a=
go) <Eric Blake>
> > > > > > > | * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for truncat=
e (3 days
> > > > > > > ago) <Eric Blake>
> > > > > > > | * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for tr=
uncate (3
> > > > > > > days ago) <Eric Blake>
> > > > > > > | * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for truncat=
e (3 days
> > > > > > > ago) <Eric Blake>
> > > > > > >
> > > > > > > I run this qemu in a VM base on EXSi.
> > > > > > >
> > > > > > > Does anyone have the same issue?
> > > > >
> > > > > cc'ing in Vitaly since he knows VMWare stuff.
> > > > >
> > > > > What's your host CPU?
> > > > >
> > > > > Dave
> > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Feng Li
> > > > > > >
> > > > > >
> > > > > --
> > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > >
> > > >
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

