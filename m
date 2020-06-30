Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EBEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1A2206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KquTRWTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1A2206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHSN-00034h-Pi
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqHRo-0002b5-64
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:41:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqHRk-0000l9-Jp
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:41:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id g75so19049213wme.5
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Uc8BgwVKmo/xiTqucrMsdF6YzFJZxnECF+PKF9Hu+ko=;
 b=KquTRWTa/8RHyLCLIzohLWmFbujQa718/uAt5KJQX35ZrETN5IriwAQE9Ff9PKQ/3Q
 gsI69qHPTSdkAgdyzDDxzpcIfiea7P++QiC5zcTF2A/hiM8VXdd6tcE06F6nMl93Szu/
 iatdjzkBU0pnTg8ocWw2TUeVa3vl8nokESeM5bFBXu9lzUYbRFnmx+GLFOAqjCWFn+HB
 kSbz0EkMhtbhldTJjnlBbqlErnoTJsjRckjig2onsyYDQE+dkCNf6CWGPkuXD1v+x0AZ
 6BXlqpiEuJ/EvZ8SRH3plizI6L3+eX+prUtcV2EpLe6juVJwZgMi5LG5GHS9iMZluFvj
 p9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Uc8BgwVKmo/xiTqucrMsdF6YzFJZxnECF+PKF9Hu+ko=;
 b=G1KlQHsAd9IUxH38Zh8VpAwukK7aVUksAnR3EUctIxROu2tU/SkKkLDiucXjZ8F4nR
 2P6LHOBHZwfRGYUd3/0PEMRcJF8QqKTjQ2XsPKox38Sdh+3oe0fKM+hC7sdMCGPYPLMx
 Z3OwFd3kaID8SRxk61BcJeS/oNE34nuusv9UTDtF6qETB73JYA5QShWFB/dJU+L4vgsA
 n4IzBDw6UoT4wRc9XZjyUGmgIfm4cgxYkSTPJKwp7HAMAQxe1AMKDMDl2PQjRXQfZ16Q
 Ci8s2D3GTC/IJL6Zvb5ihpj8kdWAod1TQHsnTcCG32OXy7lqN7iehyNCh42zCQdh8hWN
 0cPg==
X-Gm-Message-State: AOAM530zx3+J/DkQrLYX8EpYcXa41Y7qlfCBNF6Ko7xdQqnQWIQAUTcn
 doQkw5d8ySTzxUZM0bMWq/sYiw==
X-Google-Smtp-Source: ABdhPJy+hsmgxnF5Awq7JP/4Fomz2Xa4TM1m1kq7O2ZJRvWxEwUroLUEODQwmARbhjCe9vrKB5yZuQ==
X-Received: by 2002:a1c:e285:: with SMTP id
 z127mr21956002wmg.162.1593528074198; 
 Tue, 30 Jun 2020 07:41:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n125sm3616598wme.30.2020.06.30.07.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:41:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEFB91FF7E;
 Tue, 30 Jun 2020 15:41:11 +0100 (BST)
References: <20200630103448.22742-1-alex.bennee@linaro.org>
 <CAFEAcA_vmcPq=LhEd2d5Kxyg-3q-VjYVa906EUempkXZ0cRXUg@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] linux-user/elfload: use MAP_FIXED in pgb_reserved_va
In-reply-to: <CAFEAcA_vmcPq=LhEd2d5Kxyg-3q-VjYVa906EUempkXZ0cRXUg@mail.gmail.com>
Date: Tue, 30 Jun 2020 15:41:11 +0100
Message-ID: <87y2o4r4zc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 30 Jun 2020 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Given we assert the requested address matches what we asked we should
>> also make that clear in the mmap flags. Otherwise we see failures in
>> the GitLab environment for some currently unknown but allowable
>> reason.
>
> Adding MAP_FIXED will mean that instead of failing if there's
> something else already at that address, the kernel will now
> silently blow that away in favour of the new mapping. Is
> that definitely what we want here ?

Hmm maybe not. But hey I just noticed that we have MAP_FIXED_NOREPLACE
(since Linux 4.17) which says:

   This flag provides behavior that is similar  to  MAP_FIXED  with
   respect   to   the   addr   enforcement,  but  differs  in  that
   MAP_FIXED_NOREPLACE never clobbers a preexisting  mapped  range.
   If  the  requested range would collide with an existing mapping,
   then this call fails with  the  error  EEXIST.   This  flag  can
   therefore  be used as a way to atomically (with respect to other
   threads) attempt to map an address range: one thread  will  suc=E2=80=90
   ceed; all others will report failure.

   Note   that   older   kernels   which   do   not  recognize  the
   MAP_FIXED_NOREPLACE flag will typically (upon detecting a colli=E2=80=90
   sion  with a preexisting mapping) fall back to a "non-MAP_FIXED"
   type of behavior: they will return an address that is  different
   from  the  requested  address.   Therefore,  backward-compatible
   software should check the returned address against the requested
   address.

So maybe that is what we should do?

Now you've pointed that out I wonder if we need to fix
pgd_find_hole_fallback as well?

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

