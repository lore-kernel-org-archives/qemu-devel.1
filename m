Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B06C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD4124125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BpZi0RJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD4124125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifrne-0007Vk-69
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 15:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ifrjs-0006G7-Ta
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ifrjr-0006le-Jj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:40:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:44563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ifrjr-0006fq-6V
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1576269629;
 bh=HhcPoKz3hZagBCruvLb75Q5uhutpL5mly03ySPE3ESg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=BpZi0RJfyLvuWCqQ9cdMm68QvSIuvmL1AcsNecWT3+2IVIhiKr4mlHu3/AwPpmq9q
 IrwLse7MlsMfIO5FOg6nJMigCe/aq7xlofur37exYfMxwkp0ik//Z62OfEA+KcKBPh
 nivGJOoVE3G2uxYUjFk1cy9azfB8WRN7M+8IIG2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.129.239]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1iBDNy2a87-00WpoN; Fri, 13
 Dec 2019 21:40:29 +0100
Subject: Re: [PATCH v4 0/6] HPPA: i82596, PS/2 and graphics emulation
To: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191103205607.6590-1-svens@stackframe.org>
 <20191123135928.GA5553@stackframe.org>
 <4848d948-063c-826a-a3f3-9bdbad04f9ac@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <5ce01ea9-3cab-c774-41b1-25dcdc1b6aff@gmx.de>
Date: Fri, 13 Dec 2019 21:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4848d948-063c-826a-a3f3-9bdbad04f9ac@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jtlwFu8Yp9SYzl1DXEZgjuwumw+NE2/sCCNdQ5MO/mUfF2uIpRZ
 r2BHX7lh09SExJTF6ZDY3rKUBGlJMLGAse7h00jz2VlNjkiPCNdXHEtvlmgjx80CiP1FWAz
 2D/44j3Zo1WjqkKD61gwFLvOEmACfGZoeBqPxL2axozLrlu/hc6OQs/UUMhFnKWz+uqY2Nf
 HkZoKCKfmsTuDKfhN/Niw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mG2CgwymDZY=:XNtBAkBhOAVQd8d2ZAoEFZ
 4ydL4bszsUgVSDebQVgkUXCiBDeJGvW5Q1cNbIq8PpdeUxjPnl6qQ8Cg/iUJMbMPROxtcbSL2
 liY5Qi+tx01SaS5YhbxGjhEhU+7bXtTskpKDrVK10PHcalrPvZ0Cymbe3Wip5OpaUGCF1e670
 NVjQMvnrbqebJfewdXejghL4IT1U9iNFglErI50bj05Ntm9erP56jK85OQmdpWxDm9Dxnw072
 6ODa1g9gsJWnOgeJrZ2AzKMwZJwar+vPIbrU2JEAJTgo10TEx6TbEhgnznZpYVBKnhsbsymP1
 rGmLL01OBoMUlHqeA4v95KSlQV6FmMGoqimG0C0j4vQ7e24VPR1JIQeSpC4wIfvhr3bb3pmFK
 Rl3XTLqEYRK+dR1BBjixxZbJTIoBs9xQBu1BCtu3xAkzmzrso3mRR1RDHezkZeJ/l6eyEWY4m
 kx/P/Z2hF1N8zp3ftfmFCOG2nQOqnTlRrM8gVR8wJE0xPYlhcTGmdLmmZ1KNuryyxALpmcm3m
 k7MqRcwNK53SZ6b+jQ4Izx9pOsvUWWbwkyoOkfMgjogk8Dpug1aGoPpXdgpCO0GXRj2vNWYNg
 QSzwXOBoZTuvhYH7rkKALbOWG2VG3J27Jo/e99VIA1yt7ZuhVp6Sn6tuuSHWydICG1YcW9fyD
 //ItYh+pIM4irROLx6itPSZjfak4qY/onGyg56BMTxKFpnAT7+hOosptTyxuGKwMSZTGSnGEL
 nuykf5Kr4wPLRYbgNCfiLBr+3ga7xPmnRa3zkLlEaF0bzq8nUxcuK2it0HuZTEFZM+BINRGBs
 XC9aGV6zrUmO8lCPeGb33qw12hq4nhMrRkoFT3MabieWiC5CZq9Vt1u6IcMwlAwPKnCQEi2q0
 v8Byx6rJS/DKnclJtguOr9Xks1tztBpvbmT8YbZBtfFZMkwvMlUBJsqEliPPo0cVR1orp6vmP
 qC4gMb35qW6hu0PqKTO0iF1eLvoUklA0cTLN1vUZdQgY5ipwuE1rE/GKtXjOzPdKw5o8UntbY
 ramvoH585og9D83a4qHbybGN2+S/HedYY6cyYdyCH4IsvZspnpeYOokpQVGYv1ZI+kbOvI4mu
 lbLBfKKPGRsmjDFVcnNCUguugiyDGKRNOvQbXEKu7NB3lyQj+RJd0mzrZ1Q0vR5S/ne7r0Y7V
 /uxKyZAZ/fM5vC2np/eWFHiEXNfyqrLGr+kmO51zoyl1S/BJ6yIC6v6j7gdzx7ikcWgEeyJks
 g4J+oicC1aDMFdbkpXlL5yQQ564bCAzgfp+TUHQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.20
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.11.19 11:01, Richard Henderson wrote:
> On 11/23/19 1:59 PM, Sven Schnelle wrote:
>> On Sun, Nov 03, 2019 at 09:56:01PM +0100, Sven Schnelle wrote:
>>> Hi,
>>>
>>> these series adds quite a lot to the HPPA emulation in QEMU:
>>> i82596 emulation from Helge, PS/2 and Artist graphics emulation.
>>> [..]
>>
>> Ping? :-)
>
> Version 1 missed the 4.2 cutoff by few days.
> We'll get this merged for 5.0 once development opens.

To avoid confusion because we missed qemu 4.2, I've deleted the
parisc-qemu-4.2 branch at the parisc-seabios git repo [1].
Instead I've created a parisc-qemu-5.0 branch.
Please use that instead if you push the prebuilt seabios rom and
git submodule references.

Helge

[1] https://github.com/hdeller/seabios-hppa/tree/parisc-qemu-5.0

