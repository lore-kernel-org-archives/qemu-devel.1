Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BAB2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BAB2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsWs-00082H-IY
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAsVz-0006nI-Br
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:18:47 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAsVx-0005Is-E5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:18:47 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MF3U0-1kQEbR0WiG-00FVls; Wed, 26 Aug 2020 12:18:41 +0200
Subject: Re: [PATCH v3 43/74] nubus: Rename class type checking macros
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-44-ehabkost@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ed1b2bae-9beb-8211-41e3-0fb78986256d@vivier.eu>
Date: Wed, 26 Aug 2020 12:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825192110.3528606-44-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BzA/3layirPQYLnzQ/BC4karYBijDpggOni3KarLmp+a3rhLK76
 IrC5iM9mY0yzKQs+qia1R8Ytxhm398Tvska2+YPVdH5lu61nvQI/x8VKEQtU5KhlmYo3d+q
 pzv0snkGfK9ALlI/Fk/U3dYk6EbNV0d0j9hwSf/fJ/4ewqeLTrW4eW3J7XUR6TRC5+fA4xs
 fwNv5yshbk35+vIlUYU0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z6FvHEooUsE=:RIuenHAx3m5CpzPFreOp5O
 L0qXfGHd775AcSlsi58YWe2xxPSbwVtJLI83KgM4a06Wdfpv2V2HviP16C4YooNgUWiAHdrx/
 0TQfZn6kFS/a+cHEvrkKx3Vsv0kKkkaGWiONvnxB4lFxpwrTGvlSBTD+VGKwGYghVRSdqugbJ
 PLBDzkgdTo20+/b8xW5NrMiE+PPvxA3HjQikKb57HCqi7YqI1pEPPfFNoagvEC2UEuhaTC1e7
 x4fkbdsLQ9fVk1gbI1R+Swj6e+TXsGtALgBVL1V5LBRuugyEKkx7tMXZxn/7+l+NvD704/hE3
 DPq6Ab6jPvk+tTMIhlKQJ1/OSj4K5kFEBS8N1rzlPMNYxPEF4NTTMGEdZtOemGfvrtjCl4PLa
 wxNlZUw3p+iO0YgUK1kysyfZzq5/+FXwdn7bK6SyAWgxxNv97Tz+MQkXXr5SGVR46B/WRKfZv
 GlOWjsfAh6Kcr8GqqBEd3qcK7zJaZiuNJrFUKWLmLP9vdqSS1SY0TaweZ8+8o93Pd27fbjVUE
 hMo60xuhXWRHdnMzpH7+YFjYeLqFraRZT1xK8ybaxzFr+0+1cAZgxXdL1nnLbTUoiISxmiyrd
 +KVnBDb4LTyYpKV+H6Gx4m76trmXPPFmshWd7OwLPD0qFQmZvSwzzOTOz7+Hi7QNrTo9q3MAr
 osu4IjH63GqztUkatCQX2r3pREHrgOU/+RD6HIXLBFjBMbrG2hrh1sgFTN5wqqbNd50z7Dxe3
 d+DXTEfmjpEFuhIY1t9NmyuSaqP9Ov32qJRlsU8wAWcNKwne960pkQ6umgqLdDnR5K7hMdYjV
 3rFAr+14JHSHRAZ2rFUo27jxe2SRbHC/uT8IRSehi2HDYUqPPr/HP0C/1n14TGGz9lHrLKY
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 04:51:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/08/2020 à 21:20, Eduardo Habkost a écrit :
> Rename the existing class type checking macros to be consistent
> with the type name and instance type checking macro.  Use a
> NUBUS_MACFB prefix instead of MACFB_NUBUS.
> 
> This will make future conversion to OBJECT_DECLARE* easier.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v2 -> v3: new patch added in series v3
> 
> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/display/macfb.h | 4 ++--
>  hw/display/macfb.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
> index 26367ae2c4..347871b623 100644
> --- a/include/hw/display/macfb.h
> +++ b/include/hw/display/macfb.h
> @@ -40,9 +40,9 @@ typedef struct {
>      MacfbState macfb;
>  } MacfbSysBusState;
>  
> -#define MACFB_NUBUS_DEVICE_CLASS(class) \
> +#define NUBUS_MACFB_CLASS(class) \
>      OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
> -#define MACFB_NUBUS_GET_CLASS(obj) \
> +#define NUBUS_MACFB_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
>  
>  typedef struct MacfbNubusDeviceClass {
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> index b68faff4bb..ff8bdb846b 100644
> --- a/hw/display/macfb.c
> +++ b/hw/display/macfb.c
> @@ -391,7 +391,7 @@ static void macfb_nubus_realize(DeviceState *dev, Error **errp)
>  {
>      NubusDevice *nd = NUBUS_DEVICE(dev);
>      MacfbNubusState *s = NUBUS_MACFB(dev);
> -    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_GET_CLASS(dev);
> +    MacfbNubusDeviceClass *ndc = NUBUS_MACFB_GET_CLASS(dev);
>      MacfbState *ms = &s->macfb;
>  
>      ndc->parent_realize(dev, errp);
> @@ -443,7 +443,7 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
>  static void macfb_nubus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_DEVICE_CLASS(klass);
> +    MacfbNubusDeviceClass *ndc = NUBUS_MACFB_CLASS(klass);
>  
>      device_class_set_parent_realize(dc, macfb_nubus_realize,
>                                      &ndc->parent_realize);
> 

Acked-by: Laurent Vivier <laurent@vivier.eu>

