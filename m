Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD4CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDC220862
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDC220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQzI3-00089E-3b
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 15:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQzH1-0007gp-BD
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQzGz-00089K-DD
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQzGz-00086X-4s
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:41:21 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C94C85A07
 for <qemu-devel@nongnu.org>; Sat,  2 Nov 2019 19:41:18 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o202so3953408wme.5
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 12:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sp6e6Mf0zmADJX75VSRYyGfggZ9Vmlm6OHsH+NXUWrg=;
 b=oqVwav159iELAW4KyBvBlEzzUu0JaQh6r9u3HTIbXgEbsqCwN/JRsOWVhOCTwI3qx4
 Rs9E6ja+6hv9aekXp2av4eYbu86FAq/Lxc/xa1Gkfb9GimJEWGT58CO/lWrRDsjLwMxi
 PHH6IvMJdqgyRQ2DSub4VFkJkB/qj9FM3caUPqyXs9uEggtKOYrBgmBD1TSYGLBzHA96
 /jfljxChm6MAUOQ28MA5udG7dhXMTm1TrvCNZSV4K2mGUYeg1XaqgFbiS/j3mWx1Bn32
 TYsKSw07GTlkNqS1dvt4sEy8SqUtwmOApeeGSzu57HTegWygdUAovulmlZnKeecWGN5O
 lxNg==
X-Gm-Message-State: APjAAAWlRj4+BriHaQ/xpLpnolMeSCvhvVAuRxjY6rll9ofJhsxXGQrc
 N62+XcQgOGnm/uuGrO3IgFYa4yTnlveODpqRrMaVWmjy6sgOOUbn47NpDa0c9h3sZi/Fg7bAxid
 FsQi/QU1rVbwz5OQ=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr15929948wru.159.1572723677235; 
 Sat, 02 Nov 2019 12:41:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdqiAKOjtorIpi72HWvFVXOaAhi321JJNyZVwZPAWIwQO2S1VMnOPYl7c7Eg8kbvnyqlBRRg==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr15929942wru.159.1572723677041; 
 Sat, 02 Nov 2019 12:41:17 -0700 (PDT)
Received: from [10.34.4.205] ([109.190.253.11])
 by smtp.gmail.com with ESMTPSA id r3sm12097841wmh.9.2019.11.02.12.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Nov 2019 12:41:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] dp8393x: fix dp8393x_receive()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191102171511.31881-1-laurent@vivier.eu>
 <20191102171511.31881-3-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9f724f7-1bd9-3283-ab20-0038ab278251@redhat.com>
Date: Sat, 2 Nov 2019 20:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191102171511.31881-3-laurent@vivier.eu>
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/19 6:15 PM, Laurent Vivier wrote:
> address_space_rw() access size must be multiplied by the width.
>=20
> This fixes DHCP for Q800 guest.
>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 85d3f3788e..b8c4473f99 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -833,7 +833,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>       } else {
>           dp8393x_put(s, width, 0, 0); /* in_use */
>           address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) *=
 6 * width,
> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, sizeof(uint16_=
t), 1);
> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);

Which is following:

     if (s->regs[SONIC_LLFA] & 0x1) {
         size =3D sizeof(uint16_t) * 1 * width;

So OK (you describe 'width' but use 'size').

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
>           s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->=
regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
>=20

