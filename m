Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3931AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031C62332B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3KoGYtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031C62332B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnExr-00054c-4j
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 01:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jnExD-0004Yj-0A
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 01:25:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:47002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jnExB-00073j-HK
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 01:25:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id u128so7644530pgu.13
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 22:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b8RKa2xbK1fqHB2ZEJtNpRX86/5l/Job4sglHpgzDDw=;
 b=E3KoGYtWnBECWJcdjvWQ46+2N+8SQN2OBbQTIKjKO2/BjWanWIbuJq7IkqDZvLTQs6
 vljTRJYTnwbo7ZmOzSPcl9mNTXPLJTxuktAnHdcmLdFoB+zmhLpwxDKqwUsp4U2ZjGfi
 lJSbwMUisTJ19Rze9uoj6qhg1wuChVIQzyIcHAHtlSrbRk30uAKPC1YcKYSaGJbIT9gV
 8zQ8SYXLaPKA+j59wzomGz4HIhuV9uCBSzyLg7/BtSSFeWzKrHEW6deM2GkAACvqEZI9
 inN27KKxEZO9g/76laki7iJen2+Kleki4Ro9m/y7DmCYnAOJXejxJX0SrcLl+oPdyrny
 hd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b8RKa2xbK1fqHB2ZEJtNpRX86/5l/Job4sglHpgzDDw=;
 b=hE+WLEUMF7Bs6evHvFieoqE/SRRQnju833fWeTV0R1qAXn8YiVGfZBX8Xs0p1E13Hr
 5hBI9yJB+yhvxXXCVxUe8BVazIUmkV7kxsDxnVziRuFKPlSvrHmbbKiW5ZrrNQ26i63K
 53DMazSfvBeJ5zPz8IAh5QV4Hc0EnV1ra1jKM6UCaGMrawHFEhsVRoMKCry6P6BWGRo4
 ecgcs02UQZcDbBg3gqjQpvcrAuK2503h/TEnvmsV4upjz8MgwgiudVHilug6nUMJO29W
 GoGgGUkwEtgivRT/QvLflA9MddOPhK+iJ+EkxPG9p9iiLOI8bR3aLIS9G6zoWs1pgQQS
 xx0g==
X-Gm-Message-State: AOAM53001O5FqcAES800soD4VodPggHYwbLu/f87iFx0cdnA/ZwkZ+lM
 4MOjI5uMQsveoHLjbtfOnNxcS1O05xrI+i4ILvw=
X-Google-Smtp-Source: ABdhPJxLFQCirtieftZYOpWS+4ZsrlkMAjmd5Qs0PqgRMeuyISLOWMNd+meSdXVeC/KsYHrvUNIXKer+TwbYD/YjG1A=
X-Received: by 2002:aa7:91d4:: with SMTP id z20mr17724253pfa.153.1592803507654; 
 Sun, 21 Jun 2020 22:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
 <CAFEAcA_OfF2pBPCv7Wj+u4Rm3fjtApzfiE9WYhiGeEzffd60Kw@mail.gmail.com>
In-Reply-To: <CAFEAcA_OfF2pBPCv7Wj+u4Rm3fjtApzfiE9WYhiGeEzffd60Kw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 21 Jun 2020 22:24:56 -0700
Message-ID: <CAMo8BfKTMfZY_2RBncoWpZHcLQ7ug+LPxnUaS9pHe8AiAQL-0w@mail.gmail.com>
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 10:05 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> I've just sent a patch that removes the target/arm gen_io_end() calls.
> I had a quick look at sparc, xtensa and ppc, but they were too complicated
> for a quick look to be sufficient :-)

I've checked the xtensa translator. The only gen_io_end() is for
opcodes that end TB when a full instruction is translated, because
they can change active interrupt requests. So it can be removed.
I'll send a patch.

One instance of gen_io_start is for the rsr.ccount opcode that reads
current cycle counter that translates to reading
QEMU_CLOCK_VIRTUAL clock.
Looks like this adds one more case to the
following list:

> As I understand it, the definition of "I/O insn" is anything that can
> either:
>
> - affect the icount deadline (e.g. by setting or removing a
> QEMU_CLOCK_VIRTUAL timer)
>
> - interrupt the current translation block with cpu_loop_exit,
> cpu_restore_state or similar.

-- 
Thanks.
-- Max

