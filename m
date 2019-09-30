Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD857C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828D8206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828D8206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExlV-0005W7-O8
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iExPh-0005S4-8U
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iExPd-0006Nb-8W
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iExPd-0006Mv-0D
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:16:33 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E8BF85541
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 15:16:31 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k9so6101166wmb.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 08:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=798MjSRN6q3iLl2pK77ByyQ3+NW/J3ezV/4MFSKJI4U=;
 b=c3teU82i/doovKU3zHXBbgtFZaaELa7nDGGoykVUcaF9ZN5PBTht4vZtzFYMxuDAK0
 TVKc8lPCNAslGXIaqUPjQdd3VMhTjdlRf07l2DHrYfmUSfpyvqRL4nfDSNPyi/Ut8FQD
 V7TrIoT8kgnHIGkVCkjxZ4iG/AdDtdK0JjezopkqcW8VOr5Pis/TvisT4Yt3RnAa4wuT
 j8kvZTj+f3aHyCLdAQsqJNmHQ4kqiTTi2RR7QIVnrJYnjg32IC5/wijFIxxn3YaAbOnX
 FVqpgeHZlWj2tj194cxI90SuOxEnFm1tvrLEDtlcRMzq+HumEJGHmkKuwRNyXlDAcoVh
 pDZg==
X-Gm-Message-State: APjAAAV6rXdoZhxIWAyqJqLupSlIaoZmJ5QHhT/0FF0EqCFdUp+EuFX1
 vZqUtg/t5Q2PVpFmmILeyaIZECm2+eV58U2Nmf5XeYNV9rskXKs/FyxeDbW9owgPkNU1tgGTkf/
 cmUYPSreYqdyBBfg=
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr13203961wrn.352.1569856589893; 
 Mon, 30 Sep 2019 08:16:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/HpXhGwS+aAM34/IAB60iLhRxqAEs8PShtfWcEdU4pYcdsKCI06BR0v7UquRYSVIDlgCOtQ==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr13203947wrn.352.1569856589612; 
 Mon, 30 Sep 2019 08:16:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id c18sm14507376wrn.45.2019.09.30.08.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2019 08:16:29 -0700 (PDT)
Subject: Re: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
To: "Hu, Robert" <robert.hu@intel.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
References: <20190926214305.17690-1-ehabkost@redhat.com>
 <20190930102453.GO4884@orkuz.int.mamuti.net>
 <20190930141104.GA4084@habkost.net>
 <9E79D1C9A97CFD4097BCE431828FDD31173BCF76@SHSMSX104.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b9fbca16-9877-04b9-78fa-bf711c8f3053@redhat.com>
Date: Mon, 30 Sep 2019 17:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9E79D1C9A97CFD4097BCE431828FDD31173BCF76@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Kang,
 Luwei" <luwei.kang@intel.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/19 16:31, Hu, Robert wrote:
>> This might be a problem if there are plans to eventually make KVM support
>> pconfig, though.  Paolo, Robert, are there plans to support pconfig in KVM in the
>> future?
> [Robert Hoo] 
> Thanks Eduardo for efforts in resolving this issue, introduced from my Icelake CPU
> model patch.
> I've no idea about PCONFIG's detail and plan. Let me sync with Huang, Kai and answer
> you soon.

It's really, really unlikely.  It's possible that some future processor
overloads PCONFIG in such a way that it will become virtualizable, but
not IceLake.

Would it make sense for libvirt to treat absent CPU flags as "default
off" during migration, so that it can leave out the flag in the command
line if it's off?  If it's on, libvirt would pass pconfig=on as usual.
This is a variant of [2], but more generally applicable:

> [2] However starting a domain with Icelake-Server so that it can be
> migrated or saved/restored on QEMU in 3.1.1 and 4.0.0 would be
> impossible. This can be solved by a different hack, which would drop
> pconfig=off from QEMU command line.


Paolo

