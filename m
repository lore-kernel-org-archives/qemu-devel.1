Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E44BC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E4B20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMccIWzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E4B20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcGF-0000pd-Gm
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRcFY-0000Lh-VW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRcFY-0004bL-BM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:50:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRcFX-0004b0-Qx
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:50:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so6512697wmc.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8tVOugJYS4h4u5Up7dBQiDPHGN4fBQKK5iimQJrZ7rU=;
 b=WMccIWzw9qD3TO7sXzOrfcRO+kvhQsooPA32QkbKb4Y/U16Jn+T5AtDd9nEkldAX4/
 vlf2U68nVjMZHgetSQdWdunJan1IkXdKCznYwB0wjD3cEqxOIcQvzZLOup+aDspMCrxB
 CprEufmRMgnhPdrw6oXRu/hv5VzUHSL/pnWSUr490zqJhASlfTvwOvI3IMM+9J4u7ebe
 kwhqJWx7zVm1CyEjLfgDPeRhWilwnDc+j86lNlXlog5x+9dNECmr+scpghlDRxMDxUDT
 MaLSbirV+w9dEB6ShnMFDlYUN2+a90iS4JwVomgvMiValkp7Pdr9YCjwzfCTFmZxbuWn
 z4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8tVOugJYS4h4u5Up7dBQiDPHGN4fBQKK5iimQJrZ7rU=;
 b=BlCtoF3DkngYAVh1oDyeG+ITiRticT8ZtiXe/nd9IYTeoHY87iYwB4NLHwhN3AsCtG
 04pUNtLIqjRc8853jhGHb7yk4tqcYm3gnDYdYEfTGzgDh98w2uRSi+rnshLkyY1RSmsE
 WUe/gB5bmkqAarx0UaKxsvru/Lt75RPMYUIAMqcMb6aPkpPduvpMFDjlUXAtae+W8CzN
 GTdSrR3liZQwPCJp708XHzGJa5EPw0dWJm7GAoN2rFTq0BO8i2m9KbAdz3MB+dJq9eFW
 BDutVk+Ee+JNbCkUfdxGGwWwkhgL0ay9xY+Bc9mW1Z5RACQZMIU9dRTTUMM7TBRoJqnY
 ZcxQ==
X-Gm-Message-State: AGi0PubGlNAzE0H6LA8nPpoFN7iJZAfwwk8jX+1MrhzTI01SKsTT/+Qe
 8eP6sRidA4lTSWPCLVy0y/A4ID2eX4k=
X-Google-Smtp-Source: APiQypJACoZLXhptdqD+CJlVVttBNaR84YusBbDRyfLUWGve/ySD+6m2vvOYf3OuflsnUF29kiNkIA==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr4299437wmf.188.1587649842204; 
 Thu, 23 Apr 2020 06:50:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm3632323wrr.40.2020.04.23.06.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 06:50:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5396E1FF7E;
 Thu, 23 Apr 2020 14:50:40 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 00/36] tcg 5.1 omnibus patch set
In-reply-to: <20200422011722.13287-1-richard.henderson@linaro.org>
Date: Thu, 23 Apr 2020 14:50:40 +0100
Message-ID: <87v9lq9uq7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> For v1, I had split this into 4 logically distinct parts.  But
> apparently there are minor interdependencies, because the later
> sets would not apply standalone, says Alex.
>
> Rather than tease them apart, and then have to undo that work
> in order to actually apply them later, I'll just lump them.
>
> So:
>
>   Part 1, patches 1-7, tcg_gen_gvec_dup_imm, is reviewed.
>
>   Part 2, patch 8, vector tail clearing, is reviewed, and I have
>           moved the target/arm patches into a different queue.
>
>   Part 3, patches 9-25, TYPE_CONST temporaries, is mostly unreviewed.
>
>   Part 4, patch 26, load_dest for GVecGen2, a support patch for SVE2.
>
>   Part 5, patches 27-36, add vector rotate patterns, is brand new.
>           I include two demonstrators for target/ppc and target/s390x.

I've done my review pass for now. I made it through all the core code
but my brain was too frazzled to look at the back end generation code so
I'll have another go at that on the next revision when the sparc
regression is figured out.

--=20
Alex Benn=C3=A9e

