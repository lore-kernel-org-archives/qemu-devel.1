Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB95C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CD521E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CD521E6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39645 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJPi-0000oT-0L
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46469)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvJOt-000855-0G
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvJOr-0003vs-24
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:42:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvJOp-0003mz-4t
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:42:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so69138134wmc.4
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RK6l3NcbPdkNrqzfgxFAPB3AcnYTmuMm/yEayizkoGM=;
 b=LEKSuMDEMq2rwSIwzRW11NESvyu1NG+xb068ZxXT4BXA1whZAznvxv5eRJWYYYI+JU
 g8d1ZHrOu5Je2TiBpvxI6PCW1FCtNiT21JzSGtFl/zT8C8rYjcFzPh+AWXOWulgd9f7+
 mUlCW/H/3lhSQsi93vsnaFDnlC5U7nK+X8GZ67N6Mk16oj25Oj72RYd+bTCLZOqRXWxi
 j9rtLORbZ9FtVz3rpfZaT9ZdbXL+umeYve2a3B33A82goQGmNcyDacZYCU9mNv8OAYUh
 VK3JV0COTvFHwXX5KQ97Re8fVzHcLMJ/gAobq9fXehdWlD+RnSEt86ZEoYH58GgMuCHm
 d+ig==
X-Gm-Message-State: APjAAAW1IUyS/j3mZdfc78khd+bJ1hi79FbMxH8AL9oJwtn0hiY354PR
 KKuAfMscAxb+XMfCHUTN+gPDIw==
X-Google-Smtp-Source: APXvYqy9hj4IVv4iNb7hdS8YWvrZpBE1Hrpzca1t19wjkLc7WPMgYH2QNsu2RpzXYBzClduT/WHecQ==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr10171537wmi.38.1565174542531; 
 Wed, 07 Aug 2019 03:42:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id c3sm92411304wrx.19.2019.08.07.03.42.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:42:21 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166668830.25608@bt.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <962f4d91-c1c4-7e97-5297-11c546d823f0@redhat.com>
Date: Wed, 7 Aug 2019 12:42:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166668830.25608@bt.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v6 15/26] build: Correct non-common
 common-obj-* to obj-*
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 cohuck@redhat.com, sagark@eecs.berkeley.edu, david@redhat.com,
 jasowang@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 i.mitsyanko@gmail.com, keith.busch@intel.com, jcmvbkbc@gmail.com,
 frederic.konrad@adacore.com, dmitry.fleytman@gmail.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, pburton@wavecomp.com,
 xiaoguangrong.eric@gmail.com, peter.chubb@nicta.com.au, philmd@redhat.com,
 robh@kernel.org, hare@suse.com, sstabellini@kernel.org, berto@igalia.com,
 chouteau@adacore.com, qemu-block@nongnu.org, arikalo@wavecomp.com,
 jslaby@suse.cz, deller@gmx.de, mst@redhat.com, magnus.damm@gmail.com,
 jcd@tribudubois.net, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 david@gibson.dropbear.id.au, lersek@redhat.com, green@moxielogic.com,
 atar4qemu@gmail.com, antonynpavlov@gmail.com, marex@denx.de, jiri@resnulli.us,
 ehabkost@redhat.com, minyard@acm.org, qemu-s390x@nongnu.org, sw@weilnetz.de,
 alistair@alistair23.me, yuval.shaia@oracle.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, shorne@gmail.com, jsnow@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, qemu-riscv@nongnu.org, proljc@gmail.com,
 andrew@aj.id.au, kbastian@mail.uni-paderborn.de, crwulff@gmail.com,
 laurent@vivier.eu, Andrew.Baumann@microsoft.com, sundeep.lkml@gmail.com,
 andrew.smirnov@gmail.com, michael@walle.cc, paul.durrant@citrix.com,
 qemu-ppc@nongnu.org, huth@tuxfamily.org, amarkovic@wavecomp.com,
 imammedo@redhat.com, aurelien@aurel32.net, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/19 10:31, tony.nguyen@bt.com wrote:
> Preparation for replacing device_endian with MemOp.
> 
> Device realizing code with MemorRegionOps endianness as
> DEVICE_NATIVE_ENDIAN is not common code.
> 
> Corrected devices were identified by making the declaration of
> DEVICE_NATIVE_ENDIAN conditional upon NEED_CPU_H and then listing
> what failed to compile.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>

The general approach makes sense.  However, most of these should not be
DEVICE_NATIVE_ENDIAN.  I can help with some of them.

Paolo

