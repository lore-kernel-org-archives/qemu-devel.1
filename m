Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB42BC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9432051A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9432051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIF4-0007XR-WC
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jFIEN-0006yc-Je
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jFIEM-00062Q-Cd
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:02:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jFIEM-000628-4p
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:02:34 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02KDWwI0048878
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:02:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8afjtt1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:02:10 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Fri, 20 Mar 2020 14:02:06 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 20 Mar 2020 14:02:04 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02KE22Dt47513998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2020 14:02:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85A4652054;
 Fri, 20 Mar 2020 14:02:02 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.114.57])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E782952052;
 Fri, 20 Mar 2020 14:02:01 +0000 (GMT)
Date: Fri, 20 Mar 2020 15:02:00 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PULL 3/4] s390/ipl: sync back loadparm
In-Reply-To: <bcd562a0-272a-57e3-d8b7-fbc19ebc75bb@de.ibm.com>
References: <20200310150947.3510824-1-borntraeger@de.ibm.com>
 <20200310150947.3510824-4-borntraeger@de.ibm.com>
 <CAFEAcA93+BC_N28fCRwPc8YNGW_UhSOE+=A+0Qo3bB9x8zO9qQ@mail.gmail.com>
 <bcd562a0-272a-57e3-d8b7-fbc19ebc75bb@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032014-0012-0000-0000-000003948174
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032014-0013-0000-0000-000021D16AED
Message-Id: <20200320150200.1aeed403.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-20_04:2020-03-20,
 2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=972
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200058
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
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 10:23:03 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 19.03.20 21:31, Peter Maydell wrote:
> > On Tue, 10 Mar 2020 at 15:09, Christian Borntraeger
> > <borntraeger@de.ibm.com> wrote:
> >>
> >> From: Halil Pasic <pasic@linux.ibm.com>
> >>
> >> We expose loadparm as a r/w machine property, but if loadparm is set by
> >> the guest via DIAG 308, we don't update the property. Having a
> >> disconnect between the guest view and the QEMU property is not nice in
> >> itself, but things get even worse for SCSI, where under certain
> >> circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works as
> >> expected" for details) we call s390_gen_initial_iplb() on resets
> >> effectively overwriting the guest/user supplied loadparm with the stale
> >> value.
> > 
> > Hi; Coverity points out (CID 1421966) that you have a buffer overrun here:
> > 
> >> +static void update_machine_ipl_properties(IplParameterBlock *iplb)
> >> +{
> >> +    Object *machine = qdev_get_machine();
> >> +    Error *err = NULL;
> >> +
> >> +    /* Sync loadparm */
> >> +    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
> >> +        uint8_t *ebcdic_loadparm = iplb->loadparm;
> >> +        char ascii_loadparm[8];
> > 
> > This array is 8 bytes...
> > 
> >> +        int i;
> >> +
> >> +        for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
> >> +            ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
> >> +        }
> >> +        ascii_loadparm[i] = 0;
> > 
> > ...but you can write 9 bytes into it (8 from the guest-controlled
> > iplb_loadparm buffer plus one for the trailing NUL).
> 
> Right, so ascii_loadparm needs to be 9 bytes as this needs the trailing 0.
> Halil, can you spin up a fix patch?

Sure!

Regards,
Halil


