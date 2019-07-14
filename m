Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2567C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A0E2064A
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A0E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmclT-0006tW-33
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 07:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35858)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arndbergmann@gmail.com>) id 1hmclJ-0006VZ-0V
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arndbergmann@gmail.com>) id 1hmclI-00026y-3v
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:33:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arndbergmann@gmail.com>)
 id 1hmclH-00026R-VN
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:33:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id w190so9664544qkc.6
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 04:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Falj83gQzySTF0Zi/S6YcPXhrP6brnEf+pBQBmzGetM=;
 b=qQxP4dIHPHbXNYsBeMbuzqOavh4cx8kLYz3r/f5xc+Tx0dcbNprDUZb3w2YbKe2Jz5
 yioxCwhuPYyt0tbDGO+uPb1mNyuaL/dazgzaGjGTPzDt/C/1GPrRP4a6YZM6xWfACKI6
 NWud/sX/DI9XPZ2qbamd2e2z4dBQLZ6xouaRmrzJOk8ihcHt2/dv9srXFEx/MOsZxz5Y
 XlgTGXRnIyp5GjyrNRvfBRjWies5iuGweN5Dck/MDr2Epc+dEl54IBdobPmUl5tH2aN7
 44H1d09QPhPmFo8XXcM09OG4W9mxfSJxWM2THiRIDXdEf95VW3dAMJml3kSdwEUVxtWs
 k1mQ==
X-Gm-Message-State: APjAAAWk8QnuFMciJW5fNAxTr43ijxsf2P8S+1OAz8sQg+bL5mdU7xuq
 qQJ9hnQZuGiLsN4rnwEF7GoR9X8kfRgGkYhIRSU=
X-Google-Smtp-Source: APXvYqzAOogmi+p2tukyYZ9R6w8jZ+jHnPPKF3nmflmWidzH9WSCF+WnPvWb2PA/3dYEuyo5gb63CDYFEvfrR7KStM0=
X-Received: by 2002:a37:4ac3:: with SMTP id
 x186mr12353488qka.138.1563104026356; 
 Sun, 14 Jul 2019 04:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
 <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
 <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
 <CAK8P3a3fZgcSR7V=NAjDa37-5j8L+n-cF1CVPiWjteV6hfHSLg@mail.gmail.com>
 <db82d6a2-8ca7-5bbb-0cf9-feecc8b2adfb@vivier.eu>
 <CAK8P3a3GwDr1wPU3hfnmN-N4kvBvSqxa2aRVLQABO70fv21YhQ@mail.gmail.com>
 <ac90d2b2-83e8-6ad3-5dca-81e179edec00@linaro.org>
In-Reply-To: <ac90d2b2-83e8-6ad3-5dca-81e179edec00@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 14 Jul 2019 13:33:28 +0200
Message-ID: <CAK8P3a3L9e9X1-rODexx34EEs37zNK2qKXZRfZ+oi7eni_286Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
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
 Laurent Vivier <laurent@vivier.eu>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 14, 2019 at 12:41 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/12/19 3:55 PM, Arnd Bergmann wrote:
> > glibc will have to create a definition that matches the kernel, which uses
> >
> > struct __kernel_timespec {
> >     __s64 tv_sec;
> >     __s64 tv_nsec;
> > };
> >
> > As posix requires tv_nsec to be 'long', you need padding between
> > tv_sec and tv_nsec to have a libc definition matching the kernel's
> > binary layout.
>
> Yes, but that's glibc's lookout.  All qemu cares about emulating is the kernel
> interface.  So I think Laurent is right here, in that two reads handle the
> above structure just fine.

But that only works if the structure defined by qemu matches the kernel's.

The structure that Laurent proposed

struct target_timeval64 {
    abi_llong tv_sec;
    abi_long tv_usec;
};

is not compatible with the kernel or the glibc structure.

      Arnd

