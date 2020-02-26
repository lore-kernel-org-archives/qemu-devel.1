Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47854C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF29206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF29206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ykF-0002hc-9T
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1j6yje-0002Fo-22
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1j6yja-0003BA-Jm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:36:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1j6yja-00038p-Cc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:36:26 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QFZrxr129721
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:36:25 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydh919b52-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:36:25 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Wed, 26 Feb 2020 15:36:22 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 15:36:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QFaJa540567004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 15:36:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4BEAAE055;
 Wed, 26 Feb 2020 15:36:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 788F2AE057;
 Wed, 26 Feb 2020 15:36:19 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 15:36:19 +0000 (GMT)
Date: Wed, 26 Feb 2020 16:36:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <20200226083654-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022615-4275-0000-0000-000003A5B269
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022615-4276-0000-0000-000038B9CB21
Message-Id: <20200226163618.31aa86ed.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_05:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260110
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 08:37:13 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 26, 2020 at 02:28:39PM +0100, Halil Pasic wrote:
> > On Wed, 26 Feb 2020 17:43:57 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> > 
> > > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
> > > platform without IOMMU support. This can lead unnecessary IOTLB
> > > transactions which will damage the performance.
> > > 
> > > Fixing this by check whether the device is backed by IOMMU and disable
> > > device IOTLB.
> > > 
> > > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > Tested-by: Halil Pasic <pasic@linux.ibm.com>
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > 
> > Thank you very much for fixing this! BTW as I mentioned before it
> > fixes vhost-vsock with iommu_platform=on as well.
> 
> Fixes as in improves performance?

No, fixes like one does not get something like:
qemu-system-s390x: vhost_set_features failed: Operation not supported (95)
qemu-system-s390x: Error starting vhost: 95
any more.

Regards,
Halil

[..]


