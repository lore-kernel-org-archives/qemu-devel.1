Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9488C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56572173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56572173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3P2f-00007h-V2
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3P1D-0007Z7-Ep
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3P1C-0000Aw-7q
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:19:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3P1B-0000AN-WA
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:19:34 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FD752A09AF
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:19:33 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j16so2520384wrn.5
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ft41ontdbYJfOC6ya31P4ldTQo622VBKEw+p0mV3ByI=;
 b=KUSPtw4yP8vHFmSmdlrbWsxNL+Ofo6TYfbrfXalmn+DPdNGQS7KFaix17iPnsbXr5L
 4feOc/0/2wXmCkhPOFWctPfbENnw3D1EqZJ5lHxVchqfxYylpHdDdedSb8zEQqwLwjEU
 v1TUIUYhfl9OUhE6QeSm50KCOrCj50zgWApBDKIHtnEBPHjpJyhYrWkh1SGiINre3vlO
 2Rb4EtUsafJNQ4sMtFfCYzC9mkgzonLsYeHD67kCTihnDQSVk3YvJ7z8HLE4uDCtjDvg
 CuLe/k/JpvMSbdm6+RFJQ7M8WSRC7XDF4vIDhGajTeO4PvJKySfQylpQDaXrvSVfJ+oz
 /X1A==
X-Gm-Message-State: APjAAAVQ/y95bWbgQGEedt5nTpMLg5HdLQzgd8Jjme8bDJ83ATXlNjed
 W+NsnnIuOa93V5bymiFEVSlrfUgJcLPPXMRPPWI7K5SUQKvVJ2z4igl7fFjv2Uw+VtkNOG6pGVy
 8xjEAnXLiQP2N1E4=
X-Received: by 2002:a1c:96c6:: with SMTP id y189mr6826264wmd.160.1567102771753; 
 Thu, 29 Aug 2019 11:19:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqye6c4B1zQCdxcNrLuqm0uqj6oyu9Znl2lmRm7lH7QmwQTGDNzS0D+CsaGpBzEZv4+kL5TyCQ==
X-Received: by 2002:a1c:96c6:: with SMTP id y189mr6826245wmd.160.1567102771530; 
 Thu, 29 Aug 2019 11:19:31 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id w15sm523972wru.53.2019.08.29.11.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:19:30 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190823135811.13883-1-philmd@redhat.com>
 <20190823135811.13883-4-philmd@redhat.com>
 <98da7855-40eb-2d58-8f0a-b75a041aba4c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <91b9cdcd-fe85-5283-8d03-c0e948f72f45@redhat.com>
Date: Thu, 29 Aug 2019 20:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <98da7855-40eb-2d58-8f0a-b75a041aba4c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] RFC target/arm: Do not build pre-ARMv7
 cpus when using KVM
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 8/23/19 4:28 PM, Thomas Huth wrote:
> On 8/23/19 3:58 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> A KVM-only build won't be able to run pre-ARMv7 cpus, disable them.
>>
>> If KVM is not enabled, they are enabled by default.
> [...]
>>  config CHEETAH
>>      bool
>> +    select ARM_V4
>>      select OMAP
>>      select TSC210X
>=20
> Are you sure about the "enabled by default" ? There is not "default y"
> here, is it?

What I mean is if you build with --disable-kvm, this selects
--enable-tcg which provides the pre-ARMv7 cpus. So to make no changes, I
also added:

  config ARM_V4
      default y

Which include the "default y".

>=20
> Also I'm not sure whether it's such a good idea to always disable the
> config switches in default-configs/arm-softmmu.mak ... if somebody want=
s
> to build such a restricted QEMU, don't they have to maintain their own
> set of config files anyway?

Ah... I followed your example:

$ git show 9e5c2056d1e
commit 9e5c2056d1e80f344a0c412d7a3d847db1f4e034
Author: Thomas Huth <thuth@redhat.com>
Date:   Tue Jan 29 10:42:14 2019 +0100

    s390x: express dependencies with Kconfig

    Instead of hard-coding all config switches in the config file
    default-configs/s390x-softmmu.mak, let's use the new Kconfig files
    to express the necessary dependencies: The S390_CCW_VIRTIO config swi=
tch
    for the "s390-ccw-virtio" machine now selects all non-optional device=
s.

    And since we already have the VIRTIO_PCI and VIRTIO_MMIO config switc=
hes
    for the other two virtio transports, this patch also introduces a new
    config switch VIRTIO_CCW for the third, s390x-specific virtio transpo=
rt,
    so that all three virtio transports are now handled in the same way.

diff --git a/default-configs/s390x-softmmu.mak
b/default-configs/s390x-softmmu.mak
@@ -1,9 +1,13 @@
-CONFIG_PCI=3Dy
-CONFIG_VIRTIO_PCI=3Dy
-CONFIG_SCLPCONSOLE=3Dy
-CONFIG_TERMINAL3270=3Dy
-CONFIG_S390_FLIC=3Dy
-CONFIG_WDT_DIAG288=3Dy
+# Default configuration for s390x-softmmu
+
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_TERMINAL3270=3Dn
+#CONFIG_VFIO_AP=3Dn
+#CONFIG_VFIO_CCW=3Dn
+#CONFIG_VIRTIO_PCI=3Dn
+#CONFIG_WDT_DIAG288=3Dn
+
+# Boards:
+#
 CONFIG_S390_CCW_VIRTIO=3Dy
-CONFIG_VFIO_CCW=3Dy
-CONFIG_VFIO_AP=3Dy

OK now I see, I should have added your comment and use the opposite form
(because now these boards are all enabled) so 's/=3Dy/=3Dn' in my patch.

> I think we should maybe rather rework the default-configs directory:
> Rename the default to "config/default/" instead and then we can add
> other subfolders with such special configurations, e.g. config/nemu/ or
> config/lean-kvm/ or however you want to call it. Then add a new switch
> to the configure script to be able to use the configs from such a
> different folder.

OK so if someone wants a special config, he'd know the config values to
select, so it is pointless/confusing to keep them commented.
Are you suggesting to simply remove the default entries? Such:

-- >8 --
@@ -9,34 +9,33 @@ CONFIG_ARM_V7M=3Dy
 CONFIG_ARM_VIRT=3Dy
 CONFIG_CUBIEBOARD=3Dy
 CONFIG_EXYNOS4=3Dy
-CONFIG_HIGHBANK=3Dy
-CONFIG_INTEGRATOR=3Dy
 CONFIG_FSL_IMX31=3Dy
-CONFIG_MUSICPAL=3Dy
 CONFIG_MUSCA=3Dy
-CONFIG_CHEETAH=3Dy
-CONFIG_SX1=3Dy
-CONFIG_NSERIES=3Dy
 CONFIG_STELLARIS=3Dy
 CONFIG_REALVIEW=3Dy
-CONFIG_VERSATILE=3Dy
 CONFIG_VEXPRESS=3Dy
 CONFIG_ZYNQ=3Dy
-CONFIG_MAINSTONE=3Dy
-CONFIG_GUMSTIX=3Dy
-CONFIG_SPITZ=3Dy
-CONFIG_TOSA=3Dy
-CONFIG_Z2=3Dy
-CONFIG_COLLIE=3Dy
-CONFIG_ASPEED_SOC=3Dy
 CONFIG_NETDUINO2=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
-CONFIG_DIGIC=3Dy
 CONFIG_SABRELITE=3Dy
 CONFIG_EMCRAFT_SF2=3Dy
-CONFIG_MICROBIT=3Dy
-CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
 CONFIG_SEMIHOSTING=3Dy
---

Thanks,

Phil.

