Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1002C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D278E2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGAdSeVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D278E2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGUc-0005Gp-HS
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVGTd-0004a1-OK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:56:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:36007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVGTb-0000Kg-Mf
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:56:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id w27so55215ejb.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T/nt0HmUOjpMSa61ZahDw+tiEyvkBpINbyq2D/vxEaQ=;
 b=eGAdSeVrScHGUpVg4RluWROkCuRXiFcOOe5aOpIA7OCjHgEUByc5N0lcM0ZLA5LBXB
 fUXfQt4rU34qFzK1WwLqIteIW0wC5Geuv+8NnAozBjj1kYq6aVPehVh61qLB9zPwyQqG
 +c5mTYbd76aq+cDvVB5f6vC3bsq4FiMAgr0JyrjYp3Wr2sVHfYEvvp3cxtR8xPQa1yvc
 vkRQRU696JzYG+siZ2SxgGHCLxdApFR2NsbQxHKw1WWD3Nq9WcjaVhip9YGeHcr61NfI
 B0Nks8Cv3K8RUpnDDHGBK9iYZxMrq+XlTsyWwpzmwnPfYzjExijBCDGRD4q6WuE3LLwg
 GTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T/nt0HmUOjpMSa61ZahDw+tiEyvkBpINbyq2D/vxEaQ=;
 b=JPv8YM1h4eY+F2j+Qhpj9xk7GxuGKONnfhF+EuRS6ZumKW1HRYnmYLoYVjxMShnm90
 VryyeSDwgF5hUHeYsjQNNnM7FPgviZ58HUO/NtyVcTcsc3DVyfkSH3gXpzf6aiarRWXJ
 OGLldZRutCZ+nJGGe+1foX/f7XUE1AW4r7uzkxWLpsMZvfVag7vbYLgJ0EnFgM/u+K69
 6D4x7y1B/KPhBf0B2P8hYhHcEBAlY2DDYWfrAHrbwuyVVO1Dx0ywGxFMIeoX7u6DiiBA
 QVJZ5naWnZ7VFIOJC6LK3dN7nk/PFO23j54BDy/LXT5njnIOOYsDpowGkc1MrcJhUIdA
 HvtA==
X-Gm-Message-State: AOAM530MC6omKn9wFWttcfS2eHlUKIFSuIANNEPWqJTJZRHIwfar7hdF
 ytZWqnT9lsEAlphmsmjOiPdFZDU/e+N6EOiHBxGpSw==
X-Google-Smtp-Source: ABdhPJw3hEUR942Hu/kGUi/qmRPq7805lJdqS30vK/fGKqZJjm9BF6I4xyoq0u2WZ8YQ9ryhXc+zaRyXIGDxmC4Sjw0=
X-Received: by 2002:a17:906:af8d:: with SMTP id
 mj13mr4118437ejb.85.1603295793752; 
 Wed, 21 Oct 2020 08:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <3d61f127-d3b0-c8b5-877b-434228bcf275@redhat.com>
In-Reply-To: <3d61f127-d3b0-c8b5-877b-434228bcf275@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Oct 2020 16:56:22 +0100
Message-ID: <CAFEAcA91302TiXbL9rnRRRsZwK8jYLZtd17JtaFXXr+1P2k5Uw@mail.gmail.com>
Subject: Re: [PULL v2 00/21] Python patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 20:10, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:
>
>    Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020'
> into staging (2020-10-20 11:20:36 +0100)
>
> are available in the Git repository at:
>
>    https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 39cf73c3494045b4418c9c1db8e803640e2150dc:
>
>    python/qemu/qmp.py: Fix settimeout operation (2020-10-20 15:00:06 -0400)
>
> ----------------------------------------------------------------
> Pull request V2 - Squashed small change in from Nir on 20/21.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

