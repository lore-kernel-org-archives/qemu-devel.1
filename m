Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42CFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F332074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F332074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigP3-00053n-Ol
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jigOD-0004TA-5R; Tue, 09 Jun 2020 11:42:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jigOB-0007kE-Q5; Tue, 09 Jun 2020 11:42:12 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 059FXEID068226; Tue, 9 Jun 2020 11:42:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31grrj8ct9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 11:42:03 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 059FXQZa068917;
 Tue, 9 Jun 2020 11:42:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31grrj8cs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 11:42:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059Ff8sK026269;
 Tue, 9 Jun 2020 15:41:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 31g2s7x7kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 15:41:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 059FfvUh58327076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2020 15:41:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DD6911C050;
 Tue,  9 Jun 2020 15:41:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EB2211C04A;
 Tue,  9 Jun 2020 15:41:56 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.129.89])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2020 15:41:56 +0000 (GMT)
Date: Tue, 9 Jun 2020 17:40:46 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200609174046.0a0d83b9.pasic@linux.ibm.com>
In-Reply-To: <20200609121641.5b3ffa48.cohuck@redhat.com>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
 <20200606162014-mutt-send-email-mst@kernel.org>
 <20200607030735.GN228651@umbus.fritz.box>
 <20200609121641.5b3ffa48.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/hr6MQwYlM+P2gVUu2sscas="; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-09_09:2020-06-09,
 2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 cotscore=-2147483648 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 11:42:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/hr6MQwYlM+P2gVUu2sscas=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2020 12:16:41 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Sun, 7 Jun 2020 13:07:35 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Sat, Jun 06, 2020 at 04:21:31PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, May 21, 2020 at 01:43:04PM +1000, David Gibson wrote: =20
> > > > The default behaviour for virtio devices is not to use the platform=
s normal
> > > > DMA paths, but instead to use the fact that it's running in a hyper=
visor
> > > > to directly access guest memory.  That doesn't work if the guest's =
memory
> > > > is protected from hypervisor access, such as with AMD's SEV or POWE=
R's PEF.
> > > >=20
> > > > So, if a guest memory protection mechanism is enabled, then apply t=
he
> > > > iommu_platform=3Don option so it will go through normal DMA mechani=
sms.
> > > > Those will presumably have some way of marking memory as shared wit=
h the
> > > > hypervisor or hardware so that DMA will work.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---
> > > >  hw/core/machine.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >=20
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index 88d699bceb..cb6580954e 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -28,6 +28,8 @@
> > > >  #include "hw/mem/nvdimm.h"
> > > >  #include "migration/vmstate.h"
> > > >  #include "exec/guest-memory-protection.h"
> > > > +#include "hw/virtio/virtio.h"
> > > > +#include "hw/virtio/virtio-pci.h"
> > > > =20
> > > >  GlobalProperty hw_compat_5_0[] =3D {};
> > > >  const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
> > > > @@ -1159,6 +1161,15 @@ void machine_run_board_init(MachineState *ma=
chine)
> > > >           * areas.
> > > >           */
> > > >          machine_set_mem_merge(OBJECT(machine), false, &error_abort=
);
> > > > +
> > > > +        /*
> > > > +         * Virtio devices can't count on directly accessing guest
> > > > +         * memory, so they need iommu_platform=3Don to use normal =
DMA
> > > > +         * mechanisms.  That requires disabling legacy virtio supp=
ort
> > > > +         * for virtio pci devices
> > > > +         */
> > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legac=
y", "on");
> > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_plat=
form", "on");
> > > >      }
> > > >   =20
> > >=20
> > > I think it's a reasonable way to address this overall.
> > > As Cornelia has commented, addressing ccw as well =20
> >=20
> > Sure.  I was assuming somebody who actually knows ccw could do that as
> > a follow up.
>=20
> FWIW, I think we could simply enable iommu_platform for protected
> guests for ccw; no prereqs like pci's disable-legacy.
>=20

For s390x having a memory-encryption object is not prereq for doing
protected virtualization, so the scheme does not work for us right now.

I hope Jansoch will chime in after he is back from his vacation. IMHO
having a memory-protection object will come in handy for migration,
but the presence or absence of this object should be largely transparent
to the user (and not something that needs to be explicitly managed via
command line). AFAIU this object is in the end it is just QEMU plumbing.

> >=20
> > > as cases where user has
> > > specified the property manually could be worth-while. =20
> >=20
> > I don't really see what's to be done there.  I'm assuming that if the
> > user specifies it, they know what they're doing - particularly with
> > nonstandard guests there are some odd edge cases where those
> > combinations might work, they're just not very likely.
>=20
> If I understood Halil correctly, devices without iommu_platform
> apparently can crash protected guests on s390. Is that supposed to be a
> "if it breaks, you get to keep the pieces" situation, or do we really
> want to enforce iommu_platform?

I strongly oppose to adopting the "if it breaks, you get to keep the
pieces" strategy here. It is borderline acceptable on startup, although
IMHO not preferable, but a device hotplug bringing down a guest that is
already running userspace is not acceptable at all.

Regards,
Halil

--Sig_/hr6MQwYlM+P2gVUu2sscas=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJe362aAAoJEA0vhuyXGx0AVpIP/RAYLuWZvU9kRr77jj+ORXq8
xaX/o8OIlvz1pVXcY4DmBTPfw/nvfIPzbM+eRKXcfcU0o2NBb5rcwdysQPyhjNxA
8lAm0bH+BSEnsAUV5DtfhDI1Q9sqjpP7UMrTTx4wZVX9CYqSrb7hK5WhbHSe1kbt
GERlPZ1oLOW5DZ8CgYROGFlv940rhoRms43Wot9vpMQ+gdbPFPuba8Daag89j6lg
kEXM0AzOwPxnR4rCE8wcIc1o7hXHLGcPuErY0GbRx0ToVxkywDXg4axGy29CsiZO
N2PUVPpPT8AQQAAtU8og39auttNUaUo8gSrw5+LldnKPpmK2UdZPBwS6NyHflNYq
DWu1/UHkvU1wnNnrkscwF30kR1f/FtbB7Vz+8AMG4BhlL6CVFxiFazZQ8KWJdj+1
TC1EMoLlIqxChN1XR5hJ36LYYqWfrGRUXL4BRLWsl+tzXGt1NEfWK6trpeJ/xf9u
JCUV1Xws41KU0OYeSp1Z4rlL5498ORFF4WAPIfdhNmo6q7xW4THcXSA5qQWpo6bT
M8Hbp7EzgSgimZuB0kN4Ggs0Vz0QnE+anqYXW+M7nLwPyTTVO0ogWtk6PAesy13W
j4Q7X6RZEBnWRuBp9JK6PdTc58nLr0DNBzXiKmyMjZLLaNBufV3KGSx/XeXw7CCa
cabx19tN4SynK2eLp8Az
=HC+g
-----END PGP SIGNATURE-----

--Sig_/hr6MQwYlM+P2gVUu2sscas=--


