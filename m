Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38203C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E40C2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEaYybZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E40C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyn7-0004mQ-BW
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNylW-00046M-Ua
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:36:58 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:46664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNylV-0001Eu-5C
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:36:58 -0400
Received: by mail-ed1-x529.google.com with SMTP id 33so5297164edq.13
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=husF9lttPF/NA5H/0DmzTsorX5YjTsTp0brecKbUlVw=;
 b=xEaYybZ5C/PGgCnu+UrlFxBefL4oUmD/q04KttWMdW/GCY/G+u8KYzAUAWlW/Wt4ph
 Bsqls+Q2mVqi0MWQo63gSBUuViqDGSUJCwWZ39VGZdJQ04Su92cexbhPwlr/llptJZUo
 xJuWfuFvI0tz9ii75aGvpvY9QDeZUCjP4c3GD3s+bpZSGJN0c4MKD6s/7eukidhdeoxp
 Ue83Ck+WsNju24RAGeniEsnIhyWQxirAzOnz6xqRy0fOZS3eZJ5aTTfW9Rh4Hc6j3/3x
 nxI84YvSQjw8eY9FzjNYXjomNfFaPdsmyv1qwsV1TYGRDI2siRduk9TPYalV/5weM21s
 PbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=husF9lttPF/NA5H/0DmzTsorX5YjTsTp0brecKbUlVw=;
 b=nNb+1pf5x2OanEcZgUJShP9kB2hW7E1j2WdZEubO/BSXHJ+cBJ6PkRwfDIBzv8hTkn
 EkmA8erntFl7pm61XJTRK+eh67JuU1B7UcCJ0Tynh+6PvCKZkfCUUXQHtyBKVObaKfMB
 Z0tCfiLhYTWnLkEWUtzA2BhVWCraahRjQABI5bN9FJMzQ+c9oiUUuO2gE2PotWniw8A8
 SFG/4eyAQpzb2wKeWfWc3Qgu4UOcZTqiANjt3KDRp9xbVQPCkl4PapPcBOmhlp9Cqrto
 C8VOifhZp2xychYL2w/k1EF21HpSiJe1cH9WiDb3s9mQFSUDfSyo8rTXjm42QRXfd61z
 Qt9A==
X-Gm-Message-State: AOAM531QJilKIRoFITD9Ij92BJ7ZISM+i977v25e3BWB55cZjc+EVwWz
 JMfA/RSwQv+bStGN/8Pe1NGCb60sEMqsPboMCyM1EA==
X-Google-Smtp-Source: ABdhPJynCzksZ835FH1Gykk7LWaa3bz2kv4W7LCdmoL2hFyw36NX6d+fI8kqN5UpJ8IRt6It54f6SXIMwnpRSL2eJb4=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr8613135edm.100.1601559415536; 
 Thu, 01 Oct 2020 06:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201001131439.386431-1-stefanha@redhat.com>
In-Reply-To: <20201001131439.386431-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 14:36:44 +0100
Message-ID: <CAFEAcA8_+aTi6VH9ffJOjp9yyYD+3HWoBVoGRon4-YA32biXsQ@mail.gmail.com>
Subject: Re: [PATCH] block/export: fix QAPI doc indentation style violation
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 14:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Since commit a69a6d4b4d4fae2e3d2506241e22a78ff1732283
> ("scripts/qapi/parser.py: improve doc comment indent handling") the QAPI
> generator emits an error when unindented text follows "Returns:".

> -# @addr: Address on which to listen.
> -# @tls-creds: ID of the TLS credentials object (since 2.6).
> -# @tls-authz: ID of the QAuthZ authorization object used to validate
> -#             the client's x509 distinguished name. This object is
> -#             is only resolved at time of use, so can be deleted and
> -#             recreated on the fly while the NBD server is active.
> -#             If missing, it will default to denying access (since 4.0).
> -# @max-connections: The maximum number of connections to allow at the same
> -#                   time, 0 for unlimited. (since 5.2; default: 0)
> -#
> -# Returns: error if the server is already running.
> -#
>  # Keep this type consistent with the NbdServerOptions type. The only intended
>  # difference is using SocketAddressLegacy instead of SocketAddress.

Note that the reason why the generator complains is because
according to the doc-comment structure this paragraph
("Keep this type...") is actually part of the Returns: section.
This is the same as it has always been; it's just that now the
generator wants the indent to match the structure.

Given the contents of the paragraph, it clearly wasn't intentional
that it be part of the Returns: section, so moving the text is
the right thing.

thanks
-- PMM

