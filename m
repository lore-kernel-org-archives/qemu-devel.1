Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05F320774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05F320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihxh-0007cx-S5
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jihKF-00079Z-5j; Tue, 09 Jun 2020 12:42:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jihKB-0003jB-PK; Tue, 09 Jun 2020 12:42:10 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 059GVxOj160441; Tue, 9 Jun 2020 12:42:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31gg8211t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 12:42:02 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 059GWGeF161056;
 Tue, 9 Jun 2020 12:42:02 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31gg8211sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 12:42:02 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059GfVXC005658;
 Tue, 9 Jun 2020 16:41:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma01fra.de.ibm.com with ESMTP id 31g2s7tkav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 16:41:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 059Gee7w43516168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2020 16:40:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBFC84C04E;
 Tue,  9 Jun 2020 16:41:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29B704C044;
 Tue,  9 Jun 2020 16:41:56 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.129.89])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2020 16:41:56 +0000 (GMT)
Date: Tue, 9 Jun 2020 18:41:38 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200609184138.7a7e6fc1.pasic@linux.ibm.com>
In-Reply-To: <20200609180559.52298647.cohuck@redhat.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609180559.52298647.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-09_10:2020-06-09,
 2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=770 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 12:42:06
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Viktor Mihajlovski <mihajlov@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 18:05:59 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> > 
> > do we really have that many incompatible devices?  
> 
> Which devices are compatible in the end? It seems the only ones that
> are known to be working are virtio-ccw devices with IOMMU_PLATFORM on.
> virtio-pci devices and non-virtio ccw (vfio-ccw, 3270) seem to be out,
> as far as I understand it. What about non-ccw? PCI in general, vfio-ap?

AFAIU the situation is somewhat complicated. Only virtio devices have
the notion of indicating and the duty to indicate access restrictions.
We as hypervisor need to prevent the inconsistency where:
* the VM is prot virt
* the guest can detect that it is running with prot virt using the UV
  call interface
* and the virtio devices emulated by us (QEMU) lie that memory access
  by the device is not restricted (F_ACCESS_PLATFORM not offered).

It is unfortunate that the consequences are this severe, but it is the
responsibility to drive the devices accordingly if prot virt is
detected. If the guest does this, then s270 and vfio-ccw should work. The
problem is, that currently Linux is verifiedly doing the thing only for
virtio-ccw.

Regards,
Halil

