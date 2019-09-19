Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774DDC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CB721928
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CB721928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schrodt.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0qG-0006RC-FA
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 14:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <martin@schrodt.org>) id 1iB0Kp-0006TX-0x
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <martin@schrodt.org>) id 1iB0Ko-000142-1E
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:35:14 -0400
Received: from [2a01:4f8:141:20d3::2] (port=53676 helo=zapp.schrodt.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <martin@schrodt.org>) id 1iB0Kn-00013L-R9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:35:13 -0400
Received: from [178.254.117.28] (port=52878 helo=[192.168.61.123])
 by zapp.schrodt.org with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
 (Exim 4.92.2) (envelope-from <martin@schrodt.org>)
 id 1iB0Km-0006AZ-2h; Thu, 19 Sep 2019 19:35:12 +0200
Subject: Re: Will the qemu-devel prefix in the mails come back?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <9c6bf92a-0869-cf5d-222b-305e55393ebb@schrodt.org>
 <20190919172905.GC22853@redhat.com>
From: Martin Schrodt <martin@schrodt.org>
Autocrypt: addr=martin@schrodt.org; prefer-encrypt=mutual; keydata=
 mQENBFG43owBCADieX6Xjfput3Qz+1gov8WoGxfwcyPRHBPpFzSoo+UsgbOllBS0SIAC3ORP
 1Z7M+GI4a7O0+hJQl743cpfB/ZkQJONYut1KyBWGhUSBS6Nz4Zfbxam4+m/m/SsWz2cvfDqY
 MBaLo0MrFW1dVhGMPxwFUwtSPQP6OheRL5tg3zbHdX341A2JGEz906mrYE/8X/brPgNHhzBC
 nB9umfhxZRw0/t8i8y8nbH6xsMfdZhkT6BGg9hxal4+aONDOJYgLbNJWjp8h9BjWbioPjYAr
 8xd1KDtbe3vD5GwDH2jYx/OtrE/QucOA3OEspRU4bL18Ap51gEmlsXlDgRHXbRddHRkZABEB
 AAG0I01hcnRpbiBTY2hyb2R0IDxtYXJ0aW5Ac2Nocm9kdC5vcmc+iQE4BBMBAgAiBQJRuN6M
 AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAnNj/b8/ABtPRcB/4zcpD1pzNWgrHF
 8mseJ545mclasaaTy7nyMY6pLykylEtuPRSLllmFfW117Iw+yPPpEDquAsCwCVOh20V2rkrc
 6NdzIBxthg39yDGKxH8R7+1HlJymhCYrAJCGQ92Xenx8fCmZCwLH3MwI9jwlHUWZWj3kWD8x
 HXmxdzl20k+xHJvcjgFClt3YRnYhzpF3XcnaTbW9u72FQx3DAjQRL3m73x8Qyf2fZQ5S5k/p
 6rI2MktCXeia//t58sELPHAC39rnBIAp5+V/ElCExETYyDKM8pJuTxwJ1ahl/hVBvE9eih2W
 AJi9+jv4c7p36RT+55sdTtnxAreKHPzlb4atOHiruQENBFG43owBCADOb+GZjZm9pBfSIIL5
 u2GbMYyq+hCMUrNgzciyoZ6kLLEfCvQnQhdKV3Gv11Ccgv7s1efQcS09KCbP8p07yGVztD4b
 J2mQgntvmnfeo5OF/G/byFv85WUPRpTTQ5uafsGbPJk8TMw62AMHf8xxSTxOoiagUiW4SpyZ
 AakKG84BJccCSouNC2otM6Cc0/mLttd6OcQKJXDsrIy+z2Iu8t3+EkTC19+CJACHauqDQ7LN
 D5zyVxuq1mm6UybZoyh3JzfMuyFnMjaPfjcPK10cxoNCRAmu3INYwwZxV3dmmBJFgo1/QNqi
 aIm9R0k0C49PBtCj+GcE+PWjqmOYpYydXcbJABEBAAGJAR8EGAECAAkFAlG43owCGwwACgkQ
 JzY/2/PwAbSEBQgAh0miFBtYNFUnunC5lE1FcHnVlMkQ0hdikkEE8zS/4mNBDrnvUp++ww8A
 qJHvjvplp+GBIKk+77cT0UD2lKxYvy6cRfrLsspJdhUrD2q1vNW7rZHg7qCCfFCtCFOnC4aL
 FLpFQMPufNJ7TmzDUoesqADFSboeotC3RsS7/lsIqZXOmCNdIxv9YPPL8OuM3XiT8e0WxWYK
 NduiMIDjA0qSm060q5OUNaBbBO8QNlfQ8KGSKrbaMFaEgbOGoQF7LCa21uJ5v/wDvmyX3JRe
 WxUKWruIMBJbyRwVc8T9uTzVMHqKa+q5cOUVi3Ncs1XRaAg2Em0IqEbT/Jx2A8491Jg+Sg==
Message-ID: <abf955bc-2578-1f97-387e-2faca9e4c791@schrodt.org>
Date: Thu, 19 Sep 2019 19:35:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919172905.GC22853@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:141:20d3::2
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

On 9/19/19 7:29 PM, Daniel P. Berrangé wrote:
> On Thu, Sep 19, 2019 at 07:04:15PM +0200, Martin Schrodt wrote:
>> Does anybody know?
> 
> Unfortunately, no, it won't.
> 
> ...

Thanks a lot for the explanation, makes sense. Thank y'all for answering
so quickly!

Martin


