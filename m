Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AA820644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v9STOoOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AA820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRhZ-0005Oa-Lf
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:17:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLRgh-00055z-Ak
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLRgg-000811-0x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:16:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hLRgf-00080U-MX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:16:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3UC4PZN126081; Tue, 30 Apr 2019 12:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
	bh=stcZtfGfCo/IzUJLtd3HedLv0tCRRKGPYBwhTGzBWVY=;
	b=v9STOoOUwU++Z0fTdUDYGjcBy8B/HAOLzwTvQOdfHnyObjFF9dEg9dAPmT8oGzWEElr6
	kjG7WjFYmO0vGRYeH+zK/fDp1OYva1rJf+HR/tzB4KenlknrQRXHIbnwdcf27NYDGGkY
	4vZeVW7ZHCpNcmJumqd/KP+l8IJGyzQR3YwPj8q+jGmPonWubGVxC8RzrU+JMWJjwmY8
	WCMXpc1T4pYLXyYCO69PqMWZ2KaFgI4/GhAI706fRQxF4MsOvQVW6tdoQcrfQ7RdTuC4
	MH2l7qUSygkbZhoCYvuEUc/kw82lL/lBu2o61/7xN+bKoCVwHnRGitrD1ZUsXikIIScV
	cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2s5j5u0t3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2019 12:16:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3UCFbj3126300; Tue, 30 Apr 2019 12:16:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2s4yy9gjc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2019 12:16:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UCGWTM017802;
	Tue, 30 Apr 2019 12:16:33 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 30 Apr 2019 05:16:32 -0700
Date: Tue, 30 Apr 2019 15:16:25 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Hannes Reinecke <hare@suse.de>
Message-ID: <20190430121624.GA8708@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
	<e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904300080
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904300080
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
	x3UC4PZN126081
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
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
Cc: mst@redhat.com, linux-rdma@vger.kernel.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org, jgg@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430121625.qMerMF2FqLtsJ82eS_hc0v36t9jvldaSackwPs0KC24@z>

On Fri, Apr 19, 2019 at 01:16:06PM +0200, Hannes Reinecke wrote:
> On 4/15/19 12:35 PM, Yuval Shaia wrote:
> > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > >=20
> > > > Data center backends use more and more RDMA or RoCE devices and m=
ore and
> > > > more software runs in virtualized environment.
> > > > There is a need for a standard to enable RDMA/RoCE on Virtual Mac=
hines.
> > > >=20
> > > > Virtio is the optimal solution since is the de-facto para-virtual=
izaton
> > > > technology and also because the Virtio specification
> > > > allows Hardware Vendors to support Virtio protocol natively in or=
der to
> > > > achieve bare metal performance.
> > > >=20
> > > > This RFC is an effort to addresses challenges in defining the RDM=
A/RoCE
> > > > Virtio Specification and a look forward on possible implementatio=
n
> > > > techniques.
> > > >=20
> > > > Open issues/Todo list:
> > > > List is huge, this is only start point of the project.
> > > > Anyway, here is one example of item in the list:
> > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This =
means that
> > > >    in order to support for example 32K QPs we will need 64K VirtQ=
. Not sure
> > > >    that this is reasonable so one option is to have one for all a=
nd
> > > >    multiplex the traffic on it. This is not good approach as by d=
esign it
> > > >    introducing an optional starvation. Another approach would be =
multi
> > > >    queues and round-robin (for example) between them.
> > > >=20
> Typically there will be a one-to-one mapping between QPs and CPUs (on t=
he
> guest). So while one would need to be prepared to support quite some QP=
s,
> the expectation is that the actual number of QPs used will be rather lo=
w.
> In a similar vein, multiplexing QPs would be defeating the purpose, as =
the
> overall idea was to have _independent_ QPs to enhance parallelism.

Since Jason already addresses the issue then i'll skip it.

>=20
> > > > Expectations from this posting:
> > > > In general, any comment is welcome, starting from hey, drop this =
as it is a
> > > > very bad idea, to yeah, go ahead, we really want it.
> > > > Idea here is that since it is not a minor effort i first want to =
know if
> > > > there is some sort interest in the community for such device.
> > >=20
> > > My first reaction is: Sounds sensible, but it would be good to have=
 a
> > > spec for this :)
> > >=20
> > > You'll need a spec if you want this to go forward anyway, so at lea=
st a
> > > sketch would be good to answer questions such as how many virtqueue=
s
> > > you use for which purpose, what is actually put on the virtqueues,
> > > whether there are negotiable features, and what the expectations fo=
r
> > > the device and the driver are. It also makes it easier to understan=
d
> > > how this is supposed to work in practice.
> > >=20
> > > If folks agree that this sounds useful, the next step would be to
> > > reserve an id for the device type.
> >=20
> > Thanks for the tips, will sure do that, it is that first i wanted to =
make
> > sure there is a use case here.
> >=20
> > Waiting for any feedback from the community.
> >=20
> I really do like the ides; in fact, it saved me from coding a similar t=
hing
> myself :-)

Isn't it the great thing with open source :-)

>=20
> However, I'm still curious about the overall intent of this driver. Whe=
re
> would the I/O be routed _to_ ?
> It's nice that we have a virtualized driver, but this driver is
> intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> And this I/O needs to be send to (and possibly received from)
> something.

Idea is to have a virtio-rdma device emulation (patch #2) on host that wi=
ll
relay the traffic to the real HW on host.

It will be good to have design that will allow Virtio-HW to be plugged to
the host and use the same driver. In this case the emulated device would
not be needed - the driver will "attach" to the Virtqueue exposed by the
virtio-HW instead of the emulated RDMA device.

I don't know of any public virtio-rdma HW.

>=20
> So what exactly is this something?
> An existing piece of HW on the host?
> If so, wouldn't it be more efficient to use vfio, either by using SR-IO=
V or
> by using virtio-mdev?

vfio needs to be implemented by every HW vendor where this approach is a
generic one that is not depended on the HW.

SV-IOV has it's limitations.

And with virtio-mdev, sorry but do not know, can you elaborate more?

>=20
> Another guest?

No

> If so, how would we route the I/O from one guest to the other?
> Shared memory? Implementing a full-blown RDMA switch in qemu?
>=20
> Oh, and I would _love_ to have a discussion about this at KVM Forum.
> Maybe I'll manage to whip up guest-to-guest RDMA connection using ivshm=
em
> ... let's see.

Well, I've posted a proposal for a talk, lets see if it'll be accepted.

>=20
> Cheers,
>=20
> Hannes
> --=20
> Dr. Hannes Reinecke            Teamlead Storage & Networking
> hare@suse.de                              +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
> GF: Felix Imend=F6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=FCrnberg)

