Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A29EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDD7214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDD7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifKH9-0002I2-Eq
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 03:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1ifKEP-0007fp-KA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1ifKEO-0005B8-1P
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:53:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1ifKEN-00058z-PC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:53:55 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBC8lm1o062492
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 03:53:54 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuhsc97nb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 03:53:54 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Thu, 12 Dec 2019 08:53:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Dec 2019 08:53:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBC8rlAv19988578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 08:53:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 327CAAE056;
 Thu, 12 Dec 2019 08:53:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFF7FAE055;
 Thu, 12 Dec 2019 08:53:45 +0000 (GMT)
Received: from in.ibm.com (unknown [9.124.35.198])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 12 Dec 2019 08:53:45 +0000 (GMT)
Date: Thu, 12 Dec 2019 14:23:43 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
References: <20191212055059.9399-1-bharata@linux.ibm.com>
 <20191212055059.9399-3-bharata@linux.ibm.com>
 <aeadba2d-1699-a750-2dc2-cf9921e57680@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aeadba2d-1699-a750-2dc2-cf9921e57680@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 19121208-0020-0000-0000-0000039760F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121208-0021-0000-0000-000021EE684E
Message-Id: <20191212085343.GB28362@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120062
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBC8lm1o062492
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Reply-To: bharata@linux.ibm.com
Cc: linuxram@us.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 08:34:57AM +0100, C=E9dric Le Goater wrote:
> Hello Bharata,
>=20
>=20
> On 12/12/2019 06:50, Bharata B Rao wrote:
> > A pseries guest can be run as a secure guest on Ultravisor-enabled
> > POWER platforms. When such a secure guest is reset, we need to
> > release/reset a few resources both on ultravisor and hypervisor side.
> > This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> > machine reset path.
> >=20
> > As part of this ioctl, the secure guest is essentially transitioned
> > back to normal mode so that it can reboot like a regular guest and
> > become secure again.
> >=20
> > This ioctl has no effect when invoked for a normal guest. If this ioc=
tl
> > fails for a secure guest, the guest is terminated.
>=20
> This looks OK.=20
>=20
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> >  hw/ppc/spapr.c       | 15 +++++++++++++++
> >  target/ppc/kvm.c     |  7 +++++++
> >  target/ppc/kvm_ppc.h |  6 ++++++
> >  3 files changed, 28 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index f11422fc41..25e1a3446e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1597,6 +1597,21 @@ static void spapr_machine_reset(MachineState *=
machine)
> >      void *fdt;
> >      int rc;
> > =20
> > +    /*
> > +     * KVM_PPC_SVM_OFF ioctl can fail for secure guests, check and
> > +     * exit in that case. However check for -ENOTTY explicitly
> > +     * to ensure that we don't terminate normal guests that are
> > +     * running on kernels which don't support this ioctl.
> > +     *
> > +     * Also, this ioctl returns 0 for normal guests on kernels where
> > +     * this ioctl is supported.
> > +     */
> > +    rc =3D kvmppc_svm_off();
> > +    if (rc && rc !=3D -ENOTTY) {
>=20
> I would put these low level tests under kvmppc_svm_off().

Makes sense.

>=20
> > +        error_report("Reset of secure guest failed, exiting...");
> > +        exit(EXIT_FAILURE);
>=20
> The exit() could probably go under kvmppc_svm_off() also.

May be not. Then error_report would have also have to go in.
Doesn't make sense to print this error from there.

Regards,
Bharata.


