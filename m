Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEFB20721
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIPgj8ZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEFB20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdfDD-0003Mp-NG
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 15:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdfCD-0002Ph-CB
 for qemu-devel@nongnu.org; Tue, 26 May 2020 15:25:05 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdfCC-0005zg-7A
 for qemu-devel@nongnu.org; Tue, 26 May 2020 15:25:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id j145so19685488oib.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KhQZnN0KQHH8kEo7sz4kjMuOFVsu8d0izBwLocoq1Kw=;
 b=CIPgj8ZIYXMlinQdgyVwqAc3ASZ/gcDj8yuXVezS1wBzWQ7DA0lBqHZP1jUGrL+rD2
 WJuF07DoFtqJqQI8zkY9oN5Xo3izc3TS5t0p3q8dfC9ObS69cl/ektd22aqMmrCsi5C5
 sAEywbyJzbWFywlo6KQqB39Ovac3ZjzXdJqV+XXgkFKda0AUu+dsnG9HBrKVW8XpoiEj
 rBNY6yPYJ8bvjs9pEC1BdSf8iE+wg/X6cRjo8iC/im7yXATWx7Qh+xCWJ+q5a/9F5RP0
 KXBIFfpyIlU8bM3z4YDTnwPMj08M1Apr70FWAm4QEBB79vRB/depCP1nTGwIM2SDcXWt
 H7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KhQZnN0KQHH8kEo7sz4kjMuOFVsu8d0izBwLocoq1Kw=;
 b=aU2wfL7n/CcJsujmu21Mr++m91A0cnmj/ylHhnQShfntDL1Jx955TQd/Mnyw7Q6Ef6
 G9OXcrSRwwQ1kASkx7uTPJSbPbLroh7L2Ut/0OnWTcM9btJa3SJ7bubW56hOGbi0AltE
 7qfLj35igktS46MxqqSfDLmImtsqfbyUw7tUFfpiAD83gjpi7LtSHlZun/t9CZ/x0peE
 kcOhjYaPooI77LBHdPsptCWnswKVfdqeH3JRRfQJGdGMqVF7MNzOzPA0MO777uWDVHLa
 fc+Sp3VozJSVBMKvAa5Ziy8j/K3LGwzzAsv9UN7CF/29+VXlhIatIOydAEmhwCfrTIUZ
 y2FQ==
X-Gm-Message-State: AOAM531zkx5QmK1OujHAiY0uO/5vGX202+8rwvaT4RJpLHoKHliSXj/o
 tcMJ/+9XYaM2YVson+b/ARwDqFvnnKNjySdq75PPrg==
X-Google-Smtp-Source: ABdhPJxwg/45+TXggEP9WLYTn5cr1eczrOWb3OpH9IyjqrwXZtJDW7d5I+6GnbyjcqBo6ua6NlMs3oqC9SsTBNC4LYY=
X-Received: by 2002:a54:469a:: with SMTP id k26mr293351oic.163.1590521102788; 
 Tue, 26 May 2020 12:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200526114931.391049-1-groug@kaod.org>
In-Reply-To: <20200526114931.391049-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2020 20:24:51 +0100
Message-ID: <CAFEAcA_SwZ14vAYk9q87bf4Ndq4DCbHv5iP-N0JZucOvH0dV9A@mail.gmail.com>
Subject: Re: [PULL 0/5] 9p patches 2020-05-26
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 at 12:50, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit fea8f3ed739536fca027cf56af7f5576f37ef9cd:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20200522' into staging (2020-05-22 18:54:47 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-next-2020-05-26
>
> for you to fetch changes up to 84af75577cceb195b044e2d5ba6d940206b169ca:
>
>   xen/9pfs: increase max ring order to 9 (2020-05-25 11:45:40 +0200)
>
> ----------------------------------------------------------------
> - fix build with musl libc
> - fix potential deadlock of QEMU main event loop (cannot be hit with linux
>   client)
> - revert 9pfs reply truncation (LP 1877688)
> - xen backend waits for client to free space on the reply ring instead of
>   truncating or disconnecting
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

