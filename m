Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D86C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021BA20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021BA20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQHw-0006WG-Sc
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCQH0-00060K-Et
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCQGy-0006nv-FR
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCQGy-0006no-AN
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:29:08 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6BEBA859FF
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 15:29:07 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id n18so4981549wro.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i44347/3tr4Ezhe+7g50qRq/AwIHRW7Ph+BfGdYZo1c=;
 b=eZhPlvuHQ0BNRJNg9sJ8wKaLJT/Sk10YROq42hALRKRO1Am6J0cUAD+py8hQkRvIlC
 N8wQNYtkiThkmoGCZnflwoG+nCewO8S7OYujqF+i+jYcpY+0qFdLXQkpJmGpnb5OAtYW
 Kh6vciyzPOuEwEnXTqRRtx3iuMoXd26U55wrw4MOIRTCIkUFMDoGNDN/6nG0P3XOyxRj
 m7XIXWUe4EWOUJdPcNVZYErpqNdqZCmC5pJzkQckC8aVoEhL8ulDqUYKCmegjqesuCBW
 8wnbz54SDDZGQnL1kUblt+wcXfzMIFI6GXdn9xvwjwkB0F//M8jW8FNuJv42fAjASNBq
 g7sw==
X-Gm-Message-State: APjAAAUPMNYP5f26whOfsy9+o9dZVHpvlftjp7K1c4aTHFOqRaAeqaGz
 NftodnspfjvDYYGO/+1pH+5ErGfE87YV3e7eGvRecfsqIljcSvBmjdp0pVwj0QNuck3AEKrqDXD
 BYS4bt1kesoSC/aE=
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr38342wru.148.1569252546228;
 Mon, 23 Sep 2019 08:29:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1qbhJerxzIMqC3jkGCx8SIpL4wBoROjsNpXx/QhKU4QpJILYunqPviEtGNYUOpQng5S/U4g==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr38325wru.148.1569252546055;
 Mon, 23 Sep 2019 08:29:06 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v11sm10284548wml.30.2019.09.23.08.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 08:29:05 -0700 (PDT)
Subject: Re: [PATCH v31 0/8] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20190915122015.45852-1-mrolnik@gmail.com>
 <CAK4993gKyXXzffRyBYBOHp2ffSvx=gLVuKmbpVK+VGGyahCdVg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <271e5d27-4b3d-5d99-ca57-7f6afe2054f4@redhat.com>
Date: Mon, 23 Sep 2019 17:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993gKyXXzffRyBYBOHp2ffSvx=gLVuKmbpVK+VGGyahCdVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 9/23/19 5:21 PM, Michael Rolnik wrote:
> Hi all,
>=20
> Is there any hope this will be pulled any time=C2=A0soon?

I have your v28 tagged for review/test, but I need to do a big context
switch to review it and haven't find personal time to look at it again.

I don't know what happens when a contributer insists and nobody objects.
Should you pick specific persons and personally ask them? I dunno.
I'll ask around on IRC.

> Regards,
> Michael Rolnik=C2=A0
>=20
> On Sun, Sep 15, 2019 at 3:20 PM Michael Rolnik <mrolnik@gmail.com
> <mailto:mrolnik@gmail.com>> wrote:
>=20
>     This series of patches adds 8bit AVR cores to QEMU.
>     All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not
>     fully tested yet.
>     However I was able to execute simple code with functions. e.g
>     fibonacci calculation.
>     This series of patches include a non real, sample board.
>     No fuses support yet. PC is set to 0 at reset.
[...]

