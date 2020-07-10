Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1530CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13EF20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Add8Hc4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13EF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuND-0001G0-5s
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtuMZ-0000en-Si
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:50:55 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31]:33741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtuMY-0007u5-5V
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:50:55 -0400
Received: by mail-oo1-xc31.google.com with SMTP id d125so1046949oob.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6iCxcWjFIrWlKjnwyh2LZ2tHdA23LuCdkm6wbODE1dk=;
 b=Add8Hc4oy1EB60OG2fhg6468BWRZ0E7K6+ccXL0IWMeA6+IAyXwjKzwD1KbCbVt34J
 joTlNG4X3gy9q8sltTDMANQcVBDnbsA5eWIHP7oRQFpLZ/gSLua+eEcHEb0ovOeYUBxP
 /OMD06qYppB/zzYoKRUvZ0OMI3UVN0sIkDVUjl6Z9rRs+0+7l5ZRJwW33CnuSN5Dan8G
 0EFGwMCMlOZX99i07yL/IPC2Aeo06TY01jinS5jcdZtBKlNx1NL2AUWXto5ik4JKyu10
 scqj8ME0RxUYrXke+IHWBCU1HP7+hVW41brp+SlWeBXs8PaUdC/i0H4Ja+n2PrBkhedR
 g8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6iCxcWjFIrWlKjnwyh2LZ2tHdA23LuCdkm6wbODE1dk=;
 b=nxE+0qTj0DDllxB/ImDmJyEHywfWo6C3Q4TM+WRlTINatFpCRzmu7UGi9wy7Zo8Zs3
 L9goe+Hjy/EJWV0mO2GQ0OD03ip1nwDuo0TdHeLB8YHgzssicS+w+jfJwplvWKXbs7Ma
 eX2RzX/qp2bQkkq7KnHOjfuVDHUGRmY20IIAuCQtEcRgdG44HVUcYrUOZJRyuTxnyO+Y
 2C42URlF3r636TdZLvY2V3CYCfUc3iql7fbCGRU5XfJe/uOjB1tCnfFGxU/5pEdYwj+Y
 uvm7RsEGghbc32Wtp3fpb8SqjLLe/ccLsZbwjPC1x25XmBuKyyIFLBLQSm4toRpYVZXb
 oRDw==
X-Gm-Message-State: AOAM530d3lrfhiITxLt24WTmLiBKq+m3+GfPreMIV0MePBJp9jDi8SOS
 qs/jUhFkc83/OqDTdaByZGhvSZsN844jz8sT5hu/LQ==
X-Google-Smtp-Source: ABdhPJwgAhNMoOe5eb5GDaN4oep1eZv7mkUMlW4iWtWkJViA59gG/I5f73b8OiKFegEfoJTgfUpNgOlDypMhCnomYFE=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr59352812oop.20.1594392652784; 
 Fri, 10 Jul 2020 07:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200710133103.2153250-1-armbru@redhat.com>
In-Reply-To: <20200710133103.2153250-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 15:50:41 +0100
Message-ID: <CAFEAcA_c0e0GeBGNBbzx0Lw2qhpEgzmqUTS6PcGwBB3GOCfmDQ@mail.gmail.com>
Subject: Re: [PULL v2 00/53] Error reporting patches patches for 2020-07-07
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc31.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 14:31, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit b6d7e9b66f59ca6ebc6e9b830cd5e7bf849d31cf:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-07-10 09:01:28 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-07-07-v2
>
> for you to fetch changes up to 1de7096d8378a57e2d75d9cacc9a119e7e41640d:
>
>   xen: Use ERRP_GUARD() (2020-07-10 15:18:09 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches patches for 2020-07-07
>
> * Improve documentation
> * Codify rules for less clumsy error handling
> * Convert a substantial amount of code to adhere to them
> * ERRP_GUARD() infrastructure to avoid more clumsiness
> * First batch of conversions to it


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

