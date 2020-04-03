Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF197C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FDD20757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs6LNSCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FDD20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJHJ-0005QX-VP
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKJGd-000500-9D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKJGc-000073-37
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:09:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKJGb-00005c-V7
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585908577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMS1RsJWTGWV7+BXZ8l+bKaoXBouy/O6kS7cPOmAnsU=;
 b=Cs6LNSCEo876GFpnXHiIBShNTcRo1XigD52mk7g45Ea3SgAQWesa/tUqOLt5CXmR4+UpMc
 RUU24AHXeeTGiE0oPiNbgA2kuC0AFhpcbrsWfjspX/0s38EiJTw+F4K5wMK+w20JRihxyx
 4o4VNB874BmVUhvVq+5y3vumCGitq7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-HIsuhFewM5WNRZ1PmjcXIg-1; Fri, 03 Apr 2020 06:09:36 -0400
X-MC-Unique: HIsuhFewM5WNRZ1PmjcXIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA0E5F9;
 Fri,  3 Apr 2020 10:09:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08F9619756;
 Fri,  3 Apr 2020 10:09:22 +0000 (UTC)
Date: Fri, 3 Apr 2020 12:09:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 07/12] acpi: move aml builder code for rtc device
Message-ID: <20200403120921.258db9a5@redhat.com>
In-Reply-To: <20200403080502.8154-8-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-8-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Apr 2020 10:04:57 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
[...]
> +static void rtc_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    Aml *dev;
> +    Aml *crs;
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0070, 0x0070, 0x10, 0x02));
> +    aml_append(crs, aml_irq_no_flags(8));
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0072, 0x0072, 0x02, 0x06));

since this is made a part of device, can we fetch io port values from
device instead of hard-codding values here?

> +
> +    dev = aml_device("RTC");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>  static void rtc_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = rtc_realizefn;
>      dc->reset = rtc_resetdev;
>      dc->vmsd = &vmstate_rtc;
> +    isa->build_aml = rtc_build_aml;
>      device_class_set_props(dc, mc146818rtc_properties);
>  }
>  


