Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C50C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D53B206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrRlXjlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D53B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVykj-0004Bm-Mk
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyk7-0003gQ-Mh
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:40:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyk6-00054o-6y
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588689616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og0jOUb1Zt1g9JGFVhxnBYoygnz12X3aKdJaJFtpvBw=;
 b=OrRlXjlhkbzHqa4M2p4C8qhkNVFqlmkFZbsyZPJQtTNbmW7mJq7RadXXyweUEALk/z5d6D
 70dPoqNy2t53+k1y4zmtflLm+UbNoTKQNFMWpRMA+vFSrA+iD/bZTvNyZ1vvGzrdqdqyul
 O2RxULUOy9l1OqaQq7bv90XnMNHbNME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-IQRYiEuKOFebZeAOwL5eBw-1; Tue, 05 May 2020 10:40:15 -0400
X-MC-Unique: IQRYiEuKOFebZeAOwL5eBw-1
Received: by mail-wm1-f72.google.com with SMTP id u11so935853wmc.7
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8DVA4o8PGVqKeDkiPAmFMm/qex067XN7TiKFpVXJgAA=;
 b=L18T1XAqxTMyDmON+RPvm1Wfi8L25D9bYQZDm7aeZEhZqjtd721uOfzD8BEApKGix1
 cybtIkuHC/TDJlR8CLx6x6hqg+v9bn63+oC0QTb7DvB1eheOWh+/1bh6sDbNY3CMzUH3
 nmhpm+2oSr2GNb7SAtoaTb0tpvQ0vIb+GbobXR5uEQ+4wvxDvSJkBDQvHyaMU0aNq770
 BI6TfsUI0VekqLgFDR+5cOku64zDok3FzLu8Ct0FO/VV90bsNoMnCS1ryM9aro6Zkpc/
 HG/JxrOI8QsCRbhAMlvQtNZZsybcJM37QKoMPtr20yr3P3+e0CYnaqSkD/5BkBAjU6Cx
 7vcQ==
X-Gm-Message-State: AGi0PuYko9oKe4BaCvXsU53u+o9d+Z0dojDtlemIJWKX7JLUb5VOZ1LB
 Q4ct/Wq18xkzxDFirIpH2kJ7ApbfFElQKrmlHSGDQwS1E/ilhGCty+/VK6O9Gmy4eM8f6wS5tjU
 ULo9gp5HRQSwbkyw=
X-Received: by 2002:adf:fa89:: with SMTP id h9mr3942396wrr.119.1588689613738; 
 Tue, 05 May 2020 07:40:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDcqO++v1mvG17BauSiqnw6tqQciR+JqSQqKjKOHpN7el1U84cRLXe+591S+MWNEYOydT6Dw==
X-Received: by 2002:adf:fa89:: with SMTP id h9mr3942374wrr.119.1588689613522; 
 Tue, 05 May 2020 07:40:13 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id l1sm3854518wrc.24.2020.05.05.07.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 07:40:12 -0700 (PDT)
Subject: Re: [PATCH 12/17] qdev: Clean up qdev_connect_gpio_out_named()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-13-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e8fe9402-493d-d7fc-b424-d8874e5deca8@redhat.com>
Date: Tue, 5 May 2020 16:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-13-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 6:34 PM, Markus Armbruster wrote:
> Both qdev_connect_gpio_out_named() and device_set_realized() put
> objects without a parent into the "/machine/unattached/" orphanage.
>=20
> qdev_connect_gpio_out_named() needs a lengthy comment to explain how
> it works.  It exploits that object_property_add_child() can fail only
> when we got a parent already, and ignoring that error does what we
> want.  True.  If it failed due to "duplicate property", we'd be in
> trouble, but that would be a programming error.
>=20
> device_set_realized() is cleaner: it checks whether we need a parent,
> then calls object_property_add_child(), aborting on failure.  No need
> for a comment, and programming errors get caught.

I suppose it was not that obvious at the time of that comment :)

commit 615c4895703164134379b68214130dd502721174
Author: Andreas F=C3=A4rber <afaerber@suse.de>
Date:   Wed Jun 18 00:57:08 2014 -0700

     irq: Slim conversion of qemu_irq to QOM

     As a prequel to any big Pin refactoring plans,
     do an in-place conversion of qemu_irq to an Object,
     so that we can reference it in link<> properties.


commit 02757df2ad2d5dfc96482e2cdfa046f439dafc3d
Author: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Date:   Thu Sep 25 22:20:25 2014 -0700

     qdev: gpio: Re-implement qdev_connect_gpio QOM style

     Re-implement as a link setter. This should allow the
     QOM framework to keep track of ref counts properly etc.

     We need to add a default parent for the connecting
     input in case it's coming from a non-qdev source.
     We simply parent the IRQ to the machine in this case.

>=20
> Change qdev_connect_gpio_out_named() to match.
>=20
> Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/core/qdev.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c3a6a11b19..888a1de931 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -541,15 +541,12 @@ void qdev_connect_gpio_out_named(DeviceState *dev, =
const char *name, int n,
>   {
>       char *propname =3D g_strdup_printf("%s[%d]",
>                                        name ? name : "unnamed-gpio-out", =
n);
> -    if (pin) {
> -        /* We need a name for object_property_set_link to work.  If the
> -         * object has a parent, object_property_add_child will come back
> -         * with an error without doing anything.  If it has none, it wil=
l
> -         * never fail.  So we can just call it with a NULL Error pointer=
.
> -         */
> +    if (pin && !OBJECT(pin)->parent) {
> +        /* We need a name for object_property_set_link to work */
>           object_property_add_child(container_get(qdev_get_machine(),
>                                                   "/unattached"),
> -                                  "non-qdev-gpio[*]", OBJECT(pin), NULL)=
;
> +                                  "non-qdev-gpio[*]", OBJECT(pin),
> +                                  &error_abort);
>       }
>       object_property_set_link(OBJECT(dev), OBJECT(pin), propname, &error=
_abort);
>       g_free(propname);
>=20


