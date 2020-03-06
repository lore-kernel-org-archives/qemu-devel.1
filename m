Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91478C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE8D2070A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK2mNFPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE8D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9FJ-000868-Jb
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jA9Ed-0007ah-3g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jA9Eb-0001eR-S5
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:25:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jA9Eb-0001Zp-NC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583486732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzc9HssRfKHne+dft43u7ezXI/4b2GdpCxZ5YqtvbBg=;
 b=XK2mNFPlCCbTI6g3pmsPeCOj7DHwfuKsqtLlqSvgCfDuhHPUlsNcac5R2PuVv8XFmRPg1K
 IrYayzJdOZcKfYBsLXlgq3Ysk1qPyvV9fuu9U6HKIRkSn/6L3akvLDX8iU7XPP19UbTn3m
 isbzJjhatPwWU+LqcV/IXZQoHtmeXJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17--3FKz5rTOUakXdj19Ji6Iw-1; Fri, 06 Mar 2020 04:25:28 -0500
X-MC-Unique: -3FKz5rTOUakXdj19Ji6Iw-1
Received: by mail-wm1-f69.google.com with SMTP id g26so398206wmk.6
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 01:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=69HyzKQXTq/3adX7H3koH6Lnv+3vUkLmUyAPsnCtjwM=;
 b=TBk1PVAR+is7Ic+JoKK82aJa/xg0jSHdHDVgu6qxEtbmmQGPIZJQ9ejJJJQBbVpEfV
 vuo9sw+wA40P+rmHKDQJ+8Fo2JwjodaiPl/8scDOm7caO6s/dikEBkGNYaqzOR+3Tp+j
 Ivi6tKays2p4pTMJAKhORreKviSmDDUnEY04/3GlPfxPN/W7u17LY1Ty2JTp55THcrkz
 9GIYfUMqkPz3PGeVwdWgY9yk/2F508RfB+fPTdZvCyc/w0yV48+YGD/tO6a/XrkXYd2d
 9/AIw3D56KarIRCgXQ5zaeJJfZGPZ+pyK1RPM65MNYpzOUNGDVnbCSr5h7fvs7loRagS
 bVaA==
X-Gm-Message-State: ANhLgQ0Dnv7lmzPMj/ZNlbq66dPxBl4gVKFmKCYIhCGVNfVMcCQ70WxZ
 stCE+PNnBbBQ4F9YCkC5985Kqola+DASGpCoZbR1eZadNa1YIhdofZ1htOJNXJVIOf5BzKFSLbA
 gIkfOypNPyGbnfyg=
X-Received: by 2002:a7b:c081:: with SMTP id r1mr2855011wmh.12.1583486727379;
 Fri, 06 Mar 2020 01:25:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsOJpYH4iiUcAHj+8L8OWJb8CYoeA6jbDiRGnWJbTGDHyN67ZZnHWjGP89RTJU2L12IwXFDmg==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr2854992wmh.12.1583486727163;
 Fri, 06 Mar 2020 01:25:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e?
 ([2001:b07:6468:f312:b99a:4374:773d:f32e])
 by smtp.gmail.com with ESMTPSA id v7sm41615291wrm.49.2020.03.06.01.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 01:25:26 -0800 (PST)
Subject: Re: [PATCH 0/3] hw/net,virtfs-proxy-helper: Reduce .data footprint
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305010446.17029-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92a0e3c4-2d50-49a6-f794-c5df57e1b3fc@redhat.com>
Date: Fri, 6 Mar 2020 10:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305010446.17029-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/20 02:04, Philippe Mathieu-Daud=C3=A9 wrote:
> More memory footprint reduction, similar to:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00984.html
>=20
> The elf-dissector tool [1] [2] helped to notice the big array.
>=20
> [1] https://phabricator.kde.org/source/elf-dissector/
> [2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-support.=
html
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/net/e1000: Add readops/writeops typedefs
>   hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
>   virtfs-proxy-helper: Make the helper_opts[] array const
>=20
>  fsdev/virtfs-proxy-helper.c | 2 +-
>  hw/net/e1000.c              | 6 ++++--
>  hw/net/e1000e_core.c        | 6 ++++--
>  3 files changed, 9 insertions(+), 5 deletions(-)
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

These can certainly go through qemu-trivial.

Paolo


