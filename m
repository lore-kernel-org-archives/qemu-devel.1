Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3710CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DD3206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUXrPVny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DD3206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXo6-0005Du-Tt
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYXn2-0004TP-RR
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:29:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYXn1-0003vI-Uk
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:29:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id w19so9381151wmc.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bza9Wg/RyiC6VUjDcCKwu57gNegQP6dP/i6JoAQPDag=;
 b=uUXrPVny9hJzJS56mN2ml25q9fqJ254y2SubdWePpm4ZYom3Ia20JnFmYokzumWwTq
 1RdKgZg9LGMyZdLwJE9Q5s/lMzF8Kal+6jsLen1M+wOhCCZKDHpudzqn+0NiT4E3daRW
 gDyJFsknBSbL9Bt+V+nCq2HnchASzp7Bt93nZgTadtLet1fF4M8rJ5rFisBm17BSFiYy
 QzrOdk68Hl3VxcHJCAP1Vgk4PK/NdZP90iyWu31puwUkhhxlxxJxd09+qU5GQU4Z8DiO
 cdajkh48IECBk+cBCWQvFEfDjPg/SRVutK9eyZ/NP7jGXMFpFbO2pgECsLPZJEzVrtI3
 0T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bza9Wg/RyiC6VUjDcCKwu57gNegQP6dP/i6JoAQPDag=;
 b=ttRiOiVxqBrpYWinAZpsS6Ra59ydh6cKIyFeSX2DVrhjwNw4TjyDQQxlNltQSD3hGU
 CLElstihUJf4VH67PjIAkGR9PIaW2AILsHvmmyP6ikrZG2hNTzihe8hbxOp5LRZW3mc+
 /rY/Vfy+ZZkKaq50YPfWuUZThIINc9yY3O3UIa4wIRayxER0bOccM3SssA7nRLmfKyEi
 kTljamCxBTXxSJ54z4AHk61TmI9dK/hlTjqSDYVnERu3VJ5EU63XShfaq0Pk0Ix5EwvJ
 cvloKL/2eenBWiQKJltLn1F5j4jDv7AM4VkNRtvkz7Po1ujVpsla82ZASfaWrwFemfSV
 Oo5Q==
X-Gm-Message-State: AGi0Pub7Gcsou6EjYplvt/M+NTgHOXiukmJMyt6CB8bVxHyzg1QRdPL6
 zDRBgYFw6a+yomOCOu0hHAdhzA==
X-Google-Smtp-Source: APiQypIUwqXHhrgO9HAjhV94XPy+NFVq8XmWSj532UnCcM2u8A/4TJgVxq2/iWuVQrfJx/JPlag6KQ==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr18166249wme.165.1589300994338; 
 Tue, 12 May 2020 09:29:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m65sm16726095wmm.17.2020.05.12.09.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:29:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B47A1FF7E;
 Tue, 12 May 2020 17:29:52 +0100 (BST)
References: <20200326193156.4322-1-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 00/74] per-CPU locks
In-reply-to: <20200326193156.4322-1-robert.foley@linaro.org>
Date: Tue, 12 May 2020 17:29:52 +0100
Message-ID: <87ftc5f75r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: peter.puhov@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> V7: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00786.html
>
> This is a continuation of the series created by Emilio Cota.
> We are picking up this patch set with the goal to apply=20
> any fixes or updates needed to get this accepted.
>
> Quoting an earlier patch in the series:
> "For context, the goal of this series is to substitute the BQL for the
> per-CPU locks in many places, notably the execution loop in cpus.c.
> This leads to better scalability for MTTCG, since CPUs don't have
> to acquire a contended global lock (the BQL) every time they
> stop executing code.
> See the last commit for some performance numbers."

Aside from some minor comments I think this series is pretty good to go
and would favour an early merging so we get plenty of time to shake out
any bugs.

I've been hammering this with my looped build test and everything seems
pretty stable. So for me have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the series.

--=20
Alex Benn=C3=A9e

