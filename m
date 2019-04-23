Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74670C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4085E206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4085E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIuBL-0007NX-EU
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 08:05:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIuAV-00071R-Eq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIuAU-0007Ya-AM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hIuAS-0007XI-OT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:04:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DFF7DC8E8;
	Tue, 23 Apr 2019 12:04:55 +0000 (UTC)
Received: from localhost (ovpn-117-214.ams2.redhat.com [10.36.117.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1A4A1792C8;
	Tue, 23 Apr 2019 12:04:54 +0000 (UTC)
Date: Tue, 23 Apr 2019 13:04:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wei Li <wei.d.li@oracle.com>
Message-ID: <20190423120453.GF32465@stefanha-x1.localdomain>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 23 Apr 2019 12:04:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org, Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423120453.OAQEuWK2G-Vqxs3qX4O15K4rWGOrssDcCGUdIG6Ymx4@z>


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 09:21:53PM -0700, Wei Li wrote:
>         2. kvm_stat or perf record -a -e kvm:\* counters for vmexits and
>            interrupt injections.  If these counters vary greatly between =
queue
>            sizes, then that is usually a clue.  It's possible to get high=
er
>            performance by spending more CPU cycles although your system d=
oesn't
>            have many CPUs available, so I'm not sure if this is the case.
>=20
> [wei]: vmexits looks like a reason. I am using FIO tool to read/write blo=
ck storage via following sample command, interesting thing is that kvm:kvm_=
exit count decreased from 846K to 395K after I increased num_queues from 2 =
to 4 while the vCPU count is 2.
>            1). Does this mean using more queues than vCPU count may incre=
ase IOPS via spending more CPU cycle?=20
>            2). Could you please help me better understand how more queues=
 is able to spend more CPU cycle? Thanks!
>            FIO command: fio --filename=3D/dev/sdb --direct=3D1 --rw=3Dran=
drw --bs=3D4k --ioengine=3Dlibaio --iodepth=3D64 --numjobs=3D4 --time_based=
 --group_reporting --name=3Diops --runtime=3D60 --eta-newline=3D1
>=20
>         3. Power management and polling (kvm.ko halt_poll_ns, tuned profi=
les,
>            and QEMU iothread poll-max-ns).  It's expensive to wake a CPU =
when it
>            goes into a low power mode due to idle.  There are several fea=
tures
>            that can keep the CPU awake or even poll so that request laten=
cy is
>            reduced.  The reason why the number of queues may matter is th=
at
>            kicking multiple queues may keep the CPU awake more than batch=
ing
>            multiple requests onto a small number of queues.
> [wei]: CPU awake could be another reason, I noticed that kvm:kvm_vcpu_wak=
eup count decreased from 151K to 47K after I increased num_queues from 2 to=
 4 while the vCPU count is 2.

This suggests that wakeups are involved in the performance difference.

>            1). Does this mean more queues may keep CPU more busy and awak=
e which reduced the vcpu wakeup time?

Yes, although it depends on how I/O requests are distributed across the
queues.  You can check /proc/interrupts inside the guest to see
interrupt counts for the virtqueues.

>            2). If using more num_queues than vCPU count is able to get hi=
gher IOPS for this case, is it safe to use 4 queues while it only have 2 vC=
PU, or there is any concern or impact by using more queues than vCPU count =
which I should keep in mind?

2 vs 4 queues should be functionally identical.  The only difference is
performance.

> In addition, does Virtio-scsi support Batch I/O Submission feature which =
may be able to increase the IOPS via reducing the number of system calls?

I don't see obvious batching support in drivers/scsi/virtio_scsi.c.  The
Linux block layer supports batching but I'm not sure if the SCSI layer
does.

Stefan

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvv9lAAoJEJykq7OBq3PI9p8H/iYfB3k6y4E7Npe806M3d8/0
TO+l/gR/1minGRclEpiw9DWzvQOEnv/IKcEPnu7nvyQgtEtN5eTu+CiNHXWEzIB0
MzGVTm2XpqKkl+ov/M9PeY4QNqMpasKaLuHafJx7W4VVjaN1xIQ1gv3ZwKBGGDwc
GD+OsWFQXXRZcb+18iseRFNrDzUFvW7aHX4Hk3qDog6dYdWzSmKdxtqBnY08/Kf0
CYvnGFCP7jB54/m3ymT88qbp4gQutxrLQlpU+kI2qK/9GaoqqcF2AG8kbOKl2bbf
DBh78TNjiN0uzNhtiyksLfCi2vRYlcYyrWQAq/MjkoZVWKCISYOQNcpd0TWBCKk=
=sKm3
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--

