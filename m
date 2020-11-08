Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF74EC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 03:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358A620760
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 03:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358A620760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbbXq-000080-W5
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 22:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kbbWG-00085q-NY
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 22:37:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kbbWF-0000ey-1J
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 22:37:32 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so6362786ion.3
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 19:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D+c7WZvR/reobbvnK+BZbMHcH+r2zsNs06pn9mhqsCY=;
 b=i+CzxehkMIefwybFllRLidDnPKgdXDPXe72+TvrPLCDy1iizqlGyMtP5yn2M4+5DLz
 ZHWQCq56FsR3buGbaSkpCeQmjN4+RikBThDARdQfVZoayCrdKaphdox9pyb1pVIvoaHr
 YlrDzmYh+eMAAe8Z4mxGQTRm0Kq0H0b3EhfYKcLHFdPaY9pkXcljwQuFEe0grvzvXxZj
 Qb5tV8pzZmnAZu3AAeoE7Zkzlh7jOUpiRKLiWhyftpjWQdKM1gGawISZ38a6u6ahkQgG
 GbNZeF2LP99vAEAPIo0aHg7TLCoP+RPHKnKlyRR0WHSuofgSHiYX04mJq8nxtV8QKiBH
 yGJw==
X-Gm-Message-State: AOAM530PBWdbNvnbtpc8kSo+DctYfQ6Otwx0s8lN7HLarQONMPy/GkTd
 ajYcTztd8rJcB0Qn7LWVSkHIhxsrsPA=
X-Google-Smtp-Source: ABdhPJyf+PlNpVScK9rhCZKREPjBtuf7NBxqAamB3TlcgBIXEklCh3XFbItYOhvCNz8g1Wjd0lTCTA==
X-Received: by 2002:a05:6602:2d93:: with SMTP id
 k19mr6123663iow.51.1604806649299; 
 Sat, 07 Nov 2020 19:37:29 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com.
 [209.85.166.44])
 by smtp.gmail.com with ESMTPSA id w15sm3944587ilm.57.2020.11.07.19.37.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 19:37:29 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id n129so6360014iod.5
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 19:37:28 -0800 (PST)
X-Received: by 2002:a6b:e010:: with SMTP id z16mr5879432iog.84.1604806648648; 
 Sat, 07 Nov 2020 19:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20201106032921.600200-1-richard.henderson@linaro.org>
 <20201106032921.600200-17-richard.henderson@linaro.org>
In-Reply-To: <20201106032921.600200-17-richard.henderson@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 7 Nov 2020 19:37:18 -0800
X-Gmail-Original-Message-ID: <CA+E+eSCCmAxuHt9ou-voL3a8mpJggKU9Whh4QtO_CXwSM2z01w@mail.gmail.com>
Message-ID: <CA+E+eSCCmAxuHt9ou-voL3a8mpJggKU9Whh4QtO_CXwSM2z01w@mail.gmail.com>
Subject: Re: [PATCH v3 16/41] accel/tcg: Support split-wx for darwin/iOS with
 vm_remap
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.68; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 22:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 5, 2020 at 7:29 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cribbed from code posted by Joelle van Dyne <j@getutm.app>,
> and rearranged to a cleaner structure.  Completely untested.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Joelle van Dyne <j@getutm.app>

