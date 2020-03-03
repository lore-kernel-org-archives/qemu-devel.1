Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDEC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9B221556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHAEZBpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9B221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j96le-0005Lf-AI
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 07:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j96kx-0004nm-Cf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j96kw-0005X6-6y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:34:39 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j96kv-0005W6-Vo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:34:38 -0500
Received: by mail-wm1-x342.google.com with SMTP id g134so1621424wme.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 04:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kKeeUpWo/i1RJNlTBjL01q7UPupZYAfzGUP6DFzHQtM=;
 b=xHAEZBpJQWWN+GzG4ySx5rFHFMJcOz1UoE6ysAc7Z7SAsTrZPlKIqr5gZIy7Tb0rag
 fHLjM+HbuYeWlWtyHBPsZecY0zYRWXiH43v/9HiP5CxDyOsqWGq3Qz3R+yLssafMQlmN
 p0fkVnX/BOaVW37eVenWr2OlNG4l0qwUyrKfcJGqKAccXqeTJK9yesXrDT3auWbAdZ5O
 bjweLh//DmeSN3Ykjcat6BBkLwoG4iIevyqOCGdxVNUQk/ZJR45gOOkj5TS6TMb7/C32
 2Y5MliN0cZvTwdwhobmeO+RgRf5AGh9OZ0FJlRTYvpJO75GrY6BX+8j1+w4VFD+ZpRFd
 AYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kKeeUpWo/i1RJNlTBjL01q7UPupZYAfzGUP6DFzHQtM=;
 b=EmK2a17JOpr7KysCiICYmpwP1JTQRLO38FkdVbpUpg8ypwyMV0dwpcpYDG/xQgYiEB
 r7pHPDk/FC+thhwSaqFDPaEmQMx40n1xUWmV4oDYRW0o1YB8sIPpYJfnn9amB26UzYoe
 Qi1Q8YFSYCxbc3Wzd/Vckx9AmWrACC8IKPAy0acZ0/iZxQI4SvObeQLbX3ew7oAByILQ
 1zFzNTcrEy2h66FrxZ6tVC6yjSLtuszlQuFERyzq7HsQDTbUCqNr8TrWG1SiMn7eiQME
 /fC+hUeimUo3an6dJSfwj8utUz4gOAi5F3/vijWmywNvexrru8lqlfJ4RJfm5e0VF8mv
 d8Bg==
X-Gm-Message-State: ANhLgQ3jkNgWsuu4UDhgz9F6ZvJ567cDerIzBHEPAvpQGw1eVTOXU1KO
 +nM2Kkrr0lRM4lSmnxaUqBTpiA==
X-Google-Smtp-Source: ADFU+vvAawgTcHLpclSFsl2lrOoEvzu7eChVfFFGICUdW/vFCwHAuyBIliqcjisiZkRUFG4InlOyzQ==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr4093372wmd.101.1583238876520; 
 Tue, 03 Mar 2020 04:34:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u20sm3514054wmj.14.2020.03.03.04.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 04:34:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C91C11FF87;
 Tue,  3 Mar 2020 12:34:34 +0000 (GMT)
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-9-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v6 08/18] hw/arm/allwinner: add SD/MMC host controller
In-reply-to: <20200301215029.15196-9-nieklinnenbank@gmail.com>
Date: Tue, 03 Mar 2020 12:34:34 +0000
Message-ID: <87a74x7h2d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> The Allwinner System on Chip families sun4i and above contain
> an integrated storage controller for Secure Digital (SD) and
> Multi Media Card (MMC) interfaces. This commit adds support
> for the Allwinner SD/MMC storage controller with the following
> emulated features:
>
>  * DMA transfers
>  * Direct FIFO I/O
>  * Short/Long format command responses
>  * Auto-Stop command (CMD12)
>  * Insert & remove card detection
>
> The following boards are extended with the SD host controller:
>
>  * Cubieboard (hw/arm/cubieboard.c)
>  * Orange Pi PC (hw/arm/orangepi.c)
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

