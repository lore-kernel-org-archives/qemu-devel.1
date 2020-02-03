Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4283C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05152166E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAfz4ZV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05152166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyc9T-0004rl-TU
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iyc8p-0004Mh-G6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iyc8o-0004ZO-IB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:51:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iyc8o-0004Yb-Dp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580737914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq7+63ABVh+qjcCP40+qDZJgt7q7QmAiFOM/ndp/Ma8=;
 b=KAfz4ZV4J/04Hn6Z/xYwR3dU524CQJ5SFiD8d2sqSELVNvJ71Yywbs4EtkoJ6iWpTIgRgH
 qKcatetEnhknB8V79RwSvAKZVIXFgyIFTkFkAzNaePyyT4FPfTX6PBv64qB/dw1z562cEF
 pvF24zIpCSTvmqAVOMm4d17cJElkf9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-1RA_fjTqOvamAnaCFdUvJA-1; Mon, 03 Feb 2020 08:51:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23E0C1005502;
 Mon,  3 Feb 2020 13:51:51 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA83C8E9E5;
 Mon,  3 Feb 2020 13:51:40 +0000 (UTC)
Subject: Re: [PATCH v13 00/10] VIRTIO-IOMMU device
To: Peter Xu <peterx@redhat.com>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <158548eb-8337-aea0-25da-bb7729bf925e@redhat.com>
 <20200203134954.GB155875@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <08c5cf5a-18b6-d001-c470-709ec2190730@redhat.com>
Date: Mon, 3 Feb 2020 14:51:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203134954.GB155875@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1RA_fjTqOvamAnaCFdUvJA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/3/20 2:49 PM, Peter Xu wrote:
> On Mon, Feb 03, 2020 at 01:58:04PM +0100, Auger Eric wrote:
>> Hi,
>>
>> On 1/25/20 6:19 PM, Eric Auger wrote:
>>> This series implements the QEMU virtio-iommu device.
>>>
>>> This matches the v0.12 spec (voted) and the corresponding
>>> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
>>> are resolved for DT integration. The virtio-iommu can be
>>> instantiated in ARM virt using "-device virtio-iommu-pci".
>>>
>>> Non DT mode is not yet supported as it has non resolved kernel
>>> dependencies [1].
>>>
>>> This feature targets 5.0.
>> If possible I would like to make this feature upstream in 5.0. Do you
>> guys have other comments/objections?
> 
> Hi, Eric, Sorry that I forgot to read the series after a long PTO.
> 
> I'll do it today.
No worries ;-)

Thank you in advance

Eric
> 


