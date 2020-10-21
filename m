Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4852EC56204
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836DA21707
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0r4bkHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836DA21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVDLF-0007Uq-CU
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVDIL-0006C4-C7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:32:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVDIJ-0005Jw-58
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:32:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so2871234wrv.7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WmnplGN5Skb5H/vCsb/V7Jy40SpC82bTLrh8SiNTHG0=;
 b=A0r4bkHHfRM9PFUogwK2VjRSX9zZ+6r2IlH5DPSzQxJAYEFMgJCYs/6ejqr1Iv1RBM
 NeTbrF5KRwWIGIWXIlbxwMKRUXM7s/WQBHzPazzy3zXaXEGY/0D9F4N+xbv36ablK94y
 OwYL6vNfJlwXq4OUy4x/iNdH3YvKp+EqTvHLqNstPZ0i/l28oRKzCY7ppzxMU+P5pDXu
 JLKEQuvZLfLEq6vWsHyCbsPc2wA7kvbR3Qjn/7086zBqSwRBlwubfKrzWdF9J3mNv97n
 zCmsCOqYHX1cFGcMIyGpbhJ6cm3PBMzB2j55I3Y5MwA6OxfKq6h85o0w3VnTPzczFKad
 Pkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WmnplGN5Skb5H/vCsb/V7Jy40SpC82bTLrh8SiNTHG0=;
 b=BTUPGp5lV8zIta7wT+Pr8KW9K8/5EZLhm8LGuh5EirrenqYRS0jWum9P895sPTMPFz
 BDdZbwzkOVAZXM2UVQTJtpdAcS0sWQwq1d4wE2KhT0mBhl1+SLIN12LQ0BIp12SFHrN1
 9ejiU+yQeVA8lt63Zs0Da1u29/v36XVRCVQ0siVduZX4IFCE/92RxDRAiHrgt7Lz97vh
 8aKgrvWB+UFDFeajixlds8eo8lWKFsZlTzATja7zJgpw4KMhM/4UB/hGF+1liWLKiNuo
 CGjwjnYZofk+tSgAkhAqs8PLqDa3bjhHbzKq2uKHqUuEiQXU/EoruGzZjYeFdPlgPGSx
 WdKg==
X-Gm-Message-State: AOAM533K4xI0DdeYdmE6DKrhvlM4vu/hsjHPrkDjdB66EndQc+S/mDtg
 4ZGWrM3Por5qrP7UlyWptAmKZcE68Y/W2A==
X-Google-Smtp-Source: ABdhPJyc+I2SPVjnkQgMyin7hEicnBdANX+Uh9RuxchxAM5/p0ZoKF+a8Aj22Ltsq65xEJudzokuIg==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr4409261wrw.315.1603283559828; 
 Wed, 21 Oct 2020 05:32:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v17sm4337898wrc.23.2020.10.21.05.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 05:32:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA2781FF7E;
 Wed, 21 Oct 2020 13:32:37 +0100 (BST)
References: <20201019143537.283094-1-berrange@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] gitlab: minor fixes for checkpatch CI job
In-reply-to: <20201019143537.283094-1-berrange@redhat.com>
Date: Wed, 21 Oct 2020 13:32:37 +0100
Message-ID: <87eelrwyhm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This fixes a bogus error when pushing a branch whose content has no
> delta against upstream git master.

Queued to testing/next, thanks.

>
> Daniel P. Berrang=C3=A9 (2):
>   gitlab: skip checkpatch.pl checks if no commit delta on branch
>   scripts: fix error from checkpatch.pl when no commits are found
>
>  .gitlab-ci.d/check-patch.py | 8 ++++++++
>  scripts/checkpatch.pl       | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)


--=20
Alex Benn=C3=A9e

