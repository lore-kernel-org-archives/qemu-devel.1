Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB55C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB9B20575
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uueEXTBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB9B20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6RG-0006hX-Rz
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6B8-0002Gj-4P
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:21:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6B5-0000PX-80
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:21:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id a72so12473326wme.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AXbyYdXP9bE13GOya0q/0LeFMAZ4w4jljUkUSf4KYts=;
 b=uueEXTBrmHP+FDIyvcMuxfEAWM5ZKVlPunx7T+BNTQkfugHEoPI5tAmx+ZmtTECKv8
 vmmxDdJoRO1huBgC4OO80dSPlc/xt+XybQK8Jck+7cVQT++2BzLl7YqgxoLhRML0WyDS
 FMH7BN0rdfQD31/90beKfjvVcqzto379SMaksbNC7kBkld8B+C/ll+UgDwRR+fc7QdvZ
 recOZYMLsdk4swb6lt6F+zfUsei0IXC7tqu4L5gueq7hmpS+Dq1U70b+qsgEEiHmrrxg
 +2RVsjjm6S8S+j8Jc+o2aN18mAHn8uQFVS/VVbQEKtQ+P6m+q+BitL9SqZwzWmYkzsWx
 7Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AXbyYdXP9bE13GOya0q/0LeFMAZ4w4jljUkUSf4KYts=;
 b=NolfX+lAdZn9p4b64ilxzBkb/7BKVC3nSB1HtfwOTYrFCgyB+goAQM2ElwnB+q7HXf
 dyy460X0JiWhpIFuKR1CxgClegHKXAy24NQcgRwKujfiCAjWLaMhuw2kwbGt5tjS//or
 A8wuZvBSXvg7I4//M/kh9w2GEQ7jf+gSD9Kv+GW9pnMGuuFFqBl7gHWY1SP5FIqjdn/I
 05wGS4eUxBEGm7V22uvprpDJrLTTf9Y2ntZLNC9PgUJVwVZt642V5IFSwqtele0zi/kR
 gLaVxemcmzQ6GRNKoehPK+Z36POz9jUI3njyJvgdKdVtPO3PGq+RklUGhdezTiWyhSDf
 0pNg==
X-Gm-Message-State: AOAM533zMJ21f64EFCJ2xUofewi0c9DojxO/KA5h/x/jHd1KwYfFip5G
 Lr4M80Hd8ZZVCf6HD55mIJypM5pHfGfaEQ==
X-Google-Smtp-Source: ABdhPJydSGqY/R75fxk7KozWMBubX+sVAxLKmcqnlEP276GM2J6TYMb8Vpq4x9Br0PEUxackuno12g==
X-Received: by 2002:a1c:5f84:: with SMTP id t126mr16925743wmb.89.1603732858478; 
 Mon, 26 Oct 2020 10:20:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p11sm23849628wrm.44.2020.10.26.10.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:20:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 323F21FF7E;
 Mon, 26 Oct 2020 17:20:56 +0000 (GMT)
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-10-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/15] moxie: remove bios_name
In-reply-to: <20201026143028.3034018-10-pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 17:20:56 +0000
Message-ID: <87r1pkgayv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

