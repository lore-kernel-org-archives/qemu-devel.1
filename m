Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08D6C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9010421929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9010421929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6tb-0007WN-1z
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 17:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS6m5-0000QP-VC
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS6m4-0003x2-D9
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:54:05 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS6m4-0003v8-2M
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:54:04 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MwPjf-1hbvQR3EZh-00sM8x; Tue, 05 Nov 2019 22:53:58 +0100
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
References: <20191102171511.31881-1-laurent@vivier.eu>
 <20191102171511.31881-3-laurent@vivier.eu>
 <b357fb5d-bae2-5ab0-7c63-4f7106fb8c4e@reactos.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/3] dp8393x: fix dp8393x_receive()
Message-ID: <74333772-6574-2f56-df2c-e7ab48773996@vivier.eu>
Date: Tue, 5 Nov 2019 22:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b357fb5d-bae2-5ab0-7c63-4f7106fb8c4e@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NT5ntSPKBxeFugi08pXNk28BnrScpL+G4BqH6b2rso7HtT/XdTy
 SAHcPKTbHXISqAexSrYNi6Dg3iXjkKBmgohI3g8Pf62QsL7hsmpQGZh6bMnkMiXOjQjG9nW
 u7GNUT/E5VvrRtYwsFHbmM77u5jwsxC6QFeNs4yQpSMOxiU3MVYevmXNAa51EUr1nnAce0r
 C/EkIkTQDcdTeX4CVIUlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XCbpBZLg8LU=:fxtRW6QFAGbCQidquySU0M
 cE9nq+QYdu9wffxx6oOCiQzPUkc88/h6t3lIE5WESeBvT+HtU8hC2C+VawoR5bN4f87hPYl6X
 KqR+K38h9PdXTi+btMC1A5p0DIvEUYvkJMr0RpCKlSOOYdwOwZihm+wW7QiW1M/NEm5Rq3hwq
 3pHv3lU1f/S066zJrnMhxN/lD5PKMROb12yURkWCG1FD7ONcQQaNgv+jqmW+zaNi1aejle9en
 30nS71aho8MsQC5FKclzG1oxlLlAiY2qpmz+129inT4+wTWwZtOzAuecveC4g0/tF5Fh6MnyU
 iNP9qAKRtWLisRUyW/tD7KGXEEPJqAqyHEnqxodv+Z7pmuvyLMcWQLQ75/a2XcDQKNgUsHf2j
 eNorTWp3WHt9zmdz249RZDtbqdZzSeyTzRf6wMN4fttcrSBAN+GshEUw7JLhnqCMrNwlM6C8z
 gvzS4h6OU4azztvdIQL0/WeHsIUoZXX3xqKjzd7wQzEmg2dJ90fzFwo6HAYMFUOqbVK0Me2vt
 oJAObaK7sA2/+IK0ZXvNWbxGWBlM0g0azv56fb7R/guPpzF85kk5OCqj2XigaPghn4sTZd99+
 Xc/ktX8F49fGELSe4UUipOpLffOFnRsGSvjbuIRVDPsprzc17fSIJO0CIft7T4Mpg/ONm4m6g
 bFbxeT7rwtEOkyjsflfVZ8ANejAc/GJZfR2JrYLXtlPXAroAgsXXcPwGJQKR4B5NIdS/K2EmQ
 pf7lb0lGNaGN/70v+m3ddjqnoLGzlzvlhbogshxbzQoRWjFI1fL6LiU3GsZLil3V6biVzoFLf
 kTVsn3PVMAFkXaYuwWaoC5VR+ZEKpHNBYI1m9h0o1UABCkkraT1tRaBCVwLXvmIcfmxVL+Ff5
 Sxrna9gU71ZzASqaG9+No2PeZlL3Kg17veWAcUOe8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/11/2019 à 22:06, Hervé Poussineau a écrit :
> Le 02/11/2019 à 18:15, Laurent Vivier a écrit :
>> address_space_rw() access size must be multiplied by the width.
>>
>> This fixes DHCP for Q800 guest.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/net/dp8393x.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index 85d3f3788e..b8c4473f99 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -833,7 +833,7 @@ static ssize_t dp8393x_receive(NetClientState *nc,
>> const uint8_t * buf,
>>       } else {
>>           dp8393x_put(s, width, 0, 0); /* in_use */
>>           address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t)
>> * 6 * width,
>> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data,
>> sizeof(uint16_t), 1);
>> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
>>           s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
>>           s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
>>           s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) |
>> (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
>>
> 
> This patch is problematic.
> The code was initially created with "size".
> It was changed in 409b52bfe199d8106dadf7c5ff3d88d2228e89b5 to fix
> networking in NetBSD 5.1.
> 
> To test with NetBSD 5.1
> - boot the installer (arccd-5.1.iso)
> - choose (S)hell option
> - "ifconfig sn0 10.0.2.15 netmask 255.255.255.0"
> - "route add default 10.0.2.2"
> - networking should work (I test with "ftp 212.27.63.3")

I've the firmware from
http://hpoussineau.free.fr/qemu/firmware/magnum-4000/setup.zip
Which file to use? NTPROM.RAW?

> Without this patch, I get the FTP banner.
> With this patch, connection can't be established.
> 
> In datasheet page 17, you can see the "Receive Descriptor Format", which
> contains the in_use field.
> It is clearly said that RXpkt.in_use is 16 bit wide, and that the bits
> 16-31 are not used in 32-bit mode.
> 
> So, I don't see why you need to clear 32 bits in 32-bit mode. Maybe you
> need to clear only the other
> 16 bits ? Maybe it depends of endianness ?

Thank you for the details. I think the problem should likely come from
the endianness.

The offset must be adjusted according to the access mode (endianness and
size).

The following patch fixes the problem for me, and should not break other
targets:

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 85d3f3788e..3d991af163 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -831,9 +831,15 @@ static ssize_t dp8393x_receive(NetClientState *nc,
const uint8_t * buf,
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        dp8393x_put(s, width, 0, 0); /* in_use */
-        address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6
* width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data,
sizeof(uint16_t), 1);
+        /* Clear in_use, but it is always 16bit wide */
+        int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        if (s->big_endian && width == 2) {
+            /* we need to adjust the offset of the 16bit field */
+            offset += sizeof(uint16_t);
+        }
+        s->data[0] = 0;
+        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) |
(((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);

What is your opinion?

Thanks,
Laurent

