Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A440C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518F32072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd6j57ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518F32072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWth-0004qf-HT
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <afscoelho@gmail.com>) id 1ipWsv-0003a1-5A
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afscoelho@gmail.com>) id 1ipWst-0004ek-Qf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:25:57 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <afscoelho@gmail.com>) id 1ipWst-0004ZK-Cm
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:25:55 -0500
Received: by mail-lf1-x144.google.com with SMTP id b15so5059414lfc.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BLGSEm+xWvjU17lB/BhQQ31NmthzZO83HR7S7pZoBrs=;
 b=kd6j57chTnJ/uAoHZSyLw0S6RrII+jHqqGvMlRn6ucSDO6+WY7rnO/6s6jvqI7qOgu
 woyVoXyyO5qroJIflHanpWCpoyvoBbVWtD8YH6lbY8gH7Olft1C/vrK07OyK03fZip7q
 tvqdWbv6cdUys8vTl0h+eAy4NLbSLVKNIliUcJ3OxhL1g4PwOtsjqx2dD2I0mH4tiLcn
 RI+q/FZWeW9EIkY10a4+ayt+ubKAOUob0lpRHUbMEeRrh2yNR9ftTmswaCebWlq+L7AB
 P7po+MNPuatVx+HEy8tYjiW9iRFQbLebpO0X+ATw5ygh0cE6HCjcCo0eKLWwZLr13IIx
 mz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BLGSEm+xWvjU17lB/BhQQ31NmthzZO83HR7S7pZoBrs=;
 b=jFAD7QLKEii2YUyaR79WZg6HiQ5ZB7eXL5mJoltUPrwdeWx8MrMKfLPMo9YFmcf6EM
 0X+ajNx11JMmNYIiC/h4s7XiainIhBTg1cX+//IrE/LcgT6bNdOEK5KXsV8OV4Qu3l+p
 swjg1BLEzdFnl1TlpuJmliX6hA6SYmvrZRiqvk+iuCaPEFWKn51e9C6i/7/YBKHLa0/0
 G+NZc9ShtoANm9/iRN3V6cbApS2jBj4HbG7KyQutpCWaCLXzqnaXrx01878xpYgAt179
 J0eBpo/7l4ZSJZq7IjK/gDFspOev2f9BLCfOU8TmA527YuAHZpRG3VgGaJK6aAwUi1KR
 e19Q==
X-Gm-Message-State: APjAAAUCZ7K3V/JRzOCBm+F2hZCfAKdYx0j2NKtHof4nL5LRYjLsDdXf
 RFsCvCZDSQjv9qjRy6XiGK1wD5fm1EDF7pHKRBI=
X-Google-Smtp-Source: APXvYqxdKBvJf8d5hc1nXDeowJfIIc4RlDTZh0Qw5hfTXbgQO6Bxb1K1+sZ8lllDSj9Z2UuE42iwRNR10cJdgY6OsHA=
X-Received: by 2002:ac2:48bc:: with SMTP id u28mr6008428lfg.81.1578572753916; 
 Thu, 09 Jan 2020 04:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20200108161618.221116-1-afscoelho@gmail.com>
 <20200109054233-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200109054233-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?QW5kcsOpIFNpbHZh?= <afscoelho@gmail.com>
Date: Thu, 9 Jan 2020 09:25:42 -0300
Message-ID: <CAGTcC7yLjP5h4oWfgvrOYobChW-cw-oL5EBmMCH45O41+yuvyA@mail.gmail.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael!
Thanks for reviewing the patch!

> we always get LE values from memory subsystem,
> not target endian values:

I see. So do you think the patch is correct in eliminating the extra
swap (as virtio_config_readw for example already makes a swap)?

Thanks,
andr=C3=A9

On Thu, Jan 9, 2020 at 7:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 08, 2020 at 01:16:18PM -0300, Andre Silva wrote:
> > Remove the bswap function calls after reading and before writing
> > memory bytes in virtio_pci_config_read and virtio_pci_config_write
> > because they are reverting back an already swapped bytes.
> >
> > Consider the table below in the context of virtio_pci_config_read
> > function.
> >
> > Host   Target  virtio-config-read[wl]
> >                swap?                   virtio-is-big-endian?   extra bs=
wap?   Should be   Final result   Final result ok?
> > ----- ------- ------------------------ ----------------------- --------=
------ ----------- -------------- ------------------
> > LE     BE      s(x)                    true                    s(s(x)) =
       s(x)        x              No
> > LE     LE      x                       false                   -       =
       x           x              Yes
> > BE     LE      s(x)                    false                   -       =
       s(x)        s(x)           Yes
> > BE     BE      x                       true                    s(x)    =
       x           s(x)           No
>
> we always get LE values from memory subsystem,
> not target endian values:
>
> static const MemoryRegionOps virtio_pci_config_ops =3D {
>     .read =3D virtio_pci_config_read,
>     .write =3D virtio_pci_config_write,
>     .impl =3D {
>         .min_access_size =3D 1,
>         .max_access_size =3D 4,
>     },
>     .endianness =3D DEVICE_LITTLE_ENDIAN,
> };
>
>
> This triggers another swap in address_space_ldl_internal
> (memory_ldst.inc.c).
>
>
> > In table above, when target is big endian and VirtIO is pre 1.0,
> > function virtio_is_big_endian would return true and the extra
> > swap would be executed, reverting the previous swap made by
> > virtio_config_read[wl].
> >
> > The 's(x)' means that a swap function was applied at
> > address x. 'LE' is little endian and 'BE' is big endian. The
> > 'Final result' column is the returned value from
> > virtio_pci_config_read, considering a target Virtio pre 1.0.
> > 'x' means that target's value was not swapped in Qemu, 's(x)' means
> > that Qemu will use a swapped value.
> >
> > If we remove the extra swap made in virtio_pci_config_read we will
> > have the correct result in any host/target combination, both for
> > VirtIO pre 1.0 or later versions.
> >
> > The same reasoning applies to virtio_pci_config_write.
> >
> > Signed-off-by: Andre Silva <afscoelho@gmail.com>
> > ---
> >  hw/virtio/virtio-pci.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index c6b47a9c73..4ba9e847f3 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -431,15 +431,9 @@ static uint64_t virtio_pci_config_read(void *opaqu=
e, hwaddr addr,
> >          break;
> >      case 2:
> >          val =3D virtio_config_readw(vdev, addr);
> > -        if (virtio_is_big_endian(vdev)) {
> > -            val =3D bswap16(val);
> > -        }
> >          break;
> >      case 4:
> >          val =3D virtio_config_readl(vdev, addr);
> > -        if (virtio_is_big_endian(vdev)) {
> > -            val =3D bswap32(val);
> > -        }
> >          break;
> >      }
> >      return val;
> > @@ -465,15 +459,9 @@ static void virtio_pci_config_write(void *opaque, =
hwaddr addr,
> >          virtio_config_writeb(vdev, addr, val);
> >          break;
> >      case 2:
> > -        if (virtio_is_big_endian(vdev)) {
> > -            val =3D bswap16(val);
> > -        }
> >          virtio_config_writew(vdev, addr, val);
> >          break;
> >      case 4:
> > -        if (virtio_is_big_endian(vdev)) {
> > -            val =3D bswap32(val);
> > -        }
> >          virtio_config_writel(vdev, addr, val);
> >          break;
> >      }
> > --
> > 2.24.1
>

