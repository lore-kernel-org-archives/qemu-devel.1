Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9773AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3CE20674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paOGrgfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3CE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCKvD-00080V-HW
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 06:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCKuX-0007J6-Ob
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCKuW-0000nV-1T
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:17:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCKuV-0000m5-Rn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:17:51 -0400
Received: by mail-ot1-x341.google.com with SMTP id t28so2914485ott.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JvRaI+c7gJCvoP3PLElHn3U609quG71LluLIxOIbUxM=;
 b=paOGrgfMOyD+N0BtammyUJypjtrRjpv4tARzhebHyudoFNYUJwUMMErhAzzNXmGbKs
 9/FNYl/UGQwuUbeFTJag846WfsIsk3GSG4R29I5wfu8tjjkVau95YJn0bvlOg3QEjE7O
 B5+Z0R4liRZ8BjVnqDa0netJWa19xT7s6reMXFzXK63atfGSImc2GPfqwKfw8TdMBaA2
 W8d9BWVoDQLHJf2JW0vd81cO3x6ex7RL3NB5z1oX0C8iCWyNoWh/TL0R17dt8TT4DAAs
 qDbZCqQYx7g1dkkH9g51hCb3fsf7rl5k8PZESez1yMQnLa1V9ZTPOTBLd7Dw1KqN8njp
 o+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JvRaI+c7gJCvoP3PLElHn3U609quG71LluLIxOIbUxM=;
 b=qm4rQJAS1WCLwA1oLuyzrwVRsQ9yevduL7G22Ua1TL4q3Ez02SPjJoQztwsRaIt0dB
 tNijl1zJtwmpUeKwLXmOuotgB5FltusjwHv0oftKZf9+k3BvP7oNxevTvFrmS/DA00xm
 evEHsxMbyzaxsbNlH4kkhcnfZmoswBatkrxqW0IOP/IIHWWcQIs0QcS90BzYfqUbqMh6
 9FpxRbJo8a14LB05f3cfTZeltx/XsuVoy/WyeFKpu2wnd1nYdGM3A/KsbnVNJw6JXlrc
 PWn4gOqByMOWqfG7orl79I1QIwGjIcUtLtBosgjkgEqUYAZwwI3/sTyHgz4EE9m+gDeg
 T8dA==
X-Gm-Message-State: ANhLgQ2monVzVyV9uJxJ3XYjN0tcIh2eq9ScnJCQIjnyLFSNd6GTzsdA
 /Oks/Vd1GIs+HJBLC+VBGfzVH7LcC9zhOvoLMObkkw==
X-Google-Smtp-Source: ADFU+vtSmjSUkHtvDcXaxhxC+mjmxttvemOijllRSHFfExs0Ny4ehTojAXqriSQnAy+8tr0LdD4rij8aQhmkCN9w740=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr5741741otl.135.1584008270408; 
 Thu, 12 Mar 2020 03:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-2-ehabkost@redhat.com>
In-Reply-To: <20200311232342.1614944-2-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 10:17:38 +0000
Message-ID: <CAFEAcA86+_ZFVw_4pH-XDPpCB-h2U19g6YWm99dRkRfikwqQSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Use -isystem for linux-headers dir
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 23:23, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> glibc and Linux-provided headers are known to generate macro
> redefinition warnings when used together.  For example:
> <linux/mman.h> and <sys/mman.h> duplicate some macro definitions.
>
> We normally never see those warnings because GCC suppresses
> warnings generated by system headers.  We carry our own copy of
> Linux header files, though, and this makes those warnings not be
> suppressed when glibc headers are included before Linux headers
> (e.g. if <sys/mman.h> is included before <linux/mman.h>).
>
> Use -isystem instead of -I for linux-headers.  This makes the
> compiler treat our linux-headers directory the same way it treats
> system-provided Linux headers, and suppress warnings generated by
> them.

I wondered whether this changed the search order for the headers
(ie whether it meant we now picked up our copy of the header
and not the system header in some cases), but both -I and -isystem
directories are searched before the standard system headers,
so the only effect is the warning suppression.

thanks
-- PMM

