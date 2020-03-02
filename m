Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA18C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9005217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU0YhUQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9005217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8usl-00007J-4D
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8us6-0007oY-EH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8us5-0001qX-Cu
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:53:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8us5-0001qM-A2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583193192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8dxAEEcWtFw37h+1gk7F3+3uCFbExHVPI+7q+m/Npk=;
 b=XU0YhUQFk263y8EF6IZamb9AE5tJVdhT9xjKSrXULIM+HMaCqIYGhQJ4o+33XyG5AC9vEm
 2Kl/FmQYzHDJeAFVdc981ScCt6BG1s6vfXs6ADm0cCTxgcpQ2VNUMrc000GBUjmOAKr+oM
 TRgeuKxGWBTE4YqoPMZDnLBOAhGd81k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-C7AOh7YdPYSevlQIPtaHPA-1; Mon, 02 Mar 2020 18:53:10 -0500
X-MC-Unique: C7AOh7YdPYSevlQIPtaHPA-1
Received: by mail-wr1-f72.google.com with SMTP id c6so399784wrm.18
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/L6kOvySyj80Ozkhxppgla5m/9jrFkOmRy98lPQpROQ=;
 b=h+ooTIkW+gP115tqif3f3qBmS5QqvTdjWeunWH0zj74I25cnIQP8mTARanYJoS1cqV
 kotVU5L3jWxOksb0c/FdeF2jLospEoquRdpxvqJx3GXryL7cq6rfljkBakzbFjic9euD
 YbTzFmpLqfwvt5W/gidV/JQBNtzdoYuticn3CXwRyuHRfteHm38EYH13GeIrBsI7tlER
 J1qUnDQrmKKtNpd1I46c9/d/cm6+p/MVwy41B+EtQ4iP2Uw2ULYGJEgzVs4Pv/jjfMqC
 4WWMxQv5o+VZRMrGidLqevs0ZcgQnYzRD9aTJWmYsKyd/pitRw06gYQOzCiRtTWUElbD
 GjOA==
X-Gm-Message-State: ANhLgQ2kXIYQhc0ZMtuoPg7dvm6ILI5nDqZq96uhN3Fa4TIupHUpQawZ
 3xGEp9ryqSOCbjZq+mNsxxp05HBw8veohLPyGJMx78b+BcdMqGzltH2ejh1INL1PWdScyfKwlBf
 lLPcK32DGwW3SPdc=
X-Received: by 2002:a1c:6884:: with SMTP id d126mr748363wmc.38.1583193189910; 
 Mon, 02 Mar 2020 15:53:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsuUgw/kqySnK/0qs3q+ayvXPSxNCcXpaLHmY7miydxZEVnjguyEavAt/DYY6EROw6yQUGFuw==
X-Received: by 2002:a1c:6884:: with SMTP id d126mr748348wmc.38.1583193189666; 
 Mon, 02 Mar 2020 15:53:09 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id 90sm30004025wro.79.2020.03.02.15.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 15:53:09 -0800 (PST)
Subject: Re: [PATCH v2 6/9] target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fcb32d87-a012-060c-0e07-af54115ae502@redhat.com>
Date: Tue, 3 Mar 2020 00:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302175829.2183-7-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 6:58 PM, Richard Henderson wrote:
> The function does not write registers, and only reads them by
> implication via the exception path.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper-a64.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index b1a5935f61..3df7c185aa 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -90,7 +90,7 @@ DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
>   DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
>  =20
>   DEF_HELPER_2(exception_return, void, env, i64)
> -DEF_HELPER_2(dc_zva, void, env, i64)
> +DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
>  =20
>   DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


