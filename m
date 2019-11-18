Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2AC2186D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnLKw084"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2AC2186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlDz-0002BQ-JV
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWlDL-0001lo-QR
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWlDK-00059J-Ko
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:53:27 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWlDK-000595-AQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:53:26 -0500
Received: by mail-oi1-x242.google.com with SMTP id j7so16137966oib.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jt2pmtbnHSSvKh9oY09UkMOR6NpIfeUaFWM9b0hGcT0=;
 b=LnLKw084hQFD9gVyLGui7IkOZRCHRSRVvVXnrINTSx3mk0kSFkMtIsZSBcjkBvrCct
 GH2pyBaWeurK6t8MHTDwZ1HeFtpe0rokjfCW6Vk4trTIj4TzYJQLhGqTf4yPuZLBe02L
 vQ/7At+Mcrqn3i7Q0yX6uLHm5BRacSQticXJCxK9Gff0DQNgXzsClZJufGcOInphzsm3
 AaM7yf/81Mwm12ykZcDJqqlWymQhp0XWlX/5DUQgas91as5C2IOEILTHWbgKqw+f5xUv
 CJotcpNN27Ky0/7ulvx/Po19j/qH153Lh9AjyOtfDsvZvyF3cB6rcNRZtwvizSiiG4YI
 16Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jt2pmtbnHSSvKh9oY09UkMOR6NpIfeUaFWM9b0hGcT0=;
 b=XfYY3CLvbb3BOjAfpkCuib0WU5bvsAyRUMJEbK0VNek3wYaZ2+aY1DN9F9mqvLyCU+
 /4RND8gIeXP7Rm/FvnsOpu99nfF1cmzcGDhprDACxUxrpzjVzdYDSMccUw2v0a5/gtkG
 44O941yejNS2xSac7LsBkc2OVT3Z8bABqTxwfcNrG9NOQssfl5rmiWWlpY1iuX8DHGGy
 GWfgO0xCaN+k/6YEkw1mxhpheeYF5Zi37QadkYq5WcT38lnJWlCwvZacfQwmNP2JLxG0
 3cOpq/iGqnAWIgDeDeUkIcOXSK38ChBZpNlqI8V2Jz/WjR09rTwq9bOlKK/7FSGHB0lQ
 kJPw==
X-Gm-Message-State: APjAAAVnGsWcsmdyn9J+dKVFmtthWnDSECMsPYMEcNt2vQjU6byQuYL0
 ELGOpjsf4piOxNvd/fhgmv8j2a37hHwQLjgFrSXURA==
X-Google-Smtp-Source: APXvYqznBRM8vMErPB4uy4p/aqjyD/PEENAK5zR0ngIwRfA1C3hJj1r04WQLMZ9JNakFj8fqA2FgVn7OUo54zvgxj7A=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr158624oig.48.1574099605298;
 Mon, 18 Nov 2019 09:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20191117090621.32425-1-richard.henderson@linaro.org>
 <20191117090621.32425-3-richard.henderson@linaro.org>
 <CAFEAcA8FdT8R4_nwUQ1QLBMBST_K0xuHABER3f8kt6JY1vYojw@mail.gmail.com>
 <f8071794-cb5f-d987-0e7d-11a70ba4d2bc@linaro.org>
In-Reply-To: <f8071794-cb5f-d987-0e7d-11a70ba4d2bc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 17:53:14 +0000
Message-ID: <CAFEAcA_qF6e_4_7syRVomag31pMgX02=R7JJ7a5pW_r+MU-aaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Relax r13 restriction for ldrex/strex for
 v8.0
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 13:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/18/19 2:10 PM, Peter Maydell wrote:
> >>      /* We UNDEF for these UNPREDICTABLE cases.  */
> >>      if (a->rn == 15 || a->rt == 15
> >> -        || (s->thumb && a->rt == 13)
> >> +        || (!ENABLE_ARCH_8 && s->thumb && a->rt == 13)
> >>          || (mop == MO_64
> >>              && (a->rt2 == 15 || a->rt == a->rt2
> >> -                || (s->thumb && a->rt2 == 13)))) {
> >> +                || (!ENABLE_ARCH_8 && s->thumb && a->rt2 == 13)))) {
> >>          unallocated_encoding(s);
> >>          return true;
> >>      }
> >
> > These cases for r13 are indeed no longer UNPREDICTABLE in
> > v8A, but they are still marked as UNPREDICTABLE for v8M...
>
> Ho hum.  I knew I should have looked at that doc as well...

I would like to get this in for rc2 tomorrow, so I propose
to squash in changes to give the following result (basically
turning the ENABLE_ARCH_8 checks into checks on a new bool 'v8a'):


diff --git a/target/arm/translate.c b/target/arm/translate.c
index b285b23858e..4d5d4bd8886 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8927,15 +8927,17 @@ static bool trans_SWPB(DisasContext *s, arg_SWP *a)
 static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
 {
     TCGv_i32 addr;
+    /* Some cases stopped being UNPREDICTABLE in v8A (but not v8M) */
+    bool v8a = ENABLE_ARCH_8 && !arm_dc_feature(s, ARM_FEATURE_M);

     /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rd == 15 || a->rn == 15 || a->rt == 15
         || a->rd == a->rn || a->rd == a->rt
-        || (s->thumb && (a->rd == 13 || a->rt == 13))
+        || (!v8a && s->thumb && (a->rd == 13 || a->rt == 13))
         || (mop == MO_64
             && (a->rt2 == 15
                 || a->rd == a->rt2
-                || (s->thumb && a->rt2 == 13)))) {
+                || (!v8a && s->thumb && a->rt2 == 13)))) {
         unallocated_encoding(s);
         return true;
     }
@@ -9084,13 +9086,15 @@ static bool trans_STLH(DisasContext *s, arg_STL *a)
 static bool op_ldrex(DisasContext *s, arg_LDREX *a, MemOp mop, bool acq)
 {
     TCGv_i32 addr;
+    /* Some cases stopped being UNPREDICTABLE in v8A (but not v8M) */
+    bool v8a = ENABLE_ARCH_8 && !arm_dc_feature(s, ARM_FEATURE_M);

     /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rn == 15 || a->rt == 15
-        || (s->thumb && a->rt == 13)
+        || (!v8a && s->thumb && a->rt == 13)
         || (mop == MO_64
             && (a->rt2 == 15 || a->rt == a->rt2
-                || (s->thumb && a->rt2 == 13)))) {
+                || (!v8a && s->thumb && a->rt2 == 13)))) {
         unallocated_encoding(s);
         return true;
     }

thanks
-- PMM

