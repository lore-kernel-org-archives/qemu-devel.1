Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763622086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne7cdE0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763622086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2rWk-0006ZP-JM
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k2rW2-0005jc-HB; Tue, 04 Aug 2020 03:37:42 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:33721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k2rW0-0002Ds-J8; Tue, 04 Aug 2020 03:37:42 -0400
Received: by mail-yb1-xb41.google.com with SMTP id p191so5253233ybg.0;
 Tue, 04 Aug 2020 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N016jYxqycH4EFoWdJ7RPWxS/v26Q+yXklavvpLDJq0=;
 b=ne7cdE0l/HKRKiFt2ioDKcW67a/Xirn9lnkcmn22u/JpKu989fXfXaeESoZaSa0lzd
 uyzWeyfs8URQfr1Qf4zdCILyxp/3NZIurkqULsJPQdzPnC9HMFrx8SW2yPpIYZFGAtfa
 gSagX8J6KUiDTSqRO0/SxxRCjmJ9WULN6DQTAI4NTwFNbXqIgSl7Ph6rEeAd7/LB8/iX
 eo/6Xauh+wNrZSsJVxLIcdkO3oYuhp2vc56fisfU+HSjZ4ZgrcMnfVKBlQf0i+F3PSO0
 CKdjgtj86NRYaIA6dD7gntnNC2O4fFEd7+iafN40nSp0uIAKioZWh5t5ZxQMkUukNo+6
 XQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N016jYxqycH4EFoWdJ7RPWxS/v26Q+yXklavvpLDJq0=;
 b=t31AIX6/cI2zUpOwXZL69N3lIfn24ISMvyecr8G7/7ajDVEqkpE+iJu/B7aSrWT2/x
 HYkfPWffId/UkDM4QHWUxDV2yLnoATrWYk26O8sCfKJfnbr+7K8/dv7s/3BdyeJ9EAeh
 xPItWENZ+W8LPeihb3dDdIFRLq0PqKlVhQxoLJ0r24GNMAWm6UdKCrEKtOIktEBlTW7F
 OqwTKv1TsegOYPAHpw6snQci8+YVpHSFWeHLheRrXIY2NgKigKWlJDi3A3Qj3/9fmXLd
 n9AH2HxDQLC4AjDvj52cUHEx6z9HnWaYMEViLAD6FCvQEkO2IvKzScQiD7JNFUymACBe
 1ZNQ==
X-Gm-Message-State: AOAM532+1lRRYCf7U+Ak2AQHuYKwWbKzB8M1opExTdu5TigdZv0Ow4L2
 qcyDsucp5S12UXgCdskYIXWf78NmmMudlj25bOI=
X-Google-Smtp-Source: ABdhPJwTFWoi2fu4faDChQPsvQW+n2OgB5epsgFeGsQWF61pN2HcwjhS/0i17f9RenLWD+FLGYKEQzUMb5B2FvuxPXU=
X-Received: by 2002:a25:ba41:: with SMTP id z1mr32583238ybj.84.1596526657806; 
 Tue, 04 Aug 2020 00:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKS8hWbckrE_cyJCf0pgFresD-JQk66wo-6uJA=Gu2MhReHVw@mail.gmail.com>
 <20200728134936.GA21660@stefanha-x1.localdomain>
In-Reply-To: <20200728134936.GA21660@stefanha-x1.localdomain>
From: Derek Su <jwsu1986@gmail.com>
Date: Tue, 4 Aug 2020 15:37:26 +0800
Message-ID: <CAFKS8hVwajyBFrVSURs1bS0F+ig8PSUAi1+YPUpe6=KYH8TjmA@mail.gmail.com>
Subject: Re: virtio-fs performance
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=jwsu1986@gmail.com; helo=mail-yb1-xb41.google.com
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Set the cache=3Dnone in virtiofsd and direct=3D1 in fio,
here are the results and kvm-exit count in 5 seconds.

--thread-pool-size=3D64 (default)
    seq read: 307 MB/s (kvm-exit count=3D1076463)
    seq write: 430 MB/s (kvm-exit count=3D1302493)
    rand 4KB read: 65.2k IOPS (kvm-exit count=3D1322899)
    rand 4KB write: 97.2k IOPS (kvm-exit count=3D1568618)

--thread-pool-size=3D1
    seq read: 303 MB/s (kvm-exit count=3D1034614)
    seq write: 358 MB/s. (kvm-exit count=3D1537735)
    rand 4KB read: 7995 IOPS (kvm-exit count=3D438348)
    rand 4KB write: 97.7k IOPS (kvm-exit count=3D1907585)

The thread-pool-size=3D64 improves the rand 4KB read performance largely,
but doesn't increases the kvm-exit count too much.

In addition, the fio avg. clat of rand 4K write are 960us for
thread-pool-size=3D64 and 7700us for thread-pool-size=3D1.

Regards,
Derek

Stefan Hajnoczi <stefanha@redhat.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> > I'm trying and testing the virtio-fs feature in QEMU v5.0.0.
> > My host and guest OS are both ubuntu 18.04 with kernel 5.4, and the
> > underlying storage is one single SSD.
> >
> > The configuations are:
> > (1) virtiofsd
> > ./virtiofsd -o
> > source=3D/mnt/ssd/virtiofs,cache=3Dauto,flock,posix_lock,writeback,xatt=
r
> > --thread-pool-size=3D1 --socket-path=3D/tmp/vhostqemu
> >
> > (2) qemu
> > qemu-system-x86_64 \
> > -enable-kvm \
> > -name ubuntu \
> > -cpu Westmere \
> > -m 4096 \
> > -global kvm-apic.vapic=3Dfalse \
> > -netdev tap,id=3Dhn0,vhost=3Doff,br=3Dbr0,helper=3D/usr/local/libexec/q=
emu-bridge-helper
> > \
> > -device e1000,id=3De0,netdev=3Dhn0 \
> > -blockdev '{"node-name": "disk0", "driver": "qcow2",
> > "refcount-cache-size": 1638400, "l2-cache-size": 6553600, "file": {
> > "driver": "file", "filename": "'${imagefolder}\/ubuntu.qcow2'"}}' \
> > -device virtio-blk,drive=3Ddisk0,id=3Ddisk0 \
> > -chardev socket,id=3Dch0,path=3D/tmp/vhostqemu \
> > -device vhost-user-fs-pci,chardev=3Dch0,tag=3Dmyfs \
> > -object memory-backend-memfd,id=3Dmem,size=3D4G,share=3Don \
> > -numa node,memdev=3Dmem \
> > -qmp stdio \
> > -vnc :0
> >
> > (3) guest
> > mount -t virtiofs myfs /mnt/virtiofs
> >
> > I tried to change virtiofsd's --thread-pool-size value and test the
> > storage performance by fio.
> > Before each read/write/randread/randwrite test, the pagecaches of
> > guest and host are dropped.
> >
> > ```
> > RW=3D"read" # or write/randread/randwrite
> > fio --name=3Dtest --rw=3D$RW --bs=3D4k --numjobs=3D1 --ioengine=3Dlibai=
o
> > --runtime=3D60 --direct=3D0 --iodepth=3D64 --size=3D10g
> > --filename=3D/mnt/virtiofs/testfile
> > done
> > ```
> >
> > --thread-pool-size=3D64 (default)
> >     seq read: 305 MB/s
> >     seq write: 118 MB/s
> >     rand 4KB read: 2222 IOPS
> >     rand 4KB write: 21100 IOPS
> >
> > --thread-pool-size=3D1
> >     seq read: 387 MB/s
> >     seq write: 160 MB/s
> >     rand 4KB read: 2622 IOPS
> >     rand 4KB write: 30400 IOPS
> >
> > The results show the performance using default-pool-size (64) is
> > poorer than using single thread.
> > Is it due to the lock contention of the multiple threads?
> > When can virtio-fs get better performance using multiple threads?
> >
> >
> > I also tested the performance that guest accesses host's files via
> > NFSv4/CIFS network filesystem.
> > The "seq read" and "randread" performance of virtio-fs are also worse
> > than the NFSv4 and CIFS.
> >
> > NFSv4:
> >   seq write: 244 MB/s
> >   rand 4K read: 4086 IOPS
> >
> > I cannot figure out why the perf of NFSv4/CIFS with the network stack
> > is better than virtio-fs.
> > Is it expected? Or, do I have an incorrect configuration?
>
> No, I remember benchmarking the thread pool and did not see such a big
> difference.
>
> Please use direct=3D1 so that each I/O results in a virtio-fs request.
> Otherwise the I/O pattern is not directly controlled by the benchmark
> but by the page cache (readahead, etc).
>
> Using numactl(8) or taskset(1) to launch virtiofsd allows you to control
> NUMA and CPU scheduling properties. For example, you could force all 64
> threads to run on the same host CPU using taskset to see if that helps
> this I/O bound workload.
>
> fio can collect detailed statistics on queue depths and a latency
> histogram. It would be interesting to compare the --thread-pool-size=3D64
> and --thread-pool-size=3D1 numbers.
>
> Comparing the "perf record -e kvm:kvm_exit" counts between the two might
> also be interesting.
>
> Stefan

