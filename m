Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B24EC742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FBF208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FBF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlw1o-0007AN-37
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arndbergmann@gmail.com>) id 1hlw1d-0006kx-Jz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arndbergmann@gmail.com>) id 1hlw1b-0004HH-NQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:55:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arndbergmann@gmail.com>)
 id 1hlw1b-0004GN-Jj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:55:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so8111008qtn.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OIav03XMUFr78hQxMDY4yPvnZ+u+z8/xEccH0zaZ458=;
 b=IEf/v4z9zLJ3LWPnbpxiwgE3HO+s4Ca7PmC/CwH7xOq4sZkWz8eNVfel5TGCkIarZJ
 r4bWOYG2ebdl9gOavEBBNyhH/Sh4Zusm40Cfi0y9fHDRaBbY4v88PNtH8LEG+vZrlYyJ
 UkPhelHDrGWc7g5BoxBdwj3ENiyAwVdx5zU6scpeNLJhhSLJgvQ9iofuMV32Gh5ehFKJ
 407MDnnng2kxm/9Ks7Ijg9Q1pCT5fbHjMGhskSFnCtXmXEqqj9u/sOtUkAudqntLJUsk
 Jfppti9KY8kD7OLJRfffoHEESem+/yXJs3HAw6Zgrrg3YmdxHgxI8TxPDueS5YKajNRT
 WC2Q==
X-Gm-Message-State: APjAAAVldTX7R0GkMoJvJ9PSStY1j3S/ap3UC3fZbjWQ9ncwgw6e7ZpC
 8+sMyBZ6OtryuzvBAAFkb3Y9TbWYUsQMrAG2Cgo=
X-Google-Smtp-Source: APXvYqw8IzPKP31Ae5zRGuaveXLUbAyO+8tF34Tu/0NE4QMuES0IU+SuQcYjYaDtO5IWFz7TFj9oUXryGTP1CXWH5x8=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr6448691qtd.18.1562939745707; 
 Fri, 12 Jul 2019 06:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
 <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
 <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
 <CAK8P3a3fZgcSR7V=NAjDa37-5j8L+n-cF1CVPiWjteV6hfHSLg@mail.gmail.com>
 <db82d6a2-8ca7-5bbb-0cf9-feecc8b2adfb@vivier.eu>
In-Reply-To: <db82d6a2-8ca7-5bbb-0cf9-feecc8b2adfb@vivier.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jul 2019 15:55:29 +0200
Message-ID: <CAK8P3a3GwDr1wPU3hfnmN-N4kvBvSqxa2aRVLQABO70fv21YhQ@mail.gmail.com>
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

On Fri, Jul 12, 2019 at 3:50 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 12/07/2019 =C3=A0 15:36, Arnd Bergmann a =C3=A9crit :
> >> We don't do memcopy() but we set each field one by one, so the padding=
 doesn't
> >> seem needed if we define correctly the user structure:
> >>
> >> struct target_timeval64 {
> >>     abi_llong tv_sec;
> >>     abi_long tv_usec;
> >> };
> >>
> >> and do something like:
> >>
> >>     struct target_timeval64 *target_tv;
> >>     struct timeval *host_tv;
> >> ...
> >>     __put_user(host_tv->tv_sec, &target_tv->tv_sec);
> >>     __put_user(host_tv->tv_usec, &target_tv->tv_usec);
> >> ...
> >
> > That still seems wrong. The user application has a definition
> > of 'timeval' that contains the padding, so your definition has
> > to match that.
>
> I don't find this definition with the padding. Where it is defined?
>
> We are at the syscall level, so structures are the ones provided by the
> target to the syscall, and they can be converted by the libc if the one
> from the user space differs.

glibc will have to create a definition that matches the kernel, which uses

struct __kernel_timespec {
    __s64 tv_sec;
    __s64 tv_nsec;
};

As posix requires tv_nsec to be 'long', you need padding between
tv_sec and tv_nsec to have a libc definition matching the kernel's
binary layout.

      Arnd

