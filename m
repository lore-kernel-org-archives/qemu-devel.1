Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C292CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419772070B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419772070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQ1B-0006iJ-DC
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 13:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1iOQ0R-0005vC-SG
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1iOQ0Q-0005nz-29
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1iOQ0P-0005np-Qc
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:37:38 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FB43C049E10
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 17:37:36 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id i12so3043623oto.8
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 10:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rQS1KxY3x9MqDmH1RPE1VcPddsvu5Lyoh5GTCLvpq2o=;
 b=rUdcaL6Sua0m04OLuki/uTbp6dWqPRNqEALKw5m8J43bVjU918K9jAt3MRtFEf1Plq
 jFr63IBl5QkDx3foiYAo3mHpn371exkEQlflXbheSeipdIdCWuZKSnxiAFF4FIAvCYzv
 xqqHAsbpLSgo8feeDlcepDX9+JJDkp8ZjYKlI1ukelZvqPOyeJObDeoQNtEbPSi4IJPu
 6tH9rleaFS3eXUh/38k3dfODePS4oH7NZgl+mnUtuqPmOkuCYWRXpdSSrMMpq7NTfIQ8
 cA7ufj1nFNF1bvy23Sn7mtHgC2HzMpENeVpdLahePqy5qrLtW0RhKigbrDGfRMIrMlWJ
 vFmg==
X-Gm-Message-State: APjAAAUmWjPucJHUS2KUUYp8aW4teG9/6Pvpc2XAYUJCslCCy/hHTkdr
 zHTjTEjlOjSFuj7hYtM2sEXec8vVqJjx8dTCyHwEQCepcBTxs0RqFoU6jYnYei09QBnrR8/6NXU
 t5SsvI4V5Uq63TvvhwfK20bkVqR45fUw=
X-Received: by 2002:a9d:4aa:: with SMTP id 39mr7679002otm.311.1572111455870;
 Sat, 26 Oct 2019 10:37:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6cZ9is+CDit9R9EtDluPu+GFyGLWvS4SMZHjRNoouvI/Up39qxv+PPM7As0jvpo3gWqRjldSNCyqXKxd+D8E=
X-Received: by 2002:a9d:4aa:: with SMTP id 39mr7678986otm.311.1572111455499;
 Sat, 26 Oct 2019 10:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191025095849.25283-1-mreitz@redhat.com>
In-Reply-To: <20191025095849.25283-1-mreitz@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 26 Oct 2019 20:37:19 +0300
Message-ID: <CAMRbyyuMyyMp0HT2Kmdwj4svKLAmk4_Lryagx8XowRJ1T3xjcg@mail.gmail.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 1:11 PM Max Reitz <mreitz@redhat.com> wrote:
>
> Hi,
>
> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel driver, =
as
> I=E2=80=99ve explained here:
>
> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.html
>
> In combination with our commit c8bb23cbdbe32f, this may lead to guest
> data corruption when using qcow2 images on XFS with aio=3Dnative.
>
> We can=E2=80=99t wait until the XFS kernel driver is fixed, we should wor=
k
> around the problem ourselves.
>
> This is an RFC for two reasons:
> (1) I don=E2=80=99t know whether this is the right way to address the iss=
ue,
> (2) Ideally, we should detect whether the XFS kernel driver is fixed and
>     if so stop applying the workaround.
>     I don=E2=80=99t know how we would go about this, so this series doesn=
=E2=80=99t do
>     it.  (Hence it=E2=80=99s an RFC.)
> (3) Perhaps it=E2=80=99s a bit of a layering violation to let the file-po=
six
>     driver access and modify a BdrvTrackedRequest object.
>
> As for how we can address the issue, I see three ways:
> (1) The one presented in this series: On XFS with aio=3Dnative, we extend
>     tracked requests for post-EOF fallocate() calls (i.e., write-zero
>     operations) to reach until infinity (INT64_MAX in practice), mark
>     them serializing and wait for other conflicting requests.
>
>     Advantages:
>     + Limits the impact to very specific cases
>       (And that means it wouldn=E2=80=99t hurt too much to keep this work=
around
>       even when the XFS driver has been fixed)
>     + Works around the bug where it happens, namely in file-posix
>
>     Disadvantages:
>     - A bit complex
>     - A bit of a layering violation (should file-posix have access to
>       tracked requests?)
>
> (2) Always skip qcow2=E2=80=99s handle_alloc_space() on XFS.  The XFS bug=
 only
>     becomes visible due to that function: I don=E2=80=99t think qcow2 wri=
tes
>     zeroes in any other I/O path, and raw images are fixed in size so
>     post-EOF writes won=E2=80=99t happen.
>
>     Advantages:
>     + Maybe simpler, depending on how difficult it is to handle the
>       layering violation
>     + Also fixes the performance problem of handle_alloc_space() being
>       slow on ppc64+XFS.
>
>     Disadvantages:
>     - Huge layering violation because qcow2 would need to know whether
>       the image is stored on XFS or not.
>     - We=E2=80=99d definitely want to skip this workaround when the XFS d=
river
>       has been fixed, so we need some method to find out whether it has
>
> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
>     To my knowledge I=E2=80=99m the only one who has provided any benchma=
rks for
>     this commit, and even then I was a bit skeptical because it performs
>     well in some cases and bad in others.  I concluded that it=E2=80=99s
>     probably worth it because the =E2=80=9Csome cases=E2=80=9D are more l=
ikely to occur.
>
>     Now we have this problem of corruption here (granted due to a bug in
>     the XFS driver), and another report of massively degraded
>     performance on ppc64
>     (https://bugzilla.redhat.com/show_bug.cgi?id=3D1745823 =E2=80=93 sorr=
y, a
>     private BZ; I hate that :-/  The report is about 40 % worse
>     performance for an in-guest fio write benchmark.)
>
>     So I have to ask the question about what the justification for
>     keeping c8bb23cbdbe32f is.  How much does performance increase with
>     it actually?  (On non-(ppc64+XFS) machines, obviously)
>
>     Advantages:
>     + Trivial
>     + No layering violations
>     + We wouldn=E2=80=99t need to keep track of whether the kernel bug ha=
s been
>       fixed or not
>     + Fixes the ppc64+XFS performance problem
>
>     Disadvantages:
>     - Reverts cluster allocation performance to pre-c8bb23cbdbe32f
>       levels, whatever that means

Correctness is more important than performance, so this is my
preference as a user.

Nir

> So this is the main reason this is an RFC: What should we do?  Is (1)
> really the best choice?
>
>
> In any case, I=E2=80=99ve ran the test case I showed in
> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01282.html
> more than ten times with this series applied and the installation
> succeeded every time.  (Without this series, it fails like every other
> time.)
>
>
> Max Reitz (3):
>   block: Make wait/mark serialising requests public
>   block/file-posix: Detect XFS with CONFIG_FALLOCATE
>   block/file-posix: Let post-EOF fallocate serialize
>
>  include/block/block_int.h |  3 +++
>  block/file-posix.c        | 46 +++++++++++++++++++++++++++++++++++++--
>  block/io.c                | 24 ++++++++++----------
>  3 files changed, 59 insertions(+), 14 deletions(-)
>
> --
> 2.21.0
>
>

