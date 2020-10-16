Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0DDC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5CC20720
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBkEPSMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5CC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTMJB-0000oy-JA
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTMI4-0008Jy-VK
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:44:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTMI3-0007VT-7C
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:44:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so1957702wrm.13
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iTcV5txo9BNK0cK89p5RnsfBRNdRItPTdpFU01/9dBQ=;
 b=mBkEPSMS8+prgSrihnmamryk/UzhOovUphuWSH9xYgItTcuoGz6C3bvQPhOzGz6Cfv
 ZjUuKkGgy4amwjy7azd/rNVXDfewfGAdHHjuWevEPA8L7Cy+E0LbJMUTyUp7lSdxgeGP
 EYc4BwuIfFEfaeszd/04JV3JK7iFVPyEyCRmeU+0W9lWzZXnb5wFVg4a8+xJl6kTxsCl
 M/ErA9WKC+hUK86HSgcYcebere8Uk3R0UEWMIbWoPeEuz/eHvOwfOL96++hhxXo4taLA
 b4ysETbTuyBRifcG3IyN7VtLQmNXikZisW8elkAZgqGQap67SrCs97ZjvXWm3tnwJfm9
 GgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iTcV5txo9BNK0cK89p5RnsfBRNdRItPTdpFU01/9dBQ=;
 b=EfXJonrCZcbj9Lod9QRzdfKgL4Bsfh+UhVhrzfG/UUsglYUfDjrkf5xqrw29QihYNY
 b5gxEnB8NNmaUL7YnDa/a7BC2HXOGHaHGNICona3+ZHjgHgMGHMmalj+dr5pQ4F+dLL9
 +0xpkIzFszBP+QFLiJUMS4+ArEFvJkRcplDU8sFNVYD9BFBCdsyjxXD6HcyhMM3H80uK
 aan9kHHkNKSp24WUxes1O+axCrC559Dcm96Pc5phCOZHVF5+l0AMhlcTM98UAzpIhxv1
 QjbyNmTFVQ31Yx5h/RuEarjzC2dWaPzDZpRx0/oPDvt0iBvi1VLyOWh7AvwphgarEsF3
 1DMg==
X-Gm-Message-State: AOAM5309hOLW40LnDvc41NrSf/yubraDS5k/RaUMECf0V5K+gcoTFfBH
 zfU2h0oFyWN/uQd5SZ+dmw2kLg==
X-Google-Smtp-Source: ABdhPJwbomeIDDVzl9k+MQNs703l6Kseuz9Trtw2FFZSOTsx7L3Ts4xwEoyUIAcbwf51I9Ky/cWyxA==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr3106316wrm.53.1602841485494; 
 Fri, 16 Oct 2020 02:44:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm2825341wrh.94.2020.10.16.02.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 02:44:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C0991FF7E;
 Fri, 16 Oct 2020 10:44:43 +0100 (BST)
References: <20200925152047.709901-1-richard.henderson@linaro.org>
 <20200925152047.709901-5-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 04/10] softfloat: Add float_cmask and constants
In-reply-to: <20200925152047.709901-5-richard.henderson@linaro.org>
Date: Fri, 16 Oct 2020 10:44:43 +0100
Message-ID: <87h7quwlmc.fsf@linaro.org>
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
Cc: bharata@linux.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Testing more than one class at a time is better done with masks.
> This reduces the static branch count.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

