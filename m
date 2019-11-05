Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F3C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BAC214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="eEo2iZzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BAC214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5jj-00056e-UJ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iS5if-000418-2T
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iS5ic-0007bj-Ur
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:46:28 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iS5ic-0007bU-Jn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:46:26 -0500
Received: by mail-pf1-x442.google.com with SMTP id s5so8506359pfh.9
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id;
 bh=20/y1HUrwfZgRolOUpWZx8/eN/1UEDZzRi0/Qf3bZXw=;
 b=eEo2iZzvGn4tYzHjur+UVSJrmoTnAK9IERUZONqPROeGkUEVKVbdNv7yS/wK9BQLDd
 yQwa8fW/KNg4uO8XD5dNjcPNIEAfhIWHQyUXCJkWFRQLytE4T1sxKZTBP4bBfiMK7/4+
 Mfpo0tIcs4LEzWVoUZ9wbL7ljzcjFgwFB6q+EoREbvJY7SrQYPEKVr2mAWf4JLIgD6Cg
 EN2OCjdTzlJm9byRZilURzdCb8n9zGMyX+pbDqYcKTxz2N2Im8frtcaNeDH6/NURaDkG
 1a7aqN7FJHxDJk3qLoWoHJsx0k3wXvQGgXKgC25ITbz2Qt0oHneNmlkyOz0Gnr0RQ1Bt
 wQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
 bh=20/y1HUrwfZgRolOUpWZx8/eN/1UEDZzRi0/Qf3bZXw=;
 b=KYKq1lauqCCGBqSP5pbVU4LGpGaPXlytK0A1VRED5WsVcEeWINChuNijfyS/ZvZWzZ
 +xz4IXO63qIOhfLVKU9npkPte0e7aPNd3hAozanmOQgXTrTxRFV0bGVrLdT7ndJ1Ycoy
 al0XFqXUm7uDCWbx65BQT6y5/4XVQ2X7kv2Cp14i/scpSLfmSlwhW962i9zajgnSxda/
 v0lJQF/26oqjGphr3ASy6p17XhD+rktc8ChmtTEhcPqCz4LiqVD/BCiODs1F+G52gCyo
 25hsuQsdBafGGQWCFj8YTTM/JtfhH48a4ETluPmTAsba6HLTlQZ3qzHqprlcsPqsiX5y
 QAng==
X-Gm-Message-State: APjAAAXXLrhouI3Ccgt3tZNDQEz1vSp4a8pfpN56WkI9gNbzb8BeYLXU
 5CTyCDNg231nI/ZNrge+pKRRGA==
X-Google-Smtp-Source: APXvYqwZuV7iQBTafFXCLyASYRPdTFc+in0U0FU4xW8UBHmPGP5BIWASAer6H/B/Ip3umOFQ5YfnUw==
X-Received: by 2002:a62:6044:: with SMTP id u65mr40254034pfb.227.1572986783857; 
 Tue, 05 Nov 2019 12:46:23 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f8sm10678623pgd.64.2019.11.05.12.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 12:46:23 -0800 (PST)
Date: Tue, 05 Nov 2019 12:46:23 -0800 (PST)
X-Google-Original-Date: Tue, 05 Nov 2019 12:46:20 PST (-0800)
Subject: Re: [PATCH v1 1/1] opensbi: Upgrade from v0.4 to v0.5
In-Reply-To: <CAKmqyKONh4tZ+DfBk2GVDt+k807ncKyrdL-qb1NnTsbyjztFkQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-cc6999f1-fa87-4884-bf87-fac682d32f45@palmer-si-x1c4>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: philmd@redhat.com, palmer@sifive.com,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 05 Nov 2019 11:23:39 PST (-0800), alistair23@gmail.com wrote:
> On Tue, Oct 29, 2019 at 3:33 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Mon, Oct 28, 2019 at 5:56 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>> >
>> > On Sat, 26 Oct 2019 01:46:45 PDT (-0700), philmd@redhat.com wrote:
>> > > On Sat, Oct 26, 2019 at 10:45 AM Philippe Mathieu-Daudé
>> > > <philmd@redhat.com> wrote:
>> > >>
>> > >> Hi Alistair,
>> > >>
>> > >> On 10/26/19 1:15 AM, Alistair Francis wrote:
>> > >> > This release has:
>> > >> >      Lot of critical fixes
>> > >> >      Hypervisor extension support
>> > >> >      SBI v0.2 base extension support
>> > >> >      Debug prints support
>> > >> >      Handle traps when doing unpriv load/store
>> > >> >      Allow compiling without FP support
>> > >> >      Use git describe to generate boot-time banner
>> > >> >      Andes AE350 platform support
>> > >>
>> > >> Do you mind amending the output of 'git shortlog v0.4..v0.5'?
>> > >
>> > > Err this comment is for Palmer, if Alistair agree (no need to repost).
>> >
>> > Works for me.  I've included the shortlog as part of the patch on my for-master
>> > branch, unless there's any opposition I'll include this in my next PR.
>>
>> Sounds good!
>
> Ping! Just want to make sure this makes it into 4.2.

Thanks, I must have somehow dropped this after fixing up the commit message -- 
I'm up to three active laptops during the transition, so everything's a bit of 
a mess on my end.  The commit (with the updated message) is back:.

>
> Alistair
>
>>
>> Alistair
>>
>> >
>> > >
>> > >> >
>> > >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > >> > ---
>> > >> > You can get the branch from here if the binaries are causing issues:
>> > >> > https://github.com/alistair23/qemu/tree/mainline/alistair/opensbi.next
>> > >>
>> > >> You can use 'git format-patch --no-binary'.
>> > >>
>> > >> >
>> > >> >   pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 36888 -> 40984 bytes
>> > >> >   pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 45064 -> 49160 bytes
>> > >> >   pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 40968 -> 45064 bytes
>> > >> >   roms/opensbi                                 |   2 +-
>> > >> >   4 files changed, 1 insertion(+), 1 deletion(-)
>> > >> [...]
>> > >> > diff --git a/roms/opensbi b/roms/opensbi
>> > >> > index ce228ee091..be92da280d 160000
>> > >> > --- a/roms/opensbi
>> > >> > +++ b/roms/opensbi
>> > >> > @@ -1 +1 @@
>> > >> > -Subproject commit ce228ee0919deb9957192d723eecc8aaae2697c6
>> > >> > +Subproject commit be92da280d87c38a2e0adc5d3f43bab7b5468f09
>> > >> >

