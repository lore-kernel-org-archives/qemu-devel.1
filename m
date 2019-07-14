Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102D8C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 18:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10C12089C
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 18:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10C12089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmjFh-0007AO-0r
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 14:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arndbergmann@gmail.com>) id 1hmjFW-0006mS-Il
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 14:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arndbergmann@gmail.com>) id 1hmjFV-0002j3-I3
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 14:29:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arndbergmann@gmail.com>)
 id 1hmjFV-0002ii-E4
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 14:29:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so10098657qke.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 11:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AOedLqo6wYBZv9bOnp7p/a680kRz+8tWxYdZL5H6e3w=;
 b=d5KE2VYU1Am1vkQsX3elz/Ik3pAMqlze86UGbbnKja1gS78qwfNTJptAjCRa/2cLK2
 P73ndxkxWANg+DuHqaw6bP87iePWdNxZmh8kgJI3K0xTYapAQozhHvHWI235PJDtJAC5
 KVuy7A6l5Y8ugArIFpOnPWcemyfLrBIXSKTEG0UrijqOrNJUBxYjjRUZ0e3qQejjVitS
 7rN6WJTSqDYLjF9Dq7kk40XioRQ1Wa4/yKVSR8VCDyuZUaj9NScGtf5z05UyfWR2vlxw
 i9CMjvnqjWXZDpP9BfWp5URCbulwV7alVbrYOMKVD2HicOyI4pwdE1kI0lqonZjxPP1y
 f/qQ==
X-Gm-Message-State: APjAAAW7kFhqvfEMVD1oiawk+zrcs/HLwbEptGTJvhywV3pKwRRieT3r
 uFgCdv4Jj2DznIH82yqMjiG+ck43dD5wj49ocXE=
X-Google-Smtp-Source: APXvYqwPQmKe5TsnOXWZ2YzeBVz/kUwx7VrHTgIq106S99lW+p7b9OeF8j1hh7DKQ82jypMRp/ImhsiiCgp+Hr6Lh+w=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr13998224qkb.286.1563128964558; 
 Sun, 14 Jul 2019 11:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190714135423.1274-1-laurent@vivier.eu>
In-Reply-To: <20190714135423.1274-1-laurent@vivier.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 14 Jul 2019 20:29:06 +0200
Message-ID: <CAK8P3a3JHkFjf6_XJVr5WVop-KCv2cm5f=irqAUeySvSCSzDgQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH v5] linux-user: fix to handle variably
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 14, 2019 at 3:54 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The SIOCGSTAMP symbol was previously defined in the
> asm-generic/sockios.h header file. QEMU sees that header
> indirectly via sys/socket.h
>
> In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
> the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
> Instead it provides only SIOCGSTAMP_OLD, which only uses a
> 32-bit time_t on 32-bit architectures.
>
> The linux/sockios.h header then defines SIOCGSTAMP using
> either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
> SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
> on 32-bit architectures
>
> To cope with this we must now convert the old and new type from
> the target to the host one.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Looks good to me now

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

