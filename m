Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE052076E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7jGcET4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE052076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2rkk-0003zV-VI
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k2rjw-0002rW-K7; Tue, 04 Aug 2020 03:52:04 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:42341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k2rju-0003sj-Ms; Tue, 04 Aug 2020 03:52:04 -0400
Received: by mail-yb1-xb44.google.com with SMTP id a34so16450824ybj.9;
 Tue, 04 Aug 2020 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DusenhJf7zgZTt8h/CNi5vfStyUG9q2o6UYyIZzlp3Q=;
 b=p7jGcET4azWy7py48LAb2/IpE9DhEm3L+2u3S7QTXM/yKpZdFhWUSznKR1OHBIYHSE
 vkFfleTITLYkmu1odQSir93qM1a2iMQLURx76b0aAD8nnVeyOBrCq39H2vgIo/Ik75bU
 CuNRj6eUt4QeGURv+aCYPHur4aAF5iL0In9EM3WZQ694cmRk1hlaLxzmZNDiV9VNMRBs
 CTkeYUA/DPwSFLGlmfgBeOnrhDtlGSn3j6zMAl15wWZx6U0GB7deO/JrchdvBOgyO2Bd
 uXejoQyvWvHw8FI6zE7xFHWG02rokoSj4tXLtfoffAAwvYaqukNxckOI8KC0XYY+fLKs
 iVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DusenhJf7zgZTt8h/CNi5vfStyUG9q2o6UYyIZzlp3Q=;
 b=j7FqqXftqJoB+yuIJeFC7nmHEzlhu5cLNVPHNuNNxjWu4BBBJDS7ULnJdZxDRK1+Sv
 Y0hXystr/50ssyK9vo89iySi2xNdd78FNJXIGREG6ul1yGX6zwsF1wi4ARDEbnnJugho
 pcfG+h131UPkUv3L8GnjjKADlCGApSnESsld9HGvoD4MU8vc8MDX7sqvwjxxllIXMqBq
 RjXS7o72glMy+fsrl8ovxqjTPU6ZXHQ84ClxEAR2m2Xrvqm4xI6CzX1bJB8zfMSAbrTW
 TxZUC7EZZjPjghc89ComaIlZNeQaZcHBrRU9zmlne852CNTZ19oZknRTEles23WBDwcM
 /HrA==
X-Gm-Message-State: AOAM532TAMCJ+4S2iMqnWtT8Fd6K8YtTlRzQCkAEy9eh0T7M2xpgXbHk
 xsJ4aSDHgD0MER5jpbokWlTrgTcRKwS83njsLMg=
X-Google-Smtp-Source: ABdhPJxjOx5CtPbdnIgwcVNm75+GxCFhvsURhua/qCJ0U/U7rIo7y+VF/jlJkWGyWk6CalDi0N2y/actzFP6UjyuMvs=
X-Received: by 2002:a25:d387:: with SMTP id
 e129mr33327906ybf.370.1596527521041; 
 Tue, 04 Aug 2020 00:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKS8hWbckrE_cyJCf0pgFresD-JQk66wo-6uJA=Gu2MhReHVw@mail.gmail.com>
 <20200728134936.GA21660@stefanha-x1.localdomain>
 <20200728152719.GD78409@redhat.com>
In-Reply-To: <20200728152719.GD78409@redhat.com>
From: Derek Su <jwsu1986@gmail.com>
Date: Tue, 4 Aug 2020 15:51:50 +0800
Message-ID: <CAFKS8hUPdx=eHpvYqB3T__ZBWyztfNPGSBtiBDiqMotA8Cca9Q@mail.gmail.com>
Subject: Re: [Virtio-fs] virtio-fs performance
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=jwsu1986@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vivek Goyal <vgoyal@redhat.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Jul 28, 2020 at 02:49:36PM +0100, Stefan Hajnoczi wrote:
> > > I'm trying and testing the virtio-fs feature in QEMU v5.0.0.
> > > My host and guest OS are both ubuntu 18.04 with kernel 5.4, and the
> > > underlying storage is one single SSD.
> > >
> > > The configuations are:
> > > (1) virtiofsd
> > > ./virtiofsd -o
> > > source=3D/mnt/ssd/virtiofs,cache=3Dauto,flock,posix_lock,writeback,xa=
ttr
> > > --thread-pool-size=3D1 --socket-path=3D/tmp/vhostqemu
> > >
> > > (2) qemu
> > > qemu-system-x86_64 \
> > > -enable-kvm \
> > > -name ubuntu \
> > > -cpu Westmere \
> > > -m 4096 \
> > > -global kvm-apic.vapic=3Dfalse \
> > > -netdev tap,id=3Dhn0,vhost=3Doff,br=3Dbr0,helper=3D/usr/local/libexec=
/qemu-bridge-helper
> > > \
> > > -device e1000,id=3De0,netdev=3Dhn0 \
> > > -blockdev '{"node-name": "disk0", "driver": "qcow2",
> > > "refcount-cache-size": 1638400, "l2-cache-size": 6553600, "file": {
> > > "driver": "file", "filename": "'${imagefolder}\/ubuntu.qcow2'"}}' \
> > > -device virtio-blk,drive=3Ddisk0,id=3Ddisk0 \
> > > -chardev socket,id=3Dch0,path=3D/tmp/vhostqemu \
> > > -device vhost-user-fs-pci,chardev=3Dch0,tag=3Dmyfs \
> > > -object memory-backend-memfd,id=3Dmem,size=3D4G,share=3Don \
> > > -numa node,memdev=3Dmem \
> > > -qmp stdio \
> > > -vnc :0
> > >
> > > (3) guest
> > > mount -t virtiofs myfs /mnt/virtiofs
> > >
> > > I tried to change virtiofsd's --thread-pool-size value and test the
> > > storage performance by fio.
> > > Before each read/write/randread/randwrite test, the pagecaches of
> > > guest and host are dropped.
> > >
> > > ```
> > > RW=3D"read" # or write/randread/randwrite
> > > fio --name=3Dtest --rw=3D$RW --bs=3D4k --numjobs=3D1 --ioengine=3Dlib=
aio
> > > --runtime=3D60 --direct=3D0 --iodepth=3D64 --size=3D10g
> > > --filename=3D/mnt/virtiofs/testfile
> > > done
>
> Couple of things.
>
> - Can you try cache=3Dnone option in virtiofsd. That will bypass page
>   cache in guest. It also gets rid of latencies related to
>   file_remove_privs() as of now.
>
> - Also with direct=3D0, are we really driving iodepth of 64? With direct=
=3D0
>   it is cached I/O. Is it still asynchronous at this point of time of
>   we have fallen back to synchronous I/O and driving queue depth of
>   1.

Hi, Vivek

I did not see any difference in queue depth with direct=3D{0|1} in my fio t=
est.
Are there more clues to dig into this issue?

>
> - With cache=3Dauto/always, I am seeing performance issues with small wri=
tes
>   and trying to address it.
>
> https://lore.kernel.org/linux-fsdevel/20200716144032.GC422759@redhat.com/
> https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redha=
t.com/

No problem, I'll try it, thanks.

Regards,
Derek

>
> Thanks
> Vivek
>
> > > ```
> > >
> > > --thread-pool-size=3D64 (default)
> > >     seq read: 305 MB/s
> > >     seq write: 118 MB/s
> > >     rand 4KB read: 2222 IOPS
> > >     rand 4KB write: 21100 IOPS
> > >
> > > --thread-pool-size=3D1
> > >     seq read: 387 MB/s
> > >     seq write: 160 MB/s
> > >     rand 4KB read: 2622 IOPS
> > >     rand 4KB write: 30400 IOPS
> > >
> > > The results show the performance using default-pool-size (64) is
> > > poorer than using single thread.
> > > Is it due to the lock contention of the multiple threads?
> > > When can virtio-fs get better performance using multiple threads?
> > >
> > >
> > > I also tested the performance that guest accesses host's files via
> > > NFSv4/CIFS network filesystem.
> > > The "seq read" and "randread" performance of virtio-fs are also worse
> > > than the NFSv4 and CIFS.
> > >
> > > NFSv4:
> > >   seq write: 244 MB/s
> > >   rand 4K read: 4086 IOPS
> > >
> > > I cannot figure out why the perf of NFSv4/CIFS with the network stack
> > > is better than virtio-fs.
> > > Is it expected? Or, do I have an incorrect configuration?
> >
> > No, I remember benchmarking the thread pool and did not see such a big
> > difference.
> >
> > Please use direct=3D1 so that each I/O results in a virtio-fs request.
> > Otherwise the I/O pattern is not directly controlled by the benchmark
> > but by the page cache (readahead, etc).
> >
> > Using numactl(8) or taskset(1) to launch virtiofsd allows you to contro=
l
> > NUMA and CPU scheduling properties. For example, you could force all 64
> > threads to run on the same host CPU using taskset to see if that helps
> > this I/O bound workload.
> >
> > fio can collect detailed statistics on queue depths and a latency
> > histogram. It would be interesting to compare the --thread-pool-size=3D=
64
> > and --thread-pool-size=3D1 numbers.
> >
> > Comparing the "perf record -e kvm:kvm_exit" counts between the two migh=
t
> > also be interesting.
> >
> > Stefan
>
>
>
> > _______________________________________________
> > Virtio-fs mailing list
> > Virtio-fs@redhat.com
> > https://www.redhat.com/mailman/listinfo/virtio-fs
>

