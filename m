Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A274C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4603B2070B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYOMV4WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4603B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMTu-0006U0-PV
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGMQc-0004WW-TQ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGMQa-00054g-LI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:11:22 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGMQa-000535-FA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:11:20 -0400
Received: by mail-oi1-x244.google.com with SMTP id t84so5515062oih.10
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VwlvnMx+hybhvJZlZlpXIJh1sK86NoZCqos+fuccrXg=;
 b=DYOMV4WOQ/ULSCY5NuKyq/7ALWZkcGasVbuk+H4hE1iYkLkyEDEWT81UKYBYOERK9k
 xGlXcgXhcfTToywQ2rBPpb/8IZELNX0VgyP6WqvDldCRtmXB2dHKj3r5yl3A3qusvvfe
 Xzdn7HtwNAjNr9PSQTXjYA7KILworxK3CKwGNB6MAxelxBIA69sLnsJTmrc/edlTPiXr
 blo5/d5RA6SxgwH+OYUxCIRXqGpV8QB9rjqdCRgtEivO1BtxPmD/4JLAp16SQM/AIoRU
 iLVWKbAjgK2di5vhRjm4vEZz7Q0rYNkNPgAQAda0MdNdECfhC7RhM1zzaRPBwXWXzCxB
 fwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VwlvnMx+hybhvJZlZlpXIJh1sK86NoZCqos+fuccrXg=;
 b=f+8EyjA0xuGM9XIoO9FfP3BTPnfl/eGLsk+d+L1Hll6qr/hteQwJ8XWCS8ay6AdJuk
 zdPe/vhV3sk/Yq0SeZGXw1cM0w+66Ufx1tU1zn38lvcBL2DEG4s9tmwHdFiVcGquXMiB
 dT1HwHzBIjmEbR6Da5N0TZR0C94ppXheDelXRUeQVv21CAxsrnIJGy5GK5yHIqD+pliL
 43+scKOBBZDqkDQe5nWCv+yMCxeA4SamWVD1vWK0eHxcRu6pTAz4+VIsWXqjEZI9em/L
 R12L1V81MAsLPmA/fmJ8+048HobF2HV9WJpiFq3+nFtFF4CJGO1dJAFrOXb0ymO7x1ps
 n1IA==
X-Gm-Message-State: APjAAAVieTU6iBuqjJisfdIbm6QM/AcPiPVYhViMtClZZoQRteCGpKEF
 eGJS/TnvELjBF3Lx/Cx//u3LXtrIMpx6j7M77D+3Sg==
X-Google-Smtp-Source: APXvYqxx8T+tPQ99os/2qMn6RmTFLBp5Ew/MCd/7eFBjuWtMskqoZPRgrC9Hfm9Ndhyl3PBbbR2Nh6qCaTwLeYmMXDI=
X-Received: by 2002:aca:b646:: with SMTP id g67mr6925334oif.163.1570191079282; 
 Fri, 04 Oct 2019 05:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191002082636.7739-1-david@redhat.com>
 <87zhijjwph.fsf@linaro.org>
 <0479ad1f-348e-ed40-c2c6-aef168afdb7e@linaro.org>
 <379c2065-adfe-0847-46f3-7f25c7650df9@linaro.org>
 <17a008ed-8ec0-2732-347d-bb04b6d832e8@redhat.com>
In-Reply-To: <17a008ed-8ec0-2732-347d-bb04b6d832e8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 13:11:08 +0100
Message-ID: <CAFEAcA97hjbh+0rhTABhn_FwhLOoGq53=_397cGv9cnZfmQRUA@mail.gmail.com>
Subject: Re: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 09:02, David Hildenbrand <david@redhat.com> wrote:
> So shall we leave this patch as-is (adding a summary of what you
> explained to the description) or shall we somehow factor out the
> TCG-internal-thingy check?

Nothing else in target code touches the icount data structures,
so if this s390 insn needs to make this check I think it ought
to do it by calling a function implemented by the tcg code;
that can then have a good name that describes what it's doing
and a doc comment explaining the reason we need to have it.

thanks
-- PMM

