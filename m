Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84AFC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF34820735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF34820735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXYr-0005YQ-Vf
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49034 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jQXYH-00057c-Ue
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:37:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jQXYG-0005Y4-G4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:37:37 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:37288)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jQXYG-0005TT-1B; Mon, 20 Apr 2020 10:37:36 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 67D50747871;
 Mon, 20 Apr 2020 16:37:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 44EC7746383; Mon, 20 Apr 2020 16:37:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 439BB746381;
 Mon, 20 Apr 2020 16:37:30 +0200 (CEST)
Date: Mon, 20 Apr 2020 16:37:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 4/4] smbus: Fix spd_data_generate() for number of banks > 2
In-Reply-To: <20200420132826.8879-5-armbru@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2004201623041.29873@zero.eik.bme.hu>
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-5-armbru@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-537286601-1587393450=:29873"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-537286601-1587393450=:29873
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Apr 2020, Markus Armbruster wrote:
> spd_data_generate() splits @ram_size bytes into @nbanks RAM banks of
> 1 << sz_log2 MiB each, like this:
>
>    size = ram_size >> 20; /* work in terms of megabytes */
>    [...]
>    nbanks = 1;
>    while (sz_log2 > max_log2 && nbanks < 8) {
>        sz_log2--;
>        nbanks++;
>    }
>
> Each iteration halves the size of a bank, and increments the number of
> banks.  Wrong: it should double the number of banks.

Hmm, why? SPD data has: spd[5]: Number of RAM banks on module (1–255) (and 
for DDR2: Ranks-1 (0–7)). So nothing says it has to be power of 2 even if 
it's commonly 2 or 4. Does this break anything that needs this to be power 
of 2? Otherwise I thik this change is wrong.

> The bug goes back all the way to commit b296b664ab "smbus: Add a
> helper to generate SPD EEPROM data".
>
> It can't bite because spd_data_generate()'s current users pass only
> @ram_size that result in *zero* iterations:
>
>    machine     RAM size    #banks  type    bank size
>    fulong2e     256 MiB         1   DDR      256 MiB
>    sam460ex    2048 MiB         1   DDR2    2048 MiB
>                1024 MiB         1   DDR2    1024 MiB
>                 512 MiB         1   DDR2     512 MiB
>                 256 MiB         1   DDR2     256 MiB
>                 128 MiB         1   SDR      128 MiB
>                  64 MiB         1   SDR       64 MiB
>                  32 MiB         1   SDR       32 MiB
>
> Apply the obvious, minimal fix.  I admit I'm tempted to rip out the
> unused (and obviously untested) feature instead, because YAGNI.
>
> Note that this is not the final result, as spd_data_generate() next
> increases #banks from 1 to 2 if possible.  This is done "to avoid a
> bug in MIPS Malta firmware".  We don't even use this function with
> machine type malta.  *Shrug*

The code that is generalised here is originally from MIPS Malta and the 
idea was to change that as well to use this but nobody did that so far.

Regards,
BALATON Zoltan

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> hw/i2c/smbus_eeprom.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 07fbbf87f1..e199fc8678 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -229,7 +229,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
>     nbanks = 1;
>     while (sz_log2 > max_log2 && nbanks < 8) {
>         sz_log2--;
> -        nbanks++;
> +        nbanks *= 2;
>     }
>
>     assert(size == (1ULL << sz_log2) * nbanks);
>
--3866299591-537286601-1587393450=:29873--

