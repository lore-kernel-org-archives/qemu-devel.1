Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD648C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B99D2065F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XugWkhmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B99D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDeu-00007m-Ri
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtDeH-00088j-Ro
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:14:21 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtDeG-0003og-GH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:14:21 -0400
Received: by mail-pg1-x542.google.com with SMTP id g67so21077668pgc.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cid7R43/vo1+Go/BsuC5NsVB+xssapvtgKODVwJkca4=;
 b=XugWkhmAMJnLB0w0Z1A7aJ6cZqV5bWdeyJGQH0k7H7wc6GT5ZM5Eof3ZoryDRQfSde
 jA+qsCT7PboKZlfGNGI0lLOnu6nhpBRux0f8Z8XTdLfERraqVLVOl3OvC5j6VNhyFVuE
 p+zbUeSzgZ2AS6NqGkSl683G/mAwCwDg5V2PVr7aVr/+BN35r3kPKcinuQ0P61YQ4wS9
 B62secuRkpRPZB2RFKua4pAXwGx8qTMeUqgAY48rb/BHJEePLG0zqb2l8T6PrgFNqOcE
 mQj0SsRJ+NJWi0ROdhZLtoz3M3l+qHnfqIimtVzogsNikHvbISaFBeB1JIucHNCVtTTW
 y2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cid7R43/vo1+Go/BsuC5NsVB+xssapvtgKODVwJkca4=;
 b=NQyiQmtBmBDREC6eqDKu4hl+/0vIP0StDY5bWRAKs/7K5D1eP/dP1ki4dIOgov+P3w
 PUI5aWKt1gVcTGm2+5pHtVbuY/rF6SyiksOodKBoolWcJSPjMsoA8y1O6sGihjOsIZDE
 iexV5HxCCEkxIllWj2fMm8KIZBtwUAtfabZsohUeZyZ/AHkWkf4mxTN+idQCJsXNtbEg
 AG/JqoJC+GTmMYhugw8QETzPhbNFWnHG/EgEI+TM6raieiLXyyjViCsRIg7HYhhOWgEv
 ec9tk736Y6ayY2aepN7wObcoeIHAdNQwjq7wYZ+JlHf5J7L9W0ltgQ/HLTYKcOfZ83ML
 qXaA==
X-Gm-Message-State: AOAM530uX8BcFMfhWDv0cTOEoLKsYo21aYEvgmM1SwmzCuhYqOUXr4cq
 mHO3UJ5aSChaX8vcWWpNv1xwMH6M0WaZaZJ/n8Q=
X-Google-Smtp-Source: ABdhPJwiViA+WfWzTyX1jqqM4ekTiyTL3R398FjqReEJW1tWmrdDYDx849CrBGei8+V2TXIVy+tsx7785YrhUz45Eec=
X-Received: by 2002:a62:7657:: with SMTP id r84mr52755222pfc.130.1594228459090; 
 Wed, 08 Jul 2020 10:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-6-jcmvbkbc@gmail.com>
 <2f591058-a694-81a6-ee1b-a426b7402ae9@linaro.org>
In-Reply-To: <2f591058-a694-81a6-ee1b-a426b7402ae9@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 8 Jul 2020 10:14:08 -0700
Message-ID: <CAMo8Bf+reKtL-osVjQkQHhXf+0FMhUX-Qa770X7j5XuvCM5znA@mail.gmail.com>
Subject: Re: [PATCH 05/21] target/xtensa: support copying registers up to 64
 bits wide
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 9:14 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/6/20 4:47 PM, Max Filippov wrote:
> > +                if (arg_copy[i].arg->num_bits <= 32) {
> > +                    temp = tcg_temp_local_new_i32();
> > +                    tcg_gen_mov_i32(temp, arg_copy[i].arg->in);
> > +                } else if (arg_copy[i].arg->num_bits <= 64) {
> > +                    temp = tcg_temp_local_new_i64();
> > +                    tcg_gen_mov_i64(temp, arg_copy[i].arg->in);
>
> This shouldn't compile.
>
> You can't assign both TCGv_i32 and TCGv_i64 to the same variable.
>
> What's going on here?

temp is a void pointer, as well as OpcodeArg::in and OpcodeArg::out.

-- 
Thanks.
-- Max

