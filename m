Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5DBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4236820409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4236820409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPiR-0000EE-8v
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jGPhp-00089G-Er
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jGPho-0001dd-GC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:13:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jGPho-0001dT-9L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:13:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02NG48UV083016
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 12:13:35 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywbtfp5mj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 12:13:34 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Mon, 23 Mar 2020 16:13:31 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 23 Mar 2020 16:13:29 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02NGDSFL56885490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2020 16:13:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACDE042047;
 Mon, 23 Mar 2020 16:13:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44C0242045;
 Mon, 23 Mar 2020 16:13:28 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.9.105])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2020 16:13:28 +0000 (GMT)
Date: Mon, 23 Mar 2020 17:13:27 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390/ipl: fix off-by-one in
 update_machine_ipl_properties()
In-Reply-To: <20200320182518.69bbb053.cohuck@redhat.com>
References: <20200320143101.41764-1-pasic@linux.ibm.com>
 <20200320182518.69bbb053.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032316-0016-0000-0000-000002F652AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032316-0017-0000-0000-00003359EC69
Message-Id: <20200323171327.23dab29c.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_06:2020-03-21,
 2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230087
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 18:25:18 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 20 Mar 2020 15:31:01 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > In update_machine_ipl_properties() the array ascii_loadparm needs to
> > hold the 8 char lodparm and a string terminating zero char.
> 
> s/lodparm/loadparm/
> 
> > Let's increase the size of ascii_loadparm accordingly.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Fixes: 0a01e082a4 ("s390/ipl: sync back loadparm")
> 
> Fixes: Coverity CID 1421966
> 
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/s390x/ipl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index b81942e1e6..8c3e019571 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -546,7 +546,7 @@ static void update_machine_ipl_properties(IplParameterBlock *iplb)
> >      /* Sync loadparm */
> >      if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
> >          uint8_t *ebcdic_loadparm = iplb->loadparm;
> > -        char ascii_loadparm[8];
> > +        char ascii_loadparm[9];
> >          int i;
> >  
> >          for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
> > 
> > base-commit: 226cd20706e20264c176f8edbaf17d7c9b7ade4a
> 
> Thanks, queued to s390-fixes.
> 

Thank you!


