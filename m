Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB84C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4AA206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6jW6p6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4AA206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxOD-0003cQ-RQ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kRxJE-0004bf-GO; Mon, 12 Oct 2020 08:52:12 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:37391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kRxJ8-000162-5D; Mon, 12 Oct 2020 08:52:12 -0400
Received: by mail-ej1-x62a.google.com with SMTP id e22so23033852ejr.4;
 Mon, 12 Oct 2020 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=cGxZviZhW7O5jqtJ0bZv9cnvWltQUpe03KlUpuYC5Pk=;
 b=J6jW6p6hzHWOhTn5sd21PaYyZX8b8qC4clssFgX3c8w+3Lr4ULTcCq+fH6ZnydnPTR
 OoSjfTZrwz3B1f4IDFsUz73av/D7osQPM0ZIkmn96OrJq4fLJSYWE1VSsiXOZcSRqNLm
 c2Vw6gT9JIYUAtGl59LtZabKjNZO15dQrFsZfharwkYrOtpb76ojXJWmaCpBdJPZbX/+
 OVcaZVufm6GyvZAo/7aWEXuYcTxuKYo65DdzKK4erP5VJ4U5yJs7nAktT/qd0EG8d7fl
 EVU+AJicMA75lA/1Plu8+tyuGNmK9kx9EOzlzjakE1oUus+88px2HgdvFRLVc5tcdX+j
 8kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=cGxZviZhW7O5jqtJ0bZv9cnvWltQUpe03KlUpuYC5Pk=;
 b=AaK1FF4rkI86HQCO+BwRURQn3BsIEln3QnaJKnQpoosTJaV4XQLUEZji3hTmHaRhFJ
 rN4yy6y5G68/MDRc1HobvogojAGppb+2skCLVxQE3GEL2gg4+KscKN8B4eHcTNgqjDH8
 btImIFeoCV6fILc6LQAHTCeWxNOKylknFkAcHSK0zOqQeMDirEZ4qASbkugooa96CMJk
 OiikfEi1ovfYr2Iak264L22J5sQ0a2ggm865CfivTuhWlzS4852TzSXpMB051f310TTc
 bdOxVOEOvi/odyjnhyw7Io8JsnpyQsnIXnIeugChTNnF1+CmHokf/1ziQi2ksBJ6wrTE
 DwBQ==
X-Gm-Message-State: AOAM530ysP0AYkcsfM+bP9T8D4mzM+S0iT5MlNBvXJ9BktfCQbo9EI/a
 mQx276ncEXOaE3oEneEHF+8=
X-Google-Smtp-Source: ABdhPJwHAfJ1KA6vSf28jqCsNyskhp8zKVGrZmW9gROZziTmMM1V5o3vcaVB+aiilEPExBKNmWJZlw==
X-Received: by 2002:a17:906:39ce:: with SMTP id
 i14mr29164990eje.170.1602507123287; 
 Mon, 12 Oct 2020 05:52:03 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id me12sm10516645ejb.108.2020.10.12.05.52.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 05:52:02 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20201012124506.3406909-1-philmd@redhat.com>
 <20201012124506.3406909-5-philmd@redhat.com>
In-Reply-To: <20201012124506.3406909-5-philmd@redhat.com>
Subject: RE: [PATCH 4/5] hw: Use the PCI_SLOT() macro from 'hw/pci/pci.h'
Date: Mon, 12 Oct 2020 13:52:00 +0100
Message-ID: <001301d6a096$7b3a3880$71aea980$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIn0Xs2eWz4EZNtdpBYSFizYKd7hAIdwBpFqOCb0bA=
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 "'Michael S. Tsirkin'" <mst@redhat.com>,
 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>,
 'Huacai Chen' <chenhc@lemote.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Yoshinori Sato' <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 'Helge Deller' <deller@gmx.de>,
 'Aleksandar Markovic' <aleksandar.qemu.devel@gmail.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 'David Gibson' <david@gibson.dropbear.id.au>,
 'Aleksandar Rikalo' <aleksandar.rikalo@syrmia.com>,
 'Eduardo Habkost' <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>,
 'Richard Henderson' <rth@twiddle.net>,
 =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Aurelien Jarno' <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Sent: 12 October 2020 13:45
> To: qemu-devel@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>; qemu-ppc@nongnu.org; =
qemu-trivial@nongnu.org; Paul
> Durrant <paul@xen.org>; Aurelien Jarno <aurelien@aurel32.net>; =
qemu-arm@nongnu.org; Philippe Mathieu-
> Daud=C3=A9 <f4bug@amsat.org>; Michael S. Tsirkin <mst@redhat.com>; =
Eduardo Habkost <ehabkost@redhat.com>;
> Jiaxun Yang <jiaxun.yang@flygoat.com>; Yoshinori Sato =
<ysato@users.sourceforge.jp>; C=C3=A9dric Le Goater
> <clg@kaod.org>; David Gibson <david@gibson.dropbear.id.au>; Stefano =
Stabellini
> <sstabellini@kernel.org>; Helge Deller <deller@gmx.de>; Anthony Perard =
<anthony.perard@citrix.com>;
> Richard Henderson <rth@twiddle.net>; Aleksandar Markovic =
<aleksandar.qemu.devel@gmail.com>; xen-
> devel@lists.xenproject.org; Aleksandar Rikalo =
<aleksandar.rikalo@syrmia.com>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk>; Paolo Bonzini
> <pbonzini@redhat.com>; Huacai Chen <chenhc@lemote.com>
> Subject: [PATCH 4/5] hw: Use the PCI_SLOT() macro from 'hw/pci/pci.h'
>=20
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> We already have a generic PCI_SLOT() macro in "hw/pci/pci.h"
> to extract the PCI slot identifier, use it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

xen-hvm change...

Acked-by: Paul Durrant <paul@xen.org>


