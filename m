Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF59C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BA8208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLh2Acc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BA8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLQ4-0000wb-8r
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBLOM-0007UH-3o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBLOL-0003Dw-29
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:36:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBLOK-0003Dq-V5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583771792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcAsGXiG2VF6QQr/mDlUnLtJ9aFGI4GNn9FNRHU9V5k=;
 b=gLh2Acc+ss08Yjvlu8AGQV3CteB4CSECINeGsyDKMVFqG8V387IrsSI9Z1/hMBchrh10du
 s/XSm15RJNdDwGFkQTiKZ7i2cVD4biF9LMuT8x4vzz5DZV3ZB4AI7lQGESJ/VpLbS6tgpz
 eAn9e7+RlgpzjIY0XMcjy846PJRy3MI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-GPxexTMuN0qqHdXetiK7zQ-1; Mon, 09 Mar 2020 12:36:30 -0400
X-MC-Unique: GPxexTMuN0qqHdXetiK7zQ-1
Received: by mail-ed1-f69.google.com with SMTP id f13so8471188edy.21
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 09:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ss3xfdQgnPA3E1OJ1aBzz8H7ez/25Mo6ELaDcKhXc+k=;
 b=mxHq2rF1j5qS2CxIR4TxJVPTnQlO9y5exUN9izxhsOsPihAsdYBobYvkxJxwv8cZi3
 7rfsfp/6nrei7BRVimWRwM3TgoY2VYjDs8WxTBnhVeffvmUjq3AXdHUtCcPY7BVA0HEF
 SO+Jq7DCRYL9Z7fKyh9sy+j9W4d2yPlMyOW/qlOhsqGCLgHp+gjX7Kfpis/0apnH2P5C
 Nh0We7DA+7SjOADw7xTcb3t0hfJ/JwIE6e8Hdrh9yxikr0O9TNQGJpOFTXb2hmz8zq3a
 28bTBaqw2b/vOYk0S7isfVBz/VFCqNNJ8Ro1nphw1j0l9/6/owBt2fOIV8ViMFPjsiQ/
 X2EA==
X-Gm-Message-State: ANhLgQ1aVGpMalLg43prCi36x0V4d+WCkXR82zOiQYqUVDdNh2jnTc6M
 viChvJEa3uV6VrJaN1yKRLhtwhlLP+fyYUXAeWJpozfeIt4nl04v5k9qsnTCiw8iQWT1CC7VWsh
 UqyhOLmsgx9MRscw=
X-Received: by 2002:a50:f149:: with SMTP id z9mr18610386edl.246.1583771789778; 
 Mon, 09 Mar 2020 09:36:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtLgeYqYsBVT/60/2YAsZb8q8UjPdTyHLQ97h15dkLThauXG2lZH8CUxut+EyzUJ8zbiE2nNw==
X-Received: by 2002:a50:f149:: with SMTP id z9mr18610372edl.246.1583771789543; 
 Mon, 09 Mar 2020 09:36:29 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p24sm349426edx.34.2020.03.09.09.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 09:36:29 -0700 (PDT)
Subject: Re: [PATCH] softmmu: fix crash with invalid -M memory-backend=
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200309145155.168942-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <caa7121c-47ce-9003-7666-74f8b6f42704@redhat.com>
Date: Mon, 9 Mar 2020 17:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309145155.168942-1-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 3:51 PM, Marc-Andr=C3=A9 Lureau wrote:
> Fixes: fe64d06afc1c5d895f220c268cfe4d5f1e65d44e ("vl.c: ensure that
> ram_size matches size of machine.memory-backend")

<new line>

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   softmmu/vl.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 5549f4b619..38e9c404f2 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4287,6 +4287,11 @@ void qemu_init(int argc, char **argv, char **envp)
>  =20
>           backend =3D object_resolve_path_type(current_machine->ram_memde=
v_id,
>                                              TYPE_MEMORY_BACKEND, NULL);
> +        if (!backend) {
> +            error_report("Memory backend '%s' not found",
> +                         current_machine->ram_memdev_id);
> +            exit(EXIT_FAILURE);
> +        }
>           backend_size =3D object_property_get_uint(backend, "size",  &er=
ror_abort);
>           if (have_custom_ram_size && backend_size !=3D ram_size) {
>                   error_report("Size specified by -m option must match si=
ze of "
>=20


