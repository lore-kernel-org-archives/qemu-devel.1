Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFBFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 01:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6942080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 01:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qd4c6RXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6942080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxgg3-0003RY-0R
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 21:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxgfH-000307-TX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 21:01:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxgfG-0000IK-D1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 21:01:51 -0400
Received: by mail-oi1-x244.google.com with SMTP id r8so15891688oij.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 18:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QGfl7BU2QippaLviJqv6OeFFHe+fvyXr2T2BfTZb+8c=;
 b=qd4c6RXHuUyNnINFbw06hzBi8iIse6qfFSqlazG32r5YS9tZqOTCJCY+gwUiDsLFHB
 MfrjtZFnHyTUPvDNUP3lWi+X1HbH0k85aRzaXXiPXrPZdu/6usf8enUf469gCsPYCEZx
 0XD9MvebQfgfIWVJmMjQZN6WKfbgPu8Je9qgwb4SIH49J4dE+y6HC/rJd+6VCfCHr6pK
 NHTynirmK8HJeSFkuLb2vnnczFH+qzUqlIPlIf3uWYc277iiW8GSy/ROFMMdf1Xj8UbG
 wd0xiPKACGyuX/KIm9mbW3/mHP3TIhX0Gaje59rp7gnDXlmp84VHbpIQJJJfZEISfT1s
 h9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QGfl7BU2QippaLviJqv6OeFFHe+fvyXr2T2BfTZb+8c=;
 b=HbsuiuJQ6/48Md+posCbG5jvf/3Eosl9YPvxzNb0Io5vm1O7Xy80KT+uWujFFiHUbI
 ZhxOjdRU2H1r9wq29yrzA8y2T1ED0aPWNn7PX8KTP4PndDQR2/4D6rhTqjeG46AY4QtH
 9ohOKqV4q96jcLJCvJ3aLRtzqFQcTYQMbHsk7wf2M/UscchogjC9KbVqFdYAd3QLGWhN
 ZkYQad6pljTqyAzSMSHn2yRyDYEEwWVOhlfmFsja6Sps3+AkjVOvqoV+pxYXvpz2iPaM
 42O0yCPlwJiLm+fV1an8tso2vvdSBfzd5IBX/cKEioDNY9QEnS6C3t3h1VmtAr8fLFjE
 P3Ow==
X-Gm-Message-State: AOAM530vi/U8E94mer0i5fSAD0kgHJEf99lscVLB6Y2Un+tuRA4s8/3P
 +Y3j9j+YYKzYiQ0GF1ilGzegTz78hwuL0KNRuAw=
X-Google-Smtp-Source: ABdhPJzcexO0tmSrVmagl6D5So6qckEtnAjdrMBiiw1ZHRYkAJog3FKIUDM2FA5CcHIU2/20q20x3OQ/dVVGwI6VNE8=
X-Received: by 2002:a05:6808:486:: with SMTP id
 z6mr1507983oid.56.1595293305131; 
 Mon, 20 Jul 2020 18:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200717123514.15406-1-kentaishiguro@slowstart.org>
In-Reply-To: <20200717123514.15406-1-kentaishiguro@slowstart.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 21 Jul 2020 09:01:09 +0800
Message-ID: <CAKXe6SLtUn+3ykbvsM_0MHbz0fPxRehsqK0SvOBRDb42EDxDgA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/kvm/ioapic.c: fix typo in error message
To: Kenta Ishiguro <kentaishiguro@slowstart.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kenta Ishiguro <kentaishiguro@slowstart.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:14=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Fix a typo in an error message for KVM_SET_IRQCHIP ioctl:
> "KVM_GET_IRQCHIP" should be "KVM_SET_IRQCHIP".
>
> Signed-off-by: Kenta Ishiguro <kentaishiguro@slowstart.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/i386/kvm/ioapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
> index 4ba8e47251..c5528df942 100644
> --- a/hw/i386/kvm/ioapic.c
> +++ b/hw/i386/kvm/ioapic.c
> @@ -97,7 +97,7 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
>
>      ret =3D kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &chip);
>      if (ret < 0) {
> -        fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(ret));
> +        fprintf(stderr, "KVM_SET_IRQCHIP failed: %s\n", strerror(ret));
>          abort();
>      }
>  }
> --
> 2.17.1
>
>

