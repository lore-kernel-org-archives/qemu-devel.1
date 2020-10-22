Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFFCC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACBD208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1F6tn88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACBD208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVcMF-0000du-Fk
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kVcLX-0000An-4e
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:17:43 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kVcLV-0002dz-Ep
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:17:42 -0400
Received: by mail-lj1-x243.google.com with SMTP id c21so2325033ljn.13
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aytwR5IL9OS0QKf9b+p2KT2CU6QbBd6febiqArxDsfs=;
 b=o1F6tn88p06VknvNMv7p3t1B7lxIT2SpksabxDLA6YW1NknghJFih4Q/8LRdLGsXvm
 +AAURNpxNyA9F4esCWet0LRP00jLElfOYszZ/BpslWrEEVmDmOLYcHgzXdVYpKo3Ukr7
 sUVVaUuUnwGoScwwr6QzaQU456Mvr743poQ29MzGeo8ydnPATQluWMPUagKC8mF7aXkR
 9ACVkixvjrdrEKQqGZ4CuKzvwy5Zlxw1pcpVIpXazrdM0/VP5hP3rIB1JmPO87m0fK19
 shrqu1JFDDnBINUxOqEIdDSKLHDr7D8li6HdA1wLpVGzwkbxsL9JENLAxI1WZuVc16G8
 HM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aytwR5IL9OS0QKf9b+p2KT2CU6QbBd6febiqArxDsfs=;
 b=obqafbaf7Mh8MiPZvLZsgUcu/aIHvngXsr4aB2zPcguAyZwg5EC18zsMIP0vIWw/Il
 0aWxrQuRaER/qp6xlClR+iuJBI3NXPdqKAi79SBFRgoQg6TjX8un58auYaDU9zOqBdS1
 K5AoAGJElzfYwVkzZf7G8lMd+rlISgCdxuwka5D0GDP92uRMxfHuANBGeMf7OseD0oyt
 x6NUq9Ro/B8OoAQGYCeV4mXruRwzLnp4Orwd1/kMw1d/eGIpOklN1Zy8AkrjRBYrHdCp
 1hlWC/SIIocbsff45fDtBO+2eUx3d/MH9anA7Gkatbud2s4jmLl1gN6CLCVLCM1tykRw
 SShA==
X-Gm-Message-State: AOAM531vXEQI7EaFkX+yuU2GZewUUqTqW3P+xgMeTY2cqLiGEiHlz+yU
 qfJww3Obfl6boC62eb/Yf2W8dGgiMKvBHRJCPJI=
X-Google-Smtp-Source: ABdhPJw0h2w2fU5fufpA8MMTD61ePZqo/Hxao/L0FiX3RbIRviCcHhHIA/vc7KyVeYNssrZwXiP9KmHAaf52SkQ7Kaw=
X-Received: by 2002:a2e:b0c7:: with SMTP id g7mr1123806ljl.433.1603379859164; 
 Thu, 22 Oct 2020 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <ddb5c9c2-c206-28d6-2d9d-7954e7022c23@redhat.com>
In-Reply-To: <ddb5c9c2-c206-28d6-2d9d-7954e7022c23@redhat.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Thu, 22 Oct 2020 11:17:26 -0400
Message-ID: <CAKf6xpvpuG1jVdf3+heXzHFd_kc5kVHYdJgC+8iazFLciqOMZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Xen CpusAccel
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 QEMU <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 1:16 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 13/10/20 16:05, Jason Andryuk wrote:
> > Xen was left behind when CpusAccel became mandatory and fails the assert
> > in qemu_init_vcpu().  It relied on the same dummy cpu threads as qtest.
> > Move the qtest cpu functions to a common location and reuse them for
> > Xen.
> >
> > v2:
> >   New patch "accel: Remove _WIN32 ifdef from qtest-cpus.c"
> >   Use accel/dummy-cpus.c for filename
> >   Put prototype in include/sysemu/cpus.h
> >
> > Jason Andryuk (3):
> >   accel: Remove _WIN32 ifdef from qtest-cpus.c
> >   accel: move qtest CpusAccel functions to a common location
> >   accel: Add xen CpusAccel using dummy-cpus
> >
> >  accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 27 ++++------------------
> >  accel/meson.build                          |  8 +++++++
> >  accel/qtest/meson.build                    |  1 -
> >  accel/qtest/qtest-cpus.h                   | 17 --------------
> >  accel/qtest/qtest.c                        |  5 +++-
> >  accel/xen/xen-all.c                        |  8 +++++++
> >  include/sysemu/cpus.h                      |  3 +++
> >  7 files changed, 27 insertions(+), 42 deletions(-)
> >  rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (71%)
> >  delete mode 100644 accel/qtest/qtest-cpus.h
> >
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thank you, Paolo.  Also Anthony Acked and Claudio Reviewed patch 3.
How can we get this into the tree?

Regards,
Jason

