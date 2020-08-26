Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632F1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C9A207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoEJX3eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C9A207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB1VY-0007FS-DC
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 15:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kB1Uu-0006pa-Ss
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:54:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32334
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kB1RA-0000w6-N2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598471362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KrLEEkpUDk59fGsNOaQL+LkZ6p5ffFliyiEINgieX+E=;
 b=FoEJX3eW5GSAmyeM8WbJPdQQ3W7lO2BGjtvqeXpczGLdgmQ46KnaWx2tW6+HxN/eJk5rGH
 3MHwA4bp/nyP7SBP8Hb6jkHXV6d3dEpgbaYjvcD+rIpxoxsboDQ58zX0+lwx7L6dkIsb1G
 e8bKysTMBNtgCUl8w2l9rsecncIRK6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-FeDs58TeM7apl8PdWmrbGA-1; Wed, 26 Aug 2020 15:49:20 -0400
X-MC-Unique: FeDs58TeM7apl8PdWmrbGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D72364086;
 Wed, 26 Aug 2020 19:49:19 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A28C619C58;
 Wed, 26 Aug 2020 19:49:18 +0000 (UTC)
Date: Wed, 26 Aug 2020 15:49:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/1] core/register: Specify instance_size in the
 TypeInfo
Message-ID: <20200826194918.GG642093@habkost.net>
References: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: alistair23@gmail.com, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 10:30:59AM -0700, Alistair Francis wrote:
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/core/register.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/core/register.c b/hw/core/register.c
> index ddf91eb445..31038bd7cc 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -176,17 +176,6 @@ void register_reset(RegisterInfo *reg)
>      }
>  }
>  
> -void register_init(RegisterInfo *reg)
> -{
> -    assert(reg);
> -
> -    if (!reg->data || !reg->access) {
> -        return;
> -    }
> -
> -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
> -}
> -
>  void register_write_memory(void *opaque, hwaddr addr,
>                             uint64_t value, unsigned size)
>  {
> @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>          int index = rae[i].addr / data_size;
>          RegisterInfo *r = &ri[index];
>  
> -        *r = (RegisterInfo) {
> -            .data = data + data_size * index,
> -            .data_size = data_size,
> -            .access = &rae[i],
> -            .opaque = owner,
> -        };
> -        register_init(r);
> +        if (data + data_size * index == 0 || !&rae[i]) {

Do you know what's the goal of this check?

Can `data` or `rae` be NULL?  If not, it seems impossible for
this condition to be true.  If they can, this seems to be a weird
and fragile way of checking for NULL arguments.

> +            continue;
> +        }
> +
> +        /* Init the register, this will zero it. */
> +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> +
> +        /* Set the properties of the register */
> +        r->data = data + data_size * index;
> +        r->data_size = data_size;
> +        r->access = &rae[i];
> +        r->opaque = owner;
>  
>          r_array->r[i] = r;
>      }
> @@ -329,6 +323,7 @@ static const TypeInfo register_info = {
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

-- 
Eduardo


