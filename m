Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C0C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 17:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F57C20409
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLOgRrXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F57C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilyRv-00089O-TG
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 12:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilyOq-0005G3-VA
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilyOn-0002IS-7f
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:00:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25781
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilyOm-0002I9-C6
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577725207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYHvn2oYThI3z3bqnaWp4TJRAroW2ZDXFyKOmcujNKs=;
 b=VLOgRrXyY7WZWPfs8dNxzOwqQnLoNKCLBT5HTVJDNYos1JYn/xos6tXJgl3VVxjdk5nVcR
 ciIvIynUP5VI3rxtroRCV2hYHuN2prQOjU2xa2/PWB9OxBwag4+05vx0vaNjeMTzVj5Jvy
 zKxJB1sONUJV4r9FIXFyInwx7KZIbQc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-Fihwh83gNZ6HKKOxpY-LTw-1; Mon, 30 Dec 2019 12:00:05 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so16317765wrm.17
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 09:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BqrS0mPxlhSGMdF6WXF/f+VF7RdTblu/FV8J5psIfCo=;
 b=S1Q5pVR2ZAV0Wugmk5BhLpGzgX4L40W5FlWinXW98pmP7fuwmemleivKRbjwOC8Yvc
 Y87kHIN6vVfyU9tTp+WrW4MBqqKHqwbyW5eTArKquhecnJ5bbhtw37lGmb30Ok7t41ZY
 lI02/YCeFcd7LR6T25ixW/CLM8yzX2MqUlW4mk0FHKh3z/Rp+2dbB7bG/+CITbsCQDE5
 UIYXVZyV6eHP91GKd5ifCsnLYoHYLXnpetJp9r9QEbikUGJ/Tv7W5GNdfZN9Z/mcW0M0
 6BzErvB0O9MUYRs5D3oPV4mSIQbb9WKsu+NuiPZLrFmOPY67h8ye0jgwFpO4nH0u+k68
 2xHg==
X-Gm-Message-State: APjAAAVrHyfs72mswTSSop0Dzw1NQlKKjRJtDU6XBYYPcl+2P4XzD2Xo
 4Cy3fvOD6Y2QBqo8FV2gr362ZnT+TxoznoAYzyXP0fknTJYpYz/KX4nnnQzIqsLPv5tj595x2I6
 abreAkRrNa2TzgsY=
X-Received: by 2002:a5d:6802:: with SMTP id w2mr66582052wru.353.1577725204506; 
 Mon, 30 Dec 2019 09:00:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrXmBmTAvQCkVlLexJnKww7T0/7iXsZsPatiQlXiaUe8GPDSUSP/S3nW5Bi1rOl89ksMBTDw==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr66582031wru.353.1577725204259; 
 Mon, 30 Dec 2019 09:00:04 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id f207sm20297wme.9.2019.12.30.09.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 09:00:03 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Remove Claudio Fontana bouncing email
To: qemu-devel@nongnu.org
References: <20191230111801.26315-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e105845-05b1-de20-0844-7081821d0479@redhat.com>
Date: Mon, 30 Dec 2019 18:00:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230111801.26315-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: Fihwh83gNZ6HKKOxpY-LTw-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-trivial@nongnu.org, Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 12:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Claudio Fontana Huawei email is bouncing, remove it.
>=20
>    The message you sent to claudio.fontana@huawei.com couldn't be
>    delivered due to: Recipient email address is possibly incorrect.
>=20
>    Further information:
>      5.1.1 Error: invalid recipients
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 387879aebc..8db4de6b9a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2383,7 +2383,6 @@ F: plugins/
>   F: tests/plugin
>  =20
>   AArch64 TCG target
> -M: Claudio Fontana <claudio.fontana@huawei.com>
>   M: Claudio Fontana <claudio.fontana@gmail.com>
>   S: Maintained
>   L: qemu-arm@nongnu.org
>=20

Claudio, if you want we can amend to this patch:

-- >8 --
diff --git a/.mailmap b/.mailmap
index 3816e4effe..4ed87fb53f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -43,6 +43,7 @@ Aleksandar Markovic <amarkovic@wavecomp.com>=20
<aleksandar.markovic@mips.com>
  Aleksandar Markovic <amarkovic@wavecomp.com>=20
<aleksandar.markovic@imgtec.com>
  Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori=20
<aliguori@us.ibm.com>
+Claudio Fontana <claudio.fontana@gmail.com> <claudio.fontana@huawei.com>
  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
---

Simply reply with your Ack-by such "with .mailmap change:"...


