Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB7C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB342082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB342082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwOH-0002Dd-TD
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35542)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdw70-0006KH-FM
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdw6x-0001QE-IS
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:24:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdw6x-0001Lg-Aa
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:24:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so2796213wrl.9
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 05:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mgGsWZ7RpLieNPl1OdcvTd7XUUPmgnrTmm2SW/IfNVU=;
 b=hmHyuXFdxAEZl6Pr7ZT00vfm13kvtzcl6YzZzcWbdsaJjA2K2ExC1biGr9TJWEsnBZ
 UrI2HRDJ0CegaLFsiNyE6GoC6sHjM/TLQ/v7FOMMt9Jgd0NxfFu+LAiLZ1vEehH0J5qM
 Qi1f69N9RRt80rGbuFfY+3ysPmgmWJ2ynNihKs5v3PvN97YAdQR6ORGp3YdoYb+2CkGY
 IHdTgB2/qomv5GyaD/L7ghuJhHiNoKyAzEIU/0odarTbSMcK265IsM/NGky/1eGj3RMh
 vsj09BgIlXTbtECqBSKR8o0G6s05VVSDPJ6+iAM0ft1uJNYUZi5GA8Wpmnh2RP9x6gKu
 DVQg==
X-Gm-Message-State: APjAAAV9wMaGGgi8NcL8yQFQel/MNGNzhSmM2fzFtQi49yD7heKcATjP
 Zw+sASb5alM+kl4A7XrICSDVTQ==
X-Google-Smtp-Source: APXvYqwn8HW4kFVRmIwiHxri6rLo5IkT9bS7Yig0kbCpTs4iGIS/nu/Ay1QcDTwp0qY8q6RFrTbAFg==
X-Received: by 2002:a05:6000:112:: with SMTP id
 o18mr4521498wrx.153.1561033450967; 
 Thu, 20 Jun 2019 05:24:10 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z5sm21126219wrh.16.2019.06.20.05.24.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 05:24:10 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20190620121930.9729-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fcffb9f5-3723-2f4f-3898-9f5584d3696a@redhat.com>
Date: Thu, 20 Jun 2019 14:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620121930.9729-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v5 0/3] fw_cfg: Add
 edk2_add_host_crypto_policy()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 2:19 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series add edk2_add_host_crypto_policy() and the Edk2Crypto object.
> 
> The Edk2Crypto object is used to hold configuration values specific
> to EDK2.
> 
> So far only the 'https' policy is supported.
> 
> A usercase example is the 'HTTPS Boof' feature of OVMF [*].
> 
> Usage example:
> 
> $ qemu-system-x86_64 \
>     --object edk2_crypto,id=https,\
>         ciphers=/etc/crypto-policies/back-ends/openssl.config,\
>         cacerts=/etc/pki/ca-trust/extracted/edk2/cacerts.bin
> 
> (On Fedora these files are provided by the ca-certificates and
> crypto-policies packages).
> 
> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
> 
> Since v4:
> - Addressed Laszlo comments (see patch#1 description)
> Since v3:
> - Addressed Markus' comments (do not care about heap)
> Since v2:
> - Split of
> Since v1:
> - Addressed Michael and Laszlo comments.

Please discard this cover, series sent again with patches properly attached.

