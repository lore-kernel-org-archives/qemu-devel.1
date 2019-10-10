Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C54C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0042F208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0042F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIabo-0000Ez-Mk
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIaXC-0004bm-Np
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIaXB-00019p-I3
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIaXB-00019U-9u
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:39:21 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A6598E581
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:39:20 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o188so2785446wmo.5
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 08:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OCbxLCSShB8PeOl+TXv9pUrDNXqx8Pq2Y/Vr7dbU7LU=;
 b=FZ/ADMam6OyDpJxqdlJPqkdN8cLrbWn4kmd8TPrbtRqmRMmJUNRRPe67F1lguZlE6L
 4NZeNNRIfW3Xs2sdpPUlnn7SKqVgO3eTfRl4ao1RdyrYViiDrADNr62QXy85fab8F2Tu
 oiF17XHGsQ5PGZzKYsrwqdmxBgxqPRO6rDmp3wiZzWDf4LY8TvpL8rUfR7FjIJRgpNMD
 OtUAQqyqcsrTmJMQVrvWVZ7iB3Aae0cdYE9wkiL4jAi00R9wOREEJRtV337bK1+MIYeK
 2EgzJbrrD2JdiVkDXh3m3w3X/acinKgi6jaeSTqbpXe5d5YkSUqH0q0S9aEleSaWVxcb
 FS8g==
X-Gm-Message-State: APjAAAXeUJW9T9WjIMhG4kOtR8QmQvwnDju7zBCwK8awAJAY9hm3t+J+
 28qEMh4xqBAj94h8B7AmQ8oAiMspZXOJHzXAvGme+7Y0+QvXmrikyg6jYzLnGd7G/cU1HK81w1d
 YP0oKX3adW/sHZzk=
X-Received: by 2002:a05:6000:12cd:: with SMTP id
 l13mr8981859wrx.344.1570721959150; 
 Thu, 10 Oct 2019 08:39:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXhy++lNGevTxtHlZpaGOwreXqFzYRKqXaPn82s5sQh2066DxEc4qt/6KYbQZMBd+tFmNZjg==
X-Received: by 2002:a05:6000:12cd:: with SMTP id
 l13mr8981841wrx.344.1570721958969; 
 Thu, 10 Oct 2019 08:39:18 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id t83sm12115269wmt.18.2019.10.10.08.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 08:39:18 -0700 (PDT)
Subject: Re: [PATCH v8 05/15] hw/i386/pc: avoid an assignment in if condition
 in x86_load_linux()
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191010143125.67246-1-slp@redhat.com>
 <20191010143125.67246-6-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2cc5b2a9-1b24-ef43-1af5-4e7299a03ada@redhat.com>
Date: Thu, 10 Oct 2019 17:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010143125.67246-6-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 4:31 PM, Sergio Lopez wrote:
> Follow checkpatch.pl recommendation an avoid an assignment in if

Paolo, do you mind fixing: "and avoid"? Thanks!

> condition in x86_load_linux().
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/pc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e6bcc3ff42..90e2d68096 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1045,7 +1045,14 @@ static void x86_load_linux(PCMachineState *pcms,
>  =20
>       /* load the kernel header */
>       f =3D fopen(kernel_filename, "rb");
> -    if (!f || !(kernel_size =3D get_file_size(f)) ||
> +    if (!f) {
> +        fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
> +                kernel_filename, strerror(errno));
> +        exit(1);
> +    }
> +
> +    kernel_size =3D get_file_size(f);
> +    if (!kernel_size ||
>           fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=3D
>           MIN(ARRAY_SIZE(header), kernel_size)) {
>           fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

