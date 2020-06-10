Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8392072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uY1JMqYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8392072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3rx-0007lZ-NS
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj3qz-0006u6-32
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:45:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40407)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj3qx-00006v-6N
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:45:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so3051591wrc.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cKE9+s/S5ErwB6RGgztPCiR+RwyQs+EidymdltJQJdQ=;
 b=uY1JMqYWIJ1nRrsescM9/SW1hzk3oTW1X9jEusnUmMYkq5Ak1yKzOEOvIGndaST2Or
 15cHaKuU3yn6Xe5wI6FuHglMDTaxZpbxWU8oMoanqkXyZvQx4eZjds1L2k47ny1NRkBa
 PlcoDG0KH0RlmvAGcviaeptEMyKskUI/fB91Z3QsEf7A2QDJ6wCPSvQIPBWJvpMz/E1o
 jeuXcytJMR3ouqHK4wqxQZ8eTCmpC/3ZTP/2i1r/TYszZRpunQMCV0TNATsIoTcWQoK/
 0lzdEgb/4RiInhz9VSXMzHBKPkOqYnlJ2vyNfEbXestLO6tBM8XwF9L4n3wiQg2BkqPb
 fhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cKE9+s/S5ErwB6RGgztPCiR+RwyQs+EidymdltJQJdQ=;
 b=LqP9zN7rFCuGJPKnHbsz3wP/WOZHHgT7T21BM11rcvf91y9rbXm/dw2Jym6G18qZNG
 S9EhfyIjOxTykFfNp1SWHC+2pbu+FlAqwZDhC/8UO/yprqLxkQYIsmfrRxptMCp40pgw
 H1gYp2pdtZDVaAj5+7bX9etK+97bFSX25fRhy1U0gBo6lLqaWcS6Rr7iQ3ljVhoQ0AYY
 CpGZN/hrcYujhWyWb3KrUOQOakYgSuJ2fHAWo2nAMkX5NwSelkFRiTKf7FBO92Yo6lyR
 hzrUKTooT6EndujYUeMp+R/Z2w7jEjyatig4Yajg8VMwQYQxZPHAQL8tVSDRG+LzFQxH
 NVmg==
X-Gm-Message-State: AOAM530rVblI09wNw2LuAwQ3L+6NqPNyGPX4V9GfV6Q19k7e3ologr0E
 8jREpqU2U50gLuwNW1RvXrMPAA==
X-Google-Smtp-Source: ABdhPJxIdHn69gy6p6v1tAwgvBAzVo9xqvL4IJUPWTr6KpunanKCwLmkD1tAGuq/BR8UmagBXn6Vjw==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr4706393wrs.100.1591807517934; 
 Wed, 10 Jun 2020 09:45:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k12sm532601wrn.42.2020.06.10.09.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 09:45:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE4141FF7E;
 Wed, 10 Jun 2020 17:45:15 +0100 (BST)
References: <20200609200738.445-1-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v3 00/13] Add Thread Sanitizer support to QEMU
In-reply-to: <20200609200738.445-1-robert.foley@linaro.org>
Date: Wed, 10 Jun 2020 17:45:15 +0100
Message-ID: <87mu5a50pw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Changes in v3:
> - Fixed issue in tsan changes to start_switch_fiber(),=20
>   found by --enable-sanitizers testing.
> - Removed the UC_TRACE() code.
> - Removed the tb_destroy callback.
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01534.html
>
> This patch series continues the work done by Emilio Cota and others to add
> Thread Sanitizer (TSan) support to QEMU.
>
> The starting point for this work was Emilio's branch here:
> https://github.com/cota/qemu/commits/tsan
> specifically this commit: 0be125fc0afd47218b34d2019abdd19b644f3199
>
> The main purpose of this patch is to enable TSan support so that=20
> QEMU developers can start using the tool.=20=20
> We found this tool useful and even ran it on our recent changes in
> the cpu-locks series, which fixes many warnings.
> Clearly there is work to do here to clean up all the warnings. :)
> We have also made an effort to introduce enough of the TSan suppression
> mechanisms, so that others can continue this work.
>
> This series adds support for:
> - configure option for --enable-tsan.
> - testing.rst has the full details on how to use TSan with or without doc=
ker,
>   including all the suppression mechanisms.
> - We added an Ubuntu 20.04 docker that supports TSan builds.
> - test-tsan is a new docker test that builds and runs make check under TS=
an.
> - We added an example blacklist file for files or functions TSan should i=
gnore=20
>   at compile time.  This can now be specified manually.
> - Added a suppression file for TSan to suppress certain warnings at run t=
ime.
> - Added tsan.h with annotations which also can be used to suppress
> warnings.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e

