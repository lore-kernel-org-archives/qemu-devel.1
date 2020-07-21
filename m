Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4192C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 20:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DF020720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 20:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBxzrWP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DF020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxytY-0003Pt-Op
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 16:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxysp-0002yN-PT
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 16:29:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxyso-0007Mx-4g
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 16:29:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so22410683wrv.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nh/cBtaqpExQ1Mi3suuJ8qrD1BqbJmVW3YU+nfv+sbY=;
 b=kBxzrWP9wJdupojGDseKi3aD/1t7zyYXUF02Yj18Vc9Y7t8bdGi4peBgFSQmMRN1fb
 hQxWSofxHwD+Q3QaEGMhnGrKSxGa9eqoxBwv04sEbWaVJZe+mwuVvmFaHOHLbLAoHQHU
 oAbXj3A9+qcJ8rhGZs2zuf802YkasQXXsDbts1qiZwusvwoH+GqY6euGdR64Boer7T7Q
 ofvSgKyA7ypVf4rnAqOilWDepth/hBq+Z0wVtuWZkinYNlCXkYayUK84IUlkhGlo1VtD
 CySTbr2HeRWZZmXYGyE5x4SRMZKSM2Og0F8K8pge6XVhXzFnr0TKzr0YasnA2SoGVIcK
 cOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nh/cBtaqpExQ1Mi3suuJ8qrD1BqbJmVW3YU+nfv+sbY=;
 b=lFAutKJqkdyTX5HCqdCHpaYkcBv5jkK2EaIQ9jGcpUvLbStRdyt4gK0kMt4mFWuwqP
 QT25qpVc6LBwMx0SqJjfU2vm3MUW94yXs85capmrEMU4YxrCy8yttARJD0JSdNDdvLyY
 +uxYHW+ufb3KiVmAeZDFkCrswkYWGSDwfX8FT/+rtrViaWWpuZ99OWNZDUSxC/PAhIMU
 WRczILvGfCHBMezsia2uEJqovLwsktxOsHgJyQ/Up4R7lGshIdILdTJ120veWQO1/GH2
 TfP/PqykGWKcHTAl6AlovL0gXfaB0o7nrjJVwecuHVtQR4RMGyQ8zCAOFAXgHD9koA6e
 JnZg==
X-Gm-Message-State: AOAM5318kvUQFt6h8pM6hw28qc/UDySP/qwhekBusyKPQoDjNnS6XVmU
 0spqjeFEO4CsCzeIjQjCVMP9wQ==
X-Google-Smtp-Source: ABdhPJwv4qQomYLvKGCU8fkt9s5G6mZTW7Kq5UJuQooxI9bjsTgC7AbyZ9P/VF3YdG5KyXfBVdRB3Q==
X-Received: by 2002:a5d:4a03:: with SMTP id m3mr19585258wrq.186.1595363338739; 
 Tue, 21 Jul 2020 13:28:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c136sm4971651wmd.10.2020.07.21.13.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 13:28:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E9851FF7E;
 Tue, 21 Jul 2020 21:28:55 +0100 (BST)
References: <20200721201754.2731479-1-laurent@vivier.eu>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] linux-user: fix clock_nanosleep()
In-reply-to: <20200721201754.2731479-1-laurent@vivier.eu>
Date: Tue, 21 Jul 2020 21:28:55 +0100
Message-ID: <875zagvchk.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> If clock_nanosleep() encounters an error, it returns one of the positive
> error number.
>
> If the call is interrupted by a signal handler, it fails with error EINTR
> and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
> the remaining unslept time in "remain".
>
> Update linux-user to not overwrite the "remain" structure if there is no
> error.
>
> Found with "make check-tcg", linux-test fails on nanosleep test:

Queued to for-5.1/fixes-for-rc1-v2, thanks.

--=20
Alex Benn=C3=A9e

