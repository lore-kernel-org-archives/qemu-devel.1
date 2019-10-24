Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B3CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B3820679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B3820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbVP-000795-NC
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNaxS-0007gL-Ul
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNaxR-0006pM-D4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNaxR-0006lv-4d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:07:09 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 616CE5AFF8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:07:07 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id g13so696477wme.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V5M3YfvSzNReEv+iSupyqClTuTbEMUzk08xs7ixzs/c=;
 b=qL1JOEjU+9mXyLZ9UoKPiZYh+BWHno7NT8D2K7B1xlecFmtuwl725k5qXy/KLJXV0e
 Phj6pqYEmQV6FY4Pk4kR3pcjv+EUZWDUOJRwPORvuqMO8ZK4u6MZcHKn5x26br3XwuU/
 qqWEqt8zKC1pWKSwvTO5Lf940yNm+7ccWkx0i7QwxeS5B1Ld97beeS3GSZ4H3drpVGt2
 HDasedrNsFZJdwzhW4agnTEHgJUeR/XJqy1Mqn1N/IL9SUuS/lY+isUuDdYZdlvMTkK1
 QNt8cNsyDBX3yen2k84rRh/nSVID7PuOwaWW2ZsrYkP+XxM3a/Kb0+F5aXHm7YrK9LAC
 KkUw==
X-Gm-Message-State: APjAAAU//3+rTxyxJHJHjF2JXSxBd/TVuFzLgBKq6Mf+tIR7UNjJal6E
 GhKoZMkCtD8/RZ0UOXP3kACJjrScVMXys62DiyeUvagTmFsqdQ88H6eJj3SsrircGmXB2+p3W8H
 wNPIaIxZyI2ZWpUQ=
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr4608813wmg.50.1571915226075; 
 Thu, 24 Oct 2019 04:07:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5KTX9zUcHsSboeB+QX83wO4Qy6ALWUKbQ6OgQV3gcouYlp5HPJIifZGMImYCMgSmxO8M3AA==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr4608784wmg.50.1571915225804; 
 Thu, 24 Oct 2019 04:07:05 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id f17sm13334973wrs.66.2019.10.24.04.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 04:07:04 -0700 (PDT)
Subject: Re: Adding a memory alias breaks v-rings
To: Geoffrey McRae <geoff@hostfission.com>, qemu-devel@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <19efadd24a38e4e877459404ff12ac20@hostfission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <45003cbd-2fdd-248d-85e8-302b4b87957d@redhat.com>
Date: Thu, 24 Oct 2019 13:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <19efadd24a38e4e877459404ff12ac20@hostfission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Hi Geoffrey,

On 10/24/19 10:27 AM, geoff@hostfission.com wrote:
> Hi All,
>=20
> I have been working on adding a feature as a proof of concept to improv=
e=20
> the performance of applications like Looking Glass by avoiding=20
> additional memory copies. My goal is to alias part of the IVSHMEM share=
d=20
> memory over a pointer provided by the guest OS capture API (DXGI Deskto=
p=20
> Duplication or NVIDIA Frame Buffer Capture). I have managed to get this=
=20
> working by adding a few additional configuration registers to the=20
> IVSHMEM device and enhanced the IVSHMEM windows driver with suitable=20
> IOCTLs to set this all up. While this concept is backwards it needs to=20
> work this way as we do not have control over the destination buffer=20
> allocation by the GPU driver.
>=20
> This all works, however, it has exposed a bug (or I am doing things=20
> improperly) with the way that vhost tracks memory. When calling=20
> memory_region_add_subregion_overlap the memory listener in vhost fires=20
> triggering vhost_region_add_section. According to the comments this cod=
e=20
> depends on being called in memory address order, but because I am addin=
g=20
> the alias region late, it's out of order, and also splits the upper=20
> memory region. This has the effect of corrupting/breaking one or more=20
> random vrings, as evidenced by the crash/hang of vhost-net or other=20
> virtio devices.

I'm not sure this is the same issue I had before, but you might
find Frederic and Alexey suggestions from this thread helpful:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg525833.html

Also note vhost_region_add_section() you mentioned has this comment:

     if (need_add) {
         ...
         /* The flatview isn't stable and we don't use it, making it NULL
          * means we can memcmp the list.
          */
         dev->tmp_sections[dev->n_tmp_sections - 1].fv =3D NULL;

Maybe you need this change:

-- >8 --
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -642,6 +642,7 @@ static void vhost_region_add_section(struct=20
vhost_dev *dev,
           */
          dev->tmp_sections[dev->n_tmp_sections - 1].fv =3D NULL;
          memory_region_ref(section->mr);
+        memory_region_update_container_subregions(section->mr);
      }
  }

---

Regards,

Phil.

> The following and errors are also logged regarding=20
> section alignment:
>=20
> qemu-system-x86_64: vhost_region_add_section:Section rounded to=20
> 3c0000000 prior to previous 3fc4f9000
> qemu-system-x86_64: vhost_region_add_section:Section rounded to=20
> 3c0000000 prior to previous 3fc4f9000
>=20
> Here is the flat view after the alias has been added.
>=20
>  =C2=A0 0000000100000000-00000003fc4f8fff (prio 0, ram): mem=20
> @0000000080000000 kvm
>  =C2=A0 00000003fc4f9000-00000003fc4f9fff (prio 1, ram): ivshmem kvm
>  =C2=A0 00000003fc4fa000-000000043fffffff (prio 0, ram): mem=20
> @000000037c4fa000 kvm
>=20
> When the guest doesn't crash out due to the obvious corruption it is=20
> possible to verify that the alias is in the right place and fully=20
> functional. Unfortunately, I simply do not have enough of a grasp on=20
> vhost to understand exactly what is going on and how to correct it.
>=20
> Getting this feature working is highly desirable as it should be=20
> possible to obtain GPU -> GPU memory transfers between guests without=20
> requiring workstation/professional graphics cards.
>=20
> Kind Regards,
> Geoffrey McRae
>=20

