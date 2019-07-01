Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45356C06511
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21107206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21107206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtcS-0004Oc-9h
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhtZw-0003Nx-Dn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhtZu-0001jS-7u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:30:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhtZu-0001iQ-0e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:30:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so15314395wma.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 03:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CqFsUh87G8r01B1C4PLkKg+I7/gGlWet9QM9IHj3RhU=;
 b=JGmmpW/I6PcyJykLzYuMQly4q3yEKLSn0XAewXjWOhebERwwGaep+Wx3+IQCI2m54O
 MLDGfBVsHFTiS+amkei9c+IRb2M2ScbrDXFIwjvcvbSkG4v4wAkfNPnsmPB3GRMRNIk7
 dqw5RkPS6G9hFhzjY3RjIh5S6kKS5KXpZ5S7kaqDYjbUltVYkE15VFV7S8MADT6qEwCB
 75q+sY+qXEQDbVdkvmxu+C9ahT38QXEAtd5x06R4scYJ+gfI+KRq3jEKB6u7JQ3BBpAO
 i7DpMWgkAlVCMv1nA1DRiz6wIo18MO3c7SMGrpkpdXCLC59kzYaLhlsto0RxoppZOqKs
 611w==
X-Gm-Message-State: APjAAAVwHtvQqrStkDZkaMxQ69P/jTezhqssiT4rstBaR7xvpz8Mnbeg
 YghwLjJkyXFoSiE4j57tgYXCzA==
X-Google-Smtp-Source: APXvYqzldtEnbosLvvcHveD1OebbGc2m7G6FAjdy6Yl0l1aFu1Cit2GFj3LNbIoFe9XYwZTB0Ooiqg==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr17406509wmh.165.1561977028120; 
 Mon, 01 Jul 2019 03:30:28 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x11sm9289223wmi.26.2019.07.01.03.30.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 03:30:27 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190311005618.19007-1-philmd@redhat.com>
 <CAL1e-=gqqd4EogYQqb74zLkS+a=8yhfNS5tnFhG6GWSRw5vdkQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <63fd1b6a-3e35-747f-0dca-c7f1c0f38aea@redhat.com>
Date: Mon, 1 Jul 2019 12:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gqqd4EogYQqb74zLkS+a=8yhfNS5tnFhG6GWSRw5vdkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
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
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>,
 Thomas Huth <thuth@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 James Hogan <jhogan@kernel.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 6/30/19 9:12 AM, Aleksandar Markovic wrote:
> 
> On Mar 11, 2019 1:56 AM, "Philippe Mathieu-Daudé" <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
>>
>> Express the MIPS machine dependencies with Kconfig.
>>
>> Due to its complexity, the Malta board fill follow in a different
>> series.
>>
> 
> Philippe,
> 
> What do we do with this series for 4.1?

As commented in another reply of this cover, while addressing your
comment "systems with CPS that doesn't have ITU" I hit an incongruous issue:

  /usr/bin/ld: target/mips/op_helper.o: in function `helper_mtc0_saar':
  ./target/mips/op_helper.c:1614: undefined reference to `itc_reconfigure'
  /usr/bin/ld: target/mips/op_helper.o: in function `helper_mthc0_saar':
  ./target/mips/op_helper.c:1631: undefined reference to `itc_reconfigure'
  collect2: error: ld returned 1 exit status

Then while trying to resolve this I exhausted the time I had to work on
this.

Since I doubt we can fix easily the design flow when (coproc)
instructions access optional device before 4.1, I'll also take out the
Boston patches, and see what's left I can respin.

Regards,

Phil.

