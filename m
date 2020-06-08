Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2B4206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqM+ZMRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2B4206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEnA-0002WM-9r
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEmQ-00026b-2K
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:13:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEmP-0007AH-69
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:13:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id q11so16759236wrp.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fW7q0jweIpBYOGPpiFpouf6s6An+tHgfZHXEBKJ1nK0=;
 b=zqM+ZMRKNSaqmMZklQOvEjEXaqjdpZRALfi7PDCv3SAZqKB+4vzj1VdVT+d+dmN3V6
 BW7vo6Rh6eZrSldjBQX958le8dATSwuCzLrDbXjdDHa5EVChPNSKxBcThAsOHf+WSdAg
 e1lljdjmnwRrHm+gSki28ZjJt10zqqupibdG/69+nkvaCBdUn9K60VZff1TANJbRxYsV
 OLP82wjjMORngyAzvU4t6GrZYH4tpquurlIGCUtHg8T3iaDj5dWJLpIzFIMLUFm3c0iW
 Hc89SMnip53+/lQ352xb2qSsoJVTslvRJxbOk9+nx1SvUJ+axN29qeomBlt4Gzpn9ZG9
 +Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fW7q0jweIpBYOGPpiFpouf6s6An+tHgfZHXEBKJ1nK0=;
 b=WdNV806ryyvVhXyzGOwidOIovVPOrTKtne/3M4NuOM3ekHGVW72KiI7exotOeby1Bv
 +j4ZFC8F5R1pG8Vg64IIngOfyS/4HD08UVgvgphpdZ3VJ9nHnZbRLCxZ1J5KC7pnnEQb
 RVv4ayfUTwGfmXCHuiwR/Wq8CvB+OTIFCFFtUZ1tDF/ikRn8KXNqyH59DQWQdbXR+go/
 uNTmQl/1MU2++MhfmN4Wy8CefT1qVIyrAHyElrzANaHN4YB6x6pcAuSegwAnbu076oIi
 EkmP5RdhcBYTRj3TVdZg3qjqNxR/O7vwe5Zk2BxwfNAzC3ktUra8n+owGRclBfUGbmdr
 Kt6w==
X-Gm-Message-State: AOAM530CZ37aM+Yq+jlM0LQup10hJkRjrAUK+iBMHby/wywruDcoOdjI
 Xh1qFMaiCmNlPs5R8qHeacrF/w==
X-Google-Smtp-Source: ABdhPJz85hWLw1nxT1UJFhQqsTFXuh2ni7uqPNAU+Qhco2tWik5ctr/dPoaKKTYo0dtQR4Tzcd327g==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr23391095wrm.142.1591611199668; 
 Mon, 08 Jun 2020 03:13:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v7sm22592112wme.46.2020.06.08.03.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 03:13:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC1041FF7E;
 Mon,  8 Jun 2020 11:13:17 +0100 (BST)
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-8-philmd@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 07/11] Makefile: Write MINIKCONF variables as one
 entry per line
In-reply-to: <20200605093256.30351-8-philmd@redhat.com>
Date: Mon, 08 Jun 2020 11:13:17 +0100
Message-ID: <87lfkx7tmq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Having one entry per line helps reviews/refactors. As we are
> going to modify the MINIKCONF variables, split them now to
> ease further review.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

