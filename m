Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2ABC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5312098B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5312098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD01W-000503-S0
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD00Z-0004BJ-Ov; Tue, 01 Sep 2020 02:43:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD00Y-0003Rn-17; Tue, 01 Sep 2020 02:43:07 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MQuLB-1jyv5x2plv-00Nz2W; Tue, 01 Sep 2020 08:42:58 +0200
Subject: Re: [PATCH] hw/net/can: Add missing fallthrough statements
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
References: <20200630075520.29825-1-thuth@redhat.com>
 <c31c772f-9d30-ac47-9e91-02126dc79736@vivier.eu>
 <202007140009.55103.pisa@cmp.felk.cvut.cz>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <278ac22c-e3f9-cc93-c711-ad420102141f@vivier.eu>
Date: Tue, 1 Sep 2020 08:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202007140009.55103.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lQXv3JTZV+xhFPnPtXnzJIpCk7lV7he7h+WpXxNcuoeDbWHIgYB
 +viX0AAXUkLCeQxdpkqlEVrAYvLwdGzG3swNXu31j7kDYHXFmIKx/mG9i8DssUmoPVDEtKS
 H+hSyIKqNjwxfk+8sqiKvXPm7o7OAeBww351y1veO+R46inZRzvfLxJuxv4jtrUMSz/rGnx
 AdoWRzZxu5u73Cs1EruAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jUmjIUnGbGM=:13KNceBjcVpV27tbIHRivB
 6GAaQUeBKHQJZVCXYOb/Ne27IWZtco83OFuQwmgfCgR9bm7R3ZNXUh8pMVvTxHDNOSKq99yWS
 oGa+phUOkaOFEqr3CaEPbURNoxMvii2cSEF+agr+w1grknt/D7TqtgFPReXWE8ODpaWy6090b
 np3/PXOrQCXtaWp+UAt5Gesxbmjvb+6fkC+Y9pmXpah4hVPkjKm5kxZBzOgMpaoowU571nykL
 UcYQOeuhbgulk65aEeBsFbIl9eZK8FzRKH3Fx/8ngdXLe3ZCnWAYv2aHvkIDdm2z34dQeLWSD
 +mQFKNHSx4Cjc9iNoaQAb2QaqRTm739EUa8iRD+AmHMe69vv92kb1al1JyiMknRyJNgWjnbbZ
 Kt567rYyZw9KoaJjSugjuwU8JDia2slqvr/p9tw6udZuy3z6So01M+YvFlqvEXrnAQrOn9ip4
 doEkdThJeArxjYnwVbepxKIDgHP/eAGUgmqJe2eNb66ORF9GqRP3HPaERQ5sTI8/HrBAuQbc5
 cLZy5gCYooS8zqgHzIQ5fgd6fG/8CvTc/U+/YNlmm2GEr7pUIv9aaD7Y+1dOrQ+0/yb23galP
 /MZwvSYDqxTe4a+AzbpMz9wtplojiPZhGbx/ttMBla2HojCgke4wyZtOY8NITjWyJGJh60tti
 KVpMBN+2uNqfu3okYV2s2h6jDYmChCJt8PzRZuo4vKPBFRJItmT6iGhA4aup4Z9TQf4CZjOh6
 V3VhhxTkgkibw/Q71l4cKtG3peU0UxaW+vegm+dVwaVkfS6NoARI7FE5Tn2w22GOm82KoU4fq
 HCobwNjxcPHWzp7YBKxddSGjHrOwod3R4mfILzggjcjZG8FUZzrEYQaH+aOyLu3/NtstbJb
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:35:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Oliver Hartkopp <socketcan@hartkopp.net>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Ondrej Ille <ondrej.ille@gmail.com>,
 =?UTF-8?Q?Jan_Charv=c3=a1t?= <charvj10@fel.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/07/2020 à 00:09, Pavel Pisa a écrit :
> Hello Laurent and others,
> 
> On Monday 06 of July 2020 18:35:50 Laurent Vivier wrote:
>> Le 30/06/2020 à 09:55, Thomas Huth a écrit :
>>> Add fallthrough annotations to be able to compile the code without
>>> warnings when using -Wimplicit-fallthrough in our CFLAGS. Looking
>>> at the code, it seems like the fallthrough is indeed intended here,
>>> so the comments should be appropriate.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/net/can/can_sja1000.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
>>> index ea915a023a..299932998a 100644
>>> --- a/hw/net/can/can_sja1000.c
>>> +++ b/hw/net/can/can_sja1000.c
>>> @@ -523,6 +523,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr
>>> addr, uint64_t val, break;
>>>          case 16: /* RX frame information addr16-28. */
>>>              s->status_pel |= (1 << 5); /* Set transmit status. */
>>> +            /* fallthrough */
>>>          case 17 ... 28:
>>>              if (s->mode & 0x01) { /* Reset mode */
>>>                  if (addr < 24) {
>>> @@ -620,6 +621,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr
>>> addr, uint64_t val, break;
>>>          case 10:
>>>              s->status_bas |= (1 << 5); /* Set transmit status. */
>>> +            /* fallthrough */
>>>          case 11 ... 19:
>>>              if ((s->control & 0x01) == 0) { /* Operation mode */
>>>                  s->tx_buff[addr - 10] = val; /* Store to TX buffer
>>> directly. */
>>
>> cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> The fallthrough is intentional for sure but I have gone
> through datasheet and checked why the status bit is set
> there and my conclusion is that to mimic real HW the status
> bit should not be set there. In the fact, it should be set
> and immediately (in a future delayed) reset after SJA_CMR
> transmit request write. This would mimic real hardware
> more closely. May it be I send patch in future when more
> of our developed CAN support is added to QEMU. The status
> bit behavior has no influence on actual Linux SJA1000 driver
> anyway.
> 
> So for now, I confirm that adding  /* fallthrough */ is correct
> step forward.
> 
> Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


