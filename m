Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4738C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8009720578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JFAkP9rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8009720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO5N1-0004GX-Nr
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 15:03:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1hO5Ln-0003f1-Au
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1hO5Lh-0005AJ-I7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:02:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1hO5Ld-0004Al-V1
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:01:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x47Irw5H084764; Tue, 7 May 2019 19:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=Q1RA1Jje3pHKyZp2UvjsrR4pIsOK3g6qzluo7ZM1OAg=;
	b=JFAkP9rO5XDNVEhaRmiPc4kn6nO51dSOhW/yxoPSrmQ1Q1zl/ZObwxAe9yDAXFcG6Dm0
	OgWs9M4TSof7XZc26j3lNFlFpWFxMZiM5w4XpogugjhYpqL6mjunff3k3o18O+r1YUGZ
	GEvE85bDUsnSnBcgcTCG3xkBhbR7A6XtmpyOLU4SkMSgydxbqUVfLuKvpnDhLShuC4Lc
	fkC7E5HmQf7U5dykMfexKhgMA+5/zO1tqO5f7nRpyTfXJ03e1JZowzxBel/HH8nQ5DY+
	uN15eAvl6evcO90EqrbE+FJyF9scYoR9nSJ6ljPHEnk6rrbr5aiJ7do8pPclT2dS+jtk
	xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2s94bfyfwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2019 19:00:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x47IxJJ4073110; Tue, 7 May 2019 19:00:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3020.oracle.com with ESMTP id 2s94afngkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2019 19:00:55 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x47J0rCG018345;
	Tue, 7 May 2019 19:00:53 GMT
Received: from [10.11.99.171] (/10.11.99.171)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 07 May 2019 12:00:53 -0700
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190308095036.GC12318@stefanha-x1.localdomain>
	<20190326080822.GC21018@stefanha-x1.localdomain>
	<e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
	<CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
	<c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
	<20190425154421.GG17806@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
Date: Tue, 7 May 2019 15:00:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190425154421.GG17806@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9250
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905070121
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9250
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905070121
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
	x47Irw5H084764
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
	John G Johnson <john.g.johnson@oracle.com>,
	sstabellini@kernel.org, konrad.wilk@oracle.com,
	Stefan Hajnoczi <stefanha@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org, ross.lagerwall@citrix.com,
	liran.alon@oracle.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

Thank you very much for your feedback. Following is a summary of the
discussions our team had regarding your feedback.

On 4/25/2019 11:44 AM, Stefan Hajnoczi wrote:
>=20
> Can multiple LSI SCSI controllers be launched such that each process
> only has access to a subset of disk images?  Or is the disk image label
> per-VM so that there is no isolation between LSI SCSI controller
> processes for that VM?

Yes, it is possible to provide each process with access to a subset of
disk images. The Orchestrator (libvirt, etc.) assigns a set of MCS
Categories to each VM, then device instances can be isolated by being
assigned a subset of the VM=92s Categories.

>=20
> My concern with this overall approach is the practicality vs its
> benefits.  Regarding practicality, each emulated device needs to be
> proxied separately.  The QEMU subsystem used by the device also needs t=
o
> be proxied.  Global state, monitor commands, and live migration all
> require code changes to support proxied operation.  This is very
> invasive.
>=20
> Then each emulated device needs an SELinux policy to achieve the
> benefits of confinement.  I have no idea how to correctly write a polic=
y
> like this and it's likely that developers who contribute a single new
> device will not be proficient in it either.  Writing these policies is =
a
> rare thing and few people will be good at this.  It also makes me worry
> about how we test and review them.

We also think that having an SELinux policy per device would become
complicated. Our proposal, therefore, is to define SELinux policies for
each device class - viz. disk, network, console, graphics, etc.
"fedora-selinux" upstream repo. [1] will contain these policies, so the
device developer doesn't have to worry about defining new policies for
each device. This proposal would diminish the complexity of SELinux
policies.

>=20
> Despite the efforts required in making this work, all processes still
> effectively have full access to the guest since they can access guest
> RAM.  What I mean is that the device is actually not confined to its
> host process (e.g. LSI SCSI controller process) because it can write
> code to executable guest RAM pages.  The guest will then execute that
> code and therefore all guest I/O (networking, disk, etc) is still
> available indirectly to the "confined" processes.  They are not really
> sandboxed from the outside world, regardless of how strict the SELinux
> policy is :(.
>=20
> There are performance issues due to proxying as well, but let's ignore
> them for now and focus on security.

We are also focusing on performance. Please take a look at the following
blog for an initial report on performance. The results are for an iSCSI
backend in Oracle Cloud. We are working on collecting data on a much
heavier IOPS workload like an NVMe backend.

https://blogs.oracle.com/linux/towards-a-more-secure-qemu-hypervisor%2c-p=
art-3-of-3-v2

>=20
> How do the benefits compare against today's monolithic approach?  If th=
e
> guest exploits monolithic QEMU it has full access to all host files and
> APIs available to QEMU.  However, these are largely just the resources
> that belong to the guest anyway - not resources we are trying to keep
> away from the guest.  With multi-process QEMU each process still has
> access to all guest interfaces via the code injection I mentioned above=
,
> but the SELinux policy could restrict access to some resources.  But
> this benefit is really small in my opinion, given that the resources
> belong to the guest anyway and the guest can already access them.

The primary focus of our project is to defend the host from malicious
guest. The code injection problem you outlined above involves part of
the guest attacking itself, but not the host. Therefore, this wouldn't
compromise our objective.

Like you know, there are some parts of QEMU which are not directly
accessible from the guest (via drivers, etc.), which we prefer to call
the control plane. It executes ioctls to the host kernel and has access
to a broader set of syscalls, which the device emulation code doesn=92t
need. We want to protect the control plane from emulated devices. In the
case where a device injects code into the RAM to attack another device
on the same VM, the control plane would still be protected.

Another benefit with the project would be regarding detecting and
reporting failures in the emulated devices. For instance, in cases like
CVE-2018-18849, where an emulated device hangs/crashes, it wouldn't
directly crash the QEMU process as well. QEMU could detect the failure,
log the problem and exit, instead of generating coredump/hang.

>=20
> I think you can implement this for a handful of devices as a one-time
> thing, but the invasiveness and the impracticality of getting wide cove=
r
> of QEMU make this approach questionable.
>=20
> Am I mistaken about the invasiveness or impracticality?

We are not planning to implement this for all devices since it would be
impractical. But the project adds a framework for implementing more
devices in the future.

One other thing we would like to bring your attention to is that the
project doesn't affect the current usage. The same devices could still
be used as part of monolithic QEMU if the user chooses to do so.

>=20
> Am I misunderstanding the security benefits compared to what already
> exists today?

As far as we know, there is no other open-source KVM based toolstack
where the privileged operations are in a separate process, and the
emulated devices are in jail and where you can still run legacy OSes
like Windows XP

>=20
> A more practical approach is to strip down QEMU (compiling out unused
> devices and features) and to run virtio devices in vhost-user processes
> (e.g. virtio-input, virtio-gpu, virtio-fs).  This achieves similar goal=
s
> without proxy objects or invasive changes to QEMU since the vhost-user
> devices use a different codebase and aren't accessible via the QEMU
> monitor.  The limitation is that existing QEMU code and non-virtio
> devices aren't available in this model.

In some cases, the user/customer brings in VMs with legacy devices
attached to them. It's not possible to take the virtio/vhost approach in
this case.

[1] https://github.com/fedora-selinux

Thanks!
--=20
Jag

>=20
> Stefan
>=20

