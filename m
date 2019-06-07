Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E5C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9152B206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sipoI0Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9152B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFjz-0005ZJ-Pj
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZFPb-0007fA-Vw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZFPa-0006E9-8i
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:00:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZFPZ-00068g-Ub
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:00:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id m3so2308013wrv.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bbHrd+1oT1EGHZHobSPDVK3Bdjmbg6xGN6HNd64cG8s=;
 b=sipoI0NhONQAXhKd5VKsrWw/ZG3cP1vpLacRlO4SFXheuxTBX7JcsrvcOup1RSYzF3
 0Qhqe09LpAIuivAvIWEEvpkbJvfSkM9eKPz4TgDgaxKqV9XCCtloVay6kNyUArwr8WCL
 jfXIvya2P38eHXvX1/vr6IMUCe3i+bsC6AVgmNgDQyjWIKuS4zeKm+4qwSK6O7Dx3f7o
 DRdL38tMdz5mTE/nMBvLaW+coHXFGrdCynkzUOw+5zyggfQxossXEWgSS8gDxh6kSlHg
 qubXEvlBJcPyh9g8XTQPG5/iFeiFw7KPsNRfI+ue0wNuKLuyZKbZSP+9iRMGne7cimJz
 fycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bbHrd+1oT1EGHZHobSPDVK3Bdjmbg6xGN6HNd64cG8s=;
 b=DOaZVDIzU56jXGEHYhqeSj8+b7pckvJFJ5az4+K9tFS/Go6BaSsMdZcwp0ClxYlX5H
 nR5GexJl8ngW17xkVfkkGKirDzgLfl4Ij86B+x9VqPINb1IRA/qP22M2n8iCfZKGKecx
 Z0ptlXfmJlIZp9i9C4Cu3QMZ/RAYZ97oNqOjdtIjJhD6o+yUT53AxSakku9AgoE/1hh4
 XnHVRUulEJD5FK5z5s3uy8Og03kbFX3KRwXMZyOP+1LzQM0um23O9I04HALAf4mrJJDI
 EX8N+KmePulxW7/2DCt/5gU4ZC0L5Y2o7DUT6rxtMU8pWqBTObRr3K6HrIrsuoCA00xJ
 m1UQ==
X-Gm-Message-State: APjAAAVEh7ln2kSeDQvkewOsI9QyeUxatnfTWvWlEAZT461tpLdqMSIg
 OwUD91nD8Ji2VaUfBhOaVTjORg==
X-Google-Smtp-Source: APXvYqyt6tOigKsUSFs48TIcaiz/MMNbaumheSIY/vmD0tnchQbKc2x0nTggy1cOI5g9y+JSlL9Kug==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr7951876wrp.171.1559916002687; 
 Fri, 07 Jun 2019 07:00:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s7sm4655964wmc.2.2019.06.07.07.00.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 07:00:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 878211FF87;
 Fri,  7 Jun 2019 15:00:01 +0100 (BST)
References: <20190607132521.9637-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <20190607132521.9637-1-peter.maydell@linaro.org>
Date: Fri, 07 Jun 2019 15:00:01 +0100
Message-ID: <87d0jpsdge.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU PATCH] risu: Include <sys/user.h> on ppc64
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
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> To build the C parts of risu for ppc64le with recent glibc/kernel
> headers, we need to include sys/user.h to avoid a compile error,
> because sys/ucontext.h defines a struct which includes a pointer
> to 'struct pt_regs' but does not provide a definition of that struct.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> I need this to be able to do the ppc64le cross-build on my
> Ubuntu Bionic x86-64 system.
>
>  risu_ppc64.c         | 2 ++
>  risu_reginfo_ppc64.c | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/risu_ppc64.c b/risu_ppc64.c
> index 83f8d1f..a3028f7 100644
> --- a/risu_ppc64.c
> +++ b/risu_ppc64.c
> @@ -11,6 +11,8 @@
>   *     based on Peter Maydell's risu_arm.c
>   ***********************************************************************=
******/
>
> +#include <sys/user.h>
> +
>  #include "risu.h"
>
>  void advance_pc(void *vuc)
> diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
> index f9d2f0d..071c951 100644
> --- a/risu_reginfo_ppc64.c
> +++ b/risu_reginfo_ppc64.c
> @@ -16,6 +16,7 @@
>  #include <string.h>
>  #include <math.h>
>  #include <stdlib.h>
> +#include <sys/user.h>
>
>  #include "risu.h"
>  #include "risu_reginfo_ppc64.h"


--
Alex Benn=C3=A9e

