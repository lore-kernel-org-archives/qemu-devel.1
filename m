Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D637C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DC8206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiM8G3fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DC8206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Q0Q-00038f-J9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0PzH-0001O2-MU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:49:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0PzF-0003xI-RT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595944184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=5ZyevTFA0A+T1irRP2Heall65qhALB5ppulMHCnQmtY=;
 b=GiM8G3fwbTB/cAubMfFcgTkFFZOUrgCRzpUL1zOK7YcOCuYvGPRPK8DpmCYIqMx/eR092Q
 IvoUx/yc0km3m1Lk7qYr5pa2KSehyddDtSWsy50oxDJsCf5E8uqA8XSESZa5BlTVP7iYLN
 jAuIqGauuN2mHyiBQDZBFtRGU4cmmdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-7PtklTnkMq69WznBD8HSRA-1; Tue, 28 Jul 2020 09:49:42 -0400
X-MC-Unique: 7PtklTnkMq69WznBD8HSRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B8E580BCAC;
 Tue, 28 Jul 2020 13:49:41 +0000 (UTC)
Received: from localhost (ovpn-115-19.ams2.redhat.com [10.36.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C801819D7C;
 Tue, 28 Jul 2020 13:49:37 +0000 (UTC)
Date: Tue, 28 Jul 2020 14:49:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: jwsu1986@gmail.com
Subject: Re: virtio-fs performance
Message-ID: <20200728134936.GA21660@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <CAFKS8hWbckrE_cyJCf0pgFresD-JQk66wo-6uJA=Gu2MhReHVw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:02:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I'm trying and testing the virtio-fs feature in QEMU v5.0.0.
> My host and guest OS are both ubuntu 18.04 with kernel 5.4, and the
> underlying storage is one single SSD.
>=20
> The configuations are:
> (1) virtiofsd
> ./virtiofsd -o=20
> source=3D/mnt/ssd/virtiofs,cache=3Dauto,flock,posix_lock,writeback,xattr
> --thread-pool-size=3D1 --socket-path=3D/tmp/vhostqemu
>=20
> (2) qemu
> qemu-system-x86_64 \
> -enable-kvm \
> -name ubuntu \
> -cpu Westmere \
> -m 4096 \
> -global kvm-apic.vapic=3Dfalse \
> -netdev tap,id=3Dhn0,vhost=3Doff,br=3Dbr0,helper=3D/usr/local/libexec/qem=
u-bridge-helper
> \
> -device e1000,id=3De0,netdev=3Dhn0 \
> -blockdev '{"node-name": "disk0", "driver": "qcow2",
> "refcount-cache-size": 1638400, "l2-cache-size": 6553600, "file": {
> "driver": "file", "filename": "'${imagefolder}\/ubuntu.qcow2'"}}' \
> -device virtio-blk,drive=3Ddisk0,id=3Ddisk0 \
> -chardev socket,id=3Dch0,path=3D/tmp/vhostqemu \
> -device vhost-user-fs-pci,chardev=3Dch0,tag=3Dmyfs \
> -object memory-backend-memfd,id=3Dmem,size=3D4G,share=3Don \
> -numa node,memdev=3Dmem \
> -qmp stdio \
> -vnc :0
>=20
> (3) guest
> mount -t virtiofs myfs /mnt/virtiofs
>=20
> I tried to change virtiofsd's --thread-pool-size value and test the
> storage performance by fio.
> Before each read/write/randread/randwrite test, the pagecaches of
> guest and host are dropped.
>=20
> ```
> RW=3D"read" # or write/randread/randwrite
> fio --name=3Dtest --rw=3D$RW --bs=3D4k --numjobs=3D1 --ioengine=3Dlibaio
> --runtime=3D60 --direct=3D0 --iodepth=3D64 --size=3D10g
> --filename=3D/mnt/virtiofs/testfile
> done
> ```
>=20
> --thread-pool-size=3D64 (default)
>     seq read: 305 MB/s
>     seq write: 118 MB/s
>     rand 4KB read: 2222 IOPS
>     rand 4KB write: 21100 IOPS
>=20
> --thread-pool-size=3D1
>     seq read: 387 MB/s
>     seq write: 160 MB/s
>     rand 4KB read: 2622 IOPS
>     rand 4KB write: 30400 IOPS
>=20
> The results show the performance using default-pool-size (64) is
> poorer than using single thread.
> Is it due to the lock contention of the multiple threads?
> When can virtio-fs get better performance using multiple threads?
>=20
>=20
> I also tested the performance that guest accesses host's files via
> NFSv4/CIFS network filesystem.
> The "seq read" and "randread" performance of virtio-fs are also worse
> than the NFSv4 and CIFS.
>=20
> NFSv4:
>   seq write: 244 MB/s
>   rand 4K read: 4086 IOPS
>=20
> I cannot figure out why the perf of NFSv4/CIFS with the network stack
> is better than virtio-fs.
> Is it expected? Or, do I have an incorrect configuration?

No, I remember benchmarking the thread pool and did not see such a big
difference.

Please use direct=3D1 so that each I/O results in a virtio-fs request.
Otherwise the I/O pattern is not directly controlled by the benchmark
but by the page cache (readahead, etc).

Using numactl(8) or taskset(1) to launch virtiofsd allows you to control
NUMA and CPU scheduling properties. For example, you could force all 64
threads to run on the same host CPU using taskset to see if that helps
this I/O bound workload.

fio can collect detailed statistics on queue depths and a latency
histogram. It would be interesting to compare the --thread-pool-size=3D64
and --thread-pool-size=3D1 numbers.

Comparing the "perf record -e kvm:kvm_exit" counts between the two might
also be interesting.

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8gLPAACgkQnKSrs4Gr
c8gjegf8Df/59da0oKXZgqtOYrjLMp/b4LKjG7pvRgSill4J8rxGVW2ABdp7cquh
mc7nOiMU3NwOnh6bn9PkQ1v590QI9KcSGeaGy8T4Z+MbEx4BqkNuZ+dHNsid7KuK
QbSQxxPrT16sktgjQnFIT+G3JF3jvkoaQvS1n3zB7IV7SzOZyDvycgERRLzVVdYh
fy9hWFLf6dTRUeraxFG/cHX1KUmFnbEpPFQqKVYx7f4RZ5KIzgnV0zCvudTNOhup
aJ57dETC5CukcklT3Nn5mnLRRircE99n8bWjL7/2X2jv8aAl89wcL5klixdZNU8G
CLL2XAY/06/ZyyE9xPyQbNfBHJWAaw==
=Zc/F
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--


