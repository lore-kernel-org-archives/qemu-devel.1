Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E39520848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E39520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADUm-0006Ob-Nv
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jADTm-00052d-Fi
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jADTl-0002Fm-3P
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:57:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jADTk-0001wt-Pj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:57:29 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 026DpGm3115206
 for <qemu-devel@nongnu.org>; Fri, 6 Mar 2020 08:57:27 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yj4q3swx6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 08:57:27 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Fri, 6 Mar 2020 13:57:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 6 Mar 2020 13:57:22 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 026DvLQC53542990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2020 13:57:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 005794C046;
 Fri,  6 Mar 2020 13:57:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A35574C040;
 Fri,  6 Mar 2020 13:57:20 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.49])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2020 13:57:20 +0000 (GMT)
Date: Fri, 6 Mar 2020 14:57:19 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] s390/ipl: sync back loadparm
In-Reply-To: <4ff1004f-7db7-29af-45b2-45d6b3299978@de.ibm.com>
References: <20200224150213.21253-1-pasic@linux.ibm.com>
 <05f7dcf7-a0c7-8811-6b88-df86d5fa0974@redhat.com>
 <20200225125641.72e8cc86.pasic@linux.ibm.com>
 <853387e3-4425-731b-bb09-a7210ea6b299@linux.ibm.com>
 <c019ecc6-900e-8653-a603-de8d03017e95@de.ibm.com>
 <20200305151119.6cd63e96.pasic@linux.ibm.com>
 <98038ac5-c2dd-7536-2399-459fea7dc6ce@de.ibm.com>
 <4ff1004f-7db7-29af-45b2-45d6b3299978@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 20030613-0008-0000-0000-00000359F3AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030613-0009-0000-0000-00004A7B2E3C
Message-Id: <20200306145719.285c634f.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-06_04:2020-03-06,
 2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060099
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 026DpGm3115206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 17:21:44 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

>=20
>=20
> On 05.03.20 15:25, Christian Borntraeger wrote:
> >=20
> >=20
> > On 05.03.20 15:11, Halil Pasic wrote:
> >> On Thu, 5 Mar 2020 13:44:31 +0100
> >> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>
> >>>
> >>>
> >>> On 25.02.20 15:35, Viktor Mihajlovski wrote:
> >>>>
> >>>>
> >>>> On 2/25/20 12:56 PM, Halil Pasic wrote:
> >>>>> On Tue, 25 Feb 2020 10:39:40 +0100
> >>>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>>
> >>>>>> On 24.02.20 16:02, Halil Pasic wrote:
> >>>>>>> We expose loadparm as a r/w machine property, but if loadparm i=
s set by
> >>>>>>> the guest via DIAG 308, we don't update the property. Having a
> >>>>>>> disconnect between the guest view and the QEMU property is not =
nice in
> >>>>>>> itself, but things get even worse for SCSI, where under certain
> >>>>>>> circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works=
 as
> >>>>>>> expected" for details) we call s390_gen_initial_iplb() on reset=
s
> >>>>>>> effectively overwriting the guest/user supplied loadparm with t=
he stale
> >>>>>>> value.
> >>>>>>>
> >>>>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >>>>>>> Fixes: 7104bae9de "hw/s390x: provide loadparm property for the =
machine"
> >>>>>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >>>>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> >>>>>>> Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
> >>>>>>> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >>>>>>> ---
> >>>>>>> =C2=A0 hw/s390x/ipl.c | 21 +++++++++++++++++++++
> >>>>>>> =C2=A0 1 file changed, 21 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> >>>> [...]
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Sync loadparm */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char ascii_loadparm=
[8];
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *ebcdic_loa=
dparm =3D iplb->loadparm;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 8=
 && ebcdic_loadparm[i]; i++) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ascii_loadparm[i] =3D ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ascii_loadparm[i] =3D=
 0;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set=
_str(mo, ascii_loadparm, "loadparm", NULL);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 } else {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set=
_str(mo, "", "loadparm", NULL);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>>>
> >>>>>> &error_abort instead of NULL, we certainly want to know if this =
would
> >>>>>> ever surprisingly fail.
> >>>>>
> >>>>> IMHO this is a typical assert() situation where one would like to=
 have
> >>>>> a fast and obvious failure when testing, but not in production.
> >>>>>
> >>>>> AFAIU the guest can trigger this code at any time, and crashing t=
he
> >>>>> whole (production) system seems a bit heavy handed to me. The set=
ter
> >>>>> should only fail if something is buggy.
> >>>>>
> >>>>> But if the majority says &error_abort I can certainly do. Other o=
pinions?
> >>>>>
> >>>> We might consider to return 0x0402 (invalid parameter) from the di=
ag308 "set", which is less drastic and would allow the OS to do whatever =
it finds appropriate to deal with the failure. Not that Linux would care =
about that today :-).
> >>>
> >>> I think it is not an error. It is perfectly fine for a guest to not=
 set DIAG308_FLAGS_LP_VALID if the guest does not want to set it. The LOA=
DPARM is supposed to be ignored then.
> >>>
> >>
> >> I believe David's concern was not the else branch, but the last
> >> parameter of object_property_set_str(), which tells us what to do if=
 the
> >> validation/normalization done by the setter of the loadparm qemu
> >> property fails the set operation.
> >=20
> > Ah I see. I still think that the guest could provoke the an error by =
putting
> > invalid characters in the loadparm field. So error_abort seems wrong.
> > And in fact for that case, the 0x0402 proposal from Viktor seems like=
 the
> > right thing to do.
>=20
> FWIW, right now we do not check the content of the loadparm and just ac=
cept
> any kind of garbage via diag308 and we return that garbage.
> And I checked what LPAR does. LPAR also does not use 0x0402 and it sile=
ntly
> takes the garbage.
> So in essence I would suggest to leave the patch as is.
>=20

Ageed. I will do the cosmetics and send out the v2.

Regarding validation, I don't know where the criteria Farhan implemented
come from. In the longer run we may want to do away with the validation
and normalization performed in the setter, but for now I think this is
pretty close to the sanest cheap fix we can do.

Regards,
Hali


