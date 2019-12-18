Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A1EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1436320717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbLMq7Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1436320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihi5Z-0003vp-7N
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihi4T-0002sl-Iz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihi4R-0001yQ-T1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:45:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihi4O-0001sQ-Eu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576709125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vpdC2eURc6Pud4PtOtjuYXeDfFLwlFprGO2rOnumgo=;
 b=JbLMq7MpTbjjtzqa/SUL/RRk92g/bBuaSxXMSFmYvmdwGmFKqL3p3HVTWsu8tEiAjDJ3r+
 dBPJxIVwIPDDVezqligxme10zJ4s2ayh+2AdZmBVETOa4BO/nnWRrqHXlAI4XvUtYDrynl
 bPOnusNz8C/Uvb1M422begtvzhmp0Qs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250--sl2nYiWMFKGV0aQ6cJAYw-1; Wed, 18 Dec 2019 17:45:22 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so1462367wrm.18
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RSuTuG4LJsvngoXLr+MhZMR/VOYLubLVAdqIKmSG1vU=;
 b=oqVTn5yvIC7fjk+Vp0FcXOa8lJl7QRJE2/2IbyxKr5Cq/8JuQZPzeQdE12QE01t+3c
 ivIIBARPZ+35o6jyPEWWYzxxeWHyVkZE0kQephVjTkquiIzw83ZPORwqd9OsGbDUxYKu
 X8m8Zvt/EGZxTKKzvkvrqrGiBuh1+g9IAuX2eND5Yl/ThUgx1/1gCb582U9xAabSblSZ
 3vJOV3RALEPI5iaRj9XnPWkK25pgBSWS2LvhVYxo0nJdQWwjfR9322+qaiqEFy0yiIFZ
 5XowRlxUVhEPjGkrWpun8bKventX6FTC4W3qVEgbJE0zOGIWjEx1aQVknOMbkyoC4boo
 uBVg==
X-Gm-Message-State: APjAAAXLMpygwpuMQ2Z5MQ66ATXuUwmR/hR9FhfUbJq4xtmJMELsHBYj
 S175RnibsM3k+spcN1rhNRurMtggo5ldiuy30bdNkIhiiLp/r0hjJ3vP/0eRsnR0Wut1YB9tVK8
 p6cnDUJPo8pjkCcQ=
X-Received: by 2002:adf:90e7:: with SMTP id i94mr5307074wri.47.1576709121225; 
 Wed, 18 Dec 2019 14:45:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3MIh8TavpVvYFLbYlsx3j3LuPY2Xbbq6/h5A0nlgbtbBFxfDAxfVERpjS/36S5Hc1mMV4YQ==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr5307055wri.47.1576709121058; 
 Wed, 18 Dec 2019 14:45:21 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id o15sm4260612wra.83.2019.12.18.14.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 14:45:20 -0800 (PST)
Subject: Re: [RFC PATCH v2 02/14] hw/ipmi: Explicit we ignore some
 QEMUChrEvent in IOEventHandler
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-3-philmd@redhat.com>
 <f2dbed9f-1e0b-9a21-202b-b1ad34069bd9@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b47e5c80-9730-8744-8b1c-7040be4c47f9@redhat.com>
Date: Wed, 18 Dec 2019 23:45:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f2dbed9f-1e0b-9a21-202b-b1ad34069bd9@linaro.org>
Content-Language: en-US
X-MC-Unique: -sl2nYiWMFKGV0aQ6cJAYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 9:47 PM, Richard Henderson wrote:
> On 12/18/19 7:19 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> The Chardev events are listed in the QEMUChrEvent enum. To be
>> able to use this enum in the IOEventHandler typedef, we need to
>> explicit all the events ignored by this frontend, to silent the
>> following GCC warning:
>=20
> In the title, s/Explicit we/Explicitly/.
>=20
> Here in the body, "need to be explicit about all the events ignored", "to=
 silence".
>=20
> This same grammar cleanup applies to patches 2-13.

OK I'll fix that.

>=20
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> for all of 2-13.

Thanks!


