Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D47C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ABE20756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ABE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYD8h-0005dg-Oo
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYD6e-000428-Lj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:57:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYD6d-0000FY-5u
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:57:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id m26so3273331otk.11
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6ZmNwh4hQ5eVxtVo6X4dtVmsf/33FBU2M+wj/YOAxtk=;
 b=ExUHZ/byk0bXNDCd15L2XNxCYOq+pBYD6yHKRsBmDSYFIAkNOwfuxVq+Na8+AjGUJn
 v58amOTdMVDwWnCZHnc/KY1OXWGUAUpbPRWcKi7f3g/btD51Xk1wvxLVmW25loEOMwu1
 n0eppQkMvcbc/wF/4SHpg+h9GfnJv9pg6H4qck3uOD8hKq9Gi9rk3dttDecZliQ5F5h6
 T7kaPJWwRRsj8OD5A/anxoMLZjgNoIiQWRX4cHjoe3eI2AzPLtnrM69NKtPc3zPGCLC5
 PRomhKQfzcLPCQQq14yFgvV8xZlk8MZyUsaB/82MeRDIqMDOer/dfZTtbBj9t52NwGIn
 xoiA==
X-Gm-Message-State: AOAM53116l1zCvDt8OaKjiiszz5qq7T7sJ4DTgTAft4RHGikAFmLdWa+
 FIfX7TOpFxEQk6lFAl/Kk/Yk+vkHHC0mPoeosyCv70Os
X-Google-Smtp-Source: ABdhPJyAEsODndfljb13mfJhgdkbY1rb2Wkp2V+es2pdjv84j2yS4mkgwjPREGxx4C94xGZkCrVPeTooUAS6YWD3+kk=
X-Received: by 2002:a05:6830:400d:: with SMTP id
 h13mr4415241ots.371.1603997821704; 
 Thu, 29 Oct 2020 11:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201029185506.1241912-1-f4bug@amsat.org>
In-Reply-To: <20201029185506.1241912-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 29 Oct 2020 19:56:50 +0100
Message-ID: <CAAdtpL4-qCoUXMXCuS-GXQJO_ab--dWSDqgdcfZMdjSptHQwxQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] util/cutils: Silent Coverity array overrun
 warning in freq_to_str()
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.68;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ot1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 14:57:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Luc Michel <luc@lmichel.fr>, Alistair Francis <alistair.francis@wdc.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch aiming the 5.2 release.

On Thu, Oct 29, 2020 at 7:55 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> The biggest input value freq_to_str() can accept is UINT64_MAX,
> which is ~18.446 EHz, less than 1000 EHz.
> Add an assertion to help Coverity.
>
> This silents CID 1435957:  Memory - illegal accesses (OVERRUN):
>
> >>> Overrunning array "suffixes" of 7 8-byte elements at element
>     index 7 (byte offset 63) using index "idx" (which evaluates to 7).
>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  util/cutils.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/cutils.c b/util/cutils.c
> index c395974fab4..69c0ad7f888 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -891,6 +891,7 @@ char *freq_to_str(uint64_t freq_hz)
>      double freq =3D freq_hz;
>      size_t idx =3D 0;
>
> +    assert(freq <=3D UINT64_MAX); /* Max 64-bit value is less than 1000 =
EHz */
>      while (freq >=3D 1000.0 && idx < ARRAY_SIZE(suffixes)) {
>          freq /=3D 1000.0;
>          idx++;
> --
> 2.26.2
>

