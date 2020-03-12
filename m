Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A5C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64B82067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EK5VSVXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64B82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQmk-0000w7-Uh
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQiF-0000qX-NQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQiE-0005Z1-BL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:29:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQiE-0005YW-4V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:29:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id p125so6064228oif.10
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yci7ESIggvSpzMh2gFyRoUQKy4ZjZUSxsTCXLIHhUcQ=;
 b=EK5VSVXNwl2Bc3ITaplbci5hZ4KA+Ek+z1AlWunzCqXT5Zm6ZPX4QtiT24kOCow6SQ
 qbr5CI33GcjlGFBDT4zubFRS8jd8kj5ys0RB1bjpD9z7T9froMevhN4n0HReJQFMI1RH
 srZSYE9WE3vyRNROwWn/XkVztgKPgBD7DVzaHx/xFMtbGEsCzaUJrK1sU5AEpAliJf7S
 dnlw8B/Wh4n5oLj2lGDW9fboIgGT9zrOuP5E1/Yz/C1n6t8At9HsoM/0CrSbO0zHsb4Z
 k3VdX21R/3aaB6XCuYiQ53ECD+Tb7FmHT6lNN7pu1O0wQU/Fm1Ki/DSoqPxGDh7tb/M2
 GcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yci7ESIggvSpzMh2gFyRoUQKy4ZjZUSxsTCXLIHhUcQ=;
 b=Lt0wvsGKBwv6potVC/8hyUSYfL9jFbFlcDeYMPTCORFeuoM4GzGJJ5jxI00QzUIrTK
 eWX9PJueymVT+5osyJeLouZ7cgBsVZ2Yz3/1W5XP5g31aRfZGM0KUskdi4RR/WzXGFAn
 XZRi/jCPYgfQwLg+NYWlV0laCZGLIHhZz6lJ+NXvHJk9bw0L5U9HmoFDQmweLItzTSxD
 1AFoTvqvL5dHa+Qj5sJJ3EjrmTGOoib6/mI0PMNI5TunknVqrM5mCTkI84Lhm6bHkwP2
 kL53NvpasPQOe1kaJMz+Q8DPyN8QJDOdNQUy2YsHV/29s/Zi8ZG//gTWgr+24qsvTe5W
 3jsQ==
X-Gm-Message-State: ANhLgQ17mCPk9Bm6qm4aT0RmJB3vNHI8hTbP9FQ+h10GOu6herlCicMW
 udCDpHvVWidN825jKiyTwooXSjPCH7OFjwka1DbM+w==
X-Google-Smtp-Source: ADFU+vuLPZPxZRPCoygUcMneA6C5bxsczWazXaRgS8QGjHRC4X3dd1dihNaq2nUxCI4tS91fQTh6AXLDoLK2nOwFj+8=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr3135099oib.146.1584030573082; 
 Thu, 12 Mar 2020 09:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200311131618.7187-1-eric.auger@redhat.com>
In-Reply-To: <20200311131618.7187-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 16:29:21 +0000
Message-ID: <CAFEAcA9ZuxSAZ+K1MS6R8U1-ouU3qh=J72tyeNrRA4-k=AkKuQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] hw/arm/virt: kvm: allow gicv3 by default if v2
 cannot work
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Andrew Jones <drjones@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 13:16, Eric Auger <eric.auger@redhat.com> wrote:
>
> At the moment if the end-user does not specify the gic-version along
> with KVM acceleration, v2 is set by default. However most of the
> systems now have GICv3 and sometimes they do not support GICv2
> compatibility. In that case we now end up with the following error:
>
> "qemu-system-aarch64: Initialization of device kvm-arm-gic failed:
> error creating in-kernel VGIC: No such device
> Perhaps the host CPU does not support GICv2?"
>
> since "1904f9b5f1  hw/intc/arm_gic_kvm: Don't assume kernel can
> provide a GICv2" which already allowed to output an explicit error
> message.
>
> This patch keeps the default v2 selection in all cases except
> in the KVM accelerated mode when v2 cannot work:
> - either because the host does not support v2 in-kernel emulation or
> - because more than 8 vcpus were requested.
>
> Those cases did not work anyway so we do not break any compatibility.
> Now we get v3 selected in such a case.

Applied to target-arm.next, thanks.

-- PMM

