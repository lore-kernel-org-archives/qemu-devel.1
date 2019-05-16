Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C245C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E082205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E082205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRC2x-0007Hl-8D
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 04:47:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hRC1X-0006Xu-9O
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hRC0g-0003C0-FT
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:45:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
	id 1hRC0g-00039P-3g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:45:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4G8ga67102767
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:45:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sh3egk7ry-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:45:04 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
	Thu, 16 May 2019 09:45:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 09:44:58 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4G8ivZE38666410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 08:44:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB8D4A4060;
	Thu, 16 May 2019 08:44:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67B6EA4054;
	Thu, 16 May 2019 08:44:56 +0000 (GMT)
Received: from sathnaga86 (unknown [9.122.211.101])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Thu, 16 May 2019 08:44:56 +0000 (GMT)
Date: Thu, 16 May 2019 14:14:54 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Greg Kurz <groug@kaod.org>
References: <155799221739.527449.14907564571096243745.stgit@bahia.lan>
	<20190516074551.GB25414@sathnaga86>
	<3d7a99b9-5f31-e18d-5cd8-a20c4361efc2@kaod.org>
	<20190516103215.6ba7a70c@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190516103215.6ba7a70c@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-TM-AS-GCONF: 00
x-cbid: 19051608-4275-0000-0000-00000335597F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051608-4276-0000-0000-00003844E046
Message-Id: <20190516084454.GC25414@sathnaga86>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160060
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0a-001b2d01.pphosted.com id x4G8ga67102767
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH] spapr: Print out extra hints when CAS
 negotiation of interrupt mode fails
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
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 10:32:15AM +0200, Greg Kurz wrote:
> On Thu, 16 May 2019 10:22:26 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 5/16/19 9:45 AM, Satheesh Rajendran wrote:
> > > On Thu, May 16, 2019 at 09:36:57AM +0200, Greg Kurz wrote: =20
> > >> Let's suggest to the user how the machine should be configured to =
allow
> > >> the guest to boot successfully.
> > >>
> > >> Suggested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > >> Signed-off-by: Greg Kurz <groug@kaod.org>
> > >> ---
> > >>  hw/ppc/spapr_hcall.c |    4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-) =20
> > >=20
> > > Reviewed-and-Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm=
.com> =20

Reviewed-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Done!

> >=20
> > you should use two different tags. I don't think patchwork understand
> > compounds.
> >=20
> > C.=20
> >=20
>=20
Thanks !!
> It doesn't indeed.
>=20
> $ pwclient view 1100396 | grep Reviewed
> $
> =20
Regards,
-Satheesh.
> > > 2019-05-16T07:42:43.018771Z qemu-system-ppc64: Guest requested unav=
ailable interrupt mode (XICS), either don't set the ic-mode machine prope=
rty or try ic-mode=3Dxics or ic-mode=3Ddual
> > > 2019-05-16 07:42:43.394+0000: shutting down, reason=3Dcrashed
> > >  =20
> > >>
> > >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > >> index 63a55614b83d..aae9fd2b3e6d 100644
> > >> --- a/hw/ppc/spapr_hcall.c
> > >> +++ b/hw/ppc/spapr_hcall.c
> > >> @@ -1646,12 +1646,12 @@ static target_ulong h_client_architecture_=
support(PowerPCCPU *cpu,
> > >>       */
> > >>      if (guest_xive) {
> > >>          if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_LEGACY) {
> > >> -            error_report("Guest requested unavailable interrupt m=
ode (XIVE)");
> > >> +            error_report("Guest requested unavailable interrupt m=
ode (XIVE), try the ic-mode=3Dxive or ic-mode=3Ddual machine property");
> > >>              exit(EXIT_FAILURE);
> > >>          }
> > >>      } else {
> > >>          if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
> > >> -            error_report("Guest requested unavailable interrupt m=
ode (XICS)");
> > >> +            error_report("Guest requested unavailable interrupt m=
ode (XICS), either don't set the ic-mode machine property or try ic-mode=3D=
xics or ic-mode=3Ddual");
> > >>              exit(EXIT_FAILURE);
> > >>          }
> > >>      }
> > >> =20
> > >  =20
> >=20
>=20


