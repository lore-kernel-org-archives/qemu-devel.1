Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6952C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD142070A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD142070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Nkr-0000Ua-3i
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k0NkH-0008VK-QF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:26:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k0NkF-0000tZ-P2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:26:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06SB380O064275
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:26:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1cvu0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:26:04 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06SB3RQd066291
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:26:04 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1cvtyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 07:26:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SBPYXq014441;
 Tue, 28 Jul 2020 11:26:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04fra.de.ibm.com with ESMTP id 32gcpwa2na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 11:26:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06SBPxUB35455168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 11:25:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 876E711C066;
 Tue, 28 Jul 2020 11:25:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06FC111C054;
 Tue, 28 Jul 2020 11:25:59 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.179.56])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2020 11:25:58 +0000 (GMT)
Date: Tue, 28 Jul 2020 13:25:57 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 1/3] virtio: add vhost-user-fs-ccw device
Message-ID: <20200728132557.3cbef52f.pasic@linux.ibm.com>
In-Reply-To: <20200728123151.468c252b.cohuck@redhat.com>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-2-mhartmay@linux.ibm.com>
 <20200728123151.468c252b.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-28_07:2020-07-28,
 2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 04:59:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 12:31:51 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 17 Jul 2020 11:29:27 +0200
> Marc Hartmayer <mhartmay@linux.ibm.com> wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > 
> > Wire up the CCW device for vhost-user-fs.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  hw/s390x/Makefile.objs       |  1 +
> >  hw/s390x/vhost-user-fs-ccw.c | 73 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 hw/s390x/vhost-user-fs-ccw.c
> > 
> 
> (...)
> 
> > diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
> > new file mode 100644
> > index 000000000000..88a7a11a34b4
> > --- /dev/null
> > +++ b/hw/s390x/vhost-user-fs-ccw.c
> > @@ -0,0 +1,73 @@
> > +/*
> > + * Ccw transport wiring for vhost-user-fs
> 
> "virtio ccw vhost-user-fs implementation" ?
> 

Nod.

> > + *
> > + * Copyright 2020 IBM Corp.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> > + * your option) any later version. See the COPYING file in the top-level
> > + * directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qapi/error.h"
> > +#include "hw/virtio/vhost-user-fs.h"
> > +#include "virtio-ccw.h"
> > +
> > +typedef struct VHostUserFSCcw {
> > +    VirtioCcwDevice parent_obj;
> > +    VHostUserFS vdev;
> > +} VHostUserFSCcw;
> > +
> > +#define TYPE_VHOST_USER_FS_CCW "vhost-user-fs-ccw"
> > +#define VHOST_USER_FS_CCW(obj) \
> > +        OBJECT_CHECK(VHostUserFSCcw, (obj), TYPE_VHOST_USER_FS_CCW)
> > +
> > +
> > +static Property vhost_user_fs_ccw_properties[] = {
> > +    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
> > +                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
> > +    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
> > +                       VIRTIO_CCW_MAX_REV),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void vhost_user_fs_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
> > +{
> > +    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(ccw_dev);
> > +    DeviceState *vdev = DEVICE(&dev->vdev);
> > +
> > +    qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
> > +}
> > +
> > +static void vhost_user_fs_ccw_instance_init(Object *obj)
> > +{
> > +    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(obj);
> > +
> 
> This needs
> 
>     ccw_dev->force_revision_1 = true;
> 

I'm OK with that as well. Just out of curiosity, why do we need it? Is
there a virtio-ccw revision 1 feature this device inherently needs?

Regards,
Halil

[..]

