Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA2EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86EF20722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/5pdna/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86EF20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQA2-0007d3-0W
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGQ99-0006zV-Pg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGQ93-0004qn-Sr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:41:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGQ93-0004pI-LA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584981701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy+iNCXUADmBfZUgch6yPqIvM3blAnxbQchNqk7McEE=;
 b=N/5pdna/UYJ1a7VhEoG2zIl5r5dUfbs2FoBz8MVzjnD+6G85eXc0vvsXlFqFWsQFj52sUq
 d8D1IPSmkcE90iy86N4JY4/pnXh55qiY2laynlVKqCJu1fDN0zCRkKAkgTPpXRW3Rov6O8
 wfo3qE1pxnZ2Yi6y9UDyRFDk17zMWMs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-N7dmeu1zPxS5lfQQm8FfLQ-1; Mon, 23 Mar 2020 12:41:37 -0400
X-MC-Unique: N7dmeu1zPxS5lfQQm8FfLQ-1
Received: by mail-wr1-f71.google.com with SMTP id m15so3207327wrb.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jWGe4Ycu+MlbFjTNP3eQMsxASowbHhOqUH2maPS766s=;
 b=BoojEPNBWkYieURKeEUiDKgs/97QXgeY51u9eHHObFwPyHY5X3nMiC0bDLfYyxW79i
 2Zsb5/gtq3sDlTOFqXQJtKK5YfbG4SJcVOrdVHxg+KPuks/NouygTJkjCaFdCowrRSj1
 pb1PCIwF4YRkxJymyUL6rQlaPPP2ZKjN9GPxXnPuec3FUOON7d/m60GHb4CC7Qcztc4I
 MdYGzgyCbRNTCum99XMZ023q7yyJViQTvcYrjLFDV2RS5ukw9z2gWt09gWC9T9qPVVJg
 QwRL9I/gLQE/6WNAULj5XkBwr6PmgTSR4e2umyOtJAmIBAuZ+foyZ9RaaJPrjYNuh4+9
 YtUA==
X-Gm-Message-State: ANhLgQ2vEMXhl0YODV/h65dqCueVv7y2D5ugs6lYWttBJQPo3GRZcWVs
 w2hWKd2DEeDoLeHqSgzN3HumWwzt92NecBo056QRn8xA2X4rJhEMqXv3McwD6dJp4Bd7tnCipk6
 KeUPCR2t5Zy74H+w=
X-Received: by 2002:adf:9346:: with SMTP id 64mr22204379wro.174.1584981696161; 
 Mon, 23 Mar 2020 09:41:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt4bO9u4mUlX5mtM5wXMiUBc6KARY/aLgGQ8+Eqx1qhjNduxVR+NWVpar5xiSOVapIV381aaw==
X-Received: by 2002:adf:9346:: with SMTP id 64mr22204346wro.174.1584981695903; 
 Mon, 23 Mar 2020 09:41:35 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id l64sm145266wmf.30.2020.03.23.09.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 09:41:35 -0700 (PDT)
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
To: Aurelien Jarno <aurelien@aurel32.net>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
 <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
 <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
 <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
 <20200323163545.GA19598@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7ec6be5f-06c8-b179-f059-1b6024d22d7f@redhat.com>
Date: Mon, 23 Mar 2020 17:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323163545.GA19598@aurel32.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>, Yunqiang Su <ysu@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Burton <paul.burton@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 5:35 PM, Aurelien Jarno wrote:
> Hi,
>=20
> Sorry for the delay, I just want to give some more details about the
> Debian.
>=20
> On 2020-03-14 10:09, Philippe Mathieu-Daud=E9 wrote:
>> IIUC today all distributions supporting MIPS ports are building their MI=
PS
>> packages on QEMU instances because it is faster than the native MIPS
>> hardware they have.
>=20
> Actually Debian requires that packages are built on real hardware. We
> have a mix of Loongson 3 and Octeon 3 based build daemons. They all have
> 8GiB of RAM.
>=20
>> Since one (or two?) years, some binaries (Linux kernel? QEMU?) are faili=
ng
>> to link because the amount of guest memory is restricted to 2GB (probabl=
y
>> advance of linker techniques, now linkers use more memory).
>=20
> The problem happens with big packages (e.g. ceph which is a dependency
> of QEMU). The problem is not the physical memory issue, but the virtual
> address space, which is limited to 2GB for 32-bit processes. That's why
> we do not have the issue for the 64-bit ports.
>=20
>> YunQiang, is this why you suggested this change?
>>
>> See:
>> - https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.htm=
l
>> - https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-Ja=
nuary/004844.html
>>
>> I believe most of the QEMU Malta board users don't care it is a Malta bo=
ard,
>> they only care it is a fast emulated MIPS machine.
>> Unfortunately it is the default board.
>>
>> However 32-bit MIPS port is being dropped on Debian:
>> https://lists.debian.org/debian-mips/2019/07/msg00010.html
>=20
> The 32-bit big endian port has been dropped after the Buster (10)
> release and won't be available for the Bullseye release (11). The
> 32-bit little endian port is still available, but it's difficult to keep
> it alive given the 2GB limit.
>=20
>> Maybe we can sync with the Malta users, ask them to switch to the Boston
>> machines to build 64-bit packages, then later reduce the Malta board to =
1GB.
>> (The Boston board is more recent, but was not available at the time user=
s
>> started to use QEMU to build 64-bit packages).
>>
>> Might it be easier starting introducing a malta-5.0 machine restricted t=
o
>> 1GB?
>=20
> In any case having an easy way to simulate machines with more than 2GB
> of RAM in QEMU would be great.

You mean on MIPS64, right?

I see the Boston is limited to 1/2GB, probably due to code started=20
copy/pasted on the Malta. I don't know (without having to refer to=20
datasheets) the maximum amount of DRAM the Boston board can handle, but=20
it should be more than 2GB.

>=20
> Cheers,
> Aurelien
>=20


