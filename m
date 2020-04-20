Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EDEC54FCC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 22:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B03920857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 22:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B03920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQf2A-0006op-LZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 18:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jrossi@linux.ibm.com>) id 1jQf1M-0006Mc-9Y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 18:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jrossi@linux.ibm.com>) id 1jQf1L-0007rF-2p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 18:36:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1jQf1K-0007pC-6u; Mon, 20 Apr 2020 18:36:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03KMVsAr121227; Mon, 20 Apr 2020 18:36:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30gmu7ej1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 18:36:01 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03KMXVmr128845;
 Mon, 20 Apr 2020 18:36:01 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30gmu7ej1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 18:36:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03KMZJZ7005272;
 Mon, 20 Apr 2020 22:36:00 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02dal.us.ibm.com with ESMTP id 30fs66hj42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 22:36:00 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03KMZxMb53674482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2020 22:35:59 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B5686A04D;
 Mon, 20 Apr 2020 22:35:59 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E7756A04F;
 Mon, 20 Apr 2020 22:35:58 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2020 22:35:58 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Apr 2020 18:35:58 -0400
From: Jared Rossi <jrossi@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
In-Reply-To: <20200420142917.206d36a5.cohuck@redhat.com>
References: <20200417183838.11796-1-jrossi@linux.ibm.com>
 <20200417183838.11796-2-jrossi@linux.ibm.com>
 <20200420142617.5e255265.cohuck@redhat.com>
 <20200420142917.206d36a5.cohuck@redhat.com>
Message-ID: <2fe2e12dee1799afee088bed88e6c671@linux.vnet.ibm.com>
X-Sender: jrossi@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-20_09:2020-04-20,
 2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 18:36:02
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-04-20 08:29, Cornelia Huck wrote:
> On Mon, 20 Apr 2020 14:26:17 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Fri, 17 Apr 2020 14:38:38 -0400
>> Jared Rossi <jrossi@linux.ibm.com> wrote:
>> 
>> > Remove the explicit prefetch check when using vfio-ccw devices.
>> > This check is not needed as all Linux channel programs are intended
>> > to use prefetch and will be executed in the same way regardless.
>> 
>> As already commented on the Linux patch: Can we log something, so this
>> is debuggable if this statement does not hold true in the future?
>> 

Agreed.  I will work on debugging improvements so that any future issues
related to unintended prefetching are more clearly logged.

>> >
>> > Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> > ---
>> >  hw/vfio/ccw.c | 13 +++----------
>> >  1 file changed, 3 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> > index 50cc2ec75c..e649377b68 100644
>> > --- a/hw/vfio/ccw.c
>> > +++ b/hw/vfio/ccw.c
>> > @@ -74,16 +74,9 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>> >      struct ccw_io_region *region = vcdev->io_region;
>> >      int ret;
>> >
>> > -    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
>> > -        if (!(vcdev->force_orb_pfch)) {
>> > -            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
>> > -            sch_gen_unit_exception(sch);
>> > -            css_inject_io_interrupt(sch);
>> > -            return IOINST_CC_EXPECTED;
>> > -        } else {
>> > -            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>> > -            warn_once_pfch(vcdev, sch, "PFCH flag forced");
>> > -        }
>> > +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && vcdev->force_orb_pfch) {
>> > +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>> > +        warn_once_pfch(vcdev, sch, "PFCH flag forced");
>> >      }
>> 
>> What happens when you run it with an old kernel? I guess the I/O is
>> only rejected later (after a trip into the kernel), but has that path
>> ever been tested?
>> 

Yes, this was tested and you are correct that the kernel will reject the 
I/O unless
the corresponding patch is also applied there.  I will revisit this path 
while I'm
updating the logging to ensure that any potential interactions are 
appropriately
considered.

>> >
>> >      QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
>> 
> 
> Oh, and do we want to deprecate the force prefetch interface in the
> future? We probably need to wait a bit, until the kernel changes have
> become widely available.

Yes, I think we will want to deprecate it at an appropriate time in the 
future.

