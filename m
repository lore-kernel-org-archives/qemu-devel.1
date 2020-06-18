Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8222082F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eN5S4fhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8222082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvYG-0003O2-Fx
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvXb-0002oj-Hi
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:29:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvXZ-0002Gj-TB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:29:19 -0400
Received: by mail-oi1-x242.google.com with SMTP id c194so5248550oig.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dQViIVwGZ6bJrAOZdmtsYuDSJOMlVXqjHYSioefcoL0=;
 b=eN5S4fhxOvyeX1d3iPyIPQB020RNenb/Sm5TJ7VN/6TFC49jnpkZUbTa69K4ChCQY4
 4qdqbMgjAWBo/IEriCi3LtwOS8BFPqaCKnwiqd6MdLn74TDG4E1cg93vlsGhc1h4kPnh
 LWY3qKB4Rh3/ej1Ya7owAc9vh/6vh3Tdj7r+yA/RmaziwPWS8+e3j2EAOpvFjeXPUu6x
 lA2aVdx8xFCCJf/Xv2j/Z7fPb44yDPNZrOAR4CvHxigG8mOAld/JPU9wDSoKjyeGsuuU
 CPBNqRmalgw7FWfFEIf7RxArEqz6WHBSPvrxctANBt5CICF5D4G702JKkt6RLrcP8ko7
 QW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dQViIVwGZ6bJrAOZdmtsYuDSJOMlVXqjHYSioefcoL0=;
 b=RbwNVBZWw9u4eLRH3DhhWoOMuP+RFJaSf35PazLUqH5pxWTah9W/ioFIYxNEwg7qiY
 AAmjL2R/+OndqyodXO383XGqqF3gEKfUHyzQZyZd24DzNGkSxdqfdckiQZUaybFPFseJ
 ppaC7WmXvCsSfvLEyeCB6VMaZm47UuZ2AX5e6q66C1tXaVPgAUbMNEdYFFQVuwXzFi9c
 eN1+gg5K8N+bpHjWoZujuk4Stx3fKunX868vxnqKuNzvPn7nc+tLFFhTA/LS/ggf2drq
 qgSzkH4vI/1PkeOHjxA4lRcug9RfwyerZIB2VvfZGtCGgZsCM4MROz1N2OkRpHmn+gRr
 dI/w==
X-Gm-Message-State: AOAM533yX4EAJwWDAYC54AZU/ZJqsufbSxhvr1w6RmIpomynx023NB4z
 Eufby3Wf+VkgsFJApmbtpkYaxav9ERcTVwUg5R3ngg==
X-Google-Smtp-Source: ABdhPJzIbxxmLqtbrau/nOq7Z6iHz48+9i8dtneElmE/oBLcUBz4oMK5yPunEi75VgsmtLKQxbQ0FExFgG3Y+0SQE40=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3017003oib.146.1592490556688; 
 Thu, 18 Jun 2020 07:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200618121218.215808-1-ppandit@redhat.com>
 <87r1ucv7pe.fsf@linaro.org>
 <51f137f0-89ee-e130-a43e-c82d0b3623fa@redhat.com>
In-Reply-To: <51f137f0-89ee-e130-a43e-c82d0b3623fa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 15:29:05 +0100
Message-ID: <CAFEAcA_O4SD69v9QvdA=_AVmQgQoNzHHrBYPN0b6BLDiMzFtdg@mail.gmail.com>
Subject: Re: [PATCH v1] memory: assert MemoryRegionOps callbacks are defined
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 14:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> - tz_ppc_dummy_ops which is broken and should just use NULL ops

Why is it broken? The intention is to create a MemoryRegion
which asserts if it's ever used (because it is a QEMU bug if
board code ever actually maps that MemoryRegion into anything).
NULL ops doesn't do that, it creates a MemoryRegion whose accesses
all report an error to the guest.

thanks
-- PMM

