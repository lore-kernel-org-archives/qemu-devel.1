Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1982C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9661621775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9661621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSVX-0008Ej-UK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jxSV0-0007pY-D0; Mon, 20 Jul 2020 05:54:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jxSUy-0006Yf-JU; Mon, 20 Jul 2020 05:54:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06K9XGP0139832; Mon, 20 Jul 2020 05:54:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32d6d7n1mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 05:54:13 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K9YSAr144714;
 Mon, 20 Jul 2020 05:54:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32d6d7n1kt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 05:54:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K9ooF8009800;
 Mon, 20 Jul 2020 09:54:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 32brq82gt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 09:54:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06K9s8ct64225396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jul 2020 09:54:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6221552057;
 Mon, 20 Jul 2020 09:54:08 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.181.80])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 01AF75204F;
 Mon, 20 Jul 2020 09:54:07 +0000 (GMT)
Date: Mon, 20 Jul 2020 11:54:06 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/2] virtio: non-legacy device handling
Message-ID: <20200720115406.508f2115.pasic@linux.ibm.com>
In-Reply-To: <20200707105446.677966-1-cohuck@redhat.com>
References: <20200707105446.677966-1-cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-20_05:2020-07-17,
 2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200071
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 05:54:14
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 Jul 2020 12:54:44 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> As discussed in "virtio-fs: force virtio 1.x usage", it seems like
> a good idea to make sure that any new virtio device (which does not
> support legacy virtio) is indeed a non-transitional device, just to
> catch accidental misconfigurations. We can easily compile a list
> of virtio devices with legacy support and have transports verify
> in their plugged callbacks that legacy support is off for any device
> not in that list.
> 
> Most new virtio devices force non-transitional already, so nothing
> changes for them. vhost-user-fs-pci even does not allow to configure
> a non-transitional device, so it is fine as well.
> 
> One problematic device, however, is virtio-iommu-pci. It currently
> offers both the transitional and the non-transitional variety of the
> device, and does not force anything. I'm unsure whether we should
> consider transitional virtio-iommu unsupported, or if we should add
> some compat handling. (The support for legacy or not generally may
> change based upon the bus, IIUC, so I'm unsure how to come up with
> something generic.)
> 

Both patches look good to me (Acked-by: Halil Pasic
<pasic@linux.ibm.com>). I tend to agree with Davids comment on how
this information is coded: the more object oriented way would have
been to store this at the something like VirtioDeviceClass, but
Michael's argument stands.

Another OO option would be to expose this as a virtio property. Would
enable introspection, and would also give the host admin means to
force non-legacy for transitional devices. But the juice is probably not
worth the squeeze.

Regards,
Halil

