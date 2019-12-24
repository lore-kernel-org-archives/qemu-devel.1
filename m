Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5DBC2D0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 00:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79F5206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 00:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1Yx4HcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79F5206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijXv5-00009r-UG
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 19:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ijXuK-0008AH-Uj
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ijXuI-0004tx-VP
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:18:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ijXuI-0004sI-Jd
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577146717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3GwJCNHVZ1w0gEhR479dfCOA/EqIh+8B68uLB9KfGc=;
 b=C1Yx4HcOXpCFfsC1ghsFYFDvZVnNmz+6G2NJKZQWFFIy/XJHxOaxwC0L6tG94dM9UMqSDc
 fRQKM+dXp7EDjdOJKXhVH3NMH62X/jFNn7xWWUSWk8BaopG+MlNui38znazPO6QsqZNUV1
 BS5PbK6YzxMmnmKyfC7ahpdU92oFLX4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-mpbUu7TxMFqHq7kyGe2xqw-1; Mon, 23 Dec 2019 19:18:36 -0500
Received: by mail-wr1-f72.google.com with SMTP id j13so8734418wrr.20
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 16:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8eig6U3Eu49ay2xWWjuS/UesEpTRyf4eZA0gFcyWB+k=;
 b=S5oWES/We4SujWhCbksDxK95bauupjDcJv46mjOypCC1jWw9rOSt+sAVyQU5FmyHw9
 IHi+x379TiUA2lUDP8uTT2lZ+S5I2c/8e4ZtwWlJNQhWlil77ZyD1j8JNgZ9wi9Avfyb
 9FiWS4iHuVQ4v2pl4KjGkQabUcORP/0Sr8FEMP4MYtCudzPkiGBKAWMjnZ3zPISqkENw
 iS3JQRzFtMuZErARkpPOTMAGj3i3WJQcb9Ys0Im4E/UDcHAwyPTzhHewiw0SNb26S/fg
 HbOlMun2RhD32f0gXeR5OTLol5PHz42X4pVLB0tVNSqnPj3U6+YGBxpe5xIfjDbpikNq
 e5Lg==
X-Gm-Message-State: APjAAAWdjrCsxBHNjhGU2WGhgfW/SHTtSwNL7Z9WBw3erNkSpRmrKib3
 lgIftmXZ19ttIpFBu26KPiJASRHRwFQ6bahRRsg5awDlG79sW4nZnmraBM9UalK6Z4+bkampIoQ
 eeu7f/3TThtALQuM=
X-Received: by 2002:a05:600c:23c9:: with SMTP id
 p9mr1167256wmb.160.1577146715312; 
 Mon, 23 Dec 2019 16:18:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpH7fjsBaFn53opqhCHelq6Mttw6OuvrA8vb246U04Tz+MNhUQN495iM+t6FJ3z1WvTiSXpA==
X-Received: by 2002:a05:600c:23c9:: with SMTP id
 p9mr1167241wmb.160.1577146715127; 
 Mon, 23 Dec 2019 16:18:35 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id h2sm24086738wrt.45.2019.12.23.16.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2019 16:18:34 -0800 (PST)
Subject: Re: [PATCH v5 5/6] hppa: Add emulation of Artist graphics
To: Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-6-svens@stackframe.org>
 <8e0f79d6-46ba-a121-b6cc-8c0a5cc4ea14@amsat.org>
 <20191223175006.GA17323@t470p.stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37033554-7247-8301-a527-c48f6d74b91a@redhat.com>
Date: Tue, 24 Dec 2019 01:18:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191223175006.GA17323@t470p.stackframe.org>
Content-Language: en-US
X-MC-Unique: mpbUu7TxMFqHq7kyGe2xqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/23/19 6:50 PM, Sven Schnelle wrote:
> Hi Philippe,
>=20
> On Sun, Dec 22, 2019 at 01:37:48PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>>>  =20
>>> +    if (vga_interface_type !=3D VGA_NONE) {
>>> +        dev =3D qdev_create(NULL, "artist");
>>> +        qdev_init_nofail(dev);
>>> +        s =3D SYS_BUS_DEVICE(dev);
>>> +        sysbus_mmio_map(s, 0, LASI_GFX_HPA);
>>> +        sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
>>
>> How is this chipset connected on the board?
>> If it is a card you can plug on a bus, you can use a condition.
>> If it is soldered or part of another chipset, then it has to be mapped
>> unconditionally.
>=20
> Depends on the Model. Hp 9000 712 and 715 had it onboard, for the B160L
> we're emulating and others it was a GSC add-on card.

The B160L case is unclear, do you mean this is not the chipset on the=20
machine, but the software is happy if another chipset is available?

Looking at hw/hppa/ I only see one machine:

   static void machine_hppa_machine_init(MachineClass *mc)
   {
       mc->desc =3D "HPPA generic machine";
       ...
   }
   DEFINE_MACHINE("hppa", machine_hppa_machine_init)

Are you saying this generic machine is able to run different physical=20
hw? Why not add them? This shouldn't take long and it would be clearer,=20
what do you think?

Adding different machines here in QEMU mostly mean add a class which=20
declare the different properties used by each machine. Igor Mammedov=20
recently suggested to follow the example of aspeed_machine_types[] in=20
hw/arm/aspeed.c.


