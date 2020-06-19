Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF69C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B08A20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6YK9/gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B08A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHex-0004X1-PR
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jmHe8-0003S2-EG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:05:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jmHe5-0003Bx-V4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592575527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WB3tZovinqO3VkUJCkchLVMR30fR0aapG5sj4IKwycQ=;
 b=S6YK9/gjA/ks4StGlHinYXYC7IXIYNifefsEwz6lSb2lvQbZb5c2O19LdHbSjQHCU/sUbJ
 Z/7xgVjBy/FS2AQMwwNISGqeFu2I4vQWvVw6uuHtka33GQMXrbujsMZ9qyvtf1yMoMR1JP
 O8z6Bj9TB3dc7VoRLXSmi+Q4Y71QPts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-EFx6qfeQNHG1_8hQcT5xsg-1; Fri, 19 Jun 2020 10:05:25 -0400
X-MC-Unique: EFx6qfeQNHG1_8hQcT5xsg-1
Received: by mail-wr1-f69.google.com with SMTP id o25so2465046wro.16
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=6l/OnB1gcskC8LaxIEE5OiEcoRApT+9K9REXqWMWoBY=;
 b=MvhTbbuSgetOLpuvaK5rtB6q0gQdohCaQE0Nc0hcM1uWHTz2DCWCft9A/3VSP11iQK
 q5ZmjVKHqUGcGktUfXBoaqpObiHLYgbnSY661a/CFxt1dQkzLt5yZZMIMAolJ6awOU3l
 H/ZE8kXvJl/YRJIZBMLrsdzg3ZKLRyTpY0hm02Ro8WE7YZJIKJyaM4iatzE/b68lLqaC
 fsUeXtK4QUYmw2wH17IS7f/W4Ft8rsY8GclnZ/n4/4jiCStfA7CfC6Hqy3z/KRxvSszV
 K081skaSdpmIMec/M/FLydumZtfUi+wXDiasZztt2NCNDIJkvQnFvc8/YmDce/ekmeFc
 SoQw==
X-Gm-Message-State: AOAM532TT7180IkQRytTHafa4/fuPJIh2uNAN0lATrw4mlhZakKOZICQ
 Nyq9w0CiCmv1vlv/z2k9baifPm3FMMZK4SkSQA/FU8Px3yZBR6mk9ACuTX3UzOXp7rvTiRU6wbT
 ZcUYztGrnZoTCw3s=
X-Received: by 2002:adf:f308:: with SMTP id i8mr4153324wro.355.1592575524513; 
 Fri, 19 Jun 2020 07:05:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHHMAzPaANHeIJ0NNO4uBMbM2/oA7ZnSAEIu8FAFoHmLNmBFZpPW3YaD4LmkCklHoPFeHlIQ==
X-Received: by 2002:adf:f308:: with SMTP id i8mr4153293wro.355.1592575524199; 
 Fri, 19 Jun 2020 07:05:24 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:b03a:bd4c:c9f:fc11?
 ([2a01:e0a:466:71c0:b03a:bd4c:c9f:fc11])
 by smtp.gmail.com with ESMTPSA id q4sm7207433wma.47.2020.06.19.07.05.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jun 2020 07:05:23 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: how to build QEMU with the peripheral device modules
From: Christophe de Dinechin <cdupontd@redhat.com>
X-Priority: 3
In-Reply-To: <tencent_2BB56CF9C4F3AA4DBB9D8A50C3BFBDCA720A@qq.com>
Date: Fri, 19 Jun 2020 16:05:22 +0200
Message-Id: <A1C50A75-1BAC-4F4A-AF9E-29A7B7F9450E@redhat.com>
References: <tencent_2BB56CF9C4F3AA4DBB9D8A50C3BFBDCA720A@qq.com>
To: casmac <climber.cui@qq.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cdupontd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Le 19 Jun 2020 =C3=A0 15:24, casmac <climber.cui@qq.com> a =C3=A9crit :
>=20
> Hi All,
>    I am trying to add a DMA peripheral module. In hw/dma directory, a fil=
e  ti_dma.c is added.
>    Also, in hw/dma/kconfig, I added the following lines:
> config TI_DMA
> =09bool
>    In hw/dma/makefile.ojb, added one line:
> common-obj-$(CONFIG_TI_DMA) +=3D ti_dma.o

How did you set CONFIG_TI_DMA?

You can add it to the configure script if it's orthogonal to everything els=
e, or have it set as some default in a default config e.g. for whatever boa=
rd you have, or add a Kconfig dependency.

>    However, ti_dma.c is not compiled as the QEMU project is built. Some d=
irectories(eg. block, cpu...) under hw will be compiled though.=20
>    The makefile.obj seems to show that the DMA module would be built alon=
g with  others:
> devices-dirs-y =3D core/
> ifeq ($(CONFIG_SOFTMMU), y)
> devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),=
$(CONFIG_XEN))) +=3D 9pfs/
> devices-dirs-y +=3D acpi/
> devices-dirs-y +=3D adc/
> devices-dirs-y +=3D audio/
> devices-dirs-y +=3D block/
> devices-dirs-y +=3D bt/
> devices-dirs-y +=3D char/
> devices-dirs-y +=3D cpu/
> devices-dirs-y +=3D display/
> devices-dirs-y +=3D dma/
> devices-dirs-y +=3D gpio/
> ......
>     I am not sure what is missing here. Any advise would be appreciated. =
Thanks.
>=20
> xiaolei


