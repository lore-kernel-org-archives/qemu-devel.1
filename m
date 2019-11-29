Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27418C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49AF208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/f/yjE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49AF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialkE-0005CI-24
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialXE-0006uG-Kr
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialXB-0003PN-Hb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:02:30 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialXB-0003HD-Cv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:02:29 -0500
Received: by mail-ot1-x341.google.com with SMTP id n23so25605940otr.13
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+iDLHxD8YGQA4kV3gvFj4LmmDNH7bc4343SpvsQUuHs=;
 b=s/f/yjE18gDrW+6RUtlChtgMnYf7+OHHc3AZFErYFyw855PkBZiEN1++9MOaWgbVXD
 uzS52uSV/KPMKqul9YpjsMHTUK8q0ypvBfjjNLdIWYuxQ26Gg0WiR8stx55X2DvbkqYj
 G5cS5zIzTdrjIKf/CjfBS16KSXEXffAF8x7lkYJl6H1izRTro4y0gVYNv36oZs0WqtwP
 kXpy/WRHMZnMFVEtqllgkSQXnRP64TA6ILs96xl2Mi3eZdwPZYLn9jpmH+O4yIR7DN2/
 UQct35H0CKo3hkAA1odHSC3Xx4rKl/hE+ELkDZRT2GHKzqfW8OVYKQrnGpGG2o1pzcUm
 A3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+iDLHxD8YGQA4kV3gvFj4LmmDNH7bc4343SpvsQUuHs=;
 b=XDVh0c54ctji0SDM6K/v9IO/+yvhWXWTdu/k0jeQGIdP/Sr4ARGlu43UgGP/IND86X
 P4RWi6kwfLo9ztdbeUQRaJUwAD75gCHYA8WgWdjpg8ffoqwFQlFjFm8oj5tnEYOR6+7W
 AjTjAUl3jpXBR5lZD1XcjP//R9NcFrCtvY6RmKRuUYTkChNsGpwp7y/cueb5OLYT8M+f
 1ZHnN4MZi9t2JG1RnSjLgpo+XqSbsT8OZenRpouxAthuYZ9jv1CX77nr5R1YtvEQ7cfn
 Kr35XIN6fg/Ol0RLTVdlG5YLg5bFCNqJYotoIW2Bb/ApBl6tdeze7IdFf9oDOaVIvLQt
 oQNg==
X-Gm-Message-State: APjAAAXmVRPuN914uQ8bj3QXNL8wPzsdnDkNx0bshew8z9pPaIfCM0Pd
 KmmpcO3TEBfcnsKHxR7poPUPUWNsCXV3wzJ8sJn6MA==
X-Google-Smtp-Source: APXvYqzrQ2/S+qcWfDcuYpCZnh7kzXC8FpJKxw1q+OPNubz/7tnxka//ay2QLLtPH+CfvnsK1udMDVcr2PkD0e8aPQI=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr12639617otg.232.1575054147728; 
 Fri, 29 Nov 2019 11:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-12-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-12-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 19:02:16 +0000
Message-ID: <CAFEAcA_MSK2mLcg6amqE=GdvQTvxLUYMjOH23Xgz9_w_KmsBDw@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] hw/s390x/ipl: replace deprecated qdev_reset_all
 registration
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Replace deprecated qdev_reset_all by resettable_cold_reset_fn for
> the ipl registration in the main reset handlers.
>
> This does not impact the behavior for the following reasons:
> + at this point resettable just call the old reset methods of devices
>   and buses in the same order than qdev/qbus.
> + resettable handlers registered with qemu_register_reset are
>   serialized; there is no interleaving.
> + eventual explicit calls to legacy reset API (device_reset or
>   qdev/qbus_reset) inside this reset handler will not be masked out
>   by resettable mechanism; they do not go through resettable api.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

