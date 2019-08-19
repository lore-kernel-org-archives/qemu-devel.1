Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368B5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AD722CF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AD722CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzmNM-0001EG-3g
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzmMb-0000VV-89
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzmMa-0004Zf-36
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:26:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzmMZ-0004Yt-ST
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:26:40 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE1FC2F30D8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 18:26:38 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i4so5646564wri.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Es2ujF4TQs/L1dGPbqNiort7s9yCy3mx7V8CuxWsAc=;
 b=RFL59cT+UuOsIfDwsRLoFdwmRvw6Lv44yoBm8P2gn+7RCa7ajERv33n0rVfxJyV7us
 gPYemrWi0bmDOGfu9nvnQXshZRFSjihzRd0v40o7psdEb/8xRKtLM9/E89rAHVRUsz96
 gqP5Z8IFYbuB50x8QW74m/S9Pxc+aLmPUgTVndjJZKhDDWPhfJlRPgF5wLAYTyctXoLC
 kYqZ316GCZ8H982ZWxpK3NmJAiuv/8/eTtJrUxR6K6jWqRXBbt5JcA9lhYOO/LBOmUBb
 zXxLVf31e5AtJF2h67JbNpN3P3aIuOUH1qOsEnfVPE9a2BVnP+D53kOBlpiQZvpxxl/s
 vYng==
X-Gm-Message-State: APjAAAXTxy37HRiG+aNtwxKA1/byl2yIiKO23onscgmD6Gk08s7KwyS0
 Kv1FFFyLrCd+x/Rr2T7FMOh/KMmlv6CqDo+QrBEAZIX5SS1DRX9pUIj+VWkW5D+5mg6y2C/vWvj
 x3pZelJWOC2NSaiE=
X-Received: by 2002:adf:dd88:: with SMTP id x8mr30951662wrl.331.1566239196748; 
 Mon, 19 Aug 2019 11:26:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2EVL34Ciz7ioA+ani3uT0x7z6ZHUoOsQkIK2FHJfgumsldLIKL+Pq9V3Dl32Rw0+pybaCXQ==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr30951570wrl.331.1566239196446; 
 Mon, 19 Aug 2019 11:26:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240?
 ([2001:b07:6468:f312:399c:411e:1ccb:f240])
 by smtp.gmail.com with ESMTPSA id k124sm36671949wmk.47.2019.08.19.11.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 11:26:35 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565940884636.2215@bt.com> <989277a4-7f07-aaaf-f963-ee769e0efd00@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1ac89581-d52a-cdce-3c5a-786d4cb0d9c1@redhat.com>
Date: Mon, 19 Aug 2019 20:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <989277a4-7f07-aaaf-f963-ee769e0efd00@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 25/42] hw/misc: Declare device little or
 big endian
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, sagark@eecs.berkeley.edu, mst@redhat.com,
 green@moxielogic.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 keith.busch@intel.com, jcmvbkbc@gmail.com, frederic.konrad@adacore.com,
 kraxel@redhat.com, claudio.fontana@suse.com, edgar.iglesias@gmail.com,
 mreitz@redhat.com, pburton@wavecomp.com, marex@denx.de, robh@kernel.org,
 hare@suse.com, gxt@mprc.pku.edu.cn, berto@igalia.com, proljc@gmail.com,
 qemu-block@nongnu.org, arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de,
 david@redhat.com, magnus.damm@gmail.com, yuval.shaia@oracle.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, hpoussin@reactos.org,
 joel@jms.id.au, anthony.perard@citrix.com, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, jasowang@redhat.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, jcd@tribudubois.net, sw@weilnetz.de, alistair@alistair23.me,
 chouteau@adacore.com, b.galvani@gmail.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, sstabellini@kernel.org, jan.kiszka@web.de,
 clg@kaod.org, stefanha@redhat.com, imammedo@redhat.com,
 xen-devel@lists.xenproject.org, shorne@gmail.com, andrew.smirnov@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, xiaoguangrong.eric@gmail.com, qemu-riscv@nongnu.org,
 andrew@aj.id.au, lersek@redhat.com, crwulff@gmail.com, laurent@vivier.eu,
 Andrew.Baumann@microsoft.com, sundeep.lkml@gmail.com, i.mitsyanko@gmail.com,
 michael@walle.cc, paul.durrant@citrix.com, qemu-ppc@nongnu.org,
 huth@tuxfamily.org, amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de,
 cohuck@redhat.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/08/19 12:04, Philippe Mathieu-Daud=C3=A9 wrote:
>> diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
>> index 4307f00..3de8cd3 100644
>> --- a/hw/misc/a9scu.c
>> +++ b/hw/misc/a9scu.c
>> @@ -94,7 +94,7 @@ static void a9_scu_write(void *opaque, hwaddr offset=
,
>> =C2=A0static const MemoryRegionOps a9_scu_ops =3D {
>> =C2=A0 =C2=A0 =C2=A0.read =3D a9_scu_read,
>> =C2=A0 =C2=A0 =C2=A0.write =3D a9_scu_write,
>> - =C2=A0 =C2=A0.endianness =3D DEVICE_NATIVE_ENDIAN,
>> + =C2=A0 =C2=A0.endianness =3D DEVICE_LITTLE_ENDIAN,
> Uh, I doubt that.
>=20

... why? :)

Remember that BE32 and BE8 ARM OSes still are "natively" little-endian.

Paolo

