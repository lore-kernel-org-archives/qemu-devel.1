Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67207C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A95E20760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A95E20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0zJ-0001MC-AP
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jj0gy-0000w6-9Z; Wed, 10 Jun 2020 09:22:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jj0gw-0006xl-Fy; Wed, 10 Jun 2020 09:22:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05AD2teK055896; Wed, 10 Jun 2020 09:22:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31k02b0rw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 09:22:48 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05AD3JVj059016;
 Wed, 10 Jun 2020 09:22:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31k02b0ruj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 09:22:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ADFDft018008;
 Wed, 10 Jun 2020 13:22:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 31g2s7yrqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 13:22:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05ADLQAj64028968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 13:21:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 790C242049;
 Wed, 10 Jun 2020 13:22:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE4244204F;
 Wed, 10 Jun 2020 13:22:41 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.127.50])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2020 13:22:41 +0000 (GMT)
Date: Wed, 10 Jun 2020 15:21:59 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200610152159.0b892016.pasic@linux.ibm.com>
In-Reply-To: <20200610104842.2687215a.cohuck@redhat.com>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
 <20200606162014-mutt-send-email-mst@kernel.org>
 <20200607030735.GN228651@umbus.fritz.box>
 <20200609121641.5b3ffa48.cohuck@redhat.com>
 <20200610043922.GI494336@umbus.fritz.box>
 <20200610104842.2687215a.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/4sqcT16HYh+2IUfpFzvYsKp"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-10_07:2020-06-10,
 2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 cotscore=-2147483648 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100096
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/4sqcT16HYh+2IUfpFzvYsKp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2020 10:48:42 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 10 Jun 2020 14:39:22 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 09, 2020 at 12:16:41PM +0200, Cornelia Huck wrote:
> > > On Sun, 7 Jun 2020 13:07:35 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Sat, Jun 06, 2020 at 04:21:31PM -0400, Michael S. Tsirkin wrote:=
 =20
> > > > > On Thu, May 21, 2020 at 01:43:04PM +1000, David Gibson wrote:   =
=20
> > > > > > The default behaviour for virtio devices is not to use the plat=
forms normal
> > > > > > DMA paths, but instead to use the fact that it's running in a h=
ypervisor
> > > > > > to directly access guest memory.  That doesn't work if the gues=
t's memory
> > > > > > is protected from hypervisor access, such as with AMD's SEV or =
POWER's PEF.
> > > > > >=20
> > > > > > So, if a guest memory protection mechanism is enabled, then app=
ly the
> > > > > > iommu_platform=3Don option so it will go through normal DMA mec=
hanisms.
> > > > > > Those will presumably have some way of marking memory as shared=
 with the
> > > > > > hypervisor or hardware so that DMA will work.
> > > > > >=20
> > > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > > ---
> > > > > >  hw/core/machine.c | 11 +++++++++++
> > > > > >  1 file changed, 11 insertions(+)
> > > > > >=20
> > > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > > index 88d699bceb..cb6580954e 100644
> > > > > > --- a/hw/core/machine.c
> > > > > > +++ b/hw/core/machine.c
> > > > > > @@ -28,6 +28,8 @@
> > > > > >  #include "hw/mem/nvdimm.h"
> > > > > >  #include "migration/vmstate.h"
> > > > > >  #include "exec/guest-memory-protection.h"
> > > > > > +#include "hw/virtio/virtio.h"
> > > > > > +#include "hw/virtio/virtio-pci.h"
> > > > > > =20
> > > > > >  GlobalProperty hw_compat_5_0[] =3D {};
> > > > > >  const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
> > > > > > @@ -1159,6 +1161,15 @@ void machine_run_board_init(MachineState=
 *machine)
> > > > > >           * areas.
> > > > > >           */
> > > > > >          machine_set_mem_merge(OBJECT(machine), false, &error_a=
bort);
> > > > > > +
> > > > > > +        /*
> > > > > > +         * Virtio devices can't count on directly accessing gu=
est
> > > > > > +         * memory, so they need iommu_platform=3Don to use nor=
mal DMA
> > > > > > +         * mechanisms.  That requires disabling legacy virtio =
support
> > > > > > +         * for virtio pci devices
> > > > > > +         */
> > > > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-l=
egacy", "on");
> > > > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_=
platform", "on");
> > > > > >      }
> > > > > >     =20
> > > > >=20
> > > > > I think it's a reasonable way to address this overall.
> > > > > As Cornelia has commented, addressing ccw as well   =20
> > > >=20
> > > > Sure.  I was assuming somebody who actually knows ccw could do that=
 as
> > > > a follow up. =20
> > >=20
> > > FWIW, I think we could simply enable iommu_platform for protected
> > > guests for ccw; no prereqs like pci's disable-legacy. =20
> >=20
> > Right, and the code above should in fact already do so, since it
> > applies that to TYPE_VIRTIO_DEVICE, which is common.  The
> > disable-legacy part should be harmless for s390, since this is
> > effectively just setting a default, and we don't expect any
> > TYPE_VIRTIO_PCI devices to be instantiated on z.
>=20
> Well, virtio-pci is available on s390, so people could try to use it --
> however, forcing disable-legacy won't hurt in that case, as it won't
> make the situation worse (I don't expect virtio-pci to work on s390
> protected guests.)

Currently we don't have to worry about virtio-pci when running in
protected mode, because PCI is not supported currently, and this is
enforced by the ultravisor which would inject operation exceptions should
a PV guest try to use our PCI instructions.

[..]


--Sig_/4sqcT16HYh+2IUfpFzvYsKp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJe4N6gAAoJEA0vhuyXGx0ACkgP/0IBF5+0fba4WXo3noX8v2eY
MrkedmHTQZiMhFxu8lv3RNIYs5K0SYu1MVzzhIP8Iwm90LFMyT2qedMdG7lnY1gk
h7MkxJeGi2+igKobGKaE4JUqA6jvPuwj7PS3i/RCak2/heB1Tr8gVyEfE4tEGgz+
x/mo37Av8VrCosd/ct/SooJh0Zuz6MW6ZKAjwOm3ktpdhDrW/jINaw0JYBtGD31H
bLyX3R37Iscmk7ml+nvug4W85Ak9bghuFR4Aa3IY0I/0dglmEpNZJXdA+Db/XRuF
hsV2BhvHwElrqlOrhbIKuQYZhhjBdY0uExOmTQX+H3EjraaNBAzRHI9vs1Rgdxc/
D9uvUYhj7Urrc+sR2reCjgali+nagdKJZ+Ihp6+j5L0DBqIlXgoGJZX7DHoNxwVm
wjvH+lvIiTzKUoJYnanisrTsFkKJE9eW143+APonid/hiGqnXknEyULmrqQNthfa
kWrxL/S1zQbpvZaal3mMoGgjGTAFuyeBI6fFDrCxWwMoUOxVjgqX6rsEAQRgAQ6f
vLgpKTCFf9mB0Oxn/YWFYVl3CnSKQZ7Zzr5jewv2a+iih9AVtv925iNSibY2AC07
YxUW6oj+7gzTjW8+J3IXpMiIcFUeaeisICnksoXoBpYrIKSk1jZWbvqpQfXhFO0b
mPmejhBA4t++1dd30YwD
=iOJD
-----END PGP SIGNATURE-----

--Sig_/4sqcT16HYh+2IUfpFzvYsKp--


