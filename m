Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305AEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE2B20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/WCRyRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE2B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqAjv-0003os-2g
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 03:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqAiu-0003L8-1R
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:30:32 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:35079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqAis-00055k-AI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:30:31 -0400
Received: by mail-lf1-x12f.google.com with SMTP id t74so10764842lff.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+KrQvNzKc9YSWzQ0AdGIBTSgjB2SMRu8sgBGWFvEcu0=;
 b=C/WCRyRdrhmZ3jJ/GfDk8X0yJK8lG8S1jxa4zqcCofEhelpld4crFOcsKlQaM3dXl8
 622DrBwNzkRBSjm5dT/4SbuWjwnz9WWJ8bEBLvnKRJzkP6W5iYncKxalhDHsozBkGytz
 Va0pQpoG5O0Qwko9uONiUZ0zIrSpeN1Kno8ONRkTHsZDmLAm78NB/8C3fYKGno7gNP7l
 nELkjyzHevPtTUwtu/UrsUyEUrOyU6Uj7gpTpAPmVUAMAKyIhQPdJ42EPLLMMMmudmMk
 GBYfQYBf3k9GtWM+O4euPXx5sLj4dO9/ONk0AV1j8NBT3CpNqHWCpeMoWjzf0h9xAa6Y
 JLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+KrQvNzKc9YSWzQ0AdGIBTSgjB2SMRu8sgBGWFvEcu0=;
 b=qBwP5RAlkIVapdWwRongT4/8nAkt516bsSTz86ZU901Q6PK6KWYXQI1NTAd/TszVoh
 uFSGFCxLJer4TFUVLn/f3jl1zt3XSSxoH61VVWneJTQML260HBoVA9X1TWJF18SKHbVB
 ebqstciSGttuZVssQ8J//OldsYy5yvdujaNYS/7+C2bvNxUArZVFmKhblK0HQCAC4vNX
 uu9qgHmvk0HR2mcRl9Se58dn4+lgdnRoU3ySXCernkNEBvCzOH0oIRDupq/vyskgK0KE
 WXSJFQCqcmxQO84knwKNM2Y4puILbs4rim1vY1s7CDZSzRJt/lDStGVkSYNEhwQhkzUv
 wlZg==
X-Gm-Message-State: AOAM5306pQCOJCRuZx7wjRCgvvjSBlS4+kBJrtlCI9N14sXvx4NWjGig
 Idik1PdT2ev+aUi5iQM5CKYDhcWVWX3Kr9coE94=
X-Google-Smtp-Source: ABdhPJzTBP5cQAeuNndWXoUrK/LOl9Y1mOH94bcy4plHkx4MWwI5d9fk5NSqKhpP9W+mDdAnyogN4TDcgR+JsVwxUVs=
X-Received: by 2002:a19:815:: with SMTP id 21mr11013845lfi.119.1593502228407; 
 Tue, 30 Jun 2020 00:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <CAE2XoE-dOHGtJO5f0xXA7r4hEeL5LDOPB1TDNPjWNC+hf9Qyew@mail.gmail.com>
In-Reply-To: <CAE2XoE-dOHGtJO5f0xXA7r4hEeL5LDOPB1TDNPjWNC+hf9Qyew@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Tue, 30 Jun 2020 09:29:49 +0200
Message-ID: <CALTWKrVwRhQEEjMEq444fNgBp1Dv_XyJAV7suXCEmeS40raaEQ@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: luoyonggang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x12f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 7:59 AM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com> wrote:
>
> Wonderful work, May I reproduce the work on my local machine?
>
> On Mon, Jun 29, 2020 at 6:26 PM Ahmed Karaman <ahmedkhaledkaraman@gmail.c=
om> wrote:
>>
>> Hi,
>>
>> The second report of the TCG Continuous Benchmarking series builds
>> upon the QEMU performance metrics calculated in the previous report.
>> This report presents a method to dissect the number of instructions
>> executed by a QEMU invocation into three main phases:
>> - Code Generation
>> - JIT Execution
>> - Helpers Execution
>> It devises a Python script that automates this process.
>>
>> After that, the report presents an experiment for comparing the
>> output of running the script on 17 different targets. Many conclusions
>> can be drawn from the results and two of them are discussed in the
>> analysis section.
>>
>> Report link:
>> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-=
Into-Three-Main-Parts/
>>
>> Previous reports:
>> Report 1 - Measuring Basic Performance Metrics of QEMU:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>>
>> Best regards,
>> Ahmed Karaman
>
>
>
> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo

Thanks Mr. Yonggang. Yes of course, go ahead.
Please let me know if you have any further questions.

Best Regards,
Ahmed Karaman

