Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B5C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41A72073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="gXuooDbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41A72073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRIh-0004zC-VV
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isRHn-0004MR-OQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isRHj-0004ef-RG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:03:39 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:36091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1isRHj-0004dU-BL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=dDAx9EZ/7l+Lufz/pdugZnO0IKYWF+vkKJLX7Upa8jo=; b=gXuooDbqpIbot2PZwFHZCdH37u
 4pR/rf9aafAzqjpes3TTeIxNwUd7/HHj8urIMqP4x6ZDRFHvhoTQ/zDyMduPV6TmIP/Ww6q1kqIRE
 kb8pp6+7eSpWypVfF1C+6awX40UEy85zLmNErKAXWuP6s4rRbGc5jWfgKDfzQK09bpNPrccPjLjr3
 4zpGtQBNI267k46kDl+rUnNP1NWbqWC9/SSy3QAoT/T17xdgMbO0BsJm0cIfPsbYjVAOc3quSQa9L
 YgJj9o4k2FhDdau8U3HDen6uEog1po6GuQ/2/knLENzga1WtZrpnQWxiAoJ3N2Jybl00RRxqUo1K3
 yw8ip8eoTl1313dM1BbfW4P8bQBxw7SmV5CuNqaCQQB/bxKcrwpkvQM0XOTEafgjunoONdrCLF/9z
 JZzVQNNzuuisN70vb9U7DMBpuJLoVZ51KrQKI5+BH+lyZRG3GLy82hzYFkCqlYrC2QkR4WFleluz8
 bUvJUKD+dLDSkMmJkqb8GK56XhtSS2rdL+sgFp7ELBCDHQOq1Pa/8/Kt2hzpz4uwLQI+2ekHk6OlQ
 ZdsHh4/+yqFYwNKPz626mD+RwDQC7SyIlNoIwRTOBPNL9gOcf/xULPURQ7a2d7tnQgqFFavr523rc
 b2/0x8J3uOJ1OCnw9BjwRXZmM6AMsLZyWTdI3j4SQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: pannengyuan@huawei.com, mst@redhat.com, groug@kaod.org,
 zhang.zhanghailiang@huawei.com
Subject: Re: [PATCH v2 2/2] virtio-9p-device: convert to new
 virtio_delete_queue
Date: Fri, 17 Jan 2020 14:03:31 +0100
Message-ID: <1681481.LA4rHMh2Io@silver>
In-Reply-To: <20200117060927.51996-3-pannengyuan@huawei.com>
References: <20200117060927.51996-1-pannengyuan@huawei.com>
 <20200117060927.51996-3-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 17. Januar 2020 07:09:27 CET pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Use virtio_delete_queue to make it more clear.
> 
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes V2 to V1:
> - replace virtio_del_queue to virtio_delete_queue to make it more clear.
> ---
>  hw/9pfs/virtio-9p-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 910dc5045e..b146387ae2 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -215,7 +215,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev,
> Error **errp) V9fsVirtioState *v = VIRTIO_9P(dev);
>      V9fsState *s = &v->state;
> 
> -    virtio_del_queue(vdev, 0);
> +    virtio_delete_queue(v->vq);
>      virtio_cleanup(vdev);
>      v9fs_device_unrealize_common(s, errp);
>  }

No idea what the deprecation plans of virtio_del_queue() are; no behaviour 
change, so this patch is certainly not high priority. On the other hand though 
this change most certainly will be required on day.

I can imagine Greg might want to see a more verbose commit message, but that's 
beyond my personal detail level, so from my side

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>





