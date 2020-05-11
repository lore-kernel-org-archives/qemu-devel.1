Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13394C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AFF20708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ebuygst+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AFF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Nr-0007ae-WC
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY6MU-0006jm-8t
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:12:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY6MS-00062o-7Y
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:12:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id v12so10382664wrp.12
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9yzFIdldPL/Z7DlAJrwJ00GzTZpR76To7YfUsBx8AtQ=;
 b=Ebuygst+lfRShO9rijgamS/XSyiJjcGEjhXN5QB6HBAz7GUoOsz9fSgh3hmNO9un3e
 E8XIlaOpKDT+zHunN3vFZne/4OS9ME39iHxdgIuKeI02IKfAVzYLIxc5mbh2VKA7GVbQ
 jDysPMtCctZ3xDnjZxAVHNXvVeGbmyBNQatBgqlB+6ERPWYmYYZ6Bz2q0DUMsuUEdXc4
 92B2gr9hT4hIhnsdeaLqDe6Cfslsl74B0sZRRRx3/t+/8wjeUTZGtYE/RUXHhSxLqhoy
 Jyz/JryrBxmZ14WY0vkNR5tCMiOFsu0spXO0sAYNi/qVBdvUfzC2qyJjVDUQyrJ9Htwh
 0JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9yzFIdldPL/Z7DlAJrwJ00GzTZpR76To7YfUsBx8AtQ=;
 b=FYduYrOvDBzyMAQ6YXEyTxMRyDW2hiEB6OsFPjrxCBX0+5w83ujDmLuulbQOsABHPS
 9ZlnHkfnNd1clAf84cvAEWPGrieaMjZE6epBF9NyZ0nWiOksMqGZMhrfJ9+yFz39YHAd
 o92qEtx/2eSyIMV2Oa0B0xZKHOF1nKa6tE89hSuu7ClTRYQVl0lMhGcOreFTbqrY11e2
 aCFT2PaFjv8WDRnPUMqgV78KG3erAGkE5Q5hweSTAIAE6expVGlz7KvlRnM8rULkjKE0
 jpGKqEltRzDnmxM5h1rwZQiXVvSKcdhI6Lf6dA29IKuE8fAww7IZ8wBnVRtEiqL11P4G
 /szw==
X-Gm-Message-State: AGi0PuYfu4kgk4ppVaPOR+PcU9kHZ29PV7h41Nyx+OIbvheUTj6JhjFl
 IarlRfC+5ox5n82OYv8A211pyQ==
X-Google-Smtp-Source: APiQypJbhstVeDSCOYeQa73eo5nMTxAsyHaYfYPiHgE10PDaWZchsBpvEdOyRQhjQk3ZE4H7e89ZkQ==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr19564571wrv.73.1589195558249; 
 Mon, 11 May 2020 04:12:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f128sm13960763wme.1.2020.05.11.04.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 04:12:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 211101FF7E;
 Mon, 11 May 2020 12:12:36 +0100 (BST)
References: <20200501145713.19822-1-alex.bennee@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v1 0/7] various tcg and linux-user updates
In-reply-to: <20200501145713.19822-1-alex.bennee@linaro.org>
Date: Mon, 11 May 2020 12:12:36 +0100
Message-ID: <87tv0mg1y3.fsf@linaro.org>
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, riku.voipio@iki.fi,
 richard.henderson@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> Cleaning up my queues into more focused trees these are all tweaks to
> TCG related stuff. The guest_base changes where posted before but
> where a little radical for 5.0 but I think are worth getting in early
> as it enables the sanitizer builds for a range of linux-user targets
> we couldn't run before. Finally there is a little tweak made to the
> out_asm handling which makes it a bit easier to see which guest
> instructions are being emulated by which host code.
>
> The following need review:
>
>  - translate-all: include guest address in out_asm output
>  - disas: add optional note support to cap_disas
>  - disas: include an optional note for the start of disassembly
>  - accel/tcg: don't disable exec_tb trace events
>  - linux-user: completely re-write init_guest_space

Gentle ping,

I would especially like some feed-back on the guest base updates from
the linux-user maintainers so we can get the sanitizers more widely
used.

If your happy for me to include them in my next PR I'll just take some
Acked-by's ;-)

--=20
Alex Benn=C3=A9e

