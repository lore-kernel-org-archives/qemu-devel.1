Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74400C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3FB20825
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3FB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8R5-0002rf-Hw
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 17:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jj8QE-0002OM-NQ; Wed, 10 Jun 2020 17:38:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61162
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jj8QD-00021d-Eo; Wed, 10 Jun 2020 17:38:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05ALW88M084570; Wed, 10 Jun 2020 17:38:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31k4swch56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 17:38:03 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05ALWCRn085000;
 Wed, 10 Jun 2020 17:38:03 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31k4swch4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 17:38:03 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ALVbWY007397;
 Wed, 10 Jun 2020 21:38:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma01fra.de.ibm.com with ESMTP id 31g2s7ugt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 21:38:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05ALbwvR32571484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 21:37:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3007052051;
 Wed, 10 Jun 2020 21:37:58 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.127.50])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8506B5204E;
 Wed, 10 Jun 2020 21:37:57 +0000 (GMT)
Date: Wed, 10 Jun 2020 23:37:14 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200610233714.05174c93.pasic@linux.ibm.com>
In-Reply-To: <20200610042554.GD494336@umbus.fritz.box>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200610042554.GD494336@umbus.fritz.box>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/hnp6abtT+3frwSu.euV9H7q"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-10_13:2020-06-10,
 2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 cotscore=-2147483648 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 17:38:08
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
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/hnp6abtT+3frwSu.euV9H7q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2020 14:25:54 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> > > I'm going to definitely have a good look at that. What I think special
> > > about s390 is that F_ACCESS_PLATFORM is hurting us because all IO nee=
ds
> > > to go through ZONE_DMA (this is a problem of the implementation that
> > > stemming form a limitation of the DMA API, upstream didn't let me
> > > fix it).  =20
> >=20
> > My understanding is that power runs into similar issues, but I don't
> > know much about power, so I might be entirely wrong :) =20
>=20
> Sort of, but not to the same extent, I think.

I'm curious what are the ramifications of a misguided hotplug on POWER?
Does using F_ACCESS_PLATFORM when it isn't required have any
significant drawbacks, or are you fine to just go with the safe option?

Regards,
Halil

--Sig_/hnp6abtT+3frwSu.euV9H7q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJe4VKzAAoJEA0vhuyXGx0ALN0QAK5p246k2n0uOGTl3kMSto1D
bo6Rw6md2DzQgoFUcw18hycuB9Xxu3whOxQxFTjF9AQDuCxXgR0ag2pFAaeu0EhK
k5JjTg2GxXdB6NptWMTVlGpZHA01BaAlyHl6lf4xdUwL4YyTgiH90r6jfU0yaf6z
1/ZtniKK96hXSD5ubc3KWSTnbA0Bqv0SKFR4Pv+Itm+S0UZT8wrv+7cLK81k/90f
s+Ik031Mq4qAtagwWVn+a8isiGsDVED6msFRVae30UFg0ZKdIua3PM+2mabqKus5
zNyLyYuC3vFfTVy/7iDHDMl+5B2fDjy/azETFgRPVLC4vQoCmmDLhjc0R5AZMxHF
IUz2FcpqHomxH2aQWCfbOLm89vrd+3PvucpI75bzKHecN7f8RaZ5jGrytoONkxvm
4ig4R0VIT//bVuWvbHAyX4xp9j26Cotq4510MPB3d3G1L9vGcUZLit3nOJ/j05th
MXZSLKdeUpYaPQaIJsbB7WUrQXrYaM4KPh/mYK4ROCG+8CC+cdsJbx59vjVTroNH
q3t+NjcFA8CmmeImZ8H6czcSUHMR6ZOqP4sfIFBjrhGSWy23anXU45ZSXq0otkx6
w3/Uymb0Zb1/c/qRp0fs87jeDBoha9swIUfO+JEjFu+Jikmc2t7Z4yiS1UUlLSzB
d8kHvrUT/Cz7cWnE9VSK
=2qEj
-----END PGP SIGNATURE-----

--Sig_/hnp6abtT+3frwSu.euV9H7q--


