Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF4A207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vr+3e1nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF4A207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalES-0006Ix-8w
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jalDt-0005tY-7D
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:14:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jalDs-0005Hp-2w
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:14:48 -0400
Received: by mail-wr1-x42d.google.com with SMTP id s8so13150036wrt.9
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ULL/VnDfWz4tCE/o6E4vSdy4ZM+xycunHM7UXdgjgq0=;
 b=Vr+3e1nlPgwkRlzV9Sl2Cz7WDTRc1lZVDI3EuGM4PCJoSeVpRHH5glYJSwuCk3Enho
 bli5ScFqo43zl8f4UnDkCE5K+oV3mbV+ITa084lpYG2Ma4KQoC65YicdwcF9RZl9hei9
 x9BPWmn7+fQKKnm2xKSjtiJFUKuYhAhbXUqAZPR6q0WEG3daTjxn1iRuY65RXcyKTw9a
 MZbGRI0U3olb9r4aKrNeoTDIXfTSRMtpTouVR0IkhpbT+HlBtJNkHsC6fW1q6o/+12Sm
 0Ks4R72+3WT5ZaBW/TF728n5MtHwpkjVQigBAC5ylFOfj4O+MOSzeZcKaGoXg+NI/Zls
 H12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ULL/VnDfWz4tCE/o6E4vSdy4ZM+xycunHM7UXdgjgq0=;
 b=PDGb4OwQAmf1nxkAS/rnsxCJCqeIBa2K7q9aofyPyc6QhgLEdXt6SpKLc/xGe9A+i4
 QSUHqRzUuAZLfMpEIrxt+Z3A/1cwNJDTvlhBhgiEFyL+/i90BWlUDMaGW98IXYQA25Yz
 19q3XNyuU7V9AGXfY+y2h0M1UwDkeKN3sS5eu9nn8LaYEzDu5y4BTS4UJRf4TKDFn1f7
 js9UuNcAxcyPHzagXYUmhrCjufILqHogXkWztqhnmo45MTG0Coypyq5Z5J+w+3tq4mK/
 RKK0rbvKeb9nWSZ3l0Da9QrJ7BiRXOIpyX28QxE2jgCcql9+K7NWtLZ7QzNySMFYI/z2
 VM2g==
X-Gm-Message-State: AOAM530s1zck4NL1u0aFAk06FkUn4/4Bi3aBKw4xumx9K9DeNBu/y5hL
 6DtSfq7Wt08XgZABkD/JgdBEAQ==
X-Google-Smtp-Source: ABdhPJx7q44fBTrVbEVG0TyNzahWtSUclF90FOzFea8yDIrNOFEOY8BKneVTXTvHPQO+ay6X2pHy7g==
X-Received: by 2002:adf:f652:: with SMTP id x18mr21163861wrp.262.1589829285959; 
 Mon, 18 May 2020 12:14:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t82sm674037wmf.10.2020.05.18.12.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:14:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F2FE41FF7E;
 Mon, 18 May 2020 20:14:43 +0100 (BST)
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <CAFEAcA_xBwNPWFd3w36JnuBsZSKb+q-aWXHfrLe1Rb-29eXpjQ@mail.gmail.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RISU 0/9] risu cleanups and improvements
In-reply-to: <CAFEAcA_xBwNPWFd3w36JnuBsZSKb+q-aWXHfrLe1Rb-29eXpjQ@mail.gmail.com>
Date: Mon, 18 May 2020 20:14:43 +0100
Message-ID: <87h7wdjbrw.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 13 May 2020 at 19:09, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This patch set does alter the format of the trace files, and thus
>> means we'll have to re-generate these.  However, the space saved
>> for sve trace files is significant, so I consider it worthwhile.
>>
>> In addition, the new --dump option allows one to inspect the
>> contents of the trace file.
>
> Alex, would you mind reviewing these risu patches, given that they're
> mostly trace related? (Also you're the one who'll have to regenerate
> a lot of trace files :-))

Sure. I'll have a look in the morning.

>
> Richard: if you feed an old trace file to the new risu, what
> error message does it give?
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

