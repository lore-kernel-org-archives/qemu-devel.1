Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72330C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6122080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV88ZeNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6122080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42945 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydMe-00067L-BV
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iydLT-0004nR-89
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iydLR-0002Hj-VR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:09:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iydLR-0002Gg-Qb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580742541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAHMeQY5869MOBvRSAZCTMuilEc5hkmSKggijx0mJxQ=;
 b=HV88ZeNiyBlbSmqElUWJq6CC0HvhPVke2WnzN82I3IydK5myfp9gJTuSR4E/hRxPgvmG92
 vfZNn+TILAARkkPvQnCxvqDa3BlOFw2TWF1OHrX5TjiUB3VCfqvhbncYIf904nToIo6+Ko
 ALZCx3UDS480WGxYV2OX9mvHuXCUT2k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45--PDIcJJYPca2w0mtCfpDzg-1; Mon, 03 Feb 2020 10:08:56 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so8366391wrp.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 07:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JAHMeQY5869MOBvRSAZCTMuilEc5hkmSKggijx0mJxQ=;
 b=rAjVxEB09G+Ct1Y02HSO8oYjV/en//XCxMim7OClZ/7Oj3xx4aL8v+nfYcfqbcjifN
 okmyU0ZfA92sbzedvqpGkKb6WXPLyI02241TTUVsMsKgkhIB4pRfVs5DSACCZhfH1gPM
 s77cJnzNSvhsOm3hPcx3qv+hKO0Brz7xBsFz5RbaLp77TV1De+gJGnixDA6SEp0q0juh
 TQUL+Xz6JhRwtw1ZIt+g6XZfQdkoUm6SVmmEmqCq22dGmPdo1xJGrfe6ILHYDNLlwIl4
 SzYmpl4L6SFNpMelNP4TKJNUBrAwHOnL0qShzd8kKz260kMrMzlylubhk5TGzADlb1XZ
 hSDA==
X-Gm-Message-State: APjAAAUY8wcZIDRlmVm1yyyDnmoW9zmZC8Czc4J9PduDDlV7LJ2WLDZe
 z1cvNCZ1my4zqTRvzniBKWtNLgxuzPxaBeGqMussvO+ozH+1Qoi8pEgcpniX1/iqslaDUjiUORY
 NxJDWDL8WssdMLoo=
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr31301824wmg.163.1580742535619; 
 Mon, 03 Feb 2020 07:08:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyActWJGDOU7SOwKVmrT9c/0iXbvOxAbblOzwN+f+C0OtoeE7MP9cnbh5gZyB5uW3ttMVPQ3A==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr31301798wmg.163.1580742535330; 
 Mon, 03 Feb 2020 07:08:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id 16sm24116050wmi.0.2020.02.03.07.08.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 07:08:54 -0800 (PST)
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
Date: Mon, 3 Feb 2020 16:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: -PDIcJJYPca2w0mtCfpDzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/20 11:58, Alexey Kardashevskiy wrote:
>>> So really, the question isn't whether we implement things in firmware
>>> or in qemu.  It's whether we implement the firmware functionality as
>>> guest cpu code, which needs to be coded to work with a limited
>>> environment, built with a special toolchain, then emulated with TCG.
>>> Or, do we just implement it in normal C code, with a full C library,
>>> and existing device and backend abstractions inside qemu.
>>
>> ... which is adding almost 2000 lines of new code to the host despite
>> the following limitations:
>>
>>> 4. no networking in OF CI at all;
>>> 5. no vga;
>>> 6. no disk partitions in CI, i.e. no commas to select a partition -
>>> this relies on a bootloader accessing the disk as a whole;
> 
> This is not going to be a lot really, especially supporting partitions -
> the code is practically there already as I needed it to find GRUB, and
> GRUB does the rest asking very little from the firmware to work.

What partition formats would have to be supported?  But honestly I'm
more worried about the networking part.

> btw what is the common way of netbooting in x86? NIC ROM or GRUB (but
> this would be a disk anyway)? Can we consider having a precompiled GRUB
> image somewhere in pc-bios/ to use for netboot? Or Uboot would do (it is
> already in pc-bios/, no?), I suppose?

GRUB netboot support is almost never used.  There are three cases:

- QEMU BIOS: the NIC ROM contain iPXE, which is both the driver code and
the boot loader (which chains into GRUB).

- Bare metal BIOS: same, but the boot loader is minimal so most of the
time iPXE is loaded via TFTP and reuses the NIC ROM's driver code.

- UEFI: the NIC ROM contains driver code only and the firmware does the
rest.

>> In other words you're not dropping SLOF, you're really dropping
>> OpenFirmware completely.
> 
> What is the exact benefit of having OpenFirmware's "interpret"?

None, besides being able to play space invaders written in Forth.  I'm
not against dropping most OpenFirmware capabilities, I'm against adding
a limited (or broken depending on what you're trying to do) version that
runs in the host.

Yes, SLOF is big and slow.  petitboot is not petit at all either, and
has the disadvantage that you have to find a way to run GRUB afterwards.
 But would a similarly minimal OF implementation (no network, almost no
interpret so no Forth, device tree built entirely in the host, etc.) be
just as big and slow?

Paolo


