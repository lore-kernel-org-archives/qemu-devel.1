Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FAFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B55D206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSjq6J8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B55D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZWr-0006xb-UL
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixZVK-0005cJ-Mj
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixZVJ-00020q-0a
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:50:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixZVI-0001zE-NK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580489447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbZ8lkmxjwttVdO+ZOcvL7+Qx6mj4s8HQ7fAQ8X7O3g=;
 b=LSjq6J8gzgJE3KtNOJ22dcT12TlAMIOKHP6u+bSQX4QjTZ7+qOQO7ahHyh5GH9j0WR0f/m
 Gp8ySH2awaKISF6+t20eHOqi8AYUAVNho1EKiR0LXx84wigs4JlpQqsF+EBtv+3q0NLq/M
 Z9LDU//iWJwHkhjBtBIRHyD0mNUMF48=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-t8vZrjcmOtmw2UfFJfhQjQ-1; Fri, 31 Jan 2020 11:50:45 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so3596657wrm.23
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 08:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JQoe4N098i7u193ANSArP88zvLs8uh35IfTnMBeOztY=;
 b=CA2YSsYBUHKHBJ9trKwFzhtgKHb0fWQ/5rU37vGDSQZpIHoMtdfXMuseEPojsxvAyd
 TLuZmYW3SI7lXP5XhmFnXyzb+f9z4I/fHCn9TBObhE6vRS2svPcN4BxULYkkiZEduJ5b
 zvxZIF2hltGf9sEnEiG4mUDiqh5gWDHyUMREOZIIXDhRMXKAyy/q8mFCm37KBGnuIVeK
 7QeRBDlNqrlCuOkN3hWMCBhaXJrsssT4kxiIwkNUXUV1zJdh5R0Xy32mDp1JIU61W+H3
 MKAka33Qm/gXYhVZF8Yl+jsO+ssfW9tioQ+FA8khVXZV83tbKg8lvd9FGXAKTX3jA1ap
 frHg==
X-Gm-Message-State: APjAAAUm9eGWENX1rzMSjM35Ti26aABx9nKCALhT42dPTaYrEN0iOzag
 Bp9QchGyQQK3z812ye38iZzRRJuSO3uwzZOCh9TpAmF8bJAs9NKwzAl/+pq8hiztVpIevsc7nnf
 JObuppPf2OaYSuSk=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr12878449wrt.362.1580489444463; 
 Fri, 31 Jan 2020 08:50:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfKxlFhlnYtYd8HMppVYuUqxqjAiziIHOsjpTtz1jVuyMFp6UgT1T6qoeuVXUtaRbG5dJwIQ==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr12878435wrt.362.1580489444274; 
 Fri, 31 Jan 2020 08:50:44 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t1sm12058143wma.43.2020.01.31.08.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 08:50:43 -0800 (PST)
Subject: Re: [PATCH] target/arm: fix TCG leak for fcvt half->double
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20200131153439.26027-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <86de4318-8937-c228-973e-f88b41248d03@redhat.com>
Date: Fri, 31 Jan 2020 17:50:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200131153439.26027-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: t8vZrjcmOtmw2UfFJfhQjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 4:34 PM, Alex Benn=C3=A9e wrote:
> When support for the AHP flag was added we inexplicably only freed the
> new temps in one of the two legs. Move those tcg_temp_free to the same
> level as the allocation to fix that leak.

Probably too much code refactoring :/

>=20
> Fixes: 486624fcd3eac

Maybe:
Reported-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/translate-a64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 96a5be2b372..766a03335bf 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5778,8 +5778,6 @@ static void handle_fp_fcvt(DisasContext *s, int opc=
ode,
>               TCGv_i32 tcg_rd =3D tcg_temp_new_i32();
>               gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tc=
g_ahp);
>               write_fp_sreg(s, rd, tcg_rd);
> -            tcg_temp_free_ptr(tcg_fpst);
> -            tcg_temp_free_i32(tcg_ahp);
>               tcg_temp_free_i32(tcg_rd);
>           } else {
>               /* Half to double */
> @@ -5789,6 +5787,8 @@ static void handle_fp_fcvt(DisasContext *s, int opc=
ode,
>               tcg_temp_free_i64(tcg_rd);
>           }
>           tcg_temp_free_i32(tcg_rn);
> +        tcg_temp_free_ptr(tcg_fpst);
> +        tcg_temp_free_i32(tcg_ahp);
>           break;
>       }
>       default:
>=20


