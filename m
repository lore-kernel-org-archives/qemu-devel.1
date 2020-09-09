Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA72C21532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="GDvUNAtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA72C21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0OW-0007LD-Qv
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG0NT-0006Uv-OL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:43:11 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:41544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG0NR-00076S-Ct
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:43:11 -0400
Received: by mail-ed1-x52c.google.com with SMTP id ay8so2670572edb.8
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=UAaaLVt+KcEADw0jrvR2PI7v/QcKT+wCrloSNgSRlyo=;
 b=GDvUNAtO9FT2UTksn+GI3d08Z2M7kZkMS9lLsSxHMUfpaPshfj3lWA6sfglPXO/Wc5
 mgkKSs5149aomGb4V4BLAsYow01vt7pVPS0Zbc14jKKq22HPcsvqGGc78U/4zZqDhxDd
 ebodJHR2iRLeSgGLcZKqaJuDmageQD8psvViK06td5AuieKZITeCJ0jntHjuF6iMzkd8
 E7H62+0+m17SzYgX700LuywyrAWkpE1ty3sa46iHUMfuOluwa1BZQAI4BsukV+yBTiY6
 jqeY5iQF7wl5L7ON2a6Y7TG+uykF8wIWPIT93vI0ks19Er5Bdee2GECkeNNvwkc514U1
 HW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=UAaaLVt+KcEADw0jrvR2PI7v/QcKT+wCrloSNgSRlyo=;
 b=UdldunNog1eItsSOkKko+EeRjVRD0IGg0gOoBzXepPjChOjqrg2D2lZ/p7BpWFzgtX
 Io2Gofot/Xegx1kM7B8m2NB9/sZvN5kgcx0+2a+Vwnq59AqSJ1tMbGJUEC4oWxrRPBGy
 +83lzeBTz2yUSdzsR2iISSxq5HkcWjideruayDD+tX/IhL8VSequYm1cXKuA7wGQFyiC
 bKdoKerj1eb+HBN+22M3n4vqinkg4dCri99CuiRiuRczmNaf27Ab02N2XXMk9WMoj3OV
 XMnjYqn5BcVzal+a3azcY5UH0+CBriByDzXBUBPf04sYYCvWWbckCFwDRcDStLXM7s1c
 dd+Q==
X-Gm-Message-State: AOAM531ULjUGqX7CKKMP8tic4ZquzbvoER+I7HtnhS+STQFadO4Ib27m
 EQ6oYnx9XqctSCztHY/Nfnkmkw==
X-Google-Smtp-Source: ABdhPJyiHpKpMLjuhsUohel9puAvk8G9aELVzsm0pnzFezsSNSZoyEkKaAQdwLrKHs7SVX40VkdaSA==
X-Received: by 2002:a05:6402:292:: with SMTP id
 l18mr4300535edv.6.1599658987281; 
 Wed, 09 Sep 2020 06:43:07 -0700 (PDT)
Received: from wks.local ([86.120.181.246])
 by smtp.gmail.com with ESMTPSA id ce14sm2505225edb.25.2020.09.09.06.43.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2020 06:43:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA8Wgbqm15DB1YLXBzQJwNeZjKGcdLFHe8G4FS6YT5Tcmw@mail.gmail.com>
Date: Wed, 9 Sep 2020 16:43:05 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <D193145C-7ABF-4BEB-AF88-BA9E1C24C602@livius.net>
References: <2764135.D4k31Gy3CM@silver>
 <CAFEAcA8Wgbqm15DB1YLXBzQJwNeZjKGcdLFHe8G4FS6YT5Tcmw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::52c;
 envelope-from=ilg@livius.net; helo=mail-ed1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 9 Sep 2020, at 16:30, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> My experience with homebrew has been pretty good overall.

Homebrew is fine for use cases that don't mind it is a rolling =
distribution. :-(

For complex builds it is safer to lock the environment to certain known =
to work versions, and homebrew cannot do this. You can disable the =
auto-update feature, and keep it locked to a set of versions, but =
usually only within a macOS version. After you update the system, =
usually you have to update homebrew.

For my production xPack builds, I simply could not use homebrew, I had =
to recreate a build environment in a separate folder, with the desired =
versions of the tools.


Regards,

Liviu




