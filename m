Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976AC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB752133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB752133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyZ0t-0003OT-DA
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hyYzs-0002HO-4v
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hyYzq-0006TF-Uy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:58:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hyYzq-0006SK-Nh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:58:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so981493wra.6
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 02:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Foo7mqc4L4owvltcL+chmVAdJxdrnYoZDMnBcLnmc5c=;
 b=KsV4ucR/FlUCyMVNGLfIhr43p5efHTUT0SBsPLgqz2hIKSAhpgy04EM9IzzFwgafFj
 /kUnPhe1vI74hYuEWCGeCBcxFO0e/ckLWrSkKq2VtI6dOk1A/hjl0ZGr8nMzyL03B6S0
 KSVcWlCKPNzK8/BHjnhCTfE+/dD7RI4NjYNvOg9A2/uyxyYR4RqdRX0Eu9HfZmnDjjJO
 zkQkDfZ8ttAk9EseGNAAn/i6a9UiATq+C1KKjMBEzy2KLpWKnIHGo4a37FMxfb++kbOc
 Bbgh/WAwRgKVuHN8eiiJwGKM1fp3kIkFkPzj+QS5YuNyHb/3gHvP97cBYpC4RrbU+t6I
 J1Gg==
X-Gm-Message-State: APjAAAU6apOKmVvM15VP0ggO//8s1BHzzGv3F2jM5HU0IydoBeLkFQuw
 an/Wk8cRRfNTDmMt0eexPt/MNQ==
X-Google-Smtp-Source: APXvYqxEtH9z2rQcNW2PoiyLykUukmpcl5g1WXvMOKgN8N7tudUZZZ63JDl5GzOk7+ZQwUPBP9c8/A==
X-Received: by 2002:adf:82d4:: with SMTP id 78mr9141289wrc.85.1565949489545;
 Fri, 16 Aug 2019 02:58:09 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id z1sm5419150wrp.51.2019.08.16.02.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2019 02:58:08 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a7d6eede-b152-4c06-8945-9607c663b99c@redhat.com>
Date: Fri, 16 Aug 2019 11:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, jasowang@redhat.com,
 jiri@resnulli.us, ehabkost@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 claudio.fontana@suse.com, crwulff@gmail.com, laurent@vivier.eu,
 sundeep.lkml@gmail.com, michael@walle.cc, qemu-ppc@nongnu.org,
 kbastian@mail.uni-paderborn.de, imammedo@redhat.com, fam@euphon.net,
 peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, amarkovic@wavecomp.com,
 peter.chubb@nicta.com.au, aurelien@aurel32.net, pburton@wavecomp.com,
 sagark@eecs.berkeley.edu, green@moxielogic.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, robh@kernel.org,
 borntraeger@de.ibm.com, joel@jms.id.au, antonynpavlov@gmail.com,
 chouteau@adacore.com, lersek@redhat.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Tony,

On 8/16/19 8:28 AM, tony.nguyen@bt.com wrote:
> This patchset implements the IE (Invert Endian) bit in SPARCv9 MMU TTE.
> 
> v7:
[...]
> - Re-declared many native endian devices as little or big endian. This is why
>   v7 has +16 patches.

Why are you doing that? What is the rational?

Anyhow if this not required by your series, you should split it out of
it, and send it on your principal changes are merged.
I'm worried because this these new patches involve many subsystems (thus
maintainers) and reviewing them will now take a fair amount of time.

> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> targets from the set of target/hw/*/device.o.
>
> If the set of targets are all little or all big endian, re-declare
> the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
> respectively.

If only little endian targets use a device, that doesn't mean the device
is designed in little endian...

Then if a big endian target plan to use this device, it will require
more work and you might have introduced regressions...

I'm not sure this is a safe move.

> This *naive* deduction may result in genuinely native endian devices
> being incorrectly declared as little or big endian, but should not
> introduce regressions for current targets.

Regards,

Phil.

