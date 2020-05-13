Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E7DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC773205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOuiIYvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC773205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvMC-0000nQ-9Q
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salvatore.bonaccorso@gmail.com>)
 id 1jYvFS-0006Bk-5Q
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salvatore.bonaccorso@gmail.com>)
 id 1jYvFR-0007ss-97
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so494421wrt.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=7ORQbsJQ5tB+ize2DN3Qw0Beopk/JpiGedXtzTLQn+c=;
 b=aOuiIYvETSyzv0eLcXvFWxzlYPbpPvWL5YZtK67Axp6LiyxoIkgdBdQs5PifnMuP9I
 7ArN1VHSv6Hig4M91dgqqZ7ov233ggSxTnTmvkuadlEfif5QM6UGblSTJR4Jjw9k1Uz7
 r5Gi8BxOnywD5fRo/K0T4ROAF8aQmfq7sDOa0XWjJtr3EcNqyeCi65tCZtPTU2iCtuWB
 FywGg0nI6b7FFThELP/JQNiOvrv1KU4m0vsYryGecjG0MN0Aj9oil5gseJE+bjjvc2Xa
 nuJGsS5ddCS4CzIK5sSzEfcPEpN2IRfkyoAEgfrTu9x0eA+J1FA9mog1pB8hpjfZFy8K
 OIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=7ORQbsJQ5tB+ize2DN3Qw0Beopk/JpiGedXtzTLQn+c=;
 b=eMNPDeyhwDuvNRB3CmYZEquVqaJefIAYc/JQigxWE+j49dYdL8PY30ydox3GN1LTUz
 0QOSeudguWXWj/PRzePEJKvjlBVmoQnIETeSKcw+B7+m4KNGQRJMUDm+78/XSwosocjb
 0p7e9OdtI4pOm5tL1A6/SjNI7WvkHmxkWuzmXNazvMGgA/zwc3J0tVCuDI5BUKHz2Y5y
 3PBFp/RHadXCBszb28VD7Fi0BQMjCnuavdeIv+NL+qC8rIgsX4U/MqrJ8DhI33IdPhX5
 djTG038tyQ6ATxDk7QhwHGzDB5b5d7ZhDosyCbXPxhs29NSKXl9K8AibcA6rst8Q85Il
 k96A==
X-Gm-Message-State: AOAM5327FemAPn1ggduxH2XoVnrrHbGu9YKdeXBII9M8/ApIFKlppvTU
 Wv2nMnGM9xLgxgCPVVdDhP0=
X-Google-Smtp-Source: ABdhPJx+fmeOCb28BEqWV2svM81xlrBvbm18UvIYXSdJAqS54LqIIDKOXblsUv+OQjjO72nkRXgIVA==
X-Received: by 2002:adf:f786:: with SMTP id q6mr451963wrp.120.1589391167667;
 Wed, 13 May 2020 10:32:47 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
 by smtp.gmail.com with ESMTPSA id j2sm236991wrp.47.2020.05.13.10.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:46 -0700 (PDT)
Date: Wed, 13 May 2020 19:32:46 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tests/docker: Kludge <linux/swab.h> breakage by pinning
 linux-libc-dev
Message-ID: <20200513173246.GB1720163@eldamar.local>
References: <20200513120147.21443-1-f4bug@amsat.org>
 <87a72beuhn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a72beuhn.fsf@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=salvatore.bonaccorso@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Wed, May 13, 2020 at 04:15:48PM +0100, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
> > Linux kernel commit d5767057c9a [1] aimed to fix an issue with the
> > swab() declaration, but doing so it introduced the BITS_PER_LONG
> > definition, without using the kernel __ prefix, leading to odd
> > failures in userland code using kernel uapi headers, such:
> >
> >       CC      block/file-posix.o
> >     In file included from include/qemu/timer.h:4,
> >                      from include/qemu/timed-average.h:29,
> >                      from include/block/accounting.h:28,
> >                      from include/block/block_int.h:27,
> >                      from block/file-posix.c:30:
> >     /usr/include/linux/swab.h: In function `__swab':
> >     include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
> >        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
> >           |                                  ^~~~~~
> >     include/qemu/bitops.h:20:41: error: missing binary operator before token "("
> >        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
> >           |                                         ^
> >     cc1: all warnings being treated as errors
> >     make: *** [rules.mak:69: block/file-posix.o] Error 1
> >
> > The issue has been fixed in Linux kernel commit 467d12f5c78 [2].
> > Some distributions already backported the first commit, but still
> > lack the second one.
> >
> > This is the case for Debian Buster.
> > The linux-libc-dev package contains the Linux kernel headers.
> > Kernel commit d5767057c9a has been backported in package
> > commit 1fb0eb7956 "Update to 4.19.116" [3], see debian/changelog:
> >
> >   +linux (4.19.116-1) UNRELEASED; urgency=medium
> >   ...
> >   +    - uapi: rename ext2_swab() to swab() and share globally in swab.h
> >
> > The previous released update before it is debian/4.19.98-1,
> > released as debian/4.19.98-1+deb10u1.
> >
> > We can find this package in the Debian snapshot archives,
> > luckily archived on 2020-04-28 21:20:54 (see [4]).
> >
> > QEMU use Debian based Docker images for most of its cross-builds,
> > which are tested by our Shippable CI jobs. The current broken
> > package makes most of our CI red. We can kludge this by using the
> > latest package released before the breakage. Do so by pinning
> > the package version (apt hold), and using the snapshot archives,
> > similar to commit b4048a7cd1.
> > We'll revert once the fix is backported on Debian.
> 
> May as well mention:
> 
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=960271

FWIW, we applied in the buster packaging branch
https://salsa.debian.org/kernel-team/linux/-/commit/a4fb2a7b7688f3a7cb36e17b9d8c661ac44a41a4

But the point release just happened last weekend, so it might take
some time until the fix will enter either via the 10.5 point release
or sooner by a needed update.

Regards,
Salvatore

