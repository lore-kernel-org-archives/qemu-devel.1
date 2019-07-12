Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54075C742BB
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2490720645
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2490720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hluxe-0002tf-S2
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 08:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arndbergmann@gmail.com>) id 1hluxT-0002Rg-C6
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arndbergmann@gmail.com>) id 1hluxS-00008h-7G
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:47:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arndbergmann@gmail.com>)
 id 1hluxS-00007s-37
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:47:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so7873847qtn.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 05:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RHH+vLhMrxXHpITb+Ukguz44WEIcYt9eYQfmugzs/1M=;
 b=iuwAHH0epnOUQI6vJQ4A2wcWJsMbKq1TpQGdBaWQ9+SxonTBzjWxHI+z6VWEiaD2+F
 YHLahe4BnCnymg4oQGnQKxn+BWp8air0j5NISMT9M8PQOv6CYFtdcG8wcMwTJVSGWulX
 Y59/O1R9s7BQh54Jfd3u/LXqzMdIhbX2IZ0ncLd7E79xXHXStRPrKHNy8TtaMXu/ddUc
 g83WEImovzEvTtEJiK5iJysGwp8Wz0wBLA3TjU1eQc2O192oSMRX+817SHkEMR2jMdez
 XHChKT3lEN/47PrhLFwY2YFJn9Mp9QhiNpIF/JqGDAm2ak8WNpAcK+P16Abc8Z2Js79B
 WGgA==
X-Gm-Message-State: APjAAAUagX5/LGUhwNdfPEs4efCS9kuw+D2uOjnrSfAHZSH/VoEHUDrv
 XWIvTJQB7zazvUn/OfHRjxc/TLf+25RclyKBqdk=
X-Google-Smtp-Source: APXvYqy5mvVW9hECfhkV4MBshJML8ezkvCjK8BUcG/57UsJcIYn8vw/n6cE/3aPvbZ8B02PM6zijR2wtYbTVHKUyaPE=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr6451656qvf.62.1562935644908; 
 Fri, 12 Jul 2019 05:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
In-Reply-To: <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jul 2019 14:47:08 +0200
Message-ID: <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
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

On Fri, Jul 12, 2019 at 2:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 11/07/2019 =C3=A0 23:05, Arnd Bergmann a =C3=A9crit :
> > On Thu, Jul 11, 2019 at 7:32 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >
> >>
> >> Notes:
> >>     v4: [lv] timeval64 and timespec64 are { long long , long }
> >
> >>
> >> +STRUCT(timeval64, TYPE_LONGLONG, TYPE_LONG)
> >> +
> >> +STRUCT(timespec64, TYPE_LONGLONG, TYPE_LONG)
> >> +
> >
> > This still doesn't look right, see my earlier comment about padding
> > on big-endian architectures.
> >
> > Note that the in-kernel 'timespec64' is different from the uapi
> > '__kernel_timespec' exported by the kernel. I also still think you may
> > need to convert between SIOCGSTAMP_NEW and SIOCGSTAMP_OLD,
> > e.g. when emulating a 32-bit riscv process (which only use
> > SIOCGSTAMP_NEW) on a kernel that only understands
> > SIOCGSTAMP_OLD.
>
> I agree.
> I'm preparing a patch always using SIOCGSTAMP and SIOCGSTAMPNS on the
> host (converting the structure when needed).

That in turn would have the problem of breaking in 2038 when the
timestamp overflows.

> I've added the SH4 variant.

What is special about SH4?

> I've added the sparc64 variant too: does it means sparc64 use the same
> structure internally for the OLD and NEW version?

I had to look it up in the code. Yes, it does, timeval is 64/32/pad32,
timespec is 64/64 in both OLD and NEW for sparc.

> What about sparc 32bit?

sparc32 is like all other 32-bit targets: OLD uses 32/32, and
new uses 64/64.

> For big-endian, I didn't find in the kernel where the difference is
> managed: a byte swapping of the 64bit value is not enough?

No, you don't need to swap. The difference is only in the padding.
Since the kernel uses a 64/64 structure here, and user space
may have use 'long tv_nsec', you need to add the padding on
the correct side, like

struct timeval64 {
   long long tv_sec;
#if 32bit && big-endian
   long :32; /* anonymous padding */
#endif
   suseconds_t tv_usec;
#if (32bit && little-endian) || sparc64
   long :32;
#endif
};

         Arnd

