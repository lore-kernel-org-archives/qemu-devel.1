Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B88C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F097D24680
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBer/IjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F097D24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isu0L-0006tR-39
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1istfq-00078o-U4
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1istfo-0008EF-B9
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:22:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41736
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1istfo-0008D9-24
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579375339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/v41Yg0JQ8YAgMKHLKYe4V7Vex7BfK0wViwlBY14Wl0=;
 b=VBer/IjIObphOEX/GC4/NNZ3IUTKholuWPFht50iTnYVzCbKXpH2M2oaA/74+sFfg6wQ/m
 kGwf7ebtzTECqiD04ibGw8EWwlT+yrN+NkVTRBn13ENUA7xra+/2MLehVOOwKuVFR9sMLR
 EE6krB9YeT0qsyG6OtQIqmtOonHg6Lg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-AnlkZjapOMSdqqWH3Oehzg-1; Sat, 18 Jan 2020 14:22:13 -0500
Received: by mail-wr1-f72.google.com with SMTP id f15so12137644wrr.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 11:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=riPNKRlapd+vZimFcky0ZWhA6GmtWfNQjgElI/h7F/g=;
 b=f+9uybBdNgrrlnDfObKh9qwF1hDsW1T9h3FkQ3iigNU6c+TJnCH45Za7WAkhqkPOHb
 qyBzS7BZmuJerK+Yk2RYOnO4EqoQyxa0L+aQV1dEsB14qil/syIRYMU3HmMv1KHjGaoE
 IZAtkCvWOui3UxsXf3KzeVqAqRXIgdCONHLy21EQUCWmWN9bs9tX0fLmdHL/kBiy4cdf
 /pjJiMOSedCN4BvVsb6KOqOFpbRUgH7H/kVqHOKVR3Sy88ls1NgoR6e6zAUs6f4uvjFt
 mHaZjukGgwKY/O/54KBvfunvkSYVExUFTTICa0SCSu8L6OQu0bGreqVi20kBwQNSgu9Z
 sCVQ==
X-Gm-Message-State: APjAAAVgj03ZPRbmsB7R9z69PO+KWnvgjg1+G/q5LHT/zyAuF8mXmra2
 q2udTxyYc/ofT4dfCBXypHK2ydO5oEZRxSYUVAKEHA1DsT+qy3bicRWtGgNX4zpmBDKLNy56NQX
 VchClrtjhjE/5Yl8=
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr10822580wml.43.1579375332638; 
 Sat, 18 Jan 2020 11:22:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6XT6nktDxApGkvNErP1mKR3t3t0uQM812lLNg8Ezxoh613bj9wWk3McklKc2osANJN/OegA==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr10822567wml.43.1579375332420; 
 Sat, 18 Jan 2020 11:22:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id x18sm40268914wrr.75.2020.01.18.11.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 11:22:11 -0800 (PST)
Subject: Re: [PATCH v3 0/2] cpu: Clarify overloading of reset QOM methods
To: Greg Kurz <groug@kaod.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <157650846660.354886.16810288202617432561.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3407ac9e-858f-4e61-2108-75fab06e0f75@redhat.com>
Date: Sat, 18 Jan 2020 20:22:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157650846660.354886.16810288202617432561.stgit@bahia.lan>
Content-Language: en-US
X-MC-Unique: AnlkZjapOMSdqqWH3Oehzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/12/19 16:01, Greg Kurz wrote:
> Each cpu subclass overloads the reset method of its parent class with
> its own. But since it needs to call the parent method as well, it keeps
> a parent_reset pointer to do so. This causes the same not very explicit
> boiler plate to be duplicated all around the place:
>=20
>     pcc->parent_reset =3D cc->reset;
>     cc->reset =3D ppc_cpu_reset;
>=20
> A similar concern was addressed some time back by Philippe Mathieu-Daud=
=C3=A9
> in qdev, with the addition of device_class_set_parent_reset() and friends=
:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D46795cf2e2f6
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dbf853881690d
>=20
> Follow the same approach with cpus.
>=20
> Changes in v3:
> - drop 'cpu: Introduce CPUReset callback typedef' patch which isn't neede=
d
>   and makes the code less clear. This changes the declaration of the help=
er
>   in 'cpu: Introduce cpu_class_set_parent_reset()', but it is minor so I
>   keep the Reviewed-by and Acked-by tags.
>=20
> Changes in v2:
> - added Reviewed-by and Acked-by tags
> - rebased on top of https://github.com/cohuck/qemu.git s390-next
>   SHA1 dd6252f035a2
>=20
> --
> Greg
>=20
> ---
>=20
> Greg Kurz (2):
>       cpu: Introduce cpu_class_set_parent_reset()
>       cpu: Use cpu_class_set_parent_reset()
>=20
>=20
>  hw/core/cpu.c                   |    8 ++++++++
>  include/hw/core/cpu.h           |    4 ++++
>  target/arm/cpu.c                |    3 +--
>  target/cris/cpu.c               |    3 +--
>  target/i386/cpu.c               |    3 +--
>  target/lm32/cpu.c               |    3 +--
>  target/m68k/cpu.c               |    3 +--
>  target/microblaze/cpu.c         |    3 +--
>  target/mips/cpu.c               |    3 +--
>  target/moxie/cpu.c              |    3 +--
>  target/nios2/cpu.c              |    3 +--
>  target/openrisc/cpu.c           |    3 +--
>  target/ppc/translate_init.inc.c |    3 +--
>  target/riscv/cpu.c              |    3 +--
>  target/s390x/cpu.c              |    3 +--
>  target/sh4/cpu.c                |    3 +--
>  target/sparc/cpu.c              |    3 +--
>  target/tilegx/cpu.c             |    3 +--
>  target/tricore/cpu.c            |    3 +--
>  target/xtensa/cpu.c             |    3 +--
>  20 files changed, 30 insertions(+), 36 deletions(-)
>=20

Queued, thanks.

Paolo


