Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D559C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FD72076E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOx1VJS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FD72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0hmc-0007wW-MB
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 04:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1k0hl1-0006RC-LL
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:48:16 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1k0hky-0004Xj-Ny
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:48:14 -0400
Received: by mail-ed1-x541.google.com with SMTP id l23so3120328edv.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=S0TE4Jdp2+O1lgoO241QABTtlDNWoL5nAwuUdzS2LB0=;
 b=GOx1VJS8SSifyo5uT9KEz1eRGCT3b651dpAKbhFvUzDYA8T4RS/NeFTMZjtzkp2KqR
 PuHsTAeqdFeN1w4fBHEdSHR+1j/9iIlZjyN1oXagRkUJHMO70InbhMZMTMuOj2vTEUAZ
 YT24jzgT3kwTS8C4yGM68qOpo5ek7kvJRoqzNzXxq3/4Mjujb1tQdmyPT4HySRti8N1I
 /J5ijsN+YataYLT01UKs5I7p0lJqCaz/ldFieHE2NIBPkooxIpSwTlANtVcZ3tUeIhW/
 memoCb1sQGPCiPFDCY2KOtdDkvuO9p5yPSDWz8Hm242ZVBcsa2VuavDEJhmZ5r32v2D1
 3tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=S0TE4Jdp2+O1lgoO241QABTtlDNWoL5nAwuUdzS2LB0=;
 b=gANrPULwwlas5c6tqpdsVWOrhGfOtflnzAsYwSD9yHkzB2Hx6hBa8XuexvpfWeoOB3
 6I/klnET00RN2vjfR7cb3XYazggwd3qohGfRjrDbvufNqDw1zjUXOuDploY5R2gZ5IgR
 MKgnqXTj8cXyGfV0HiAVOhP+9lMaqDBueGhXuAzQJCpEP2FRj/jgdeHCwDeD+7Hp6dcN
 S/GuIFe6Wxvm9rzS16rbPVu/Vq+mhsOoM0M6P7CnsC87kTblKn+O/IVxtd5S8ACi4E+9
 /IFQoBMCNYfps3f+7q4DfUfA8tV4tDjd+OJgqiIKa9KmcWXwVVm2r+egqEmrWmr2o1uo
 g1LA==
X-Gm-Message-State: AOAM533OGjurJOixTksYAbsSXReOYwtYpjBriAdx0fuVHS7P5Te2+cF3
 8FAHmkHVuzeyQXW4yK/3sWM=
X-Google-Smtp-Source: ABdhPJy9gInyQ+K7uZWngudVQqjoOJDGlCD+w7WDZPaIIEqb6GwbcFcjjcJV/1ILbyUcxLgPPVnLqw==
X-Received: by 2002:aa7:d88e:: with SMTP id u14mr30431017edq.11.1596012490707; 
 Wed, 29 Jul 2020 01:48:10 -0700 (PDT)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id q21sm1010128ejr.75.2020.07.29.01.48.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Jul 2020 01:48:10 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/2] assertion failure in net_tx_pkt_add_raw_fragment() in
 hw/net/net_tx_pkt.c
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200727172929.5nnasrbvp2gg3yyv@mozz.bu.edu>
Date: Wed, 29 Jul 2020 11:48:08 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA604F63-C36B-471C-9E0C-F9A84C9595BA@gmail.com>
References: <20200727170838.1101775-1-mcascell@redhat.com>
 <20200727172929.5nnasrbvp2gg3yyv@mozz.bu.edu>
To: Alexander Bulekov <alxndr@bu.edu>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=dmitry.fleytman@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org,
 ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

The idea looks good to me. I believe it makes sense to do the check in =
net_tx_pkt_add_raw_fragment() as suggested by Jason.

> On 27 Jul 2020, at 20:29, Alexander Bulekov <alxndr@bu.edu> wrote:
>=20
> I sent a reproducer for the to the list some time ago, but never =
created
> a Launchpad bug...
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg701930.html
>=20
> Anyways.. I can confirm that I can't reproduce the issue with these
> patches.
>=20
> Minimized Reproducer:
> cat << EOF | ./i386-softmmu/qemu-system-i386 -M pc-q35-5.0 -nographic =
\
> -display none -serial none -monitor none -qtest stdio
> outl 0xcf8 0x80001010
> outl 0xcfc 0xe1020000
> outl 0xcf8 0x80001004
> outw 0xcfc 0x7
> write 0xe10207e8 0x4 0x25ff13ff
> write 0xe10200b8 0x7 0xe3055e411b0202
> write 0xe1020100 0x5 0x5e411b0202
> write 0xe1020110 0x4 0x1b0202e1
> write 0xe1020118 0x4 0x06fff105
> write 0xe1020128 0x7 0xf3055e411b0202
> write 0xe1020402 0x2 0x5e41
> write 0xe1020420 0x4 0x1b0202e1
> write 0xe1020428 0x4 0x06ff6105
> write 0xe1020438 0x1 0x63
> write 0xe1020439 0x1 0x05
> EOF
>=20
> -Alex
>=20
> On 200727 1908, Mauro Matteo Cascella wrote:
>> An assertion failure issue was reported by Mr. Ziming Zhang (CC'd).
>> It occurs in the code that processes network packets while adding =
data
>> fragments into packet context. This flaw could potentially be abused =
by
>> a malicious guest to abort the QEMU process on the host. This two =
patch
>> series does a couple of things:
>>=20
>> - introduces a new function in net_tx_pkt.{c,h} to check the maximum =
number
>>  of data fragments
>> - adds a check in both e1000e and vmxnet3 devices to skip the packet =
if the
>>  current data fragment exceeds max_raw_frags, preventing
>>  net_tx_pkt_add_raw_fragment() to be called with an invalid raw_frags
>>=20
>> Mauro Matteo Cascella (2):
>>  hw/net/net_tx_pkt: add function to check pkt->max_raw_frags
>>  hw/net: check max_raw_frags in e1000e and vmxnet3 devices
>>=20
>> hw/net/e1000e_core.c | 3 ++-
>> hw/net/net_tx_pkt.c  | 5 +++++
>> hw/net/net_tx_pkt.h  | 8 ++++++++
>> hw/net/vmxnet3.c     | 3 ++-
>> 4 files changed, 17 insertions(+), 2 deletions(-)
>>=20
>> --=20
>> 2.26.2
>>=20
>>=20


