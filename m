Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3539C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1642074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2yA3Xtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1642074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZX65-0004iE-SH
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZX4m-00020p-D9
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:56:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZX4k-00054a-At
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:56:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id n5so1983895wmd.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hmYImSo8JLm3498SCOerOEVZRkNCtM0j4+IxvkoXYCY=;
 b=Y2yA3Xtnrbu/rWLvU7LM0pQ4FEWf9ySWWAv/5jH1yYmwIrrO0JCAcDGGNWmZzyz2NU
 i0FTd7mFuW9HGWiQYoDXWx1aB2zYIKXPm3zIHe7sMPDbCCAK0ck8XexLgXGc/MwKq+nb
 VSpAYAqyABR+zCMMK/8hmDAJJKVhNHd/XTb/zeNWMQvJ3dq19aZ1/U5xQ5N6cRku7kDQ
 xhgGxZyuGMFXH8pXxREkm8bQAneY2OfPqJMK9Itec07XBjAc2f920xAGp4OiwNx9im7n
 wVpyoFVbB+PzaOe5GWvYT2utomY5CSVGuPRTvVyjLhT4tKsdY5v/VpCj9z/Fy00rSnIl
 f/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hmYImSo8JLm3498SCOerOEVZRkNCtM0j4+IxvkoXYCY=;
 b=sBmy0ra2dhgokWYM2ZkjF6vMLUW9iiAuIDgTjHuO2yGBdwV0TORh+u1nxrM0ei8z8P
 QEzrONMLUmx7ZMsw2Dylys6AM1MFClUceguJhHaFd4YCRx0KQ5xRYoPJ7Ny2K0EUvZgM
 Ce272IgoTbDl6DcfWr4zxVDOILnNwZsl5FIerMvaojneT1IsL3Eev2VhzP85MIX7NJT+
 ZCTHbfkNU7KZoGdsBjF6WPVygt9O59WGpTnD5+850Ft4gUjwKulNq/rh5FLZ+dh1MFie
 CcBCFaQA9eFFV+TJQNA/oeFHnB38ULsc6agu3QQMiJln1HFZg0bx53VbMhxFg81sWyt4
 qYuA==
X-Gm-Message-State: AOAM533nAJr1MjHbsFe+3iv2eDr90VpN5hndTvONtXN0oI8/A2ygw031
 vCmIthKU6KBAMom4IQGBJPpVh8n6Eiw=
X-Google-Smtp-Source: ABdhPJwJ1FRrHXEla1tVU9WQo8Bu926lwM/+Dc8xqi0+0tqWy4hRBBq8jSxXAwE5fVq+UKtDdH/ivw==
X-Received: by 2002:a1c:5944:: with SMTP id n65mr3314851wmb.73.1589536577019; 
 Fri, 15 May 2020 02:56:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 32sm2940967wrg.19.2020.05.15.02.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:56:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 295231FF7E;
 Fri, 15 May 2020 10:56:15 +0100 (BST)
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-6-peter.maydell@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 5/5] docs/system: Document Musca boards
In-reply-to: <20200507151819.28444-6-peter.maydell@linaro.org>
Date: Fri, 15 May 2020 10:56:15 +0100
Message-ID: <87eerlcyio.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Provide a minimal documentation of the Musca boards.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

