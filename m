Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0CFC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205B82072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWwsEmZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205B82072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLkI-0003kC-0l
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGLjT-00031o-93
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGLjS-0001Gr-79
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:59:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGLjS-0001GK-2z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584964741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Jtr+SrTZ4MtneIqpIbzEfHkTPd/POKT1GAxTxyrcs4=;
 b=VWwsEmZOH8WDH+K1L7cJJioYhVBAzqmJ3aEif6iChS30Hgy8NfWTAwaPQ9nhKjqL3VTeXV
 3gN1uVUuQdADliR4fOPXrHQRO1keNXFgzHQYM1wP1Nhjvb8AQkpJjGFCmUF/Xls+2a3a33
 w54K8Q5ThuPsWbecFTLms/wWeRpblgk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-a8JJ8nn4PkmfqHcO-axq4A-1; Mon, 23 Mar 2020 07:59:00 -0400
X-MC-Unique: a8JJ8nn4PkmfqHcO-axq4A-1
Received: by mail-ed1-f70.google.com with SMTP id a32so11341599edf.17
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EOYX4xpk+QY4eUq3Zd49ycxvNXC8dFDfFPBPKwLGh70=;
 b=MyqQ2qYRqjfergD9haqHKBLlhzHZ1rK97cbVhwFjyq/G3pmZlKUo2+ZSv2Ku9RjaBZ
 qXAGhBDP5QdRw5CHhGIYGMcWe6g4pwvGnPz5qbRTKP7buKYnseHaiv7W7aeYqOfn6LxA
 6mRhD/m25LyuWwdNUDi1OCojvTVUBiBD79aC/6XSsFhpzcvhj1EmId6XkuDARumZ38NT
 VcwNS4+fS0DE0g1EwK1qVIcxJAvUSnziiyFP86hzTG6B2mdyn9mli0oqN+9NvIhlrHyZ
 pe0jmLJ/djC7vBc7mvtjbDS/Lyt4pSKo8WJVCMgjGQKpKhn9Mn/Vp7yxQRABPNBHVpCx
 xizg==
X-Gm-Message-State: ANhLgQ20vJVlbqQ/I6+eXwf1H4/SEj3y/h1z+Dn88cNrkVH9Ae8HlIed
 jHJiOy3UFBxmCAfrPXT7fPj5DjBL0VvoLpGPU5dFWVJmEqpnT+bECvHQp15qJ484yo/A/xP9pYK
 MNm409IZ4K5aJbQw=
X-Received: by 2002:a17:906:6c91:: with SMTP id
 s17mr4023313ejr.345.1584964738805; 
 Mon, 23 Mar 2020 04:58:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsDmOY7/9pgovCV83g9SmaZurQ6UG++HLFVAoNPCcdhg6KaAIUeWbCN+CWV4YZ+zhjCtLKxmg==
X-Received: by 2002:a17:906:6c91:: with SMTP id
 s17mr4023298ejr.345.1584964738547; 
 Mon, 23 Mar 2020 04:58:58 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id rl28sm869194ejb.28.2020.03.23.04.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 04:58:57 -0700 (PDT)
Subject: Re: Coverity CID 1421984
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
Date: Mon, 23 Mar 2020 12:58:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-ppc since this is restricted to the aCube Sam460ex board.

On 3/23/20 12:46 PM, Max Reitz wrote:
> Hi,
>=20
> I was triaging new Coverity block layer reports today, and one that
> seemed like a real bug was CID 1421984:
>=20
> It complains about a memleak in sii3112_pci_realize() in
> hw/ide/sii3112.c, specifically about @irq being leaked (it=E2=80=99s allo=
cated
> by qemu_allocate_irqs(), but never put anywhere or freed).
>=20
> I=E2=80=99m not really well-versed in anything under hw/ide, so I was won=
dering
> whether you agree it=E2=80=99s a bug and whether you know the correct way=
 to fix
> it.  (I assume it=E2=80=99s just a g_free(irqs), but maybe there=E2=80=99=
s a more
> specific way that=E2=80=99s applicable here.)

What does other devices is hold a reference in the DeviceState=20
(SiI3112PCIState) to make static analyzers happy.

Ideally we should free such memory in the DeviceUnrealize handler, but=20
we in the reality we only care for hotunpluggable devices.
PCI devices usually are. There is a trick however, you can mark=20
overwrite the DeviceClass::hotpluggable field in sii3112_pci_class_init:

   dc->hotpluggable =3D false;


