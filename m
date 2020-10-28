Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87123C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A0F2468A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKAPabZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A0F2468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXixf-0007lI-7J
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXiwL-0006pa-Iq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXiwF-0004Zv-9e
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603881857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kF7GZi9PZ1TUsePBDfRPYnIfmVomfA/+ANOLSJfTQyE=;
 b=cKAPabZOV745zEc9i6WGTafagyDrivuSJL2at7z52tqCg18SmTS1Ys9agrREJ/HQ8b4Jjk
 ZzDYBpTbxEDO4VczIOSxGd8+P4uDeh5RU96X+SzfF+Mp79qsLv3bTjkt4R1HoIiaGza/mi
 kTD2oePYCgVvZWNj0VyJffr92xmtwaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-IZrvoqCkPTKW1H-RNnROIw-1; Wed, 28 Oct 2020 06:44:15 -0400
X-MC-Unique: IZrvoqCkPTKW1H-RNnROIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E778E1084C82;
 Wed, 28 Oct 2020 10:44:13 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 710AB55785;
 Wed, 28 Oct 2020 10:44:07 +0000 (UTC)
Subject: Re: [PATCH 09/25] block/nvme: Move definitions before structure
 declarations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-10-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <94f5fe36-2435-9506-a18c-00872b9ee2cf@redhat.com>
Date: Wed, 28 Oct 2020 11:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-10-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> To be able to use some definitions in structure declarations,
> move them earlier. No logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  block/nvme.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index be14350f959..30075e230ca 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -41,6 +41,16 @@
>  
>  typedef struct BDRVNVMeState BDRVNVMeState;
>  
> +/* Same index is used for queues and IRQs */
> +#define INDEX_ADMIN     0
> +#define INDEX_IO(n)     (1 + n)
> +
> +/* This driver shares a single MSIX IRQ for the admin and I/O queues */
> +enum {
> +    MSIX_SHARED_IRQ_IDX = 0,
> +    MSIX_IRQ_COUNT = 1
> +};
> +
>  typedef struct {
>      int32_t  head, tail;
>      uint8_t  *queue;
> @@ -81,15 +91,6 @@ typedef struct {
>      QEMUBH      *completion_bh;
>  } NVMeQueuePair;
>  
> -#define INDEX_ADMIN     0
> -#define INDEX_IO(n)     (1 + n)
> -
> -/* This driver shares a single MSIX IRQ for the admin and I/O queues */
> -enum {
> -    MSIX_SHARED_IRQ_IDX = 0,
> -    MSIX_IRQ_COUNT = 1
> -};
> -
>  struct BDRVNVMeState {
>      AioContext *aio_context;
>      QEMUVFIOState *vfio;
> 


