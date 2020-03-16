Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C6D20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C33SZ7JZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C6D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlOv-0001Vb-Gg
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDl9N-0004fV-67
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDl9L-0008LW-TC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:31:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDl9L-0008ET-LH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584347458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Is5aEc3iBUZMFBGz3Kx0fFO8HEbNJjBR9P8gQXDScSM=;
 b=C33SZ7JZheyQ6GDuFd8DifkJx9jvjsVVoAtxWTO0ywbvh+JQbHwFj1udliVzCDWapwIJJw
 TaaXBxMhels9Z9PuhJ7K/vXFwAu25Gs4Iv0CUSNdwHIFedyFP5wDqPpbUHHc2CvgGppt2S
 NQ1LWbc5EDs3m16sxdIHtebQ/Nrn0Ow=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-G6m6aVh8NqyNdhWL9IUrww-1; Mon, 16 Mar 2020 04:30:56 -0400
X-MC-Unique: G6m6aVh8NqyNdhWL9IUrww-1
Received: by mail-wm1-f70.google.com with SMTP id p18so1450766wmk.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h1AitmqAjojbZNzm/eWPNIhjh5Q17jT6zDR+1HunmIk=;
 b=gRkAXdpaO85fn1hGVCLSUjnGjkNuZmiBXSTHgAo3oO8K5hVr1Lh9qPr7cq1nJ7Lm1s
 zQnLXF2Ri9f/1BE0aQ3Pa8ro1SLKAff6UGOdjSXWSVFWP3I8PlHt0gG8Qa3ehv9fXWSf
 ta/Ik/EM0QXm9BpDrY9kAEOVBoJ1MAQBq/tqP6G3Km054Jt1GgK3FECYLgp6W43M/Otr
 KIusRw0F4Di20hseUXZIK7xuo5GRTFGFKOyJkfkz+1rzMGfHwTLcTU2CRPA/3GDEk3f/
 XGeB/eTcLHU2AomYiGa7YObSz4rM+424BrfCi48EUmgiUB2RKo80O0RvrPsqbQt2SyPb
 KzYg==
X-Gm-Message-State: ANhLgQ0zDC0FrCVNVPPpQBQD1m4IT2l9NL0nKR+Ad5+9a/nttJpvfXRz
 0wOBBT84gf5bgR70g3JaE5+YOf9wmgcVze2N7mrCWnEu6bV8Iow2Rf+kT8/iBIOkFswF4rH/nfv
 Ax75BtPzKcVBLk7w=
X-Received: by 2002:a1c:196:: with SMTP id 144mr27196857wmb.100.1584347455465; 
 Mon, 16 Mar 2020 01:30:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtrpR4TnI59CWfDoU1kc7Bfm2MNexQSE9z0ov8iLheUawhLCJruzwl/4s5bT2PcVgRryUh/xA==
X-Received: by 2002:a1c:196:: with SMTP id 144mr27196815wmb.100.1584347455131; 
 Mon, 16 Mar 2020 01:30:55 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id a1sm52170954wru.75.2020.03.16.01.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:30:54 -0700 (PDT)
Subject: Re: [PATCH 6/8] hw/ide: Do ide_drive_get() within
 pci_ide_create_devs()
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <49bf646a9419c3b20125187a26f8a4fd5f35f399.1584134074.git.balaton@eik.bme.hu>
 <alpine.BSF.2.22.395.2003132307280.85181@zero.eik.bme.hu>
 <cb660aa6-6bb6-b75e-ebe3-8fc0e59fb1da@redhat.com>
 <87d09c3jjj.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f3aa3c0d-0786-18aa-0c75-e195910b7a77@redhat.com>
Date: Mon, 16 Mar 2020 09:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87d09c3jjj.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 7:23 AM, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 13/03/20 23:16, BALATON Zoltan wrote:
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 pci_dev =3D pci_create_simple(pci_bus, -1, "cmd646=
-ide");
>>>> +=C2=A0=C2=A0=C2=A0 pci_ide_create_devs(pci_dev);
>>>
>>> Additionally, I think it may also make sense to move pci_ide_create_dev=
s
>>> call into the realize methods of these IDE controllers so boards do not
>>> need to do it explicitely. These calls always follow the creation of th=
e
>>> device immediately so could just be done internally in IDE device and
>>> simplify it further. I can attempt to prepare additional patches for
>>> that but first I'd like to hear if anyone has anything against that to
>>> avoid doing useless work.
>>
>> No, it's better to do it separately.  I think that otherwise you could
>> add another IDE controller with -device, and both controllers would try
>> to add the drives.
>=20
> Correct.
>=20
> Creating device frontends for -drive if=3Dide is the board's job.  Boards
> may delegate to suitable helpers.  I'd very much prefer these helpers
> not to live with device model code.  Board and device model code should
> be cleanly separated to to reduce the temptation to muddle their
> responsibilities.  It's separation of concerns.
>=20
> I actually wish we had separate sub-trees for boards and devices instead
> of keeping both in hw/.

Never too late!

To be clear, you suggest:

- one dir with machines, boards, system-on-module
- one dir with devices, cpu, system-on-chips

Correct?

>=20
>> Basically, separating the call means that only automatically added
>> controllers obey "if=3Dide".
>=20


