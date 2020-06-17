Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00833C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E9B206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpr+ZxsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E9B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jld4p-0007w3-0a
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jld2y-0005Y3-0b
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:44:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jld2v-0000ht-CI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:44:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so3471046wrt.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YtNazOednAi6MOOw9lenaekpAHnI6NKLdX3/PjslyFw=;
 b=cpr+ZxsWbDKb4OVyNaBwtmRejPSUL5S4/1xfzLjZduDqwahH8GvZXv00/DV2f4ADn5
 nJlw/We/5Nd7nyqMaGsJypBTzsQnutgFpCTPWWMA9Xgmr9r6z5RKckDWYvDlmaggUQep
 o1moOeS4KxjniP1BFRYovIwsBpNPP/zavn3ZIr5u1WsB00KRhGTSRf6t4PTMSAqiZ36Z
 gow9mvrWwaXDLCOm5VopArMaGXyBG/68d1/WbD5Ttj4tbOCbbgf+BWjiOX1ZRKgifo9F
 s4OamGzU+gYSf3YeiDrCbzCMITsxLgb4jLcAHIKGoaGTwB3ip1fSAAsV1BpAmXoj/did
 o9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YtNazOednAi6MOOw9lenaekpAHnI6NKLdX3/PjslyFw=;
 b=OfqAL0b0CgOXW597skkfdjaPOE2NV4WC6ZJl9TpEyPa3XFcXy1bobSFvS8mv1gnKGm
 Q5OWOgphjwLK+QVXwvUQ7tExzoQk5Aj+1OZ0HSwb3y0rj8knxXiPggos2M+UrV5zBFpz
 OoDUnecpQaWNoo1WFLLpzoiWaJsLNB7/bv/BCktri1mCrPBwcs07KC/R4/YMpg01plHt
 0N5vzWyJr4C1S8ad7uzfM2xTJwS+rc+8wSzTN4Bq4Gf26Qm9sYLoXjlGwLiS8jE7LbO4
 uhFkWeibyp9ltdMEeSngMCtHmnt/Vb3aO1SuMJjpdXlqsmlQqUnpAstg4q33AHxXyCsd
 sEIA==
X-Gm-Message-State: AOAM531mUowZ633oo7OQcYDakrt0iSkPxReiNq5aeEQmJqzLLxJ8rwOV
 o62EvQhOa/Xn0EOYLAxianUIYg==
X-Google-Smtp-Source: ABdhPJwusH3lhFbO/4VXHNdvLMEoQY4u0S4V8EBiktE+smoQ/gdhKk6KbttLGEMCmzoRu/a/uNB3cg==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr630985wrm.346.1592419463466; 
 Wed, 17 Jun 2020 11:44:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm509666wrm.57.2020.06.17.11.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 11:44:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 475731FF7E;
 Wed, 17 Jun 2020 19:44:21 +0100 (BST)
References: <20200601211421.1277-1-robert.foley@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v9 0/9] tests/vm: Add support for aarch64 VMs
In-reply-to: <20200601211421.1277-1-robert.foley@linaro.org>
Date: Wed, 17 Jun 2020 19:44:21 +0100
Message-ID: <87y2olv8fu.fsf@linaro.org>
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This is version 9 of the patch series to
> add support for aarch64 VMs in the vm-build infrastructure.
>  - Ubuntu 18.04 aarch64 VM
>  - CentOS 8 aarch64 VM

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e

