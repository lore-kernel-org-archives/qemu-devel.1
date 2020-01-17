Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A297C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3914B2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhWuiQsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3914B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRnh-0005Pw-Vn
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRl1-0002wD-HN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRl0-0008V5-IE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:33:51 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1isRkx-0008RU-1d; Fri, 17 Jan 2020 08:33:47 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so7481858wmc.2;
 Fri, 17 Jan 2020 05:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yT+sU+iEPYv6vcV3y79HbWr4gfQRlPyXmRwCd7eoCkI=;
 b=NhWuiQsWE1zBblBcC4P9XLVjxoTMFApAZh1Mycx8VTPuXvZJXvrrDrVLgwt8UC14Hx
 y8bXyx1CYaxfYK8jSW79Syd4frMyglY0BwlkVsPxBXw2CMlhmvRfCHcXwL7G3Yo4AT/L
 9J1in+KvbxFKg7jaBnOOIkj+YBUsqYvN7C7fa8DyDFVE1dCLephAXtpfn4wKHOzmFfoD
 r3bdsV/0eTJNYd3FmlWIrOPVSigbLxMKxhr5453eiJ43mfMqGZ1pS0MDuk2zB/p7F/9J
 r1KT1XZ5crS1IYXgAk6t8Dw14d5NkSyPvdIAIJgcRVIIgcKF9Nn8LON1LMcM2WiTyqmg
 gizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yT+sU+iEPYv6vcV3y79HbWr4gfQRlPyXmRwCd7eoCkI=;
 b=QqpnrZlFFkeQV41evJKj00P5nL+8mK9Ed5TlUU1kb2CifMEf0aUCdmJx6QuBAeH6ZH
 iDbgsG2eLjLSJFkiq4OStq7tjujArfJQLQVx4d+df78+W1xneFP+JFQi/ml0RA7vgLZ7
 NkfIP3lfCJZJxhyUzUSFgmXLXc4bDWA0GNV7AU1YfkVNpFXq/kaV3E3IzMkarDH9rim/
 /mP88b4d1EqPHUC/GIT4LMj3lFLxjiuJnM+UChVbKYX7rP42yVS/eO/SCj9CCZlu+c+p
 PFpPpBCFW2yMqZNakF2P+TKlZBt5wIHMBcy+ywPrdPTsXol9iW+sNBKsh563B4AiZ8CY
 Y8wA==
X-Gm-Message-State: APjAAAUE6AsmZoLwl8PqGs6/iv3YDRoibjJ9Jn7AVKrxofKgb1kZSUDi
 aMqmyzlzr7mZUHl5uSRR+4MUJqqdpJwP+HAhN00=
X-Google-Smtp-Source: APXvYqwOPbQ4nXWygK/DER8YSQi6Fptt9beqiPyZx9YLDn5dItDbPTyKvtL41BuJWNJ1bxAnsLew0+F/0g1gg0NUwww=
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr4604402wml.55.1579268024350; 
 Fri, 17 Jan 2020 05:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-6-stefanb@linux.ibm.com>
In-Reply-To: <20200108161012.1821385-6-stefanb@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jan 2020 17:33:32 +0400
Message-ID: <CAJ+F1CK+XJ2vcZdZG0-__S8Tx2PzpLWbV_JcwF63m7cb6OohJQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] hw/ppc/Kconfig: Enable TPM_SPAPR as part of
 PSERIES config
To: Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 8, 2020 at 8:13 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>


(trivial conflict on master)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/ppc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index f927ec9c74..b5b3519158 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -10,6 +10,7 @@ config PSERIES
>      select XICS_SPAPR
>      select XIVE_SPAPR
>      select MSI_NONBROKEN
> +    select TPM_SPAPR
>
>  config SPAPR_RNG
>      bool
> --
> 2.24.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

