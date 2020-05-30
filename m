Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A94C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F42222070E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU3Den7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F42222070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jew0X-00022E-5t
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 03:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jevzz-0001dX-K0
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:33:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jevzx-0000ZE-FS
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590824019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i/4sW/bzmdSyGdap5K1iXSmbXV3LmE8dc1nnwlObaW0=;
 b=VU3Den7ti8sIizjW17oZnAWV6fB1zYNhxBFjTR+FAbDqcqWYd4t8dql/zrlbr8djcqdrR+
 awEif0/3oxtOqjWvfQDH/t14dqlHnz+3WqidrdjpO4LxrbvgliY+oVRqPhOW4WZN/1jJwQ
 MFMoFVUgLrqAgZ4kUYf3J6I1q/OTCEw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-WgWC9I-3Mu27JPz3C4Avuw-1; Sat, 30 May 2020 03:33:35 -0400
X-MC-Unique: WgWC9I-3Mu27JPz3C4Avuw-1
Received: by mail-wr1-f72.google.com with SMTP id n6so1931123wrv.6
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 00:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i/4sW/bzmdSyGdap5K1iXSmbXV3LmE8dc1nnwlObaW0=;
 b=E81SRKqBvYCv3NuhY+eljlMBOtPR2cQYBXpeNYyNhHVpTvKJREZQO5MTwsak822vpF
 D+EWjFHHwo+mE8roGb5S92J09l5vJXIRBxwTH5AA/N1sjPN/6Sxw8A1OBFzCtcQir1BA
 CDmaaDVI0gVQDpg+gselPo4NYkXw3HQko6fuwJeqWnQDi8AGS2Sw48WsLaTSEicTLT49
 2RDC4iYhUPBgU+ebQy9mISYV+n51Tb0U6O2kaMY4KGesJRRRjJT7vfvpJl8AEtFpdSvy
 I+hCkumIwnAL8aCsfCiqjOX16cq/N2HvGl7CmriCldzVlh78y2dlX//iGR/ZpHYkU3h4
 s3NQ==
X-Gm-Message-State: AOAM530ggywpmP/iyMqK9VCZvyLKLXIZqIBV1MyaPXtSULXB5ZeaeXey
 zfjOoGZnPmGTBqFXkNNLXrMeAqNFzBte3Nzoj4YXCbv3CbulVAw+Ct/sxN1Q2C91r39W43wDFWs
 Sbl/3t73tO5pBp9I=
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr12959884wmr.160.1590824013819; 
 Sat, 30 May 2020 00:33:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJqteaMOasU10zrGiJfIdQXvUE9AbiQMaLeU85nPcefy8u9jt/yz3cpRN5fiODtr32E7+aDw==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr12959863wmr.160.1590824013428; 
 Sat, 30 May 2020 00:33:33 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a81sm2407073wmd.25.2020.05.30.00.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2020 00:33:32 -0700 (PDT)
Subject: Re: [Bug 1878255] Re: Assertion failure in bdrv_aio_cancel, through
 ide
To: Bug 1878255 <1878255@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <158930780033.13046.17639068194138488918.malonedeb@wampee.canonical.com>
 <159079315819.13831.18211338576992499588.malone@gac.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <50c992d8-d48b-a247-41e2-15dfde41940a@redhat.com>
Date: Sat, 30 May 2020 09:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159079315819.13831.18211338576992499588.malone@gac.canonical.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 01:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/20 12:59 AM, John Snow wrote:
> outl 0xcf8 0x8000fa24
> outl 0xcfc 0xe106c000 (Writes e106c00 to BAR5 for 0:31:2)

We might eventually display this in the reproducer output.

> 
> outl 0xcf8 0x8000fa04
> outw 0xcfc 0x7 (Enables BM, Memory IO and PIO for 0:31:2)
> 
> outl 0xcf8 0x8000fb20 (Enables 0:31:3, I guess? My PCI knowledge is
> iffy. We set the enable bit and select BAR4, but then we don't actually
> write to 0xcfc again to set anything.)
> 
> 
> write 0x0 0x3 0x2780e7
> - write these three bytes to addr 0 in memory.
> 
> write 0xe106c22c 0xd 0x1130c218021130c218021130c2
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSCTL] @ 0x2c: 0x18c23011
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSERR] @ 0x30: 0xc2301102
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSACT] @ 0x34: 0x30110218
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxCI] @ 0x38: 0x000000c2
> 
> write 0xe106c218 0x15 0x110010110010110010110010110010110010110010
> 
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxCMD] @ 0x18: 0x11100011
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:Reserved] @ 0x1c: 0x00111000
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxTFD] @ 0x20: 0x10001110
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSIG] @ 0x24: 0x11100011
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSSTS] @ 0x28: 0x00111000
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSCTL] @ 0x2c: 0x00000010
> 
> Not all of those register writes are actually important for the bug, so
> I simplified them to the fewest writes and fewest bits.
> 
> outl 0xcf8 0x8000fa24
> outl 0xcfc 0xe106c000
> outl 0xcf8 0x8000fa04
> outw 0xcfc 0x7
> outl 0xcf8 0x8000fb20
> write 0x0 0x3 0x2780e7
> write 0xe106c22c 0x4 0x01000000
> write 0xe106c238 0x2 0x02
> write 0xe106c218 0x4 0x11000000
> write 0xe106c22c 0x1 0x00
> 
> 
> 1. PxSCTL write arms the DET bit. It isn't intended to be left on when PxCMD.ST (Start) is issued. It's not clear what should happen if this DOES occur. (Undefined behavior, at the very least.)
> See AHCI 1.3 section 3.3.1.1 "Offset 2Ch: PxSCTL – Port x Serial ATA Control (SCR2: SControl)"
> 
> This bit is intended to send a reset signal to attached SATA drives.
> QEMU just synchronously resets the drive because we can.
> 
> 
> 2. PxCI is not intended to be written to when PxCMD.ST is unset. The spec suggests that when ST transitions from '1' to '0' that this field is cleared, but it does not suggest what happens when it transitions from '0' to '1'. QEMU will happily set the register.
> 
> 
> 3. PxCMD write: This sets PxCMD.ST and PxCMD.FRE, which engages the AHCI device in earnest.
> 
> At this point, AHCI sees outstanding commands and tries to process them.
> The FIS receive address is never programmed, so it's at zero. We start
> reading a FIS there:
> 
> 15712@1590789960.784835:handle_cmd_fis_dump ahci(0x55b4c56621a0)[2]: FIS:
> 0x00: 27 80 e7 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 0x40: 34 40 70 01 01 14 eb 20 00 00 00 00 01 00 00 00 
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 
> This is translated as:
> 0x27 SATA_FIS_TYPE_REGISTER_H2D
> 0x80 SATA_FIS_REG_H2D_UPDATE_COMMAND_REGISTER
> 0xe7 command = FLUSH CACHE
> 
> This will engage ide_flush_cache() (core.c)
> 
> 
> At this point I get a little confused. I wouldn't think we'd have a BlockBackend here for ide_flush to work on, but it seems to think we do and allows the flush command to proceed. We then immediately try to cancel this flush, but bdrv_aio_cancel can't tolerate an aiocb with a null BDS and panics.
> 
> ...Hm, it should be the case that blk_do_flush detects this as
> ENOMEDIUM, but are we maybe just canceling this request too fast? I
> actually can't trigger this through the console, but I can trigger it by
> redirecting input from a .txt file.
> 
> Yup, OK: if you look in blk_aio_prwv, we schedule a oneshot to invoke
> the callback on a synchronous failure, but we are managing to inject the
> reset command before the oneshot gets a chance to run.

What is not clear to me is, can this be reproduced by a real guest, or
only replaying the fuzzer payload (via the qtest chardev)?

Very nicely detailed analysis btw!

Various parts are worth being copied in the fix commit description.

> 
> I think either blk_aio_cancel or bdrv_aio_cancel needs to check that
> there isn't a dangling BH callback -- it seems wrong to make it as far
> as bdrv_aio_cancel when there's no BDS, but the IDE device no longer has
> any idea why its callback hasn't returned yet, and blk_aio_cancel is the
> only mechanism it has to kick the state machine forward.
> 


