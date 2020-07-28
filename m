Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF4BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58302065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58302065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0NqH-000290-4A
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k0Npc-0001gu-9v
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:31:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64742
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k0NpZ-0001ms-Sq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:31:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06SB7epH085231
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:31:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32hsqfty3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:31:36 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06SB7abl084716
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:31:36 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32hsqfty2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 07:31:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SBPKNn026621;
 Tue, 28 Jul 2020 11:31:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04ams.nl.ibm.com with ESMTP id 32gcy4kdab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 11:31:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06SBVVqp58589368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 11:31:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF65352051;
 Tue, 28 Jul 2020 11:31:31 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.179.56])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 595085204E;
 Tue, 28 Jul 2020 11:31:31 +0000 (GMT)
Date: Tue, 28 Jul 2020 13:31:29 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 2/3] libvhost-user: handle endianness as mandated by
 the spec
Message-ID: <20200728133129.386e2025.pasic@linux.ibm.com>
In-Reply-To: <20200728124850.7c15eade.cohuck@redhat.com>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-3-mhartmay@linux.ibm.com>
 <20200721093942-mutt-send-email-mst@kernel.org>
 <20200721184456.1305ca0b.pasic@linux.ibm.com>
 <20200728124850.7c15eade.cohuck@redhat.com>
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
 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=944 adultscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280085
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 07:31:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 12:48:50 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 21 Jul 2020 18:44:56 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 21 Jul 2020 09:40:10 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Fri, Jul 17, 2020 at 11:29:28AM +0200, Marc Hartmayer wrote:  
> > > > Since virtio existed even before it got standardized, the virtio
> > > > standard defines the following types of virtio devices:
> > > > 
> > > >  + legacy device (pre-virtio 1.0)
> > > >  + non-legacy or VIRTIO 1.0 device
> > > >  + transitional device (which can act both as legacy and non-legacy)
> > > > 
> > > > Virtio 1.0 defines the fields of the virtqueues as little endian,
> > > > while legacy uses guest's native endian [1]. Currently libvhost-user
> > > > does not handle virtio endianness at all, i.e. it works only if the
> > > > native endianness matches with whatever is actually needed. That means
> > > > things break spectacularly on big-endian targets. Let us handle virtio
> > > > endianness for non-legacy as required by the virtio specification
> > > > [1]. We will fence non-legacy virtio devices with the upcoming patch.
> > > > 
> > > > [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003
> > > > 
> > > > Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > > > 
> > > > ---
> > > > Note: As we don't support legacy virtio devices    
> > > 
> > > Who's "we" in this sentence? vhost user supports legacy generally ...  
> > 
> > In that sentence "we" is the library "libvhost-user". I would like
> > to avoid s390x being an oddball regarding this. Marc's previous
> > version made an attempt at correct endianness handling for legacy
> > and non-legacy. That spawned a discussion on how we don't want
> > legacy devices in this context. This series makes what seemed to be the
> > consensus reached in that discussion explicit: namely that libvhost-user
> > does not support legacy-virtio.
> 
> Can someone please clarify what libvhost-user actually supports?
> 
> virtio-fs is clearly non-legacy only, but in the changelog I also see a
> mention of scsi, and that one probably does support legacy?
> 
> Can we make a distinction along the lines of:
> - if we are non-legacy, we support any endianness;
> - if we are legacy, we support little endian host/guest only?
> 

I don't like the idea of this conditional support of legacy (with a
condition being a little endian host/guest). The library is supposed
to be portable in my opinion.

Regards,
Halil


