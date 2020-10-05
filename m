Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0803D20776
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffX1HrjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0803D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPNJU-0000pR-UE
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNHA-0008Bl-0a
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:59:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNH8-0003Zo-6g
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:59:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id h7so5191290wre.4
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UZ9BFAzg6pnhcW0Gfb7V8AhzKo1m8niCY+Wyd5/pQqk=;
 b=ffX1HrjFTMzxOWG6b+COxcqocbxZrnc8iSnrgFq1RkqgAN5KJk+1p7Wb5Smz2tYFTz
 x+Q3E05Rm558bOzdwebtxWD9ZMk50WkjWLCgurJx9Nry5ZASeLrILsr0MMlbQmAmkaEe
 +NBZ1zlek+ScNst8FUWka2bFgQUxbXnyvR23RahjHfs9nra+Ob4FTtinBLgpsd3mQh5R
 v22rR7FItVAaSobaXlYcsnioRG7oKTEt+3tzSxl1cND5F8PtfQlM9vcUmWlsICaLSvvO
 /BhmpZZXLe9g+RgTM16fEz8VakH6sYSDDR7/g5b0LWLdJ4HB+HOAdpOTKJ3USB4j/+sy
 2c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UZ9BFAzg6pnhcW0Gfb7V8AhzKo1m8niCY+Wyd5/pQqk=;
 b=IN97Bu1XYFKDuRWET7uJ3wJbLTnGKthzLCjImWwtnluAcz02JWZJg+9xbGqNQwl5y3
 loLVHmUPbA6Tsah7pVs9+U0KWzAAvIi6JDhFtVM+3wjzCQjHWP3K6TFz5wBUXKfuAA/B
 5c0qHIt/tjFw8Qbaj/PMln9pMkxJxbGLOJmexbVFUKnDrcjeEC8EyINEH/D79LWXAQQm
 n+EXFTWxgPOahqxDLyy0IBlExQA8F8JeSMkal9I5nc5me81sgmeTuQz94X6M7oYeSyYl
 TLZfLxli0VeK+Wfp0wdic7qei8vKpKniL+cW/n4+ZAPlRKtdNqJI4kPgJrv+oV+QId7z
 kR2g==
X-Gm-Message-State: AOAM533yMKmzQnE6QFOaiUPrmZHJwgTncG3X5/RXtp4fnUHF+UXFhBCS
 FpPKRtlczCd4UU32j7eF2f5muw==
X-Google-Smtp-Source: ABdhPJzceWD1/qDdR28qR6xb0BJk6M2LEYmJNTDPzMl0X8DFh7iYbmTwhsWNLIJ2r2jORh93TX1OHQ==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr15782476wrr.44.1601891960258; 
 Mon, 05 Oct 2020 02:59:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x2sm12333601wrl.13.2020.10.05.02.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:59:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F8B51FF7E;
 Mon,  5 Oct 2020 10:59:18 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-2-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 1/6] plugins: Fixes a issue when dlsym failed, the
 handle not closed
In-reply-to: <20201001163429.1348-2-luoyonggang@gmail.com>
Date: Mon, 05 Oct 2020 10:59:18 +0100
Message-ID: <87362t3seh.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

