Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3D4C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551A7206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551A7206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvjP-0002kT-AM
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arndbergmann@gmail.com>) id 1hlvjC-0002Cf-L7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arndbergmann@gmail.com>) id 1hlvjB-0003Ot-HI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:36:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arndbergmann@gmail.com>)
 id 1hlvjB-0003O0-Ce
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:36:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so8048128qto.10
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S+FsBqoJKxFjGIk4HF7CIctm7nVW+hcRsoh2fkAJb+U=;
 b=PGtjM7dPyegjGDTB9Qecw4eNEUB/1xc0sn5jqNpOu+qz2ZQxBsPNW+7jQANnbxmtif
 J7LUteMf6FfR3yw3FUVdsWRbV4AJtJcLnlGH7vIs1LwZoLuMTYZLiv5aBChH3zGAkae6
 zDvVZvfgyfi5a2k3ZwF4eq/btnM5XzCENP7TV8JQsIipOL9m1J95jJ1p4WKD0E7cWMh4
 SN4zP9wzLl1kX9yEfEiEmuosjYTW0heSEbA2ORNTa1mbukZoKZ9OGdBjusFVYcKmeIEe
 XOe1THqdWw9IojNeRnoQR/TVABmMxYw4FKdtMOWWHCOh5Dbe8tH1JHJHiS8g2b/0BDa2
 GcNw==
X-Gm-Message-State: APjAAAUjoj/o7zT36WPvN5A16kWOUpZh814Di6y5dnSZMOW+3a0n1oce
 CTbHsrJ5X7w1ed82PjQfSRLHtj/uRFWuR6EqBso=
X-Google-Smtp-Source: APXvYqzmHuKCblevmsNRFldNOtEFfL1SLelbnJQ9lxmxG3BH3/YXGKtfSG2lDyQwwHCI1U4FuAlwieQt/33zGX+ZENM=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr6201231qtn.304.1562938604330; 
 Fri, 12 Jul 2019 06:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
 <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
 <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
In-Reply-To: <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jul 2019 15:36:27 +0200
Message-ID: <CAK8P3a3fZgcSR7V=NAjDa37-5j8L+n-cF1CVPiWjteV6hfHSLg@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 3:23 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 12/07/2019 =C3=A0 14:47, Arnd Bergmann a =C3=A9crit :
> > On Fri, Jul 12, 2019 at 2:17 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Le 11/07/2019 =C3=A0 23:05, Arnd Bergmann a =C3=A9crit :
> >>> On Thu, Jul 11, 2019 at 7:32 PM Laurent Vivier <laurent@vivier.eu> wr=
ote:
> >>>
> >>>>
> >>>> Notes:
> >>>>     v4: [lv] timeval64 and timespec64 are { long long , long }
> >>>
> >>>>
> >>>> +STRUCT(timeval64, TYPE_LONGLONG, TYPE_LONG)
> >>>> +
> >>>> +STRUCT(timespec64, TYPE_LONGLONG, TYPE_LONG)
> >>>> +
> >>>
> >>> This still doesn't look right, see my earlier comment about padding
> >>> on big-endian architectures.
> >>>
> >>> Note that the in-kernel 'timespec64' is different from the uapi
> >>> '__kernel_timespec' exported by the kernel. I also still think you ma=
y
> >>> need to convert between SIOCGSTAMP_NEW and SIOCGSTAMP_OLD,
> >>> e.g. when emulating a 32-bit riscv process (which only use
> >>> SIOCGSTAMP_NEW) on a kernel that only understands
> >>> SIOCGSTAMP_OLD.
> >>
> >> I agree.
> >> I'm preparing a patch always using SIOCGSTAMP and SIOCGSTAMPNS on the
> >> host (converting the structure when needed).
> >
> > That in turn would have the problem of breaking in 2038 when the
> > timestamp overflows.
>
> No, because SIOCGSTAMP and SIOCGSTAMPNS are aliased to the _NEW versions
> on system supporting them (yes, we need to rebuild the binary, but we hav=
e 19
> years to do that).
>
> #define SIOCGSTAMP      ((sizeof(struct timeval))  =3D=3D 8 ? \
>                          SIOCGSTAMP_OLD   : SIOCGSTAMP_NEW)
> #define SIOCGSTAMPNS    ((sizeof(struct timespec)) =3D=3D 8 ? \
>                          SIOCGSTAMPNS_OLD : SIOCGSTAMPNS_NEW)

Right, makes sense.

> >
> >> I've added the SH4 variant.> What is special about SH4?
>
> The definition of _OLD is different:
>
> #define SIOCGSTAMP_OLD  _IOR('s', 100, struct timeval) /* Get stamp (time=
val) */
> #define SIOCGSTAMPNS_OLD _IOR('s', 101, struct timespec) /* Get stamp (ti=
mespec) */

Ah, that one.


> > No, you don't need to swap. The difference is only in the padding.
> > Since the kernel uses a 64/64 structure here, and user space
> > may have use 'long tv_nsec', you need to add the padding on
> > the correct side, like
> >
> > struct timeval64 {
> >    long long tv_sec;
> > #if 32bit && big-endian
> >    long :32; /* anonymous padding */
> > #endif
> >    suseconds_t tv_usec;
> > #if (32bit && little-endian) || sparc64
> >    long :32;
> > #endif
> > };
>
> We don't do memcopy() but we set each field one by one, so the padding do=
esn't
> seem needed if we define correctly the user structure:
>
> struct target_timeval64 {
>     abi_llong tv_sec;
>     abi_long tv_usec;
> };
>
> and do something like:
>
>     struct target_timeval64 *target_tv;
>     struct timeval *host_tv;
> ...
>     __put_user(host_tv->tv_sec, &target_tv->tv_sec);
>     __put_user(host_tv->tv_usec, &target_tv->tv_usec);
> ...

That still seems wrong. The user application has a definition
of 'timeval' that contains the padding, so your definition has
to match that.

       Arnd

