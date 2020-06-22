Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3774BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0165C206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQBbyrfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0165C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIIK-0007vx-6Y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnIHe-0007Eb-9Y
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:58:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnIHc-0004o7-OQ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:58:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so4046506wrw.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6j4kFuGS3BH3vxyFAxK8lBy5b4AXTKuqC2qmtVVKFdI=;
 b=uQBbyrfUHgh0jxGC5W8TCQxjlsQdpjdk1exWkp/8Buy3iAnn9b4gH2+TEDuGPkSNvD
 ovupTunzcO7Yp060hP2LvrhT/OzBDFRoptb8MCkhh+bQLWaLHh9byirF6QszSa0uxMd+
 GiDc/uhVaCR655PZSKJarpak/3Ch+8JSzkpZDGMUODAzpi58ZkC87OLIid9GQbLniWLN
 F87q5Xx5CdoINrsuh7teV9ROq8btlNow0/DuZryPE4Ax+bH8AECPeBi8AFqQ6Yr1QMt+
 1AS4Ik6T3/Bkg6js46JkWg2MBWNUTkhCsyK1igfocQvhHdVnLJEIfI8iA4/jZiNXlnXu
 Mljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6j4kFuGS3BH3vxyFAxK8lBy5b4AXTKuqC2qmtVVKFdI=;
 b=XKVP5JkhKSEt0oDNADYBr5Hu4QxPpW+EoZvyRAoY2dOWpZkx2stgf3EwIw5453n76d
 3ksENZtmHXeCeu6s2PaLuK6e/BX9BFWbioBHrZCelI7iQDEqIeUv27VX3z5cgLo/v4z9
 iUAKLiRe2G10WocM37X1dmyw4KvFEpqdabitwYANHQH4sT120OSb2Z0xC/8AM2/R0xD5
 0+oa6A26iA2pThDDar0m2qYjA4Gi8c3Kq0scK0MPWs77eQ3haGXhZj09TMJFFCy+3+9L
 /vlhHuTg8uR6SCYF+3PAKvBDn0yMfW8t3sEGTJQhUKYW8HlLONZjbeoU+gYh1ftMRjve
 0bYw==
X-Gm-Message-State: AOAM532vAOhG6LLpOuE6NsgLmiPJXmffa5AFsu9tZvZV1M3buqvUfnw+
 ZaW1jD/WDOOguFn6IaPliPgXGw==
X-Google-Smtp-Source: ABdhPJwudMd771OcoiBAmIlyKiVFF/48/k2M46wM/vL+SFYm5QXaT6XXVE9YC0TUyQcSiVOxpKx2Tw==
X-Received: by 2002:adf:f209:: with SMTP id p9mr17289282wro.86.1592816307191; 
 Mon, 22 Jun 2020 01:58:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 125sm16706881wmc.23.2020.06.22.01.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 01:58:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B9221FF7E;
 Mon, 22 Jun 2020 09:58:25 +0100 (BST)
References: <20200619170930.11704-1-alex.bennee@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] docs/devel: add some notes on tcg-icount for developers
In-reply-to: <20200619170930.11704-1-alex.bennee@linaro.org>
Date: Mon, 22 Jun 2020 09:58:25 +0100
Message-ID: <87lfkfa34e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This attempts to bring together my understanding of the requirements
> for icount behaviour into one reference document for our developer
> notes. It currently make one piece of conjecture which I think is true
> that we don't need gen_io_start/end statements for non-MMIO related
> I/O operations.

Well I should have totally removed that line from the commit message...

--=20
Alex Benn=C3=A9e

