Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C34C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1869F204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Spyf5auD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1869F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dYu-0006kl-SQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3dR4-000183-Aa
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3dR2-0007in-6s
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 9so8393685wmj.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DpFloc4F+NrzNfX/APleLAoGihUtSc9ljTfDQuKF5RM=;
 b=Spyf5auDC3SRCeZWuxIXLutacux6aNMILeN1EMQQGY3XqQ02DuaTYVsz+1eBZ0rvRZ
 Wi2VWrRhD3I2kdg4C674t8ZTZmSsVGIsg8qv5jCFe5cia2JfL8Or9vDOfgUSKxHjzEBp
 aVHlT5YCPHnWwEK3wy5rXkTKFjkO42/z5AVXoOqA4oQ5YHhnRfY66HxUfNC6C18aIaMN
 VA4a+dZWF1stdu451Ymu5Sd6DZcE3924gcim2HtNZd8JR4l9YcCtPFHLkcOGMx8V2ddI
 FV5Nruz1fd2tDwxT5whuLe2+ZLQNcvZe0e+nVDUHzbhgitG9LQwMpykRqoRdv+6q99f3
 Vpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DpFloc4F+NrzNfX/APleLAoGihUtSc9ljTfDQuKF5RM=;
 b=I+AVUck6GaTcG+dOi4rpgNPaL7YxzuT96gkxgcW1KSBSvP4tO1HNJ2YsEZpCc6lim7
 KF7My/YgqbOacvCLJZOlcBAFEE9WaAsuorvFKIsaosLCt1zahr1vkmMYxt8ozufeCa80
 HPiLVPkfIEBAxoDmS2VN/yKoGPDzKLV2TEpRg+QGmGVZZYPMHDcEefT+a1kngKaCHBH2
 1C9JWll1v3rLUC2pUlyIQW1QfhBNVEL89zyBd9+H4Kce9ARB7JeniKNda2+Os4RTe+p+
 E7a5qkf3kk4+ymCKYv4YdRmp7EColOJOds0nU/Ie5Lf1iUiS89oA8kYONTRr+TIrFB9p
 u/1w==
X-Gm-Message-State: AOAM533c/HIVZl45vkawvR8bxyhLOs5cwJh8NakIV8MWjucr/Q1yRrlU
 XIufwHI7jgD9oj+X4SEaVTW9sH93j4c=
X-Google-Smtp-Source: ABdhPJwvPbtPgA2xSpiPY7pD0Rlyqij58IduCZXFJq0WsIHa06r/RmLGOCexyZ7olOurVRCN3trO6w==
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr7955973wmb.154.1596710860007; 
 Thu, 06 Aug 2020 03:47:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g8sm5783248wme.13.2020.08.06.03.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EECD81FF7E;
 Thu,  6 Aug 2020 11:47:37 +0100 (BST)
References: <9C8E7160-7A4D-4002-8DE8-6BBFE0C2240A@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Qemu web site down?
In-reply-to: <9C8E7160-7A4D-4002-8DE8-6BBFE0C2240A@redhat.com>
Date: Thu, 06 Aug 2020 11:47:37 +0100
Message-ID: <87o8nokq46.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christophe de Dinechin <dinechin@redhat.com> writes:

> Hi Stefan,
>
>
> The link from https://wiki.qemu.org/Documentation pointing to
> https://qemu.weilnetz.de/doc/qemu-doc.html seems to be dead. Is the
> problem on your web site, or should the wiki be updated?

It should be pointing at:

  https://www.qemu.org/documentation/

now.

>
>
> Thanks
> Christophe


--=20
Alex Benn=C3=A9e

