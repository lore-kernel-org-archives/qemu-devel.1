Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75674C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D2F20637
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D2F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZZt-0008R2-EA
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1j6YpZ-0002Xu-Lv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1j6YpX-0003eV-EA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:56:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1j6YpX-0003bA-6h
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:56:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01PBp5jX019843
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:56:50 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ycxcxsrs5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:56:49 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Tue, 25 Feb 2020 11:56:47 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Feb 2020 11:56:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01PBuhHr44630382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 11:56:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C71EA4C04E;
 Tue, 25 Feb 2020 11:56:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 777D84C040;
 Tue, 25 Feb 2020 11:56:43 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2020 11:56:43 +0000 (GMT)
Date: Tue, 25 Feb 2020 12:56:41 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/1] s390/ipl: sync back loadparm
In-Reply-To: <05f7dcf7-a0c7-8811-6b88-df86d5fa0974@redhat.com>
References: <20200224150213.21253-1-pasic@linux.ibm.com>
 <05f7dcf7-a0c7-8811-6b88-df86d5fa0974@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022511-0016-0000-0000-000002EA1914
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022511-0017-0000-0000-0000334D444B
Message-Id: <20200225125641.72e8cc86.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_03:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250097
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
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:39:40 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 24.02.20 16:02, Halil Pasic wrote:
> > We expose loadparm as a r/w machine property, but if loadparm is set by
> > the guest via DIAG 308, we don't update the property. Having a
> > disconnect between the guest view and the QEMU property is not nice in
> > itself, but things get even worse for SCSI, where under certain
> > circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works as
> > expected" for details) we call s390_gen_initial_iplb() on resets
> > effectively overwriting the guest/user supplied loadparm with the stale
> > value.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Fixes: 7104bae9de "hw/s390x: provide loadparm property for the machine"
> > Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> > Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
> > Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > ---
> >  hw/s390x/ipl.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index 7773499d7f..97a279c1a5 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -538,6 +538,26 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
> >      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
> >  }
> >  
> > +static void update_machine_ipl_properties(IplParameterBlock *iplb)
> > +{
> > +    Object *mo = qdev_get_machine();
> 
> I'd just call this "machine".
> 

I can change that.

> > +
> > +    /* Sync loadparm */
> > +    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
> > +        char ascii_loadparm[8];
> > +        uint8_t *ebcdic_loadparm = iplb->loadparm;
> > +        int i;
> > +
> > +        for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
> > +            ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
> > +        }
> > +        ascii_loadparm[i] = 0;
> > +        object_property_set_str(mo, ascii_loadparm, "loadparm", NULL);
> > +    } else {
> > +        object_property_set_str(mo, "", "loadparm", NULL);
> > +    }
> 
> &error_abort instead of NULL, we certainly want to know if this would
> ever surprisingly fail.

IMHO this is a typical assert() situation where one would like to have
a fast and obvious failure when testing, but not in production.

AFAIU the guest can trigger this code at any time, and crashing the
whole (production) system seems a bit heavy handed to me. The setter
should only fail if something is buggy.

But if the majority says &error_abort I can certainly do. Other opinions?

> 
> > +}
> > +
> >  void s390_ipl_update_diag308(IplParameterBlock *iplb)
> >  {
> >      S390IPLState *ipl = get_ipl_device();
> > @@ -545,6 +565,7 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
> >      ipl->iplb = *iplb;
> >      ipl->iplb_valid = true;
> >      ipl->netboot = is_virtio_net_device(iplb);
> > +    update_machine_ipl_properties(iplb);
> >  }
> >  
> 
> Somewhat I dislike this manual syncing (and converting back and forth),
> but there seems to be no easy way around it.
> 

I share your sentiment.

Regards,
Halil


