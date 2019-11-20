Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F00C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A30A22419
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SZBSjO0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A30A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOee-0005Zb-Gk
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tfiga@chromium.org>) id 1iXOd0-00048H-JA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tfiga@chromium.org>) id 1iXOcy-0006B9-EU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:58:34 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tfiga@chromium.org>) id 1iXOcw-00061q-IR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:58:30 -0500
Received: by mail-ed1-x542.google.com with SMTP id w6so20011174edx.10
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EIAxtINR2+zXYlLUtuUhPt0/bKbdnOmWECKoASACwyc=;
 b=SZBSjO0HZtPg1H6inYc7QepIwQk3r1qfPZlM7zmth9EbaNxtNZix9BUYDJEYPbOEVh
 tTIiPAP2moqK1T7oL/xoozNlIiPmne+JM12oAf/tDk1dtDp4tiCVRPJiWvmFZWMVNmOZ
 qY4gCVNg/YWaHQlTIAW/zPdU8URPIpxZrSjqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EIAxtINR2+zXYlLUtuUhPt0/bKbdnOmWECKoASACwyc=;
 b=HH75ip178c6RJom2F56iZT+mCd3w8q+kKao1u0Q1ACoJplkRnSDfM2bbkWGiBL8SAb
 6VIr3O6Br8Z/dlC8SiK6AViJKEboj+VlHmHiVWVAkRBCn6+RT/+Cu4New7n4Q94V5A5M
 U2Cw6NW/vx0W0lKbJT5uNMA8jNStdQHMmbb0JFqOEhguHNSEiuP3qR4Hd5k7AwtnriP3
 2zz8JzbVC9ctAf7gnDajiDDRoczLfA2Z/KWN5n6THMBTddRMF0w7SuP4wOsx6QvPwWlu
 rvAZSxHQ89sCJTi5BfciotJwNqcIqH3ZrlgMQi0qqg1cma/umtWp8K2N6fT2wz3WHnOp
 9OqQ==
X-Gm-Message-State: APjAAAUrJk8h/Gbx33q7mzetYR/kz1aFnD3313SnRZg0bkzcBhHqyu7Z
 Nligfg78T2NgdRsCORGub1MdJBIIIqZxMA==
X-Google-Smtp-Source: APXvYqzbq9OWa1J016Sm2tZC6f4SXOJbQMd/s0v8ixMmA2Tg1d50W0CW/IRQaHvuaSDRCT6TQBK0yg==
X-Received: by 2002:a17:906:258a:: with SMTP id
 m10mr4992332ejb.304.1574251107834; 
 Wed, 20 Nov 2019 03:58:27 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45])
 by smtp.gmail.com with ESMTPSA id h50sm1430229eda.51.2019.11.20.03.58.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 03:58:25 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id i12so27832906wro.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 03:58:24 -0800 (PST)
X-Received: by 2002:a5d:4946:: with SMTP id r6mr2767405wrs.155.1574251104342; 
 Wed, 20 Nov 2019 03:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org>
 <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
 <CAEkmjvU8or7YT7CCBe7aUx-XQ3yJpUrY4CfBOnqk7pUH9d9RGQ@mail.gmail.com>
In-Reply-To: <CAEkmjvU8or7YT7CCBe7aUx-XQ3yJpUrY4CfBOnqk7pUH9d9RGQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 20:58:11 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ASJ0yEXY-V0j+c8nBQ1Q=k9SUU48AZ_8haLezUb_yN-A@mail.gmail.com>
Message-ID: <CAAFQd5ASJ0yEXY-V0j+c8nBQ1Q=k9SUU48AZ_8haLezUb_yN-A@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Frank Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Frank,

On Fri, Nov 8, 2019 at 12:10 AM Frank Yang <lfy@google.com> wrote:
>
> So I'm not really sure why people are having issues sharing buffers that =
live on the GPU. Doesn't that show up as some integer ID on the host, and s=
ome $GuestFramework (dmabuf, gralloc) ID on the guest, and it all works out=
 due to maintaining the correspondence in your particular stack of virtual =
devices? For example, if you want to do video decode in hardware on an Andr=
oid guest, there should be a gralloc buffer whose handle contains enough in=
formation to reconstruct the GPU buffer ID on the host, because gralloc is =
how processes communicate gpu buffer ids to each other on Android.

I don't think we really have any issues with that. :)

We just need a standard for:
a) assignment of buffer IDs that the guest can refer to,
b) making all virtual devices understand the IDs from a) when such are
passed to them by the guest.

>
> BTW, if we have a new device just for this, this should also be more flex=
ible than being udmabuf on the host. There are other OSes than Linux. Keep =
in mind, also, that across different drivers even on Linux, e.g., NVIDIA pr=
oprietary, dmabuf might not always be available.
>
> As for host CPU memory that is allocated in various ways, I think Android=
 Emulator has built a very flexible/general solution, esp if we need to sha=
re a host CPU buffer allocated via something thats not completely under our=
 control, such as Vulkan. We reserve a PCI BAR for that and map memory dire=
ctly from the host Vk drier into there, via the address space device. It's
>
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-=
master-dev/hw/pci/goldfish_address_space.c
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-=
master-dev/android/android-emu/android/emulation/address_space_device.cpp#2=
05

I recall that we already agreed on exposing host memory to the guests
using PCI BARs. There should be work-in-progress patches for
virtio-gpu to use that instead of shadow buffers and transfers.

>
> Number of copies is also completely under the user's control, unlike ivsh=
mem. It also is not tied to any particular device such as gpu or codec. Sin=
ce the memory is owned by the host and directly mapped to the guest PCI wit=
hout any abstraction, it's contiguous, it doesn't carve out guest RAM, does=
n't waste CMA, etc.

That's one of the reasons we use host-based allocations in VMs running
on Chrome OS. That said, I think everyone here agrees that it's a good
optimization that should be specified and implemented.

P.S. The common mailing list netiquette recommends bottom posting and
plain text emails.

Best regards,
Tomasz

>
> On Thu, Nov 7, 2019 at 4:13 AM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
>>
>> On Wed, Nov 6, 2019 at 1:50 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > > In the graphics buffer sharing use case, how does the other side
>> > > determine how to interpret this data?
>> >
>> > The idea is to have free form properties (name=3Dvalue, with value bei=
ng
>> > a string) for that kind of metadata.
>> >
>> > > Shouldn't there be a VIRTIO
>> > > device spec for the messaging so compatible implementations can be
>> > > written by others?
>> >
>> > Adding a list of common properties to the spec certainly makes sense,
>> > so everybody uses the same names.  Adding struct-ed properties for
>> > common use cases might be useful too.
>>
>> Why not define VIRTIO devices for wayland and friends?
>>
>> This new device exposes buffer sharing plus properties - effectively a
>> new device model nested inside VIRTIO.  The VIRTIO device model has
>> the necessary primitives to solve the buffer sharing problem so I'm
>> struggling to see the purpose of this new device.
>>
>> Custom/niche applications that do not wish to standardize their device
>> type can maintain out-of-tree VIRTIO devices.  Both kernel and
>> userspace drivers can be written for the device and there is already
>> VIRTIO driver code that can be reused.  They have access to the full
>> VIRTIO device model, including feature negotiation and configuration
>> space.
>>
>> Stefan
>>

