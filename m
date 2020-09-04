Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79BBC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F302074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP6l6A3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F302074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEFw-0005lW-Pt
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEEF0-0004L2-2r
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:07:06 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEEEx-0003Ce-KP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:07:05 -0400
Received: by mail-ed1-x542.google.com with SMTP id l17so6597407edq.12
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BmqhTmNJ6ObjaaWvIsaHhotNeVlbuyYbxnOSGt97p+M=;
 b=ZP6l6A3WPQMWVEPI3sPyitBUfj9ex8VUo0aMBLGW3JTISiLrFSLV4/0doM0vF05ZYq
 6FItRu5jirdI8QBkCZP5aVYQutRFzKei5ag0TI2+IIDPVCdfn7GRF7tnB9iSVwizoLPo
 DGmmH0YSm7Sb3oIWK9AZuEDfM+Z8ygnYGwtr1qz6us6hYjMtDBTiLBxsm3DM2PAHKkZj
 K7131/ilyJ+bDtPK+yHeNw1GFLtwkevsHOerUCRJTkPLMkerRW7KDIsthuKaPPHeZZwn
 o/ZDNLkvWvqapAqArzcsd5BRBCHGJ2Ji40juBDdAuiumi/DzzQYuM3+4QG5kWJ69D9ti
 rCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BmqhTmNJ6ObjaaWvIsaHhotNeVlbuyYbxnOSGt97p+M=;
 b=KHMl/T/z3HcYLOWqQUvns5Q0m8k1Tij2u9WGc+oPiMy+zTmdPvLa6fkh9Y/0Uaegbb
 pLCrtd+TyQ/8+uP1wRGangEYYE4XzuqHAT/eXlCTMkzIeDf68n76u9O0tnoJ14+OPnKY
 BY0NhldzPQ2oj6fDKHOMlRhKEKw4iw0LUTkjUwDuKkVPCbDMEKrZhk519AC8Q8esx+25
 45W7nigeHkA1EWlXgytbQk6JVrdKB8w3qlMKFTFqG32iu11KXxne6SMh/COvGtkrCwFa
 rWPL4d5zZDJp5sxa6pEAtBXHz+yMvsjxpy/IpnO4EUV5RBAJEEF9/smh8Q9HwRpSilxC
 waGg==
X-Gm-Message-State: AOAM531XDfMitEDOK4MCPCCtPSUhYim66KRt/hG79e8rjxdEhtCRpXu8
 SZJKNgJEDeDAs1wbI2XbpblHWidx7xMrrF83bIkrNQ==
X-Google-Smtp-Source: ABdhPJw7Kme6GKeNM/7EjGb68X5u5Mx2+OLdEbevFEhXXeKtGO4/iZgztRnjQsBfqwbbdbQCSF24auKWFCaE+01DqT8=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr9004924edv.146.1599235621736; 
 Fri, 04 Sep 2020 09:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154156.31943-1-peter.maydell@linaro.org>
 <20200904154156.31943-3-peter.maydell@linaro.org>
 <11457fd8-725f-5836-e2ef-6c60aee344e5@redhat.com>
In-Reply-To: <11457fd8-725f-5836-e2ef-6c60aee344e5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 17:06:50 +0100
Message-ID: <CAFEAcA8+CSam2MENNiyafV7FkO2zmg4pb5D9Lv1gGjg_oxjzOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Remove no-longer-reachable 32-bit KVM code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 17:01, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Scary :) This is the if {} else {} removed, OK.

Mmm. It would be nice if there was a patch syntax for
"indent or dedent lines X to Y by N spaces", but I guess
we're several decades too late to add such things.

thanks
-- PMM

