Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04547206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCPyKw3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04547206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgP0J-0000oG-21
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jgOzm-0000OH-VP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:43:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jgOzl-0006xV-ML
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591173811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gw+HhxlPV7XdgkZAs3tvlV2AiJ0KFCioRNvIqvW+yA=;
 b=HCPyKw3DWoG1Y0Rik5rcpZYqZ/3DHgqXYF0MlRsxHLn0Gp1appBhOfWVOdvwgGrw0L3InA
 xkR/pfcKRKoxjWyxgmzJ3yyLIE2Z6Xe7FPa0ThWJui+oi3lIFHY1mlL3QOSyayChCLs+IG
 WogoPKQEmFjcfU6kJbbK8ckcXcrw/7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-fdc3ug17PCqoDnU9yrt-pA-1; Wed, 03 Jun 2020 04:43:30 -0400
X-MC-Unique: fdc3ug17PCqoDnU9yrt-pA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A881005510;
 Wed,  3 Jun 2020 08:43:27 +0000 (UTC)
Received: from [10.72.12.214] (ovpn-12-214.pek2.redhat.com [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31C60512E7;
 Wed,  3 Jun 2020 08:43:09 +0000 (UTC)
Subject: Re: [RFC v3 8/8] vhost-vdpa: introduce vhost-vdpa net client
To: Cindy Lu <lulu@redhat.com>
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-9-lulu@redhat.com>
 <4ae425c2-6b5f-5f64-9e26-f20b8f52f996@redhat.com>
 <CACLfguUeYjAaknk+GEM9K6myUdCqXtxn=OEGYO4h3pqOUm9NxA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6ac66cf2-30d3-d87c-9ca5-0785f05984ad@redhat.com>
Date: Wed, 3 Jun 2020 16:43:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACLfguUeYjAaknk+GEM9K6myUdCqXtxn=OEGYO4h3pqOUm9NxA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/3 下午4:19, Cindy Lu wrote:
>>> +static void vhost_vdpa_cleanup(NetClientState *nc)
>>> +{
>>> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
>>> +
>>> +    if (s->vhost_net) {
>>> +        vhost_net_cleanup(s->vhost_net);
>>> +        g_free(s->vhost_net);
>>> +        s->vhost_net = NULL;
>>> +    }
>>> +
>>> +    qemu_purge_queued_packets(nc);
>> Why this is needed?
>>
>> Thanks
>>
> This is to clean the packet in the queue while the vdpa remove,  I
> will double check this part


Note we don't have a software backup driver for qemu currently (we 
probably need one in the future).

So we can't fallback into userspace which means the packet can not be 
queued by qemu.

Thanks


