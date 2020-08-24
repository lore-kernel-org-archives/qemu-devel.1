Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E301C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD95220706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKMSJdNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD95220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAKY3-0008Jk-2D
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAKV8-00066i-Bg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:59:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAKV6-0008Eg-Lu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598306375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTxc+S6SMvT1xjvTbHN2X0LL6KYY3/EVzb/A8AAD93k=;
 b=jKMSJdNgDRV4N3DjW2BwsB2FoZtBWWmlzP7BwV7mkZEyKwm6n2YsyoCKSSKGTCfZimwKeC
 u72urb+/w9EtTA3RErbPwbSOQsf1KEP8g0bACaWd5TWLMgUHgnNnZfWM2mwNGigGgbnIrK
 Rsm3Fczmd6xQAlg4lueaEi/4gBIFJRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-65S_IJ2fMsKkQm4hmD1ZbQ-1; Mon, 24 Aug 2020 17:59:33 -0400
X-MC-Unique: 65S_IJ2fMsKkQm4hmD1ZbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 607CD18A2246;
 Mon, 24 Aug 2020 21:59:32 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 416435B680;
 Mon, 24 Aug 2020 21:59:31 +0000 (UTC)
Date: Mon, 24 Aug 2020 16:35:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v1 1/1] core/register: Specify instance_size in the
 TypeInfo
Message-ID: <20200824203540.GR642093@habkost.net>
References: <87a2da602785bce972a6a6b4502769f4fee58a2d.1598074333.git.alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <87a2da602785bce972a6a6b4502769f4fee58a2d.1598074333.git.alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 17:57:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 10:33:06PM -0700, Alistair Francis wrote:
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/core/register.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/register.c b/hw/core/register.c
> index ddf91eb445..5e8e8199d0 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -180,11 +180,7 @@ void register_init(RegisterInfo *reg)
>  {
>      assert(reg);
>  
> -    if (!reg->data || !reg->access) {
> -        return;
> -    }
>  
> -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
>  }
>  
>  void register_write_memory(void *opaque, hwaddr addr,
> @@ -269,13 +265,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>          int index = rae[i].addr / data_size;
>          RegisterInfo *r = &ri[index];
>  
> +        if (data + data_size * index == 0 || !&rae[i]) {
> +            continue;
> +        }
> +
> +        /* Init the register, this will zero it. */
> +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> +
> +        /* Set the properties of the register */
>          *r = (RegisterInfo) {
>              .data = data + data_size * index,
>              .data_size = data_size,
>              .access = &rae[i],
>              .opaque = owner,
>          };

This doesn't look right.  Won't this wipe out all DeviceState
data in r->parent_obj?

> -        register_init(r);
>  
>          r_array->r[i] = r;
>      }
> @@ -329,6 +332,7 @@ static const TypeInfo register_info = {
>      .name  = TYPE_REGISTER,
>      .parent = TYPE_DEVICE,
>      .class_init = register_class_init,
> +    .instance_size = sizeof(RegisterInfo),
>  };
>  
>  static void register_register_types(void)
> -- 
> 2.28.0
> 
> 

-- 
Eduardo


