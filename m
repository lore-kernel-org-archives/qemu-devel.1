Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C096C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4DF21D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1fOVukw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4DF21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDKP-0003Gf-MI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJDFq-00008P-TW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:04:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJDFo-0001CG-M1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:04:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id x14so4985767wrl.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=phlBynLnLto1w5JGDpMDEHuQUGh8TJy8AigmmV345HI=;
 b=V1fOVukw7JROHxzGmlnS883ct4Q5JWHjXO7lZE9eMS+t72VMukudC30NrOABC5x7ru
 7Ur7/PWPO8YNjdLf8ENB690GsczuXjdSeJDPQ/WQMYGgkQuaDxVkHrDKqcYMUJNrW7zP
 OKZN0kddViEtc/dJpkpzFsW2wYgBMReW53ge+yxDFcVEkesp/NClQjiJsIPgWKgb7CTb
 KNuvTtm5SysDv51HzRSIa5uy8GucWC5A5JY3/WFBZBGeMTMVcvJ7GJ67BZ7IoYDB6ZCW
 r9+a8fByumdObJgZKC3bCyLzqAkFB7FJSav4sk152SNSF9RtSKh+zfNONyIspMxSVbzU
 CTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=phlBynLnLto1w5JGDpMDEHuQUGh8TJy8AigmmV345HI=;
 b=L3S4LrBMi0yEqPjh0BTcKM3AnkjG3tt7U1qxHUAlWVt6uuLRW37dNC+/+6ZnVUkhEY
 Yt0uNbFesI/t06K7PpT9po8dVm9qF6CkND6VzxSfy7c9NEuUt3Yv0HbVJnx+cjIt/unh
 G7L2cSn0BfKLn46YVI3OqRV9kgUGqfZQXJjs/gZyw0DIvRPYqcM2q5Fh5currNxigvdM
 bN3VgjDT8WMP+3cKYj2R+Kep4uXsguF3bwpEVtuy1PT1zORZn758ZTQNiRmuIuiG5w6d
 BoD5VtW6DIwzuIbaahl+kUf25OZHJXv59NuCcynAqHDbnM5cWgJ28WWws1Dyk1zOAmM5
 tsRw==
X-Gm-Message-State: AOAM531mAwvqmclmfAyadGmgwwiMOPtVAfpY20O/IcpA9YdWMIuIS2+k
 9z1+NBe4Vyi0LLTOSLIlQ3Bqhw==
X-Google-Smtp-Source: ABdhPJwoHi7hVthAmvYt8ti4XvbmFCoEcq/1q2OQneoolPKybgtFsppUjlKmVOossAwd8FELPnKxdA==
X-Received: by 2002:a05:6000:118a:: with SMTP id
 g10mr37927530wrx.67.1600423470596; 
 Fri, 18 Sep 2020 03:04:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t15sm4273307wrp.20.2020.09.18.03.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:04:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA3B51FF7E;
 Fri, 18 Sep 2020 11:04:28 +0100 (BST)
References: <tencent_EAC696641F035EB7E9885302EAAE37455907@qq.com>
 <7f78871a-01a8-f00f-4dcb-5ba95ed1fee4@amsat.org>
 <tencent_6FBC0FD37CA798D4766FE6B2822DAC3E2908@qq.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: casmac <climber.cui@qq.com>
Subject: Re: =?utf-8?B?5Zue5aSN77ya?= Why QEMU translates one instruction to
 a =?utf-8?Q?TB=EF=BC=9F?=
In-reply-to: <tencent_6FBC0FD37CA798D4766FE6B2822DAC3E2908@qq.com>
Date: Fri, 18 Sep 2020 11:04:28 +0100
Message-ID: <871rizxuxf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
Cc: "Peter&nbsp;
 Maydell" <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


casmac <climber.cui@qq.com> writes:

> Hello ,=20
>
> &nbsp; thanks for the hints. I modified one parameter of&nbsp; memory_reg=
ion_init_ram() call ,and the slow-path problem disappeared.=20
>
> &nbsp; What I did is , change the RAM size from the exact memory size nee=
ded to hold the object file section(s), to the size that TI C3X user manual=
 memory mapping specifies.=20
>
> &nbsp; The former size is significantly smaller. But I did not specify th=
e memory mapping else where in the program, so still unsure about the cause=
 of conflict.=20
>

Well you should be modelling the system - not what is actually loaded.

<snip>
> &gt; &nbsp; &nbsp; One intresting fact is that this somehow depends on th=
e linker
> &gt; command file. The object file generated by the following linker comm=
and
> &gt; file(per_instr.lds)
> &gt; will "trigger" the problem. But QEMU work well with the object file
> &gt; linked by the other linker command file (ok.lds).
> &gt; &nbsp; &nbsp; What cause get_page_addr_code_hostp() function to retu=
rn -1? I have
> &gt; no clue at all. Any advise is appreciated!!
>
> Maybe the "execute from small-MMU-region RAM" problem?
>
> See:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg549660.html

That is the change that introduced the ability to do this. On some SoCs
you often run small amounts of boot code from device memory (or on-chip
chache) while the main system memory is setup. Usually it's not a large
amount of code so doing it one instruction at a time isn't a massive
burden.

You have to do it this way because the underlying instruction may change
each time you read that memory. In normal system RAM we have
architectural hints such as flushing events which eventually end up as
tlb-flush events that ensure code is re-translated when needed.

--=20
Alex Benn=C3=A9e

