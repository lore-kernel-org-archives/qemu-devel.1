Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21572C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD052075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH4zDICP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD052075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6jp-0004qR-2z
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 21:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kB6ip-0003oi-1h
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 21:28:59 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kB6in-0006At-GB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 21:28:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id k2so3152255ots.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 18:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fpenwrvLfc97hkyHgDpEPphR84cdeFww9gUYZbeCj1Q=;
 b=bH4zDICP5pcu5U+UT+7+xym50/CW0037J4xkeAKNRkamy/V/pa1aZiyIjCPeLmD5y6
 eXxfL0u8NSjH2Kx7OJmt7lxMcuqhl45B475huBn8lmTZSsEHIdcu8tgATqZTVnaelnd9
 8891R3oih45fkgsKxgIbnO9Qc/elNSl2WBd21fgc9RZNZr52QtRaTSYHl7Lf30WEj+rp
 6kQSgRHVLZDoh0zR7T7hxfiUvhMlapSIzkhWJFC+FbbsWoeSYYzLAwdh2hQJ1ht9WnhM
 9KK29X4/61kjdNQek2nuYm2BRxuwq28bGr+vCeP2dzkMwotL2I14KD6R8r9hCoc5I97+
 ID2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fpenwrvLfc97hkyHgDpEPphR84cdeFww9gUYZbeCj1Q=;
 b=UaM6ifMz7wfIHAbHMFWrb8lSvcRgYmeVLVJH23GdjGrro5hy8cq4jfZLAh7MDSFdmh
 38qUNSvNskWx9XUr5Ji77F6BfafmQkCBOwxIsONDlNrc77xnumib2NLr2XZuv/URAuu7
 nZkawsPwp7lEuz1v+9d536jPCsJoPDihgLJySKqqDEsxzWOpNIfXYWhoUvj+b3xzybjz
 EZBwEDi6eAyuxhrh8zugIf5aM+F8IFG5ugZd3b/J2rqOIAse1z87bDeX1P/jQ3x/ppRk
 4dCB8bH1ztsWcdELIwR0hk/gVmIcfRO+5EylAj4W9FiZ1bQKRg20oizJEvzv++LizZqv
 64CA==
X-Gm-Message-State: AOAM5310bcsFIVgv96orntpd7OIz8+yszE9GkYxz7l7JYYxVvbktYZSB
 3lg2VG1Yp1AkinIEdCwvhXLG3ecPfTIxDJ2hVHc=
X-Google-Smtp-Source: ABdhPJwZEs7AAxt15PdmaFaCzxKbPlgcWvWNMihfyeK5n4GtkFMxEZS9j6568YIfv7uSAVh/UC880YwLYQN7VZ7nYA8=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr8974644otn.333.1598491736469; 
 Wed, 26 Aug 2020 18:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-3-ehabkost@redhat.com>
In-Reply-To: <20200826184334.4120620-3-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 09:28:20 +0800
Message-ID: <CAKXe6SJHPg99UQ9cogjFX2vhjoCWErp0WdsUedp1hZKyP7AScA@mail.gmail.com>
Subject: Re: [PATCH 2/8] nios2_iic: Use TYPE_ALTERA_IIC constant
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
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
Cc: Marek Vasut <marex@denx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:44=E5=86=99=E9=81=93=EF=BC=9A
>
> This will make future conversion to use OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/intc/nios2_iic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
> index 1a5df8c89a..86d088f9b5 100644
> --- a/hw/intc/nios2_iic.c
> +++ b/hw/intc/nios2_iic.c
> @@ -80,7 +80,7 @@ static void altera_iic_class_init(ObjectClass *klass, v=
oid *data)
>  }
>
>  static TypeInfo altera_iic_info =3D {
> -    .name          =3D "altera,iic",
> +    .name          =3D TYPE_ALTERA_IIC,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(AlteraIIC),
>      .instance_init =3D altera_iic_init,
> --
> 2.26.2
>
>

