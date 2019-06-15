Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBAAC31E47
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 10:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEFC20868
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 10:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEFC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hc60r-0007lh-Qv
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 06:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hc5zg-0006j8-0t
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 06:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hc5tJ-0002ur-G7
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 06:26:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hc5tJ-0002rs-90
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 06:26:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so4730179wms.2
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2019 03:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=we76Cor5YuNEJsNdw3qAWVmIkcWTsQUYt8rM5dM4Acw=;
 b=feVDHZfNArmvGKp1bOPjZACNLRK6HWJQ72ElWlLt7I3N3w4XKjZBzQx1Y7DaTrlyvm
 /Nv16OBkaZo9aJu48rCOsVCz+KocvcKzxXwsY6d1bWW7avLqJ/yNbdz7eHQmGr9gHL4e
 RMJMjZ/RhIvuCZr78/Uh571bytvBWgs8nsPFRTli9p784oTUR5ozH4zV9zTa8QjRbtfe
 QHaoRRQl93vOhb/+yCXouK02fTcXX5zITroCoXiMQuKIYdsVIpXQISTB05yhKBiY1di5
 rQfH6pJWgaJlOl82exhYKVUDFtezqeCYiGCCkVoHZwvcuuwa5ELvbSVd2a/3II+MQxHV
 xkdQ==
X-Gm-Message-State: APjAAAXGDAn2yRCrVoFc99DzDE4eo7vXOI+hw1YFCZEsAd6bVGj/bQzl
 rl8pYwVerGgEEpn5/2zeLTgHOg==
X-Google-Smtp-Source: APXvYqwKpZmX8MudhG4BDlV03CX4LTq2IKA84cHfqXUrXyPYqw+RL08yak3gqaCV2zhgQw5mNzZovA==
X-Received: by 2002:a1c:a7ca:: with SMTP id
 q193mr12136363wme.150.1560594390840; 
 Sat, 15 Jun 2019 03:26:30 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z5sm3856110wmf.48.2019.06.15.03.26.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 15 Jun 2019 03:26:29 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
References: <20190531154735.20809-1-philmd@redhat.com>
 <CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
 <947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
 <431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
 <a3cbd83c-a942-25f4-d424-bbbc0013acec@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c81017d4-0ea0-99f3-854d-6ab4b514a15c@redhat.com>
Date: Sat, 15 Jun 2019 12:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a3cbd83c-a942-25f4-d424-bbbc0013acec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 10:11 AM, Paolo Bonzini wrote:
> On 31/05/19 18:54, Miroslav Rezanina wrote:
>> What about CONFIG_ARM_VIRT - can we use it to introduce dependency on
>> CONFIG_SEMIHOSTING or is there valid scenario of qemu build with CONFIG_ARM_VIRT
>> enabled and CONFIG_SEMIHOSTING disabled?
> 
> If you are not really going to use TCG, disabling SEMIHOSTING makes sense.
> 
> I think Philippe's patch are the right way to do it.
> 
> Perhaps CONFIG_SEMIHOSTING should be made "default y" and added as
> "#CONFIG_SEMIHOSTING=n" to default-configs/, but that's just cosmetic.

But then it is compiled/linked on target that don't care...

Oh, but this is also true currently:

$ fgrep -r qemu_semihosting_log_out
Binary file ppc-softmmu/qemu-system-ppc matches
...

What about:

  config SEMIHOSTING
      bool
      default n
      depends on !KVM

and keep specific targets using SEMIHOSTING=y

Using "default y" or "default y if !KVM" we have to add SEMIHOSTING=n on
all targets that don't care, which seems an incorrect use of Kconfig.

Aleksandar: Can we use SEMIHOSTING on KVM MIPS?

For ARM Peter said:

"semihosting hooks either SVC or HLT instructions, and inside
 KVM both of those go to EL1, ie to the guest, and can't be
 trapped to KVM."

Thanks,

Phil.

