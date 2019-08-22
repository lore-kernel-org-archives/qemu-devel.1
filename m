Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24FDC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9643721743
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9643721743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qLv-0003jO-QC
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0qKt-0002D0-12
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0qKr-0000nF-M5
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0qKr-0000mR-Fh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:53:17 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D3A112BB
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:53:16 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a17so3494906wrw.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7OylcwYLww+r4/Ek6o+oEXpH43QgKe6vW2vuiCM0CiI=;
 b=dhdZGt//UIBEG6u4cpqg1SH6s2y399J6HBWOW/YXjjucNKR+oPbHRONL5jRu5tlIbJ
 uqyPqlXrCbZBbpOwpSEurjloz6yURkUWk56BcRx0wajKPmyuUTgkJ54UsiycGil4tEtE
 oG/aEoXOBa9yINI52fgj0zuE1iUxpc6H1SnS4F5whAsD2hi4wY1xDJhhWoR+kBy7dXFj
 jcAZhXZ6UPz+YYiv2M4Hs/yfuoj3dqfFcgnZhP9kQt5ntioAvTGv3nIJa94HlbGRRuyH
 8zsqIAR4of1NukNrZi59aWYbhN+f7kEd+ccMXV8EEiunRpjgHLhdOULaBTRZn6J1aRbC
 HMBg==
X-Gm-Message-State: APjAAAUNqD2X8HPSaNkzi2CfV7jRkmKzrpXSJNFgejbgCl1gTt3jI8oh
 RV+oR9RQMiUveWnA6D7wjGi6NXXpeiFdgY0iMcYEkAxj7f9cZMOa67+zK6MfS5ZZ9PZ+kYgNph2
 vaHLy6fO2uEWkc54=
X-Received: by 2002:a1c:6785:: with SMTP id b127mr15754wmc.66.1566492795111;
 Thu, 22 Aug 2019 09:53:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8gs3/FLa9xW1Qm3jHbJTLuNrGp3xQDvR57d5z+pOjOG/besnj3kBHF2sfOOJ1ZFyY5LPMHA==
X-Received: by 2002:a1c:6785:: with SMTP id b127mr15730wmc.66.1566492794823;
 Thu, 22 Aug 2019 09:53:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id o129sm72228wmb.41.2019.08.22.09.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 09:53:14 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190822162618.27670-1-mreitz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47d2cafd-da56-eb81-b54f-4f666aff016f@redhat.com>
Date: Thu, 22 Aug 2019 18:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822162618.27670-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix
 xfs_write_zeroes()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 18:26, Max Reitz wrote:
> Luk=C3=A0=C5=A1 ran over a nasty regression in our xfs_write_zeroes() f=
unction
> (sorry, my fault) made apparent by a recent patch from Anton that makes
> qcow2 images heavily exercise the offending code path.
>=20
> This series fixes the bug and adds a test to prevent it from
> reoccurring.
>=20
>=20
> Max Reitz (2):
>   block/file-posix: Fix xfs_write_zeroes()
>   iotests: Test reverse sub-cluster qcow2 writes
>=20
>  block/file-posix.c         | 16 ++++++---
>  tests/qemu-iotests/265     | 67 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/265.out |  6 ++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 85 insertions(+), 5 deletions(-)
>  create mode 100755 tests/qemu-iotests/265
>  create mode 100644 tests/qemu-iotests/265.out
>=20

What about just killing libxfs support and only use fallocate?
FALLOC_FL_ZERO_RANGE was added in Linux 3.15 (2014) and the only
platform we probably support with such an old kernel is of course
RHEL/CentOS 7 which has had it backported.

Paolo

