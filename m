Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17523C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA17206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA17206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj1FB-0003U7-7F
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jj1EX-00033l-Lx; Wed, 10 Jun 2020 09:57:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jj1EW-0006Z0-Eo; Wed, 10 Jun 2020 09:57:37 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05ADXCnb096888; Wed, 10 Jun 2020 09:57:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31k02bsq6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 09:57:29 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05ADXI6B097645;
 Wed, 10 Jun 2020 09:57:28 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31k02bsq58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 09:57:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ADt69t031159;
 Wed, 10 Jun 2020 13:57:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04ams.nl.ibm.com with ESMTP id 31g2s7ytjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 13:57:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05ADvNF251708092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 13:57:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7C154C040;
 Wed, 10 Jun 2020 13:57:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1F794C04A;
 Wed, 10 Jun 2020 13:57:22 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.127.50])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2020 13:57:22 +0000 (GMT)
Date: Wed, 10 Jun 2020 15:57:03 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200610155703.661aca83.pasic@linux.ibm.com>
In-Reply-To: <20200610042929.GE494336@umbus.fritz.box>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
 <20200610042929.GE494336@umbus.fritz.box>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/gT4qYfrQeiJV=SC5f44QI/P"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-10_08:2020-06-10,
 2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 adultscore=0 cotscore=-2147483648 spamscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:16:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S.
 Tsirkin" <mst@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/gT4qYfrQeiJV=SC5f44QI/P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2020 14:29:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
> > On Tue, 9 Jun 2020 17:47:47 +0200
> > Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> >=20
> > > On Tue, 9 Jun 2020 11:41:30 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >=20
> > > [...]
> > >=20
> > > > I don't know. Janosch could answer that, but he is on vacation. Add=
ing
> > > > Claudio maybe he can answer. My understanding is, that while it mig=
ht
> > > > be possible, it is ugly at best. The ability to do a transition is
> > > > indicated by a CPU model feature. Indicating the feature to the gue=
st
> > > > and then failing the transition sounds wrong to me.
> > >=20
> > > I agree. If the feature is advertised, then it has to work. I don't
> > > think we even have an architected way to fail the transition for that
> > > reason.
> > >=20
> > > What __could__ be done is to prevent qemu from even starting if an
> > > incompatible device is specified together with PV.
> >=20
> > AFAIU, the "specified together with PV" is the problem here. Currently
> > we don't "specify PV" but PV is just a capability that is managed by the
> > CPU model (like so many other). I.e. the fact that the
> > visualization environment is capable providing PV (unpack facility
> > available), and the fact, that the end user didn't fence the unpack
> > facility, does not mean, the user is dead set to use PV.
> >=20
> > My understanding is, that we want PV to just work, without having to
> > put together a peculiar VM definition that says: this is going to be
> > used as a PV VM.
>=20
> Having had a similar discussion for POWER, I no longer think this is a
> wise model.  I think we want to have an explicit "allow PV" option -
> but we do want it to be a *single* option, rather than having to
> change configuration of a whole bunch of places.
>=20
> My intention is for my 'host-trust-limitation' series to accomplish
> that.
>=20

Dave, many thanks for your input. I would be interested to read up that
discussion you hand for POWER to try to catch the train of thought. Can
you give me a pointer?

My current understanding is that s390x already has the "allow PV" option,
which is the CPU model feature. But its dynamics is just like the
dynamics of other CPU model features, in a sense that you may have to
disable it explicitly.

Our problem is, that iommu_platform=3Don comes at a price point for us,
and we don't want to enforce it when it is not needed. And if the guest
does not decide to do the transition to protected, it is not needed.

Thus any scheme were we pessimise based on the sheer possibility of
protected virtualization seems wrong to me.

The sad thing is that QEMU has every information it needs to do what is
best: for paravirtualized devices
* use F_ACCESS_PLATFORM when needed, to make the guest work harder and
work around the access restrictions imposed by memory protection, and=20
* don't use F_ACCESS_PLATFORM when when not needed, and allow for
  optimization based on the fact that no such access restrictions exist.

Sure we can burden up the user, to tell us if the VM is intended to be
used with memory protection or not. But what does it buy us? The
opportunity to create dodgy configurations?

Regards,
Halil


--Sig_/gT4qYfrQeiJV=SC5f44QI/P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJe4OavAAoJEA0vhuyXGx0AC5sQALNS0x5lb5w3Zkhrw1uU7IiD
U1PY7X6k11eOq7cuX5Do5SmzaVVLjsp/1ktccYyoy3/KZg9PE6EgYnor+hDI5Xof
tjdcTrj/J6134qjufGP5zgULYFT1gZ9/AMu+1IXibYDi+0epNuuXQmadd0R0VmyG
s4yfzbrkK3/64QRG5xg70Fo5HCmhpvySMho9mrqD5iyqzkd2mIUKOVljlZUW8TbY
mZE9Evgl65rBGHWJf62QX1Se1CmIbyjr10j1F0I9UG3R7bepaZZVt6neoPVD8F4y
9ljLZnySNwIJmxk3iQcAP9XfdWQlSeT3PY4kmQWoKSjm64Jw3Pd297JwVjIibjWD
pHimzbK7vmw9B5jLAJrlJN1zFzFf0PUz56JO6zEaSIpFlCOea0u4HSkVCoIvx/CR
i9YZW25KjMENGlPM1oHJhlEw3EX3XLWllIrtwwKc16Ph+I08HJ1i1OEn1CZQfSCB
lmSLr91QNFsuOGNp04ZSVWkC8xL0gRsrlGdmIv4kAj42LagmMoUxy6jAsNWkjK3u
pPFiMDuqOxG4PnqK6PIGpRZbFSkhyJ0/SrMC0Nz+IgOClf4kNvtjOASIFAFklwRQ
ws4cCeWqPpK8A+JmIcSkXnbS9FK9J1mU3B1OvslFbn9CY0U79Ce1y76Z2NTc7AVW
Qx/McwRJpJZiJpZKBOrb
=EQ+u
-----END PGP SIGNATURE-----

--Sig_/gT4qYfrQeiJV=SC5f44QI/P--


