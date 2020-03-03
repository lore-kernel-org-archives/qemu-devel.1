Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F82C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E720D20848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQVwwqfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E720D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BSY-0003KF-Td
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9BRs-0002Xj-1h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9BRq-0000oR-WE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:35:15 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9BRq-0000o9-PP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:35:14 -0500
Received: by mail-ot1-x342.google.com with SMTP id v19so3814045ote.8
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NgfyOwCr0rQp7cvVPDDlPEUTyclEzT/YpGUIN7EfV7I=;
 b=eQVwwqfUryF499R0PrJ7PbLmqCoeM2R6sZmYCtNP02iq3xziVAVcIEBb9XLII5zDz0
 m97Gx7h35ipqgtExV5N2qiMeIhs4H53/YAp/YTxScv6cEv0BzQphkpr1EhC/KcM26QuF
 hnnNUUbrSSSZ5cJrjFzPikISaLV7BQxBorqkT97lACQdB2PL60ROjsgzFeeGlBIcB9gu
 TfN1bYTVZ3ro9qQZHgKJDBDaeixYIGiUSDWvqX+MkR+tlqYXQNdNQ/qPW+BdCaz9c8zk
 DaBkCMAcldBjnDMhtDiavIlSE9uyjaYTDQg3Qe4n3uO04ficFpcsZvaeyk5NUCVcro9l
 Y3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NgfyOwCr0rQp7cvVPDDlPEUTyclEzT/YpGUIN7EfV7I=;
 b=N655QTJtGwOSZc/WyGYzWFQo1eRy9rWo8m60Eps1XVTNVe4oi4M+CC1jnM8PtTCpCb
 gMHpS42WqYDsoBPc87OXhPrXOS0RvVaxOKjpHiLvAXu/vfRUBFknPjctpY/JmgHmtP7O
 NKE3RqSWcLimG/mM99BP/qVkreY3PFPv9p+EnU1CT06ybH9vjVsZM7T/JtJcA4xFzuQs
 g37xlC+wN5s4yRCIelwHrCBNR1qAfjVuJ1I0pT+gT54LpCX5lx2R1qTuvWWQVo7ep4W6
 fxyM4GsdFNZ9fwRlgY9Xv3mzkNhq8b89Eys3StGsCfC3NEVkmVRlDCVq4GZDBNtF9Fxf
 Vc1g==
X-Gm-Message-State: ANhLgQ1Zsn/vJTt3ghwzMwa1Rd/brx/xgLNeNOD4J5XN7xwDrOqy8TNH
 jCZ6i6+B7bRncTBfPlJguAajK0d6dg3arFrKubu7oQ8K
X-Google-Smtp-Source: ADFU+vuK4ByuB8oRRZbon39UwYalJVkAQD5Ue15nakvbbRA42+7TuCE5kmooojFND0ShcJdFkaJ9/l9PsyoftzMxv50=
X-Received: by 2002:a9d:75ca:: with SMTP id c10mr3959693otl.97.1583256913546; 
 Tue, 03 Mar 2020 09:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20200228153619.9906-1-peter.maydell@linaro.org>
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2020 17:35:01 +0000
Message-ID: <CAFEAcA8vbqA_4K7dkyOrU_8HDrRo8h5eYESLgNnOzvrp0tVUpQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Convert qemu-doc to rST
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 15:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; this series does a complete conversion of qemu-doc from
> Texinfo to rST, including the hxtool-generated parts and
> creation of the qemu.1 manpage from rST.
>

Advance notice: I would like to put these into a pull
request at the end of this week. This is your opportunity
to say "that would be a bad idea", "I need X more time
to review it", etc :-)

thanks
-- PMM

