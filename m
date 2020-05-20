Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7C3207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="QYEzPq6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7C3207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLlz-0000vj-RK
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbLlK-0000UL-Jb
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:15:46 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d]:38229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbLlI-00073w-Fm
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:15:46 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id g15so1500298vsb.5
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VmY7hKYDVAlVjSdLIfbAkGtO8VRQ3uZaKv1zruO4ioI=;
 b=QYEzPq6wcJj70ty+5pNb8HsT+jowk1U/rUyFeD4IGPVzYpI18mEdsxqxUA2VZQ9+V1
 aghsKWphzreCEQpPPN1klO0gRDM4nvsQVfcS2XUoDzlstqjwQKaDLptTebbDnGlwFTGN
 EBXqaVYZOdXvehR05Rv31sCZb+zoyczXP+lTQIeISkwbz6hahQceUMUShP9aVtrGlSNj
 lZbKo6BvQeSAUtWQ6C3ZW2VGLix7AgPIgP2CfjzGFxz/JeECgruj0YRmFuDlr+KQVk6c
 oFXnAtBU86t/lcpG1cL140+KCfvnxQfa92VS5URSvGzDkNT0+XoZlbBnO1SsXz8Q4Rp3
 9PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VmY7hKYDVAlVjSdLIfbAkGtO8VRQ3uZaKv1zruO4ioI=;
 b=KRQmNrJyalUgUrCaow/RkJpSxNpaA6zxa25JA+p4sB5Jj0AqVhs3KedSpo0+NxBQEH
 fv6rZvQgQwJB1aforQunKzRpqea4gnuDqN1emuRRyNa3Y2fSiBQKtxaBjF/3azLK4Z5P
 BEUiYUHpkUlzSj1IfHTIFv+7s/Inj8f0ytGlGS6gefBUeRJTAUp+I0AmtN9ZPy7rnouk
 LLjR4ei26GtJaqJMU9ScS58nj2R+TO2Xt376sVUrigepYvmOhtWmfXv7vRVFZaFxQxwj
 04dmZkl/B7ASb2MKa//FC2CAanCwE6ri2tzIo1UsSHDUR2Gsnsfjjd7/KQeWWimSpz/N
 3fhg==
X-Gm-Message-State: AOAM533/Pble4QkIzyr/FfDIerNB8UAaJNVFEsz33LIC/loX3pXkQXVb
 qofoCdDlN1IkN2gr6I1Asemldakc2MNCrOa4W165TA==
X-Google-Smtp-Source: ABdhPJx8LswZ3KxxME/ZUM67YbePnjVDoyZXeKkAmWukRdx+chSj652v3UI4cwa8J2iBGQ214teXrkBT4waZgPJt2cA=
X-Received: by 2002:a05:6102:2008:: with SMTP id
 p8mr2607249vsr.183.1589969742963; 
 Wed, 20 May 2020 03:15:42 -0700 (PDT)
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
 <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
 <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
 <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
 <7ecfb762-0359-92a4-d8b3-1a9e081ace92@redhat.com>
 <CAHckoCwEt+citc5pQkJxhsWkLuqJa47A98YUYtMHd7epmx0esQ@mail.gmail.com>
 <5902006b-655a-9208-796d-1af7b36da52c@redhat.com>
 <CAHckoCyZmYXU8bz-3UAVXGi1MpdNdb20no1-kB09MoWOGPz_VA@mail.gmail.com>
 <8ce60286-85a5-f338-c079-20e868da59dd@redhat.com>
In-Reply-To: <8ce60286-85a5-f338-c079-20e868da59dd@redhat.com>
From: Li Feng <fengli@smartx.com>
Date: Wed, 20 May 2020 18:15:31 +0800
Message-ID: <CAHckoCxFGTgPwTXvf6H4AeGDmDyy2dfQRtEHD51QojZpv-0E+Q@mail.gmail.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=fengli@smartx.com; helo=mail-vs1-xe2d.google.com
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
Cc: vkuznets@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On 20/05/20 11:36, Li Feng wrote:
> >> Can you do "rdmsr 0x48f" (as root)?  On my machine for example I get
> >> 1ffffff00036dfb.
> >>
> > $ rdmsr 0x48f
> > 3fffff00036dfb
> >
>
> Hmm, weird.  What is exactly your QEMU command line?
>
/root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
-device virtio-balloon -cpu
host,-vmx-exit-nosave-debugctl,-vmx-exit-ack-intr,-vmx-exit-save-pat,-vmx-e=
xit-load-pat,-vmx-exit-save-efer,-vmx-exit-load-efer,-vmx-exit-save-preempt=
ion-timer
-smp 4 -m 2G -drive
file=3D/root/html/fedora-10g.img,format=3Draw,cache=3Dnone,aio=3Dnative,if=
=3Dnone,id=3Ddrive-virtio-disk1
-device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk1,id=3Dvirtio-di=
sk1,bootindex=3D1
-device virtio-net,netdev=3Dnw1,mac=3D00:11:22:EE:EE:10 -netdev
tap,id=3Dnw1,script=3Dno,downscript=3Dno,ifname=3Dtap0 -serial mon:stdio
-nographic -object
memory-backend-file,id=3Dmem0,size=3D2G,mem-path=3D/dev/hugepages,share=3Do=
n
-numa node,memdev=3Dmem0 -vnc 0.0.0.0:100 -machine usb=3Don,nvdimm -device
usb-tablet -monitor tcp:0.0.0.0:1234,server,nowait -qmp
tcp:0.0.0.0:2234,server,nowait -device
virtio-serial-pci,id=3Dvirtio-serial0,max_ports=3D16 -chardev
socket,id=3Dchannel1,path=3D/tmp/helloworld1,server,nowait -device
virtserialport,chardev=3Dchannel1,name=3Dcom.redhat.rhevm.vdsm1,bus=3Dvirti=
o-serial0.0,id=3Dport1

The CentOS version(qemu-kvm-ev-2.12.0-33.1.el7) works well on my VM.
So I guess this is an issue in the upstream master codebase.

> Paolo
>

