Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBDC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D7122269
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhBuS/6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D7122269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnUj-0004FC-UM
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHnPU-0008CI-N3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:16:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHnPT-0006dI-08
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:16:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so18448927wrn.10
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aZw1WxSuW0sHSx0EF1KxXnXje58Wqv+vyxNnd2FH2fI=;
 b=WhBuS/6HfUFoqmD99R2S+1IEaS8Ux05pruHVDOei+01UrjrY9kma8DUED/qNCe+xRV
 JaszOz3q29L/EQWPe5UHs8MGy7SsbnN3TLLQo3sSQ87apibaLicR5vclnM/Io8bcK41z
 dWYjo4eHRLUwhPbYQJoMue1QSuZR1i6Keps46GPsqAFTPpIGLvFXoAKNDD7xE0aKAIZI
 bCAc2kVch7Au6HoxRhkuy3QkwoDRFpY7p1GnSAXZR8iMr7xAVdfimCNgUl9IcIx/36CY
 m8fYTsa948WTQvN+WQQJ/pSQvPO/wQHj0T6vEhQvbC4pBNQ96bjnhRnIIY87RQQALddX
 rbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aZw1WxSuW0sHSx0EF1KxXnXje58Wqv+vyxNnd2FH2fI=;
 b=rqphE2cZZQbcVi6B8ozbOJkbQ1Co3Sk9zPqmDjOrPnuD92Rs71rNYcEInUtoOT6dWY
 5YKZYa8zHI60XTn2O1TrLLXxzOzAmyGz1wjWoddol20PTdK+5f8Iu0LYovVRWGbC/0V0
 37kKXC6YzBQPadcmpB0w/aV+ba/nadFY05pGVBAlqpY+UoXBVgn4Di8+jHoVUGDko8wG
 QMw/UWafPE6JNGPSltxE+9S39Zml2phoOilyfCF9unK2GvCRuAvYeU0aIqozd0Pwcp9b
 Z+2odccJEjhD0fhB/mfkx7PI570omJT8d/UO7TQ67zBYCTsAv3uFzq+mYUIqGWaNHClX
 0egQ==
X-Gm-Message-State: AOAM531jEC/H4XFFFYmaCGNvZxocRMio2A+KilZLBehDNExRaiLCyvki
 ebymI3I8o5B1J4aDgMtr0p4rFw==
X-Google-Smtp-Source: ABdhPJzSWJTDhLV5h4SIZuRNSkPHxdm6r9rG/hhEML7L2fnT011XDllvEfj5XWzw2OE2I7QSq7vDGg==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr15044578wra.88.1600085796694; 
 Mon, 14 Sep 2020 05:16:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q192sm21013199wme.13.2020.09.14.05.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 05:16:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F25CC1FF7E;
 Mon, 14 Sep 2020 13:16:34 +0100 (BST)
References: <20200914113809.63640-1-mreitz@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] iotests: Work around failing readlink -f
In-reply-to: <20200914113809.63640-1-mreitz@redhat.com>
Date: Mon, 14 Sep 2020 13:16:34 +0100
Message-ID: <87h7s01rkt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Reitz <mreitz@redhat.com> writes:

> On macOS, (out of the box) readlink does not have -f.  If the recent
> "readlink -f" call introduced by b1cbc33a397 fails, just fall back to
> the old behavior (which means you can run the iotests only from the
> build tree, but that worked fine for six years, so it should be fine
> still).
>
> Keep any potential error message on stderr.  If users want to run the
> iotests from outside the build tree, this may point them to what's wrong
> (with their system).
>
> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
>        ("iotests: Allow running from different directory")
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e

