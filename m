Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB64C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B1420756
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoR+grii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B1420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaysZ-0001RQ-CH
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jayrV-00007q-Gu
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:48:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jayrU-0001gg-FV
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:48:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id d7so4237251ote.6
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ak2H7rB/DvgHdGwou1WvaV9Jt0pud1tPDPyoqj484WU=;
 b=ZoR+griibeFsv/ylck1g290gkBjicjwztH30AQbKgEz+UWFKvUaAl2lMVoPo69TvBj
 8BLcO9aSgCmdwY6pIcNaI9WK293sBpcDRNzfn7jRc3MxtAow6R0CVmNroDNEfhEl3TKF
 cVeQAosox5SdznwMY68ERNJyH9qIWG9kUOqqKSd+fFNFXlEyaRAN+vTZAy2KeOmYi5d1
 I5ORxyIGl8X+rZ+bnkvp1uz/yRUs7WVIgfcskY7rF0ttXWPB0iWngwNbowgxjho232Tu
 oTEhO4kSwBsZ2C0uyg99wW7E++x052rDT5h940+HwzuQiSQObnDGGF0BkzcKxUIVQIdH
 TcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ak2H7rB/DvgHdGwou1WvaV9Jt0pud1tPDPyoqj484WU=;
 b=nVmPJZ5Z4XMNiPhcRbQ8L5lSG26V7PDHjFAndxZgPTpZ3d7vaIfSfRq+DMYr4Ad0WA
 wLbiG9hkllK2omsxG5mMpo0HUurf5EFW/Mcs0vkJuTIYmRyWqEVA89iqXQ/2Bj/uxtv9
 3Vf7na6OKt93vqxTSKopn2DZySOeH17RnXNixor3U3RU3CysxU6zigtLVDrTG+ScfYvZ
 dIgaXyFg0tBrZMed4H+m/e9LbLhcSQGQZjAb4JNwv+PC9awznUMjO0jYtpNt33Oko6Yc
 M/jNueG5kzgcNfQcngDyhCR4Fa54F4UUuiaxEUJ8JVrVvonEpgCUohQ1oUWOLfrmTzdD
 II4Q==
X-Gm-Message-State: AOAM531c5+uFBL9sacTl6nNS8eA76DBgUGvSoXR/2Ymb85KxNGixSePO
 v72eQZazX+HFPt+XBUQ8o1uAOmZuvr4/yQ9Zvyv8Lw==
X-Google-Smtp-Source: ABdhPJzhiKUqpaqX7dAJUdq/8MFqMHQQzSwjMvFvLQRUOsIi6EVaWE3qKlM8KesYu1KKfzlXHakSanFFQzFUPiUWIm4=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr13573014otb.91.1589881714921; 
 Tue, 19 May 2020 02:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-3-armbru@redhat.com>
 <d6b1e66a-23be-e38f-1140-9b45618741e7@adacore.com>
 <878sho7bor.fsf@dusky.pond.sub.org>
In-Reply-To: <878sho7bor.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2020 10:48:24 +0100
Message-ID: <CAFEAcA9tVM7RhgUyjOAfc18Ti=Z_yk-BhL7r070aqkxsPPBwcg@mail.gmail.com>
Subject: Re: [PATCH 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fred Konrad <konrad@adacore.com>, KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 at 06:09, Markus Armbruster <armbru@redhat.com> wrote:
> I figure the "device becomes real only on realize" thing is actually
> more myth than thing.

It's not a myth, it's an API guarantee thing. If you don't realize
the device you create before you use it then you're in the world of
unspecified behaviour, and anything could happen: maybe it works,
maybe it doesn't, maybe it works today and breaks tomorrow.

thanks
-- PMM

