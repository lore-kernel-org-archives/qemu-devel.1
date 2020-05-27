Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DEDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE402078B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3qpu2KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE402078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxPL-0005S7-0M
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdxOU-0004fM-JG
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:50:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdxOS-0004MX-QL
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590591055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jt2O02vs+NLP0r9p0Z1zjPBIZdH//DNFNRyNX/mabPM=;
 b=G3qpu2KY6Go5VVjMJ5CO6XipBTIPrLXE3+t6EWTwXUgFpRNdKGUS85Ji7Vbe1G+AD+ugnE
 Y6fpps9nbDENPKaRrZFw/Yg1VKSh6XT+7xzGuVw4ndgkQuWbOfeMrUuEq3m1C3QbC0GWlH
 +kJb7r7rWR8va8MIZvpifOo5JpxjtVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-Aj8ZSKYKNliX64OSfWTUIg-1; Wed, 27 May 2020 10:50:51 -0400
X-MC-Unique: Aj8ZSKYKNliX64OSfWTUIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF17EC1B6;
 Wed, 27 May 2020 14:50:49 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1CD662932;
 Wed, 27 May 2020 14:50:40 +0000 (UTC)
Subject: Re: [PATCH v6 4/5] block: make size-related BlockConf properties
 accept size suffixes
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org
References: <20200527124511.986099-1-rvkagan@yandex-team.ru>
 <20200527124511.986099-5-rvkagan@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d2ac3549-e63d-d737-41fa-21965c551175@redhat.com>
Date: Wed, 27 May 2020 09:50:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527124511.986099-5-rvkagan@yandex-team.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 7:45 AM, Roman Kagan wrote:
> Several BlockConf properties represent respective sizes in bytes so it
> makes sense to accept size suffixes for them.
> 
> Turn them all into uint32_t and use size-suffix-capable setters/getters
> on them; introduce DEFINE_PROP_SIZE32 and adjust DEFINE_PROP_BLOCKSIZE
> for that. (Making them uint64_t and reusing DEFINE_PROP_SIZE isn't
> justified because guests expect at most 32bit values.)
> 
> Also, since min_io_size is exposed to the guest by scsi and virtio-blk
> devices as an uint16_t in units of logical blocks, introduce an
> additional check in blkconf_blocksizes to prevent its silent truncation.
> 
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> ---
> v5 -> v6:
> - add prop_size32 instead of going with 64bit

Would it be worth adding prop_size32 as its own patch, before using it 
here?  But I'll review this as-is.

> +++ b/hw/block/block.c
> @@ -96,6 +96,17 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
>           return false;
>       }
>   
> +    /*
> +     * all devices which support min_io_size (scsi and virtio-blk) expose it to
> +     * the guest as a uint16_t in units of logical blocks
> +     */
> +    if (conf->min_io_size > conf->logical_block_size * UINT16_MAX) {

This risks overflow.  Better would be:

if (conf->min_io_size / conf->logical_block-size > UINT16_MAX)

> +        error_setg(errp,
> +                   "min_io_size must not exceed " stringify(UINT16_MAX)
> +                   " logical blocks");
> +        return false;
> +    }
> +
>       if (!QEMU_IS_ALIGNED(conf->opt_io_size, conf->logical_block_size)) {
>           error_setg(errp,
>                      "opt_io_size must be a multiple of logical_block_size");

> +++ b/tests/qemu-iotests/172.out
> @@ -24,11 +24,11 @@ Testing:
>                 dev: floppy, id ""
>                   unit = 0 (0x0)
>                   drive = "floppy0"
> -                logical_block_size = 512 (0x200)
> -                physical_block_size = 512 (0x200)
> -                min_io_size = 0 (0x0)
> -                opt_io_size = 0 (0x0)
> -                discard_granularity = 4294967295 (0xffffffff)
> +                logical_block_size = 512 (512 B)
> +                physical_block_size = 512 (512 B)
> +                min_io_size = 0 (0 B)
> +                opt_io_size = 0 (0 B)
> +                discard_granularity = 4294967295 (4 GiB)

Although 4 GiB is not quite the same as 4294967295, the exact byte value 
next to the approximate size is not too bad.  The mechanical fallout 
from the change from int to size is fine to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


