Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DAACA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247FA20578
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247FA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPopJ-0008JN-56
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iPooR-0007Ye-R0
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iPooP-0006J9-9Y
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iPooP-0006DO-47
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:19:01 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4E1B37F41
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 14:18:56 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id b4so1396631wrn.8
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 07:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vc+48eAR2aA8GTU2b/dHjjPIwEqzY7v5699Eeq5U0pA=;
 b=WfvfGyi7C5dpBvY7NNjIxdZl4zGaDIgjqbKdZgUPBjODsvmaFm+XSOmEjZnV3f/ODc
 g2Rb9va9d+WcAMpZtp0n3aggFP7VEORGgL0ynRuK2xrcl3iaG2/Ey2BiHf8nlEC/kvI1
 caT6KlZB8zFDdlOCfbHAuzIpSyMAaZaXIoufshTTHgvHpGO2sIkZ0MnbQqGojFnbXygv
 bRO/8GEFZh4YoATW6dbx+axWVYzjQN8yOqIniClqMViICdFoyMaJ7Ib+zWcV/8kaaVQZ
 7Pb26HLXtwSzFtn3gsxm1SGFd60U2MhKKi7fuRlPxAsmeYl3kmqLuV0432B4T6T4Cp7M
 CYJA==
X-Gm-Message-State: APjAAAX2K2PhBKhuhOAtATFoKxqUXMBoO1FvJP28LcLIw/pp17akQdO1
 JiBOb6gHA164y9fAk49iYkjhuzTKwRw5GsGIyKMYBRlDQluUkR5pSO0iz3C2joRjXei9V+bYP32
 tr1y4PcaPaXQxx8U=
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr9539142wmg.13.1572445135274; 
 Wed, 30 Oct 2019 07:18:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzX/ZgZl0WpnFRZRsBAQDfBNFFV8WCdpiv6Z+158+FXl7sZ2ITXbNHyYGwO3kWuhVadfDNzvQ==
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr9539114wmg.13.1572445134983; 
 Wed, 30 Oct 2019 07:18:54 -0700 (PDT)
Received: from [172.20.53.126] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id r15sm366521wro.20.2019.10.30.07.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2019 07:18:54 -0700 (PDT)
Subject: Re: [PATCH v11 14/15] hw/i386: Introduce the microvm machine type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191018105315.27511-1-slp@redhat.com>
 <20191018105315.27511-15-slp@redhat.com>
 <58f50ece-5fc2-dcad-f367-455d5f58e184@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <92c66a5c-b772-d255-21b7-a35617762a7d@redhat.com>
Date: Wed, 30 Oct 2019 15:18:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <58f50ece-5fc2-dcad-f367-455d5f58e184@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, groug@kaod.org,
 marcandre.lureau@gmail.com, kraxel@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/19 10:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> diff --git a/default-configs/i386-softmmu.mak
>> b/default-configs/i386-softmmu.mak
>> index 4229900f57..4cc64dafa2 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -28,3 +28,4 @@
>> =C2=A0 CONFIG_ISAPC=3Dy
>> =C2=A0 CONFIG_I440FX=3Dy
>> =C2=A0 CONFIG_Q35=3Dy
>> +CONFIG_MICROVM=3Dy
>=20
> Do we want to maintain a 32-bit microvm?
>=20
> IIUC the main interest in 64-bit.
>=20
> Can we restrict it with this change?

You would still be able to have 32-bit microvm with "-cpu 486" or even
"-cpu host,-lm" so it doesn't matter much.

Paolo

