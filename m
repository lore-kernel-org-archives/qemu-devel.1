Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29F1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19202073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqlqAliC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19202073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkh4-0001Qb-3H
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnkJl-0006VS-LG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:54:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnkJj-0001nQ-MS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:54:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id v3so13367178wrc.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZoO3pyibE8uz7naSIOnMdxj99BGlER8qDsCbmWL+SiA=;
 b=aqlqAliCDHnUhluDlEnLVUsj3YTRKgvhySTFzokrl1tBpilSe5B0zMphJVH/E7Gq8I
 4AqU9HPW8QzzwenNhSA0EuPeuj24+//hF+0DVKuo2Yars4f3FXLaec9e+Yp6vU6hpssc
 iF844jvVH+ieBEV8LuX+/BPs2jNTbEaloj3PSxw9zaF1hknZdmRA6Ot9ts46eT0LF2Y2
 k7o+UOTGZ5iZqiubNXXmRq+cgEKoMxGunmjaxu8uQrS+3BwkbfdL7fwteb3tP9f4XfIO
 MNDtwc9F293Xj8Y0dO4J2lxh44uMZ2S+1SWomZPw1UG02mFKKYynfXkKRLNp5YMDfMW0
 2I5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZoO3pyibE8uz7naSIOnMdxj99BGlER8qDsCbmWL+SiA=;
 b=iWSpkOJT1EGSPlH1K24Q4oGkj38Uh7WNQcYJB5RPTBErDXhdLC1y/CwWQmXtRdeyjt
 Tgvaxvao4nKd6tN+5G87anBshtj1K5kRR8B40GHOix8Ynfv2ZSXFEHAmTZP/gctfF9RJ
 pzZiWGFzbNdwdJ5qWVHPK+yIvLMBLONdOSynR8L/jyZKoB6PFBSNX/pZgswU1cHeaFVk
 rsGP3eXRJDGF8sbqHFLduJngnNsDAhvsVGnvpvcMmkDutqmJbYbHSQtbQ8VLbhoHGogZ
 mJbPG/CNLqfIXJDzpt6A7uSzJf5wm4FQb/4CZppKhcYpoU2x9wdO9oVJ/HyLi4vADI5h
 EYnQ==
X-Gm-Message-State: AOAM530tRr0h+4L6PeZIi0mYm3oTpW8ogK83cKjARMJ3OOjzIl912N49
 wujYBS8PtPHZXD5AmJXtb4L/zg==
X-Google-Smtp-Source: ABdhPJyln5omtga9prkeoHAdsQ+K+GIUz4zuIaukwLGsCQ06Ny4HVdnIlhk8s5Z5Xbdr5oWgpVkD4Q==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr3182821wrs.287.1592924069975; 
 Tue, 23 Jun 2020 07:54:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o82sm4283982wmo.40.2020.06.23.07.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:54:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 354F11FF7E;
 Tue, 23 Jun 2020 15:54:28 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-19-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 18/25] Compute reginfo_size based on the reginfo
In-reply-to: <20200522023440.26261-19-richard.henderson@linaro.org>
Date: Tue, 23 Jun 2020 15:54:28 +0100
Message-ID: <87h7v196jf.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This will allow dumping of SVE frames without having
> to know the SVE vector length beforehand.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

