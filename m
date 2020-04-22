Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662CAC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3035A20781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlZG//br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3035A20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDWR-0008Is-8r
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRDVV-0007VE-5N
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRDVU-0006JP-BA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:25:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRDVT-00068C-Tj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:25:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id u127so1925233wmg.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FpKT1plQlP5s9SgpnD/aSuW0g2cCJXmHnqFc+kt0+Tw=;
 b=VlZG//breWXVLlNlxUanG86DBfWB+uHdZIsxedfY3VI91vhmB0xMmYlIfIbhzf5JlR
 Fu5Wb2Qw8MEtC+J7QxudecyBvJkW31TPiu9kslueuVNI3JQ4bm1mds6bUB+eBo2Se8rh
 bK9fomYK7/SJ5XTm3UMbb16wbmz30YKRBmeyJ8I8kSnsCW88E3UNfVI0cUduuv/URFRd
 EovUbFJ1m/Ltg9qfCazz0tMfLYLs1H2MPPCE9u/pgEHCKO+nLoVHlZBqlPRGu7QEQ5lt
 KyZgtO5Ln6j01jx26wyVKfvs4JOG4eH1iU5HRiC48XRNIKc/ac+3bGOLXPMHDxLCsjTR
 +Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FpKT1plQlP5s9SgpnD/aSuW0g2cCJXmHnqFc+kt0+Tw=;
 b=g58voBNRLS6+HQtlwLuf0+0LDBLitmTn45sRVLYNn3f0Qt14T2bJPZVGsb1vFTXBAL
 TCM3zcv/ifrYenYUrZ6UKq/YtmBtPei0h0oGyWoPKuO2rp27C9Y3ZTCZXxUrBd/k9XFG
 n0I1Hw2/WJ+LHgJG/VhtLQ5xVNDoJdqDZI8U1T0r7dbx+q5U2luqMdMtcPQIfrbnEc8Q
 pWVLskpNsDjmI2fc+oZNzHM+rmqbeKtwsqMTqH2qgB4sTDed4WrbZcdJqo5/deKRpXpw
 QH1SSzS9smy72gRsoePqx77WSp4f9HK/0MBxxMJWJzHSkP8eL6CEcZURK7RruBNUOQuA
 6i6Q==
X-Gm-Message-State: AGi0PubbzYo02bM9XZENlq7RtMaqGhgofGxLPbcr53p/GDPzJTRCVg3d
 bFmQe2P/FLuFknf/iajurXNxUA==
X-Google-Smtp-Source: APiQypJ4aTpupLQ12Cm+CVfC5DqYnZwOgzDXLeQ94/po9tPE6VxQm+/GiDG3Mskygf/Fk7+wlz+iwg==
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr10885495wmi.91.1587554729440; 
 Wed, 22 Apr 2020 04:25:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d133sm8336829wmc.27.2020.04.22.04.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 04:25:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B1821FF7E;
 Wed, 22 Apr 2020 12:25:27 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-10-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 09/36] tcg: Consolidate 3 bits into enum TCGTempKind
In-reply-to: <20200422011722.13287-10-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 12:25:27 +0100
Message-ID: <87v9lrdaoo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The temp_fixed, temp_global, temp_local bits are all related.
> Combine them into a single enumeration.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h |  20 +++++---
>  tcg/optimize.c    |   8 +--
>  tcg/tcg.c         | 122 ++++++++++++++++++++++++++++------------------
>  3 files changed, 90 insertions(+), 60 deletions(-)
>
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index c48bd76b0a..3534dce77f 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -480,23 +480,27 @@ typedef enum TCGTempVal {
>      TEMP_VAL_CONST,
>  } TCGTempVal;
>=20=20
> +typedef enum TCGTempKind {
> +    /* Temp is dead at the end of all basic blocks. */
> +    TEMP_NORMAL,
> +    /* Temp is saved across basic blocks but dead at the end of TBs. */
> +    TEMP_LOCAL,
> +    /* Temp is saved across both basic blocks and translation blocks. */
> +    TEMP_GLOBAL,
> +    /* Temp is in a fixed register. */
> +    TEMP_FIXED,
> +} TCGTempKind;
> +
<snip>
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -116,21 +116,21 @@ static TCGTemp *find_better_copy(TCGContext *s, TCG=
Temp *ts)
>      TCGTemp *i;
>=20=20
>      /* If this is already a global, we can't do better. */
> -    if (ts->temp_global) {
> +    if (ts->kind >=3D TEMP_GLOBAL) {
>          return ts;
>      }
>=20=20
>      /* Search for a global first. */
>      for (i =3D ts_info(ts)->next_copy; i !=3D ts; i =3D ts_info(i)->next=
_copy) {
> -        if (i->temp_global) {
> +        if (i->kind >=3D TEMP_GLOBAL) {
>              return i;
>          }
>      }
>=20=20
>      /* If it is a temp, search for a temp local. */
> -    if (!ts->temp_local) {
> +    if (ts->kind =3D=3D TEMP_NORMAL) {
>          for (i =3D ts_info(ts)->next_copy; i !=3D ts; i =3D ts_info(i)->=
next_copy) {
> -            if (ts->temp_local) {
> +            if (i->kind >=3D TEMP_LOCAL) {
>                  return i;
>              }

I was confused as to why these were not equality tests as being of one
type does not imply the properties of another? But I see the logic is
simplified even more in later patches.

<snip>
>=20=20
>      memset(s->reg_to_temp, 0, sizeof(s->reg_to_temp));
> @@ -1885,12 +1896,17 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, c=
har *buf, int buf_size,
>  {
>      int idx =3D temp_idx(ts);
>=20=20
> -    if (ts->temp_global) {
> +    switch (ts->kind) {
> +    case TEMP_FIXED:
> +    case TEMP_GLOBAL:
>          pstrcpy(buf, buf_size, ts->name);
> -    } else if (ts->temp_local) {
> +        break;
> +    case TEMP_LOCAL:
>          snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
> -    } else {
> +        break;
> +    case TEMP_NORMAL:
>          snprintf(buf, buf_size, "tmp%d", idx - s->nb_globals);
> +        break;
>      }
>      return buf;

Random aside - if tcg is firmly staying part of qemu we should consider
modernising some of the string handling here.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

