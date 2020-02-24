Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D6C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22952072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwgS1QGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22952072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6DA7-0004GH-Uu
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6D9P-0003mX-Q4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6D9O-0006dy-L5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:47:55 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6D9O-0006de-Ec
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:47:54 -0500
Received: by mail-ot1-x344.google.com with SMTP id i6so8539796otr.7
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GjboJdXb5jdDi6o9EnROEYBh6eM6T95EPWUm/aFCl3U=;
 b=JwgS1QGj2wTggan5BVMyPZotIUypaszQ0x0tSLcJn/viR5Tpz3RYX7U+4p+89eUHXc
 rxXkpp52nx0ZD5ubgSklOyzkDNKdm7bahCknc9ZmYkWZPh1Q0kyPr2P2/NE7fC8SDbPh
 pY2/mD5wYNhPKXz8GkHiNUl5eXANg57ARgVX4hQoLooTs3Wlx8f0Af3BkHnYx4KWyQ9N
 aUBuBUeg6xSI+ChtHzcvV00IhvKWE5CXZ22eR5DCFpfcqzOZV9uCkgZ8hG3tolhzHp4p
 T0SNsbY9NVcnle/Zh5NIHNdoVq2js8xOA35nXy/u3TDDmPXtLPh7v+9+St9WoMwiqeE9
 AIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GjboJdXb5jdDi6o9EnROEYBh6eM6T95EPWUm/aFCl3U=;
 b=Fyu20eOl7Bgsbt01OvYtQW3k49uG5WvqGS1PYwu6NRmCowzLmVUT4FqVHSZJLXPF/W
 JSzxvJzLAPBTG2k1G8i8gRiPcTjsxqul2f7z41SkfBNIxwx9TG5ghAzUcoZW41xS6wgo
 JlX2fURexxK4VDSlq5uodEPIFHjvwcK6xAVtnWvE4kQ/sVCufjpkNxHqYLRb27WJ+SiA
 bmt8uUC63v5h77ZHo+u5KSEF9BwXG+uYVKNDMKgw/TkgJAu1cTMvVuLU3kdq0JVvoihm
 VetSz7nJPV8OaeO7jYYZu/HRE0f6tOhKPUghH7g0uex9+L8zKLmriBX61yiQnqi/mmVq
 g0Kg==
X-Gm-Message-State: APjAAAUD450m70XQLsqI52KHPV2CHEPVa2w3l2C/z9lMhqdnm+XLhw0t
 G8KRtIxm1VGhRJajYCChZcohWmF4fBIpgaK+NhGd8w==
X-Google-Smtp-Source: APXvYqw7Mu9b2xI68hCpUBQnIH9UOV5sCGbIi91wMjvj5cVVpRVPDTlaucUWtwWCaG9FyjmBKMdXZO5CcCQl7mhvPI8=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr40206411otd.91.1582548473597; 
 Mon, 24 Feb 2020 04:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20200222085030.1760640-1-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2020 12:47:42 +0000
Message-ID: <CAFEAcA9jUDfm_kPPEtWtdBe+a=j3bysj49WWyzZxwwUSC69YGw@mail.gmail.com>
Subject: Re: [PULL 00/31] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Feb 2020 at 08:50, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 9ac5df20f51fabcba0d902025df4bd7ea987c158:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200221-1' into staging (2020-02-21 16:18:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to e5c59355ae9f724777c61c859292ec9db2c8c2ab:
>
>   fuzz: add documentation to docs/devel/ (2020-02-22 08:26:48 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> This pull request contains a virtio-blk/scsi performance optimization, event
> loop scalability improvements, and a qtest-based device fuzzing framework.  I
> am including the fuzzing patches because I have reviewed them and Thomas Huth
> is currently away on leave.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

