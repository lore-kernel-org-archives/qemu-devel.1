Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B534C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AA02053B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mwv8t1LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AA02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0S5s-0005vX-6h
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0S5G-0005Uf-4d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:04:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0S5E-0008Eu-FN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:04:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id f18so18844252wrs.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XNRbxDXYqtKxJzkFjKkOZyGUXhNdT8PDRiOUBlQ+pjI=;
 b=Mwv8t1LBr0X/K6s/jx+RUloS04NjuPWp4r7MxymPuzc4Qj1Q9FoTV0B3n/o8ZNf4p5
 +S/5meJ0Yc1Y3afvzhr+NMapZhY4EA7otitVd00YCPWt4gC3nSnuQNt1+YWKZhrevPs/
 lEEre/O1dHi9aOE85f4q7Qz4TLT52N1PEYlZYOaVc5/jQzIeV3lSZOPg2cjCNhBdSb99
 uH1bJzOHaQG1eoWb5SIc8RrkH5GLM8rnkRwu1YGRRkvmPVWRjyWytzpjPpaPYj1GeL6e
 2vvqXFwMBKoYYQ5lKKq5m0V+fz3e9tNB+qSuB06OKsalmSTQxKjc1c3sfkKH85URDqR7
 36Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XNRbxDXYqtKxJzkFjKkOZyGUXhNdT8PDRiOUBlQ+pjI=;
 b=jjot6lu7gRuvz+7ae3He2lnZBS8kh9bXADTRPZINzV+8i4JGLX0krdoDbh9lBbTfVl
 BuYWtml1pMI22ISgIpsGKGFAAIFHf98SE2vQ7TQhfgqYcpp8ZDMXMLhnvswp5KYciVz+
 yCbNLoCABgJIZvpNKhy/6MO79dZN54M05i/5Pxy4z7Z0O0o8mlUmvM3BJYLN22KE94r6
 n7Ds1toqVoRVIRR8U28xPo/8zdcdgqIWz6MXJHDqJ+nHwpK8AxtprAXVrB/fmCTjA2hR
 be04HEv8zy43Ppltu8t8VzHYXO7u0RUK61A9G2RtdlaMePEaEAxnwyHlmlLRR8aNo1lN
 PJ2Q==
X-Gm-Message-State: AOAM530AwQscalL4cieqWquA9NUE0wZNdOi2eRI09tYYVqLu2YlrSWRA
 hV9VMWTRl7B1MZAl/5Z2W7uEqw==
X-Google-Smtp-Source: ABdhPJw5CGwNi/zE1N26ji0as1Oom0kVdowrmlzIkwWBseiEy8vKUfxWvyuizcoUcXpV34SQ+3kz4g==
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr24557700wrr.426.1595952242441; 
 Tue, 28 Jul 2020 09:04:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n12sm18734747wrg.77.2020.07.28.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 09:04:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 17E601FF7E;
 Tue, 28 Jul 2020 17:04:00 +0100 (BST)
References: <20200727122357.31263-1-alex.bennee@linaro.org>
 <20200727122357.31263-9-alex.bennee@linaro.org>
 <CAFEAcA8oTrHUzOF5tcqVDNtPWdoG0Yz0GKb2=JuT3O5h5g-YQg@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 08/16] linux-user: don't use MAP_FIXED in
 pgd_find_hole_fallback
In-reply-to: <CAFEAcA8oTrHUzOF5tcqVDNtPWdoG0Yz0GKb2=JuT3O5h5g-YQg@mail.gmail.com>
Date: Tue, 28 Jul 2020 17:04:00 +0100
Message-ID: <87r1sv39u7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 27 Jul 2020 at 13:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Plain MAP_FIXED has the undesirable behaviour of splatting exiting
>> maps so we don't actually achieve what we want when looking for gaps.
>> We should be using MAP_FIXED_NOREPLACE. As this isn't always available
>> we need to potentially check the returned address to see if the kernel
>> gave us what we asked for.
>>
>> Fixes: ad592e37dfc ("linux-user: provide fallback pgd_find_hole for bare=
 chroots")
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20200724064509.331-9-alex.bennee@linaro.org>
>
> Hi; Coverity thinks this conditional expression is suspicious
> (CID 1431059):
>
>>              if (mmap_start !=3D MAP_FAILED) {
>>                  munmap((void *) align_start, guest_size);
>> -                return (uintptr_t) mmap_start + offset;
>> +                if (MAP_FIXED_NOREPLACE || mmap_start =3D=3D (void *) a=
lign_start) {
>
> because it's performing a logical OR operation where the left
> operand is an integer constant that's neither 0 nor 1
> (it's 1048576). What was this intended to be?

It's 0 if the header doesn't provide it. If it's !0 we don't need to
check the address because it should have been in the correct place.

>
>> +                    return (uintptr_t) mmap_start + offset;
>> +                }
>>              }
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

