Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C218C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 22:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECB120786
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 22:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SL+fkNvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECB120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZiIF-0003XB-MS
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 17:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZiEn-0001U2-EP
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 17:23:41 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:40424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZiEl-0002g2-7T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 17:23:41 -0500
Received: by mail-ed1-x533.google.com with SMTP id p93so15948361edd.7
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MTJ4lwKWcG79B9yyKezHd+0lMdDcxCVgIAGkATNhNg4=;
 b=SL+fkNvKkWxiuCGlN3E57SXu9vaW6iTGRD8cEp5QoEFPaqBcclsgRI2CEA7GVaitz+
 l7W1foqrsXcFEU5YPkbKJV1KsDkUX33085poVlJFSqb3e5NB58ezAThlvqKf2YAIQa6/
 OoAn+K0fIN4HcLcHfa8lK2Fa2IOvt90Ztr/rdAkMJ1MzCh7MMX1yK53VW2AAihhzzLRL
 GulJWlRgvq0LnBDX3xLgWMtJSjEavB/96LChA0WVyFMEf/lWZlhi5+VDzBsSheMDfZo4
 pkZGnfglc8Dm9vDp1CwJwdWbzesB3AHuS3ryLkNNxAhCv0Lv1+nwrtgp8lhUH1Kg+nm2
 B27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MTJ4lwKWcG79B9yyKezHd+0lMdDcxCVgIAGkATNhNg4=;
 b=EHvsYmMxLrlluHHxDAavtHWGQF64mzn6MmqFRnfmV0jJf+6DPurwBmf6qhdWGZ0v3o
 G0N93jvxpiTQRLtTaQeN5FqzN8tgkZMNyhwzj8Hn9HjdPff11NESJb+47vq4XR3vfc0R
 /edgCcI4lItygNvz672E427z1vG35aRr+N3aFSwS2+RaCb1/A0nPqqJ5u6AiC2bfDGPO
 9v6CNhCVMmcwnp0akcx1ZeE5bHllsYKA0baTW/2oSec0yRN7kip+9lZA6zRWbFqn1yE6
 9oo56n0Hacz9S8Q9nKbRj4JWFsdzl4/DbQfSHcPS79AytUgaM8a5Z6UHTlYbVRAysK76
 Atnw==
X-Gm-Message-State: AOAM530SCll7pwaDR4ymnJM+qGhADXQwmxsKieLAS2lAjbI6jN7IvDt4
 YQyZ383e8gRDNzFi48FjKheB6XkE1MeE1hyyWWGHlA==
X-Google-Smtp-Source: ABdhPJykYphr0VlGN/n5kvEzXS9EY1X2E0fpjlA3j9eJNYyRl6CLvEuIQZY986k+cJYMuyz6KMwK8bSpXExrstmGrGM=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr19412700edb.52.1604355816927; 
 Mon, 02 Nov 2020 14:23:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA93d5VKj+jbJQcyxsG+54G32r1k53DPT8rGRqZcROU2hA@mail.gmail.com>
 <20201102203723.t7p4ildto3xbbdsx@function>
In-Reply-To: <20201102203723.t7p4ildto3xbbdsx@function>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 22:23:26 +0000
Message-ID: <CAFEAcA8dfDPe2=iaMB3SVtJ3Z3ZPaqXVmxtQC2JYZ3AX2h_Uqw@mail.gmail.com>
Subject: Re: Does QEMU's coverity-scan run need to track coverity issues in
 dtb or slirp ?
To: Samuel Thibault <samuel.thibault@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 20:37, Samuel Thibault <samuel.thibault@gnu.org> wrote:
>
> Hello,
>
> Peter Maydell, le lun. 02 nov. 2020 19:54:14 +0000, a ecrit:
> > Do dtc and slirp as upstream projects already track Coverity issues
>
> We started tracking them yes.

OK, so I can just dismiss anything that comes up in slirp/ in QEMU's
scan; that will help to cut down on the recent buildup.

thanks
-- PMM

