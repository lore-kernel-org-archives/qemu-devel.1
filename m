Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B0EC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE81120791
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC+Rahmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE81120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUS2a-0000V4-T5
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUS1o-0008TP-LQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:04:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUS1m-0004OQ-FT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:04:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id n18so10701999wrs.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9tXUtbjT0Nni1peQodrX8lGNwRJhm0G3z4a+vrd9VUM=;
 b=aC+RahmbSWysp4DLiV8UWSJ/FSkXFbw6dE4hat0uDsjviWWpX3rVTNL/sA5k14/b+d
 ixoZBSFJw9mnvoZE0PDvqnFfsNeJ7+lefKKymoTpZzUNRr3+YP52BpDYre4+LLwnDa3J
 jTHF2CTGTskCjdeDX8RyzJALCpAXsXmTDsjiLL28sMUcQbSrTWKnGTUwbXkr5mgLEi/8
 l6e2aCRu5gqkcYTmgUt7t8sBidFvTO8S8AXQzyKe/A2d2G4UogMn3fOhkkRTT18xP1PA
 ex8ee5UVzTmqlNgyHRaLlnuoicUAes9+8GREInIFaKCpX3B+zywQOPmcMYpkLnbauRS/
 FG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9tXUtbjT0Nni1peQodrX8lGNwRJhm0G3z4a+vrd9VUM=;
 b=bkmkOwN3B17mxIC1524b+WJzd19YNhP/HybuBZavFLLUsLfWWjT3L3aMf+Go48OmKO
 I+QETB+oI72xa1Einrxa4hj/pNIw8/BbtzHeJG7KNo6nWSl3W4i/4Ur4BKgUBdd0m947
 W1DdmYE92uh1NrHRTzuUPXyKiqP1r0QnSbsmOe6/8UuA79N3oCWKMPd9sCVfdr1X1IVM
 FeYxr0XT8KpSXYsqHAytZck8BhF7xbW22omPMpQBnbOagJ2B6VCqIRVz0Es+aF1TNnok
 JCTnwKwTJD+lBpddlQ3AAzBaekupbwK7UhNW84ZkAF+ZUZ+gpXvhSwq0z85kANLUil3e
 8R+g==
X-Gm-Message-State: AOAM530g4pcD6ZtXQ48dHyyeXBtUGKM8uEcV8/SjP2btPci2gJFjf2fg
 2y4WgjiMrYRDlFhn3cNtWTTL/Q==
X-Google-Smtp-Source: ABdhPJzRrkGbn4jyFjZbMoDHtpxHc4pUkIpjZ5icOtHbJ4i7erKICXXnqcRC+3jmwHPsDgAinuPocA==
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr1628574wrw.64.1603101868839; 
 Mon, 19 Oct 2020 03:04:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p21sm15469126wmc.28.2020.10.19.03.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 03:04:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8324A1FF7E;
 Mon, 19 Oct 2020 11:04:26 +0100 (BST)
References: <20201018203334.1229243-1-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] softfloat: Mark base int-to-float routines QEMU_FLATTEN
In-reply-to: <20201018203334.1229243-1-richard.henderson@linaro.org>
Date: Mon, 19 Oct 2020 11:04:26 +0100
Message-ID: <87v9f6wmz9.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This merges the int_to_float routine and the round_pack_canonical
> routine into the same function, allowing the FloatParts structure
> to be decomposed by the compiler.
>
> This results in a 60-75% speedup of the flattened function.
>
> Leave the narrower integer inputs to tail-call the int64_t version.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1892081
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

