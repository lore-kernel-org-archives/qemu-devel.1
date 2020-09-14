Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6A4C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1EB208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6O22RfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1EB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHonM-0007Kq-4A
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHokD-00023g-0z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHokA-0002zv-W6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id s13so63980wmh.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fFPE8NKraAo5d+/O9jqRbl7tKs30QkI6NrwjIfYzypU=;
 b=l6O22RfERHstPDVBJU58nrDKSdqbuuQA7Tl/4sqHleOvSKwzEdtfA4fOyqYrScA5oR
 wUUbZ8881uHmQU0jvzCCopwpBSc9H5QFS/szF5Oqmd/6fk3jgOZEDJdBBqq8eXwey/Rf
 Q66eLH0tomu5G4Rrj9uDXjbVlN2dQ4RK2B8vdUSCkIyDauysUd8U1rdrNRO4F7qNvPvh
 GY7+wCUW3u3VH4MKUCCVmUA5DeNhaDgLZem+4rGrW3m7y7lV6JNC31jLxzOGK8mvZdBV
 yQJRzqDJcX4uw47rE26QCu3j7vK6ZYl4fKH9aZWHmVU5IoQT85NjjRPyPk4KGyrRdpbZ
 Ld3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fFPE8NKraAo5d+/O9jqRbl7tKs30QkI6NrwjIfYzypU=;
 b=EqYO98jr9uenZ+Y568C1AusW9/izbBeAwBg0xReJEewfp3g/D8uoqlM+vNXKqH/Qhk
 rWuD2XrUFhHOgZPob1lVToSjVDK5ASX5XvUgbH2P2aJavbMTXtFBay9VCRR0V6LS3h31
 6xqKrejxM1xkLdSiQEM42eTuOCQk+lzPOznVhkNJ26jJ56cleK8zgUdgV60QN4Sb15P1
 EI4ufAoJWkwCchrzVoLEw17qTAjRgeoSXaBmOO0hFYZSrs+SxgEe6ycYpy488Ondv1/s
 LFaT+JiG8EYQxz72TS26SwmjX7Dslbnb8lncvtbxTRRKRb1NT7WyZsrYcH808ZW6tLEB
 NoRw==
X-Gm-Message-State: AOAM533vB7WLKPTmP7qdyNL6tYJ83kGVPhOKCVq6X0iVDywOsMuWUPME
 6iFLV4NWLBHEWfJUEPdT0FyjHw==
X-Google-Smtp-Source: ABdhPJwtSmoPpl0Vu0jANt7vTUe5/Ip19hRzieBy4QQwUfxyr3phw2Kopa0UCHli8oSpQDVO2jYP3g==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr14844985wmc.84.1600090925341; 
 Mon, 14 Sep 2020 06:42:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q20sm18745523wmj.5.2020.09.14.06.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 06:42:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 82A491FF7E;
 Mon, 14 Sep 2020 14:42:03 +0100 (BST)
References: <20200901162046.32670-1-peter.maydell@linaro.org>
 <20200901162046.32670-2-peter.maydell@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] arm.risu: Correct VLDR/VSTR U=0 patterns
In-reply-to: <20200901162046.32670-2-peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 14:42:03 +0100
Message-ID: <87bli81nmc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Correct the VLDR and VSTR patterns, which claimed to be setting U=3D0
> but in fact left it identical to the U=3D1 pattern due to a
> cut-and-paste error.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Somehow the pre-generated test binaries I have from Alex have
> U=3D0 insns in them -- I suspect this got fixed locally but never
> made it upstream ?

Hmm my current set of aarch32 test patterns have U=3D1 throughout. So if
it did get fixed locally it also got lost.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

