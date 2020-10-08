Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55CC4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 01:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC49320B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 01:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC49320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQKnQ-0003Ru-Lg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 21:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kQKmI-0002yO-Al
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 21:31:30 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:39468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kQKmG-0005ol-Qb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 21:31:30 -0400
Received: by mail-io1-f50.google.com with SMTP id q9so4566905iow.6
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 18:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=coBg1jC0x6z7EUaxgBqzICCl/yeU3OQzxeZ+m50SssM=;
 b=tn/AkI+sgeUv8WmsxdQ812VI8R2FbmwodxcT3p0q1pz2vn/T9BVW++aH6iroDH1vyv
 QpN9ToirOPsrvIrUezgeOjp1XMks3jKuFVEbXPVluzPm4txaicJcETsLimDGJm8PLxU8
 bgpsJJCL39Ae9g2fpwBvfP9J+N2+dDmJ8cnglGwy696sA8wcFH+3DxTxxUorWVNqMOhM
 BC6gDaGUJiU7/ESD9aMEsipla1gOqpumEjdgnfVwOlE6xvi2YbGsSmza0GjFS4Sh13Lx
 bG78jChzeIs3uRr67VK29NDu/B+tvXNm0Z76e9MmWJ+z42xrTZV5BBivh4MPkGrTN5en
 rC+A==
X-Gm-Message-State: AOAM532eTB+F5usw45IFLrPbmQH5n5c79Ort3Lm8dwA6B5WjcqcNEY0s
 lEoXhn2K2heKbg+V99L/8lUzR+cI9M5WneeiAZA=
X-Google-Smtp-Source: ABdhPJySluF6T6v8RMvtx1VMPl4VZq5rL1ymMyOWCoL/S1zzePxMCGHU6Bg7ekIlOOLoSTUsp5/nthCWZx9fol8w/dE=
X-Received: by 2002:a05:6638:14c8:: with SMTP id
 l8mr5102142jak.136.1602120687002; 
 Wed, 07 Oct 2020 18:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201007160038.26953-1-alex.bennee@linaro.org>
 <20201007160038.26953-22-alex.bennee@linaro.org>
In-Reply-To: <20201007160038.26953-22-alex.bennee@linaro.org>
From: Ed Maste <emaste@freebsd.org>
Date: Wed, 7 Oct 2020 21:31:15 -0400
Message-ID: <CAPyFy2AkuD3Wi1-wH7VhCQ8WheeZhbUdqPt=Yyvs1XUkg3HN+g@mail.gmail.com>
Subject: Re: [PATCH v1 21/22] cirrus: use V=1 when running tests on FreeBSD
 and macOS
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.50; envelope-from=carpeddiem@gmail.com;
 helo=mail-io1-f50.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 21:31:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Oct 2020 at 12:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Using "V=3D1" makes it easier to identify hanging tests, especially
> since they are run with -j1.  It is already used on Windows builds,
> do the same for FreeBSD and macOS.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20201007140103.711142-1-pbonzini@redhat.com>
Reviewed-by: Ed Maste <emaste@FreeBSD.org>

