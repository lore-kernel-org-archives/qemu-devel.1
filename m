Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0359C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E42121D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLr4ctHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E42121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLwR-0001xI-Qi
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <john.g.johnson@oracle.com>) id 1iiLug-0000HT-E4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <john.g.johnson@oracle.com>) id 1iiLuf-00025l-1g
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:18:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <john.g.johnson@oracle.com>)
 id 1iiLud-00023X-GC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:18:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKH9I2V078948;
 Fri, 20 Dec 2019 17:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=kVLC8a4v2EQr3qIDaGe0PANJ3a4LFt8Ni7OvrDOfjOU=;
 b=kLr4ctHYCETtzITB9+OowlNGjgG7EbBRy4GZY4+qG7C1K71k3mYnqPHIWfIIGggX3xyX
 NGHN52lS3MM4HFAl7qpiEiQ+988LbOgYJvIc0lkXydzK0U0JtUSvDMwl3ALjqyZgNbmh
 5zhhH526C5f8Wi3gveeinGB2FXufUoQzB1mvG6NHkBqCdaG2LH2m8hY+3y1OzmRnt9SC
 EXmY4LRiqTdvbUvnifGID414J4I7QfSnp3VnVWjLtneLemsnwuDyirEoBMH7TrsK/KS6
 us/OvQL5v63551jf12b+gVTu4xFxpzXF0TmAXKo0T3+EnO3HpD2sFS3Yq7f5ms7F/IBT IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2x0ag170fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2019 17:17:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKHEHOV171971;
 Fri, 20 Dec 2019 17:15:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2x0pcc68qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2019 17:15:45 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBKHFg7V007522;
 Fri, 20 Dec 2019 17:15:42 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 20 Dec 2019 09:15:42 -0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20191219133650.GE1624084@stefanha-x1.localdomain>
Date: Fri, 20 Dec 2019 09:15:40 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <D60846D3-5434-4EF8-B25F-7C70F4FA5367@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <4a302c6d-e2c8-0c3e-43d2-946e1fafea5d@redhat.com>
 <20191219133650.GE1624084@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200130
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Dec 19, 2019, at 5:36 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Wed, Dec 18, 2019 at 01:00:55AM +0100, Paolo Bonzini wrote:
>> On 17/12/19 23:57, Felipe Franciosi wrote:
>>> Doing it in userspace was the flow we proposed back in last year's =
KVM
>>> Forum (Edinburgh), but it got turned down.
>>=20
>> I think the time since then has shown that essentially the cat is out =
of
>> the bag.  I didn't really like the idea of devices outside QEMU---and =
I
>> still don't---but if something like "VFIO over AF_UNIX" turns out to =
be
>> the cleanest way to implement multi-process QEMU device models, I am =
not
>> going to pull an RMS and block that from happening.  Assuming I could
>> even do so!
>=20
> There are a range of approaches that will influence how out-of-process
> devices can be licensed and distributed.
>=20
> A VFIO-over-UNIX domain sockets approach means a stable API so that =
any
> license (including proprietary) is possible.
>=20
> Another approach is a QEMU-centric unstable protocol.  I'll call this
> the qdev-over-UNIX domain sockets approach.  Maintaining an =
out-of-tree
> device is expensive and ugly since the protocol changes between QEMU
> versions in ways that are incompatible and undetectable.
>=20
> On top of that, the initialization protocol message could include the
> QEMU version string that the device was compiled against.  If the
> version string doesn't match then QEMU will refuse to talk to the
> device.
>=20

	This is very similar to our multi-process QEMU implementation =
before
we looked into using muser.  The differences are:

We use one object per emulated device type in QEMU rather than having a =
single
VFIO type that can masquerade as any PCI device.

We don=E2=80=99t pin guest memory; we pass the QEMU file descriptors =
used to create
guest memory to the emulation program, and it mmap()s them itself. (ala
vhost-user).

								JJ



> Distributing a single device executable that works with many QEMUs =
(e.g.
> CentOS, Ubuntu) and versions becomes difficult.
>=20
> I want to mention that we have the option of doing this if there are
> strong concerns about out-of-tree devices.  It does have downsides:
> 1. Inability to share devices with other VMMs.
> 2. Probably won't replace vhost-user due to the out-of-tree =
limitations.
> 3. Can still be circumvented by a motivated device author.
>=20
> Stefan


