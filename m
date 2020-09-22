Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A970C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA378207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDtH/Y60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA378207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlkj-0002cs-Kp
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKlGW-0002l2-Gh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKlGT-0002ji-Qa
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600792536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqnZJOEuUcpQsb9WxFVyyP93CsLg6sjqatL0aqqSBQQ=;
 b=MDtH/Y60HhA+SLBG33BiA0/k5mLGwTztGJ8+vK5EqLOgZOo5eiZUUfm8pQJjQ3gfukBBgu
 ynhq38pJGBRIR5zlOHYvAIKo5g/u/iRI00UyesyIF/ETrLNSOXT8WPYyqndB86zxSnzL1d
 kMcEP1Sy5gGDKPfNicnBlS1qZYVJYeQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-DGd_1nlePTeisHNTrtp0MA-1; Tue, 22 Sep 2020 12:35:34 -0400
X-MC-Unique: DGd_1nlePTeisHNTrtp0MA-1
Received: by mail-wm1-f69.google.com with SMTP id y18so757226wma.4
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 09:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqnZJOEuUcpQsb9WxFVyyP93CsLg6sjqatL0aqqSBQQ=;
 b=bbeRw8a9XsL2IVvbrzo/Gr4pg9suKss0K9X0cP3nktPPlAgFXQT0KcT4U2Mi1LA1xm
 SHghrpq+wjgeVfcw1pdvAZc6IhLl6DXAyY8mUnTbtkPbAKemgmHuhbXmUErwbzg33sJC
 +MePypPvoAWS12tE6rXdWJokkjGcWBtcJZTlPuAkODBN/zLmPzRPXbU03cOU1d5HjMtc
 S9NIrcDyLeH/6n1bZFujFjWYYWRsYm393CAMiDOxQUPAGzSa5zNr3QepKWVx1xu4sJyH
 y9EEj2ZKvCP998dESR4hZsCk70peRZacKcdTuIYI7k0MiKgFnI2oTTRBC93o/S+1liHn
 A/aA==
X-Gm-Message-State: AOAM5303FLny+BSct3whGE9c7f7kKTAhkpqlVwugtJOiaSMaxhxlpiv7
 C1DETutAWLJSErXUrjEKtokO6viEcgUQMzLz9DIdd/RuqHgkZzzRYoa/PEz2sLP68iq97CuzcPE
 MVVL63JpX2wwbQqo=
X-Received: by 2002:adf:f548:: with SMTP id j8mr6612346wrp.114.1600792532879; 
 Tue, 22 Sep 2020 09:35:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqF4Y+cacSmuxU0BUVFAeI6G0w9kAb357NlYFwmqscXwbJmhgReQfV5cT5ClZjzsBaUQhDJQ==
X-Received: by 2002:adf:f548:: with SMTP id j8mr6612325wrp.114.1600792532608; 
 Tue, 22 Sep 2020 09:35:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id 189sm5477189wmb.3.2020.09.22.09.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 09:35:32 -0700 (PDT)
Subject: Re: [PATCH] coverity_scan: switch to vpath build
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200922130806.1506324-1-pbonzini@redhat.com>
 <CAFEAcA8kovt998Ds0jbEAJTqkHmJETcHvfwqCS-JZWWW+=wLrw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a242b133-4e2c-72b4-5739-a51cb3bd59d3@redhat.com>
Date: Tue, 22 Sep 2020 18:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8kovt998Ds0jbEAJTqkHmJETcHvfwqCS-JZWWW+=wLrw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 15:18, Peter Maydell wrote:
>> +echo "Nuking build directory..."
>> +rm -rf +build
>
> As Philippe points out, odd name choice.
> It might also be nice to steal the logic from configure
> that avoids blowing away the build directory if it
> wasn't created by this script in the first place.

I thought that was a bit overkill for this usage, and just used a
slightly odd name to limit the chance of doing damage.

> PS: on the subject of component regexes, they seem to have
> vanished from the Coverity website. I don't suppose you have
> a backup of them, do you ? (I have a list of what the component
> names were, but not the associated regexes.)

I did have a backup and I've now tried to update them again.
It passed, here they are:

alpha	(/qemu)?((/include)?/hw/alpha/.*|/target/alpha/.*)
arm     (/qemu)?((/include)?/hw/arm/.*|(/include)?/hw/.*/(arm|allwinner-a10|bcm28|digic|exynos|imx|omap|stellaris|pxa2xx|versatile|zynq|cadence).*|/hw/net/xgmac.c|/hw/ssi/xilinx_spips.c|/target/arm/.*)
avr     (/qemu)?((/include)?/hw/avr/.*|/target/avr/.*)
cris    (/qemu)?((/include)?/hw/cris/.*|/target/cris/.*)
hppa    (/qemu)?(/target/hppa/.*)
i386    (/qemu)?((/include)?/hw/i386/.*|/target/i386/.*|/hw/intc/[^/]*apic[^/]*\.c)
lm32    (/qemu)?((/include)?/hw/lm32/.*|/target/lm32/.*|/hw/.*/(milkymist|lm32).*)
m68k    (/qemu)?((/include)?/hw/m68k/.*|/target/m68k/.*|(/include)?/hw(/.*)?/mcf.*)
microblaze      (/qemu)?((/include)?/hw/microblaze/.*|/target/microblaze/.*)
mips    (/qemu)?((/include)?/hw/mips/.*|/target/mips/.*)
nios2   (/qemu)?((/include)?/hw/nios2/.*|/target/nios2/.*)
ppc     (/qemu)?((/include)?/hw/ppc/.*|/target/ppc/.*|/hw/pci-host/(uninorth.*|dec.*|prep.*|ppc.*)|/hw/misc/macio/.*|(/include)?/hw/.*/(xics|openpic|spapr).*)
riscv   (/qemu)?((/include)?/hw/riscv/.*|/target/riscv/.*)
rx      (/qemu)?((/include)?/hw/rx/.*|/target/rx/.*)
s390    (/qemu)?((/include)?/hw/s390x/.*|/target/s390x/.*|/hw/.*/s390_.*)
sh4     (/qemu)?((/include)?/hw/sh4/.*|/target/sh4/.*)
sparc   (/qemu)?((/include)?/hw/sparc(64)?.*|/target/sparc/.*|/hw/.*/grlib.*|/hw/display/cg3.c)
tilegx  (/qemu)?(/target/tilegx/.*)
tricore         (/qemu)?((/include)?/hw/tricore/.*|/target/tricore/.*)
unicore32       (/qemu)?((/include)?/hw/unicore32/.*|/target/unicore32/.*)
9pfs    (/qemu)?(/hw/9pfs/.*|/fsdev/.*)
audio   (/qemu)?((/include)?/(audio|hw/audio)/.*)
block   (/qemu)?(/block.*|(/include?)(/hw)?/(block|storage-daemon)/.*|(/include)?/hw/ide/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
char    (/qemu)?(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)
capstone        (/qemu)?(/capstone/.*)
crypto  (/qemu)?((/include)?/crypto/.*|/hw/.*/crypto.*)
disas   (/qemu)?((/include)?/disas.*)
fpu     (/qemu)?((/include)?(/fpu|/libdecnumber)/.*)
io      (/qemu)?((/include)?/io/.*)
ipmi    (/qemu)?((/include)?/hw/ipmi/.*)
libvixl         (/qemu)?(/disas/libvixl/.*)
migration       (/qemu)?((/include)?/migration/.*)
monitor         (/qemu)?(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
nbd     (/qemu)?(/nbd/.*|/include/block/nbd.*|/qemu-nbd\.c)
net     (/qemu)?((/include)?(/hw)?/(net|rdma)/.*)
pci     (/qemu)?(/hw/pci.*|/include/hw/pci.*)
qemu-ga         (/qemu)?(/qga/.*)
scsi    (/qemu)?(/scsi/.*|/hw/scsi/.*|/include/hw/scsi/.*)
slirp   (/qemu)?(/.*slirp.*)
tcg     (/qemu)?(/accel/tcg/.*|/replay/.*|/(.*/)?softmmu.*)
trace   (/qemu)?(/.*trace.*\.[ch])
ui      (/qemu)?((/include)?(/ui|/hw/display|/hw/input)/.*)
usb     (/qemu)?(/hw/usb/.*|/include/hw/usb/.*)
user    (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/exec/user/.*)
util    (/qemu)?(/util/.*|/include/qemu/.*)
xen     (/qemu)?(.*/xen.*)
(headers)       (/qemu)?(/include/.*)
virtiofsd       (/qemu)?(/tools/virtiofsd/.*)

Adding the "Other" component fails but, this time, it didn't blow up
and delete everything else.

Paolo


