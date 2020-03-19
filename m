Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C6C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58642076E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpPTuVjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58642076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jElAv-0000PS-TH
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jElAC-0008Ln-N6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jElAA-0005cS-LX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:44:04 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jElA8-0005UV-8q; Wed, 18 Mar 2020 22:44:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id r3so360658pls.13;
 Wed, 18 Mar 2020 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=HEGphen06MFZCeyeel8e6WO0sFLbMnT5piXzOBdMdvM=;
 b=YpPTuVjHwPJCX4ZyS3l0oHIyq7tcRIzjo1Ln/8Kd1GKoLvY7v3SC/t+WeCjnJMqSnD
 1mPR82wOQid+OrNBEDxNbx+qigNX0cJiFV1TCvljhDcxtg0I7Up2H0ado+lVTEUXTIbF
 mW+/7I4vCPTN+xO8nCXHfTsKSVOpXrvByw+8GIXs9rmrLaM2/Kjz7CNm7gDgFdou/CVk
 fuxLQBscqTmRDTbpRJRQ3Z9S2RbtwMnutZDl5gkHJHrpMcjWIy0LweSJdBCn1HWGU5uS
 w50znnwmm1GYmm1PbE2ckTIY3cv36Rqd/tkW5wwZMBZTvReCE71mtzwje1X0AqvZptMY
 Ip2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=HEGphen06MFZCeyeel8e6WO0sFLbMnT5piXzOBdMdvM=;
 b=o7E/tc5ByN0fxGwgrGMNxWNpqN3FOClK4xzWvMHqjoYf7jWaL1xQ+V+zJtr3N86cJM
 UYP9R53iLH6jRn/dCEO3gNHImoOIugozXzM7QuF9a0ONxo5c5bziDdeLHz+VsJhHMoXX
 RdLhlVXPjW85oWvcBguAdCi+oQxKWsTnZp3qNDZESIVl0NUnk6g6huRsowh6BXCHklvz
 pp3kfWY5XYbapjQpBw+A2F7ygjWbHPf5fKgMQegvB9Eu7PTGSZmzsmHHlyqTxkxrSlqQ
 TKOKD34OFAOIXHGXVMTi/fHtt01wcsK9oaYUku1PHnvjvScZp/REaTdoh8kG1Q46kfnu
 4QQw==
X-Gm-Message-State: ANhLgQ2cgrXpPQF9GsnQpWEnACU//CIV57/f3ex/5u+zmuHy+prV5+po
 8Kc1MGBkpiT5RkNs8Y56FGs=
X-Google-Smtp-Source: ADFU+vvRpCeDhOua7QzMiF1RXHvxXT1r6cAy43BNEl9Grw9NfD0/XhZfgKWXCKWW7AG+7VWBYPc2xw==
X-Received: by 2002:a17:90a:2e06:: with SMTP id
 q6mr1393147pjd.111.1584585838906; 
 Wed, 18 Mar 2020 19:43:58 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id u26sm328062pfh.193.2020.03.18.19.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 19:43:58 -0700 (PDT)
Date: Thu, 19 Mar 2020 12:42:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [EXTERNAL] [PATCH 2/2] target/ppc: Fix ISA v3.0 (POWER9) slbia
 implementation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200318044135.851716-1-npiggin@gmail.com>
 <20200318044135.851716-2-npiggin@gmail.com>
 <47de57fe-189f-aef1-87f4-d9e2b5d31b22@kaod.org>
 <c534dd84f3e8509b7d8f1e844e48ee0dfaa3c420.camel@kernel.crashing.org>
In-Reply-To: <c534dd84f3e8509b7d8f1e844e48ee0dfaa3c420.camel@kernel.crashing.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584585553.zuw6q5vhv4.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemu-devel@nongnu.org, =?iso-8859-1?q?Greg=0A?= Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Benjamin Herrenschmidt's on March 19, 2020 6:46 am:
> On Wed, 2020-03-18 at 18:08 +0100, C=C3=A9dric Le Goater wrote:
>> On 3/18/20 5:41 AM, Nicholas Piggin wrote:
>> > Linux using the hash MMU ("disable_radix" command line) on a POWER9
>> > machine quickly hits translation bugs due to using v3.0 slbia
>> > features that are not implemented in TCG. Add them.
>>=20
>> I checked the ISA books and this looks OK but you are also modifying
>> slbie.

That was a mistake that leaked in from debugging the crashes.

> For the same reason, I believe slbie needs to invalidate caches even if
> the entry isn't present.

I don't think it does per the ISA. If we overwrite it then we can only
invalidate with slbia. That's why there is that slb insertion cache for
pre-POWER9 that lets us use slbies to context switch so long as none=20
have been overwritten.

> The kernel will under some circumstances overwrite SLB entries without
> invalidating (because the translation itself isn't invalid, it's just
> that the SLB is full, so anything cached in the ERAT is still
> technically ok).
>=20
> However, when those things get really invalidated, they need to be
> taken out, even if they no longer have a corresponding SLB entry.

Yeah we track that and do slbia in that case.

Thanks,
Nick
=

