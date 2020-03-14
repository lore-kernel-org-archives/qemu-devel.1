Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07426C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 10:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51E320769
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGm1YuTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51E320769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD3cz-00032W-0z
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 06:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jD3bt-0002Vu-3k
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jD3bp-0004LQ-Pl
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:01:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43472
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jD3bp-0004Jg-Kc
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584180093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PERHun32JEU+NGosPRuIQF0/1HGDGMEWJSygsbOf4U=;
 b=IGm1YuTnhbr9W7xCk4MV0VZqULp2fjv1FWOv+/B1rSZPYp02Uc5maB8M1mDRDj7ohpNdAj
 cqi9/NT4mGxvan7/TzqZAQNVtvHNlyTmf892kXR2/LzSmjf3vdI8SnlP21JFFkK+/HQyad
 gzWqUUysKVWR5rg2EM/8vLgVSzAG9bI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-a112ZU5dOz6DNYwNmtF2_Q-1; Sat, 14 Mar 2020 06:01:31 -0400
X-MC-Unique: a112ZU5dOz6DNYwNmtF2_Q-1
Received: by mail-wr1-f69.google.com with SMTP id w6so5704206wrm.16
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 03:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SAIV7tVrEjRTB44OapzWulLh37XFoYtDLpzcFFH2WKc=;
 b=jsOWmmqJXmCagPpTIvJIqRVGZnDwS1GM0D/H61gZD18YgkodQsVUqeaoqwUOa6cU4z
 K7TTjhjeJd+Vxvy9IAzyAIfUUrPDlq3soSdx95yopclI6CCkINlRNDEGUwsFNPSNtzwZ
 FRMCtSKD/YQbgHBEDxzEjPBJEPHQD3LT/FiaNy5e328UpXojisajd9pl4WoypetllS0o
 EdkwBdWszimThNqTZqZXQtyl8/QwZ1vuVryQU4LfFwDZXFeT2hP8SKhz396Mjvo2aull
 iMt8aapgxCgPsdoTXq329VVWPqrNtA+K7BMfmIT3H5/IjhHiG/OOfwiTy3gxnSxUAQeH
 1rpw==
X-Gm-Message-State: ANhLgQ2LYhiumbyfFr5PpbPySdt58qbb+FiX/w9wYP1/qeGm4sJcPfzA
 MJp/q+XRTvb2pKFvr2M6BFTuNyHbpK1aKNlUUDotVDDE8rrR1Gl0N0hIViJXKUP2mo/WCsHHrQg
 Amwly1/Jt3aCrasg=
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr24829976wrp.249.1584180090415; 
 Sat, 14 Mar 2020 03:01:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvM7Py+IHClxjm9FaGI7WDEQVGihINR3UCen7u/sA0VRFbpgSGYOcEyBV+f7UZI1CPIOAf8qg==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr24829948wrp.249.1584180090218; 
 Sat, 14 Mar 2020 03:01:30 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.174.5])
 by smtp.gmail.com with ESMTPSA id b5sm42070941wrj.1.2020.03.14.03.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 03:01:29 -0700 (PDT)
Subject: Re: [PATCH 6/8] hw/ide: Do ide_drive_get() within
 pci_ide_create_devs()
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <49bf646a9419c3b20125187a26f8a4fd5f35f399.1584134074.git.balaton@eik.bme.hu>
 <alpine.BSF.2.22.395.2003132307280.85181@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb660aa6-6bb6-b75e-ebe3-8fc0e59fb1da@redhat.com>
Date: Sat, 14 Mar 2020 11:01:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003132307280.85181@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/03/20 23:16, BALATON Zoltan wrote:
>>
>> +=A0=A0=A0 pci_dev =3D pci_create_simple(pci_bus, -1, "cmd646-ide");
>> +=A0=A0=A0 pci_ide_create_devs(pci_dev);
>=20
> Additionally, I think it may also make sense to move pci_ide_create_devs
> call into the realize methods of these IDE controllers so boards do not
> need to do it explicitely. These calls always follow the creation of the
> device immediately so could just be done internally in IDE device and
> simplify it further. I can attempt to prepare additional patches for
> that but first I'd like to hear if anyone has anything against that to
> avoid doing useless work.

No, it's better to do it separately.  I think that otherwise you could
add another IDE controller with -device, and both controllers would try
to add the drives.

Basically, separating the call means that only automatically added
controllers obey "if=3Dide".

Paolo


