Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D7C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6712076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMUuZ5kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6712076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETrE-0003KT-AZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jETqb-0002l7-OD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jETqa-0002Kc-AG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:14:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33591)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jETqa-0002Gv-6H
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584519278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8STEHTvOLIZsFiVR89glQuw/FGgTdoOmnDV/WFZOocs=;
 b=ZMUuZ5kJXBSk9TxJW+XzL/4uxTn/TiA12D/HPh9zHKEDQ961MFOVNQEjN0Msm2Bq7uFXwR
 6ErG30g9GJ9BytE8qknvutPwvl5csYVGNqt5F+hpKZ5z9mG59qTzRBsl2FDuXH+VBTMkvv
 vbAkLZnZvPBYqA395dxmGiSlbA+y+fo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-FbQb_gQvPtmqRpzFnlzbYw-1; Wed, 18 Mar 2020 04:14:32 -0400
X-MC-Unique: FbQb_gQvPtmqRpzFnlzbYw-1
Received: by mail-wr1-f69.google.com with SMTP id i18so870623wrx.17
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 01:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8STEHTvOLIZsFiVR89glQuw/FGgTdoOmnDV/WFZOocs=;
 b=R5ejD3Xveq3ZrT3/o18mtvLe8GcgWqpoKACQfT42QkqjWVrQCSaic1fb2kEhZZKGB1
 csz0nnjedDWBmyEGj5E6/poyrULoiXGs/5n19z/6n7TD5kvyuAuUpliRiAQdABUSK1vK
 3P36eOLCfBeHV2tNruYXSeNvjc2OIZcVdgTI/R2nPyQyjKnTPkKITDQHXel2sN9iwwNn
 ly9OKo+NoBan1vaxWma1z/4KdgXAGuPyvHhGmCTr1WQ+fypYc9ZL/O80cSyDTBFuQd0R
 9W5CtYXfuYfpBUMZ86I0H5zPnV/Yw4QuMlYW6UBYePIRoezECVhvccPaN709oxcp6aBu
 BVsA==
X-Gm-Message-State: ANhLgQ3x+UOitXGTu7dEPJ+9B+MImSW3PwjLEOwD48PILJFblzc/jvhq
 0sY+W9+TRT9seFLzEsWxr2HhaBHDjLNcFYhZG59uRA3dYZdE6pwW98G4MgUy64EiUWSE88cjete
 V9OHQWea/SxDHEv8=
X-Received: by 2002:a05:6000:d0:: with SMTP id
 q16mr4305177wrx.71.1584519271701; 
 Wed, 18 Mar 2020 01:14:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuw+jR2ITzPApCcMNlLttjffE5a9pysBkVeqplroX+j3ilsLZrQVWBlnTgCMakkq92kJaIzsg==
X-Received: by 2002:a05:6000:d0:: with SMTP id
 q16mr4305145wrx.71.1584519271460; 
 Wed, 18 Mar 2020 01:14:31 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id z22sm2858002wmi.1.2020.03.18.01.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 01:14:30 -0700 (PDT)
Subject: Re: Missing Null check
To: Mansour Ahmadi <ManSoSec@gmail.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
References: <CAGT9xrB039Q7_fG1NpKv7w3t1N0OH93U9HPNawtpq9TsNr5hfA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c4e58b3-fb9c-c172-1b2e-5a1e25d02c6d@redhat.com>
Date: Wed, 18 Mar 2020 09:14:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAGT9xrB039Q7_fG1NpKv7w3t1N0OH93U9HPNawtpq9TsNr5hfA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 9:40 PM, Mansour Ahmadi wrote:
> Is a NULL check on 'drv1->format_name' missing here?
> https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/block.c#L400-L403
> 
> if(!strcmp(drv1->format_name, format_name)) {

This could be NULL indeed. I'd rather assertions in the entry function, 
bdrv_register():

-- >8 --
diff --git a/block.c b/block.c
index a2542c977b..6b984dc883 100644
--- a/block.c
+++ b/block.c
@@ -363,6 +363,7 @@ char 
*bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)

  void bdrv_register(BlockDriver *bdrv)
  {
+    assert(bdrv->format_name);
      QLIST_INSERT_HEAD(&bdrv_drivers, bdrv, list);
  }

---

> While it is checked in similar case:
> https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/block.c#L797-L800
> 
> if(drv1->protocol_name&& !strcmp(drv1->protocol_name, protocol)) {

Because 'protocol_name' is optional.

Regards,

Phil.


