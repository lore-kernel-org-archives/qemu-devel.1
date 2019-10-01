Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC9C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AF12053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AF12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKVI-0001nR-4J
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFKJv-0006eP-Rm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFKJr-0000Ls-9f
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFKJr-0000Kz-1j
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:44:07 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F960356C9
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 15:44:05 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o188so1601166wmo.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 08:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l8CZUp1xVyQvejAqLquXWbLNcqmwg0cfq/ipTtsyQMM=;
 b=bL+i5+/px2YOWj0sEX3bTtTBLXi6vmSWiKJmQ5ljtUhYxhHccoML7pbzOWyrkkNvZB
 MCW0LPfvDXlxmHBNXYvhwvRzTqGExD1w9EZXBNMkYy8hBR8i+t2LKBcXOmrAyyETbLqZ
 SZ7O8Rf7D5cOw1lDqinntZ1OyX83WhDdQj+rtIjKU7Tab+XeJRfbBQLg03iQrJ420C5B
 Kbtxm7r0emjmmy7O4a8NK1OYloadLg0UsTlqleflm4zWOFhaT1QsSaYcglDSgMZ0w5xz
 TJtekppFkr7V8zN+O0YpP8q016vceqo2Thz26tg8zv8GmuyDkHDHlfeoUi7Du/fNKkuW
 pPxw==
X-Gm-Message-State: APjAAAVkd+noKllpZeKtupa1loTwzV3ZHWfQj5swZ6RqhTSHtnY3KQlg
 ydMdNSELddo2YhEai2YT8dseZ6y8IKe9k05mlQ1/xiEASVgBWcHQF4PwSaLMg0357ghLXobIVnh
 WACVJqh1RrmCBirU=
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr3934615wmk.61.1569944644248;
 Tue, 01 Oct 2019 08:44:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSsL7zpbF+gcInLuq3SAg0xbD5h1EgEbs9eexWyEBp2V2rAFT/A5biwN6ZWWmx8HTOHTuZcA==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr3934603wmk.61.1569944644059;
 Tue, 01 Oct 2019 08:44:04 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id i1sm4778091wmb.19.2019.10.01.08.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 08:44:03 -0700 (PDT)
Subject: Re: [PATCHv2] slirp: Allow non-local DNS address when restrict is off
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
 jasowang@redhat.com, marcandre.lureau@gmail.com
References: <20191001154057.27250-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c129b661-52ce-6ebf-3802-cd2533d93594@redhat.com>
Date: Tue, 1 Oct 2019 17:44:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001154057.27250-1-samuel.thibault@ens-lyon.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 5:40 PM, Samuel Thibault wrote:
> This can be used to set a DNS server to be used by the guest which is
> different from the one configured on the host.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1010484
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
> Difference from first version:
> - handle DNS IPv6 as well
> - reference bug with Buglink

Thanks!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>   net/slirp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/slirp.c b/net/slirp.c
> index f42f496641..c4334ee876 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -456,7 +456,7 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
>           error_setg(errp, "Failed to parse DNS");
>           return -1;
>       }
> -    if ((dns.s_addr & mask.s_addr) !=3D net.s_addr) {
> +    if (restricted && (dns.s_addr & mask.s_addr) !=3D net.s_addr) {
>           error_setg(errp, "DNS doesn't belong to network");
>           return -1;
>       }
> @@ -522,7 +522,7 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
>               error_setg(errp, "Failed to parse IPv6 DNS");
>               return -1;
>           }
> -        if (!in6_equal_net(&ip6_prefix, &ip6_dns, vprefix6_len)) {
> +        if (restricted && !in6_equal_net(&ip6_prefix, &ip6_dns, vprefi=
x6_len)) {
>               error_setg(errp, "IPv6 DNS doesn't belong to network");
>               return -1;
>           }
>=20

