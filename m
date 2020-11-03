Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9750C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A052074B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH4v0mxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A052074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka1C1-0002eA-Ud
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 13:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ka1BN-0002CS-V6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:37:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ka1BL-0007rM-A8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604428641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoDu0EyYr3THzTPxyaDoAhAhOFmx/6L3PtDj4t8aXzs=;
 b=fH4v0mxfKTjXjkUY+nQ417xrG2irDBJTsXmqSIRPr6z6eROFqId4zvUNGYXEDadfOEcR43
 xZ8QnrpHaaAj6XjEWuyKdx3+F4azLeUHRMi/YIOjW5RXqKxP5ZH2ht/l+bNe2EzA6Fpdfx
 DB5RxmRA+iZhFWpGp3H6c46OqwbPCjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-o5bup-36MxKIX9zEh82VFA-1; Tue, 03 Nov 2020 13:37:19 -0500
X-MC-Unique: o5bup-36MxKIX9zEh82VFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 475521084CA3;
 Tue,  3 Nov 2020 18:37:18 +0000 (UTC)
Received: from [10.36.114.125] (ovpn-114-125.ams2.redhat.com [10.36.114.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BF7260BF1;
 Tue,  3 Nov 2020 18:37:13 +0000 (UTC)
Subject: Re: [PATCH-for-5.2 v3 0/7] util/vfio-helpers: Generic code
 strengthening
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201103020733.2303148-1-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <36c9a6cb-3851-ed9b-e857-0c53106bccd7@redhat.com>
Date: Tue, 3 Nov 2020 19:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201103020733.2303148-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,
On 11/3/20 3:07 AM, Philippe Mathieu-Daudé wrote:
> v3:
> - Extract reviewed patches from
>   "util/vfio-helpers: Allow using multiple MSIX IRQs"
> - Added "Assert offset is aligned to page size"
>   which would have helped debugging:
>   "block/nvme: Fix use of write-only doorbells page on Aarch64 arch"
> 
> Missing review: 7
> 
> Based-on: <20201029093306.1063879-1-philmd@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> Philippe Mathieu-Daudé (7):
>   util/vfio-helpers: Improve reporting unsupported IOMMU type
>   util/vfio-helpers: Trace PCI I/O config accesses
>   util/vfio-helpers: Trace PCI BAR region info
>   util/vfio-helpers: Trace where BARs are mapped
>   util/vfio-helpers: Improve DMA trace events
>   util/vfio-helpers: Convert vfio_dump_mapping to trace events
>   util/vfio-helpers: Assert offset is aligned to page size
> 
>  util/vfio-helpers.c | 43 ++++++++++++++++++++++++++-----------------
>  util/trace-events   | 10 ++++++++--
>  2 files changed, 34 insertions(+), 19 deletions(-)
> 


