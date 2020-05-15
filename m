Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6827E20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9oEn+pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6827E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeNp-00034K-Hz
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeNF-0002ZS-Gh
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:43:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30805
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeND-0005hQ-NM
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589564630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sS4YSPeWZNwrAUDTBbRtFLGf/O92oqrhULsyrQdACrM=;
 b=X9oEn+plPRzDgXhg6VCRhyf/6+DRPZfANZyE6wV8UYLBQIWqqap0YXktdtkGvIO9UF+bvs
 EZDnPOd5x8kbrA18nGjGJhUn7NAaIB3KYBWElXBcbSOwxU+kmdTx1tpj8gfV/OZiFyuYx0
 VHmV2EH8V9OkKeNMjxsBccs2feb/Vzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-7hf7a0MqP-SjqESyCnQbgQ-1; Fri, 15 May 2020 13:43:48 -0400
X-MC-Unique: 7hf7a0MqP-SjqESyCnQbgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2308C1B18BC1;
 Fri, 15 May 2020 17:43:47 +0000 (UTC)
Received: from [10.3.114.84] (ovpn-114-84.phx2.redhat.com [10.3.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6EDD60BF1;
 Fri, 15 May 2020 17:43:46 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] sysemu/block-backend: Document
 blk_read()/blk_pwrite()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200515091924.14380-1-philmd@redhat.com>
 <20200515091924.14380-5-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3fe181eb-c24a-e87a-23e4-33b36aec7134@redhat.com>
Date: Fri, 15 May 2020 12:43:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515091924.14380-5-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 4:19 AM, Philippe Mathieu-Daudé wrote:
> The blk_read()/blk_pwrite() return value is not obvious,

s/read/pread/ here and in the subject

> document it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---

> +/**
> + * blk_pread:
> + *
> + * @blk: the block backend where the buffer content is going to be read from
> + * @offset: position in bytes to read at
> + * @buf: the data buffer
> + * @bytes: number of bytes to read
> + *
> + * Returns: the number of bytes read on success, or a negative errno otherwise.
> + */
>   int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);

"the number of bytes read" is ambiguous - it sounds too much like the 
read() syscall where short reads are successful.  But blk_pread() never 
does short reads, on success, the result is exactly 'bytes'.

> +
> +/**
> + * blk_pwrite:
> + *
> + * @blk: the block backend where the buffer content is going to be written to
> + * @offset: position in bytes to write at
> + * @buf: the data buffer
> + * @bytes: number of bytes of @buf to write
> + * @flags: request flags
> + *
> + * Returns: the number of bytes consumed on success,

Ditto - we don't support short writes, so on success, it is always 'bytes'.

> + *          or a negative errno otherwise.
> + */
>   int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
>                  BdrvRequestFlags flags);
>   int64_t blk_getlength(BlockBackend *blk);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


