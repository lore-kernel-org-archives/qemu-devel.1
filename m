Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB550C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D7722AED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D7722AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyst-0000g5-L5
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:44:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyrW-0008PS-Gn
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyrV-0007x7-Kz
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:43:26 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVyrV-0007wI-Fk
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:43:25 -0400
Received: by mail-wr1-f53.google.com with SMTP id d18so1833571wrs.5
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kyTjih9rynAjnV2tcVGHUx3FswbbCYtAfZLSKhAedRw=;
	b=adlKvkBF7pVxiVv6rhebrAXWzOhd4LGd0KNVVD84DdxBrROiryDzhi1zIdGKnokHZt
	Vs2MwFlUW98zXphZG+0vesKQbb3YQnyKjh0O8a3joXPDHxWq7avqa30wt+wyhw8KDmox
	ec9BTqZBYHkj2Xz/KuKmafe2z4nsIDrHbzlmfpHzHjUZQUqW+Ny7OohDIsgdpWF8Ri3S
	xlpxc2UTbg1i2AZtpF37GOH1ViCiEnYy8EzZQWOzBA9HFvAOQR8m4i4t9JWyETyuHcE/
	9B5nqTvN5rFiMjbn2+F1AATgXsBBTF5xF4RsuqIYys7afvUWcz6ZBeDne2PUWBPYXpNd
	v6Wg==
X-Gm-Message-State: APjAAAU+mMvMTIVufdYAo9QWNGNrpp3Ur3kArnFttQZL1heHSpzF2/AU
	TdaFUHBtkMNRtUKbIELB3ndaiw==
X-Google-Smtp-Source: APXvYqz/lqj/+/j2y7wX/6U0g0HFuqB28JuwnyDwJS0eokpOLjE1TkElhXHciBUd/pLY6KB2ipHDyg==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr44541089wri.190.1559137404180;
	Wed, 29 May 2019 06:43:24 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	k185sm3513032wma.3.2019.05.29.06.43.23
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 06:43:23 -0700 (PDT)
To: Aleksandar Markovic <amarkovic@wavecomp.com>
References: <BN6PR2201MB1251C914F948CFB53757492DC61F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2b3a7c62-81d1-0d91-e7d5-03c9fcd4a012@redhat.com>
Date: Wed, 29 May 2019 15:43:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251C914F948CFB53757492DC61F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.53
Subject: Re: [Qemu-devel] Malta-related files in MAINTAINERS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 5/29/19 10:22 AM, Aleksandar Markovic wrote:
> Hello, Philippe.
> 
> Currently, we have these two files in Malta MAINTAINERS section:
> F: hw/mips/mips_malta.c
> F: tests/acceptance/linux_ssh_mips_malta.py
> 
> Do we need to add more files, or other Malta-related files naturally belong to some other sections, or are shared by many boards?

Not related to your question:

The Malta model is an old one in QEMU, as such it uses the condensed
format where all the Malta specific devices are self-contained in the
same file. This organization has Pro/Cons.

New MIPS boards where added and instead of reuse components, they were
duplicated few times, so now it is harder to maintain.

Back to your question:

All the South Bridge and 'below' devices are shared with the x86 PC
machine, except:

- FDC37M81X Super I/O: maintained by 'PC Chipset'
- PIIX4 South Bridge: maintained by 'PC' but this might change
  as Michael S. Tsirkin is mostly interested in the PIIX3.
  I have a WIP painful series related to PIIX cleanup.

The North Bridge differs and is Malta specific, so you can add it in
this section:

- hw/mips/gt64xxx_pci.c

I'll sort the PIIX some day ;)

Regards,

Phil.

