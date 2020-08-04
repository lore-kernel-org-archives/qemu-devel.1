Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49655C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272DF2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272DF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2yuX-0000aK-AR
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1k2ytk-00007x-Kh; Tue, 04 Aug 2020 11:30:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6772
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1k2yti-000742-00; Tue, 04 Aug 2020 11:30:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 074F1TH8040461; Tue, 4 Aug 2020 11:30:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32q9vah26e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 11:30:36 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074F25Xv043796;
 Tue, 4 Aug 2020 11:30:35 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32q9vah25h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 11:30:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074FJgtN026062;
 Tue, 4 Aug 2020 15:30:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04ams.nl.ibm.com with ESMTP id 32n0183f58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 15:30:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 074FUVYG24903990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2020 15:30:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DF41A4051;
 Tue,  4 Aug 2020 15:30:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 884D0A4055;
 Tue,  4 Aug 2020 15:30:30 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.12.119])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2020 15:30:30 +0000 (GMT)
Date: Tue, 4 Aug 2020 17:30:28 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 3/6] pc-bios/s390-ccw: Move the inner logic of
 find_subch() to a separate function
Message-ID: <20200804173028.0a85b484@ibm-vm>
In-Reply-To: <44398bdc-6b72-8aff-ad25-bc0110fcfd7f@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-4-thuth@redhat.com>
 <20200803104639.5946bdd2@ibm-vm>
 <44398bdc-6b72-8aff-ad25-bc0110fcfd7f@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-04_04:2020-08-03,
 2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 07:10:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J .
 Herne" <jjherne@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Aug 2020 15:24:09 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 03/08/2020 10.46, Claudio Imbrenda wrote:
> > On Tue, 28 Jul 2020 20:37:31 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> Move the code to a separate function to be able to re-use it from a
> >> different spot later.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  pc-bios/s390-ccw/main.c | 99
> >> ++++++++++++++++++++++++----------------- 1 file changed, 57
> >> insertions(+), 42 deletions(-)
> >>
> >> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> >> index 9b64eb0c24..9477313188 100644
> >> --- a/pc-bios/s390-ccw/main.c
> >> +++ b/pc-bios/s390-ccw/main.c
> >> @@ -51,6 +51,60 @@ unsigned int get_loadparm_index(void)
> >>      return atoui(loadparm_str);
> >>  }
> >>  
> >> +static int check_sch_no(int dev_no, int sch_no)
> >> +{
> >> +    bool is_virtio;
> >> +    Schib schib;
> >> +    int r;
> >> +
> >> +    blk_schid.sch_no = sch_no;
> >> +    r = stsch_err(blk_schid, &schib);
> >> +    if (r == 3 || r == -EIO) {
> >> +        return -EIO;
> >> +    }
> >> +    if (!schib.pmcw.dnv) {
> >> +        return false;
> >> +    }
> >> +
> >> +    enable_subchannel(blk_schid);
> >> +    cutype = cu_type(blk_schid);
> >> +
> >> +    /*
> >> +     * Note: we always have to run virtio_is_supported() here to
> >> make
> >> +     * sure that the vdev.senseid data gets pre-initialized
> >> correctly
> >> +     */
> >> +    is_virtio = virtio_is_supported(blk_schid);
> >> +
> >> +    /* No specific devno given, just return 1st possibly bootable
> >> device */
> >> +    if (dev_no < 0) {
> >> +        switch (cutype) {
> >> +        case CU_TYPE_VIRTIO:
> >> +            if (is_virtio) {
> >> +                /*
> >> +                 * Skip net devices since no IPLB is created and
> >> therefore
> >> +                 * no network bootloader has been loaded
> >> +                 */
> >> +                if (virtio_get_device_type() != VIRTIO_ID_NET) {
> >> +                    return true;
> >> +                }  
> > 
> > here it seems you are returning true for any non-network virtio
> > device, is this the intended behaviour? (I know it was like this in
> > the old code) like, non-block devices?  
> 
> Yes. Other devices are already ignored by the virtio_is_supported()
> call some lines earlier in this function.

ah, that makes sense


Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


