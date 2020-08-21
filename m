Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F05722B47
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkZ6C6tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F05722B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99kl-0004OW-T0
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k99jR-00037s-SF; Fri, 21 Aug 2020 12:17:33 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k99jQ-0005Fo-7n; Fri, 21 Aug 2020 12:17:33 -0400
Received: by mail-io1-xd44.google.com with SMTP id s1so2242876iot.10;
 Fri, 21 Aug 2020 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qLDh8XVkGea4uB8QZaVh8OdtptdFsOpXTmCURYKOR4c=;
 b=MkZ6C6tlpWVaXIjZc3xxDr90IDZWLEVcxoHcejXrHLfu9ITj74F+Ok/10ahQWY5U98
 NsF4cYYwEvMiqdiCap3nOCEtCaL+UjDTlOCjTyAiDCBlpoLjisNSRELo37+BrT4v3mIu
 oiHQPPcC/tWolo+VRWjXLI2Lt1jZIH0hejbGPRwojsqtURmzaccWTbAmLlyIhARULPqM
 IkDCNxA0r5bD6vIzWXHFXD5PvjViwIBoy/K34XA6BdDPpsK+9GwSRAAtgrZFwsd+FLcG
 FKlNtKtlXEBx/g346Sw1m2D2/0U8J2L9mO/KO+ZqWhjelxFUZidoD8RsZrNZehLhYNid
 Dmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qLDh8XVkGea4uB8QZaVh8OdtptdFsOpXTmCURYKOR4c=;
 b=SLfLNQoSsFc7H7hkJvworWIT8BKdUBJZTe2i9zonaXqS+USKCtOWSKKt9akYV9MsnL
 BclvdYIDRxh9LW7ph8B3hRZv1t3PQjiweRaeOqt9F2XghXFYwYkEeStrmOckMBG/ffNG
 due64CltIvmkouQYDSGif0PpgJvDh8aHmjUv50qrEDl4OOiiEwveUyVlvC16x93IeyTx
 IiWDBOMKbh0IsfXri01R8kSf96OcV+hllbr3QqtWa8ZTHQPTeS/J2PRDlwiq+APUESa0
 s50hpMjTvOT5VFSKqeX0cIsGmrxwhokQTbDNa3Lsm3vGH3DvHSy9wrVMnGYmkDqZy122
 nnRg==
X-Gm-Message-State: AOAM5319gFsOH8/pvEcowRVpqGpf5SwLIfrJzlrOO/i2lVxNAOVuLd3L
 D1M+bpI4Gil9OyDUahJ0WiGgRYXfv2Oy3yk4wHA=
X-Google-Smtp-Source: ABdhPJxmuAlxpv66stO/k3WT03HGllgsmQJsz6XUmswMnr9m5ROs2kdP4UtU3aRwd1KVq6a3q4auX30R3FbCesDF11c=
X-Received: by 2002:a05:6638:248e:: with SMTP id
 x14mr3156151jat.135.1598026649601; 
 Fri, 21 Aug 2020 09:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200820215529.GH642093@habkost.net>
In-Reply-To: <20200820215529.GH642093@habkost.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Aug 2020 09:06:51 -0700
Message-ID: <CAKmqyKO2z3XMeA9-_hMp0ebdSG03db5FtmbUk3uF-rA9Qi1FaA@mail.gmail.com>
Subject: Re: Suspicious QOM types without instance/class size
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 2:56 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> While trying to convert TypeInfo declarations to the new
> OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> where instance_size or class_size is not set, despite having type
> checker macros that use a specific type.
>
> The ones with "WARNING" are abstract types (maybe not serious if
> subclasses set the appropriate sizes).  The ones with "ERROR"
> don't seem to be abstract types.
>

> ERROR: hw/core/register.c:328:1: instance_size should be set to sizeof(RegisterInfo)?

I'll send a patch out for this one today.

If you are fixing all of these as part of a series I'm also happy to
just let you do that.

Alistair

>
> --
> Eduardo
>
>

