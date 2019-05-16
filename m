Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F68C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C4C20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFnOJc48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C4C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53620 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFIO-00078f-G3
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:15:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFHd-0006o5-Fv
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFHa-0007Ct-FF
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:14:49 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:38500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRFHa-0007C8-7x
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:14:46 -0400
Received: by mail-oi1-x22c.google.com with SMTP id u199so2315821oie.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=FvOcv/Iz640Pp0geIixoVZyOao9FH3Cth/px3i2VBwE=;
	b=nFnOJc48bZM7LhtMbGOKj0Rgy04rFR24OICP2ChSfOMmwAVAFNRLLLdp2oIA0aZTnX
	V6LpRjErrxRlqbcdtGY9jL7tvEsJhVuRzJXWkWB+GFMvMSpRG2UCVdSrzw3gnX/FTHq3
	28tL2StJzldVh61l0R5RX2crr0xOHNtvCWG+X399CYTEpXi9+LsNfIuqWWo+zX9lFUmW
	zuJ4D45NB6a+NF/8STmYtCTfUm/ZHerAfuK8xX5x9JvUInkLnG/g9+Dqcl6OLXqrzHem
	neo/vpGqnaLxNRQHi2zasSyWy8axdrZo0msN+/+q9/mDcH9i3mR3QzC+fa+rgKUvB3Xw
	dZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=FvOcv/Iz640Pp0geIixoVZyOao9FH3Cth/px3i2VBwE=;
	b=kDq54265+LDNOYb8Hv28g0dvjEjY0uERz5zv/0eYfPY1r8Z4YX08cBy2+O+/l1tPYg
	iaRkXS56ekRCdoTuSod3kYH+G/Di8Cx2b+Ruyfnftm3PBcOj+3cqrjj/Ow5IM7CIWTFD
	bkkP+Iyjh6fvUKIv0Xvl5ce3GOAS4EjuMn0RZwbZIaDBSwivQCBx8hTd3Bt7J45Oc2Hp
	xT49Wss/3zT1FU5jkuOjR6QIdgDoeiShCQOK5cKdmWhnV/vOHCQFYCaHmyYiygy9/87L
	oEXdEbb9RDeVaBF6VuQnnzY29IldzBN3N9q/TH/xDegEGxS9gaNO57ekAfoC6aiT81eo
	1kkA==
X-Gm-Message-State: APjAAAXKfyh//pQaYIG+x3NXF7aQrHXJpoXgpO7zNTQhBWMRzcFRIu6K
	80Ms6lT+CwDiNerJ3rfNgO9vSdyGBNYobsL1DwHyig==
X-Google-Smtp-Source: APXvYqz8GhJFPQaUeVvYz+muaqc6HMYGoO9G/3CKfHB92qO/U2GVNuOoP6OAjzEFy7MRtETHD5HOc2grvLU74uJGvTY=
X-Received: by 2002:aca:845:: with SMTP id 66mr10282953oii.163.1558008885095; 
	Thu, 16 May 2019 05:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 13:14:34 +0100
Message-ID: <CAFEAcA95TtKvc0iy7UAKvBYSzj+=_WbRXug+E7MCStbOnst7_w@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL 00/21] Misc patches for 2019-05-15
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 May 2019 at 21:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e329ad2ab72c43b56df88b34954c2c7d839bb373:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190513' into staging (2019-05-14 10:08:47 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 88f1090e9020057022ac04531ca87d25f67f57ca:
>
>   hw/net/ne2000: Extract the PCI device from the chipset common code (2019-05-15 11:56:54 +0200)
>
> ----------------------------------------------------------------
> Mostly bugfixes and cleanups, the most important being
> "megasas: fix mapped frame size" from Peter Lieven.
> In addition, -realtime is marked as deprecated.
>
> ----------------------------------------------------------------
> Chen Zhang via Qemu-devel (1):
>       hvf: Add missing break statement

Hi -- looks like this commit needs its author
email tidying up so it isn't attributed to the mailing list.

thanks
-- PMM

