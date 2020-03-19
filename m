Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41F6C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD8B20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIAO7K8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD8B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF1pm-0005KO-TB
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 16:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF1p1-0004sW-Uj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF1oz-0000mq-Op
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:31:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF1oz-0000m0-J2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:31:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id x26so3871162otk.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o8Sdb2pg3BbCtB8ahXdMacI1iJETA+ZgJ5S9p4eJANU=;
 b=xIAO7K8rmHoCQKiNcLE9iD08HyOBu9a1jQD1lHKG+pU+Yc1yRaXjZ9VKsd8ejaqRc1
 Hb+VCe6/RPsbqjzHkNRRZPJMo98T5xBM5RfbNVwGa99LiTAqrWV5KSMxyjoZTsXuJLks
 4d1oaY1+lUCk125latSpzk851azdtMx+eKSFMnZL9IDPxAPL6FdhRGJKLl7l4niZk9Du
 wMMt8Ja2sEjIAMZK/QeiuIFd/A4Yz2PO6WcJzLNNRc3OpBm3bz79xLFMvXWS6kqzeZ1Y
 CxMcevj5H3OC7v9PFg3qocQDoeBApH9az4Fpf1aANTh/8m7Z9Mon6JeIw0+wrngvyUp1
 kKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o8Sdb2pg3BbCtB8ahXdMacI1iJETA+ZgJ5S9p4eJANU=;
 b=hEkrWnBvh0Wp8NtrmF1xOHjvE4S2XVFu6z/YPOJ7cz6Ra4pe4+ovtZulthHViPLk6i
 +8paG83DmtW/wgHf5roqpcvkFEukY3FpuFi28xmYkyDtmmamWFxJnj1vYFeK021iTUEW
 7Ir/xP0O/gef0QxSES0394EPfNxZQl6I/FI3jIyJsTOwwMMgUaIIrpodGg4C2yaHYeJo
 3SfezkjP00YlJU8nHITffj9zdGpSYW6Ny8nc8W5gXRtAXOT0eK3ayiPDBDHvFOv0wvL2
 cxme5Im+UZ4AL0ic5jZkjnynSM9iKhCp4bwo3Q8mdm5v43xntF1m7mfheLe1/1xwnXrx
 B9mw==
X-Gm-Message-State: ANhLgQ29N9luoENuPky9vsBzpvIbBA/ANHTbBhlmRBcZnLDxAOSAsxIe
 BIM/Zom82xLldcasVprTtSDXNXUU+gnR4sSluuE1IQ==
X-Google-Smtp-Source: ADFU+vuFLnyuZjoqy/8S5ol6Wz5jeL3AZbBoycyG7euk0Pm2bg1G1ev58Bwbaf3LgG0P8vQ98P5hE48zakCJGowP4PA=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr3965384otk.232.1584649876390; 
 Thu, 19 Mar 2020 13:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200310150947.3510824-1-borntraeger@de.ibm.com>
 <20200310150947.3510824-4-borntraeger@de.ibm.com>
In-Reply-To: <20200310150947.3510824-4-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 20:31:05 +0000
Message-ID: <CAFEAcA93+BC_N28fCRwPc8YNGW_UhSOE+=A+0Qo3bB9x8zO9qQ@mail.gmail.com>
Subject: Re: [PULL 3/4] s390/ipl: sync back loadparm
To: Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 15:09, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> From: Halil Pasic <pasic@linux.ibm.com>
>
> We expose loadparm as a r/w machine property, but if loadparm is set by
> the guest via DIAG 308, we don't update the property. Having a
> disconnect between the guest view and the QEMU property is not nice in
> itself, but things get even worse for SCSI, where under certain
> circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works as
> expected" for details) we call s390_gen_initial_iplb() on resets
> effectively overwriting the guest/user supplied loadparm with the stale
> value.

Hi; Coverity points out (CID 1421966) that you have a buffer overrun here:

> +static void update_machine_ipl_properties(IplParameterBlock *iplb)
> +{
> +    Object *machine = qdev_get_machine();
> +    Error *err = NULL;
> +
> +    /* Sync loadparm */
> +    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
> +        uint8_t *ebcdic_loadparm = iplb->loadparm;
> +        char ascii_loadparm[8];

This array is 8 bytes...

> +        int i;
> +
> +        for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
> +            ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
> +        }
> +        ascii_loadparm[i] = 0;

...but you can write 9 bytes into it (8 from the guest-controlled
iplb_loadparm buffer plus one for the trailing NUL).

> +        object_property_set_str(machine, ascii_loadparm, "loadparm", &err);
> +    } else {
> +        object_property_set_str(machine, "", "loadparm", &err);
> +    }
> +    if (err) {
> +        warn_report_err(err);
> +    }
> +}

thanks
-- PMM

