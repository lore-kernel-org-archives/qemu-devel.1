Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D4C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D9920578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D9920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJOe-00088B-Iq
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jBJNy-0007cA-ED
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jBJNx-0000F7-9p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:28:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22214
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jBJNx-0000Eq-52
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:28:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029EKJFW042244
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 10:28:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8g3b202-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 10:28:00 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Mon, 9 Mar 2020 14:27:58 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 14:27:55 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029ERsut56557716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 14:27:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 121A5A4059;
 Mon,  9 Mar 2020 14:27:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A87DEA404D;
 Mon,  9 Mar 2020 14:27:53 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.108])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 14:27:53 +0000 (GMT)
Date: Mon, 9 Mar 2020 15:27:51 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/1] s390/ipl: sync back loadparm
In-Reply-To: <c35e5027-1682-2a40-1db3-301be2b2d248@redhat.com>
References: <20200309133223.100491-1-pasic@linux.ibm.com>
 <c35e5027-1682-2a40-1db3-301be2b2d248@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030914-0012-0000-0000-0000038EA25B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030914-0013-0000-0000-000021CB6A9B
Message-Id: <20200309152751.5f0cd2f8.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_05:2020-03-09,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
 Marc Hartmayer <mhartmay@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 14:44:20 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 09.03.20 14:32, Halil Pasic wrote:
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
> > Fixes: 7104bae9de ("hw/s390x: provide loadparm property for the machine")
> > Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> > Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
> > Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > ---
> > v1 --> v2:
> > * tweaked the Fixes tag (Connie)
> > * s/mo/machine/ (David)
> > * We decided to not abort if the setter fails. It is not clear where
> >   do the validation logic come from in the first place. For now lets put
> >   out a warning if things go wrong.
> >   The warning we get looks something like:
> >   qemu-system-s390x: warning: LOADPARM: invalid character '?' (ASCII 0x3f)
> > * I keept the r-b's and the tested-by as the changes are minor. Please
> >   shout at me if you object.
> > ---
> >  hw/s390x/ipl.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index 9c1ecd423c..8bd50de44c 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -538,6 +538,30 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
> >      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
> >  }
> >  
> > +static void update_machine_ipl_properties(IplParameterBlock *iplb)
> > +{
> > +    Object *machine = qdev_get_machine();
> > +    Error *err = NULL;
> > +
> > +    /* Sync loadparm */
> > +    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
> > +        char ascii_loadparm[8];
> > +        int i;
> > +        uint8_t *ebcdic_loadparm = iplb->loadparm;
> 
> Nit: move this to the top

Do you mean (reverse xmass tree)

+    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
+        uint8_t *ebcdic_loadparm = iplb->loadparm;
+        char ascii_loadparm[8];
+        int i;

or do you mean I should make the declarations function scope
instead of block scope? 

Regards,
Halil

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 


