Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B397121897
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B397121897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18M0-0007Zv-Ut
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i18Ig-0004hJ-13
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i18Id-0003Cm-9e
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i18Id-0003Bc-4D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:04:11 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C33419CFF4
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 12:04:09 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k8so4727351wrx.19
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+Ht3TJBU3zkq85E9GFOxLOACPY0LmuRsrUaKFyk8k9A=;
 b=fqb5jSwR8J5GV5HihG2+jR6Mb9A1Mqq78KzpGYBGAsg4uYG5KOcuoLrKzzvvLfYjqu
 2VCdlhOPZiJZ1llMDZTZGxKrGaHNii1fB/dVbeMPNIZEM96CQMDPkLYZ1kIPItdRZWtP
 4VlBvZ+45brg/2Wri14lOZle3vVw4hf8ENQi631xDXqdnnfsPvxISCpae9eFrUGpGfnn
 WPWMxCAiYz5K5s5li7Ujg8oPJg/e5BHB69uoulonVOMqZPK5yfjPsBtLmCDV0JZOiufo
 RJsDR6FgQlp8Wh2TqFE63k/vuVFr1VJiX9iqQ5aosMAF5q8iHj1TxvhPhRzg8Cq69xbR
 Vi7Q==
X-Gm-Message-State: APjAAAXB8QExQDq0TBGsMdJ1hJ7Q0shxmie6d4VdJz2DXkD0EclcEX1m
 gpIigd9LDMDRMDE/fVbp9z6Yw4nuimhiwXyML/VcGD2wr9k5WPk+5WMdbqyFoqmZBJKmjZ3qeAy
 ZwL+dqdpjMqEn7jc=
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr4601970wrg.325.1566561848312; 
 Fri, 23 Aug 2019 05:04:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzoMea0tmqLnmfGiPzTo+R3H5/Xh8HhPa7bP+Zzo2WlWF0SSDnNE2RyH2+nrfibA/RldsBQ1g==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr4601940wrg.325.1566561848036; 
 Fri, 23 Aug 2019 05:04:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4566:f1b0:32e7:463f?
 ([2001:b07:6468:f312:4566:f1b0:32e7:463f])
 by smtp.gmail.com with ESMTPSA id a23sm3653025wma.24.2019.08.23.05.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 05:04:07 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <1566495734-23297-2-git-send-email-pbonzini@redhat.com>
 <CAJ+F1CKx_B9nFAaAdNbWAdsim7LUvSEY06mR-b_Ngya79iwoSg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ce54cd4e-182c-6ae7-6b47-65ae028e749e@redhat.com>
Date: Fri, 23 Aug 2019 14:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKx_B9nFAaAdNbWAdsim7LUvSEY06mR-b_Ngya79iwoSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] modules-test: ui-spice-app is not built as
 module
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/08/19 09:32, Marc-Andr=C3=A9 Lureau wrote:
> On Thu, Aug 22, 2019 at 9:43 PM Paolo Bonzini <pbonzini@redhat.com> wro=
te:
>>
>> $(call land, $(CONFIG_SPICE), $(CONFIG_GIO)) will never return "m" so
>> ui-spice-app is always linked into QEMU.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> I would rather build the module:
> -common-obj-$(call land,$(CONFIG_SPICE),$(CONFIG_GIO)) +=3D spice-app.m=
o
> +ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
> +common-obj-$(if $(CONFIG_MODULES),m,y) +=3D spice-app.mo
> +endif

That would not be a quick patch that Peter can apply to fix the build...

Paolo


