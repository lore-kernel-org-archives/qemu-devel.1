Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A070ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361FC20B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KC8R8vOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361FC20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGcP-0001Ym-8j
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iIAPm-0001HA-Jp
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iIAPk-0004BR-GB
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:45:58 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:41116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iIAPj-000440-Kd
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:45:56 -0400
Received: by mail-io1-xd44.google.com with SMTP id n26so4200112ioj.8
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 04:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RV4BW2Rul1SJvLbGnsvPDgNULkZjIYo7yp+xwh6MfbQ=;
 b=KC8R8vOTKBcfyuI9fRqTnAaEg2TBr9H6W5ltiHVJ8dQyMiWynYetcUr/feR9G7dAAf
 YN1vqmHMRZrHauFjHjhJr+W9B4PsC5tCp+l65DHSOkuoDc4KUOMc6I82ZYQicIFlJynx
 u7r1x1jgs+KzhFQg59WzgBHE82GCKWcChAyUK/SZtOQEyYAzrOC8I++tVA0AVcGeVxEa
 HwXBTyI9fqoIkgorPCu7Tsl3sPamxW7bMhFoHmiIJeu0kLiuiokLwCxmKGZTSDQyWZW/
 0ms3UxjjSQC0QjiCGM0UDWzoU8aUJ+MEfTQ9RDP+dXmO/xTpvHJ9cx1rknmkX0ndL4JT
 GjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RV4BW2Rul1SJvLbGnsvPDgNULkZjIYo7yp+xwh6MfbQ=;
 b=l0vchOF3yNdF3vyAjitkWYprW81fA3JAWZ3+k16leBjQTkQf9IQrh89/gOKQ7cadvp
 HZXZYziAfiSk/MZh+pVSjOlECfpJF2aXGv0oFfWdRtEGqLmYLOQR7nEwiGgRPwyD697A
 FireirM0Tnt62Mor+ke6/N5uw251CMBg//tMJb/tYy9sD6+9o1WgrgahenKY0D8GXZUx
 caEGgsiOtjk+lxE7Ci0mZ5+sSuC4WyBPNs3Tzn5NL4avbu99SwFSsCnucA+Nypqb3hhv
 oGuhCm2s5CMtbmc/lJy0dNfobk3JIUHqk0yD2RS7+52kn2DSuvyZSk5LfDpoIJTlmzwd
 pvvA==
X-Gm-Message-State: APjAAAVwVbe/kv0bbco0LgX2DOeAU78x+90RkbYHnCF1tN+tq5O94Jt2
 YgcVdibJYUQ7/AdlN1scmKXYdmaWJSl9twtR6hSQNQ==
X-Google-Smtp-Source: APXvYqzgeJlcbu7KFQ+jnN3mUS0sT1GujuFJYv+FVB7IepQXtX6vg6B+G08i3sE2Nvy/pU1UTh1+FpdM1zwDOOzp498=
X-Received: by 2002:a92:2406:: with SMTP id k6mr2949553ilk.260.1570621553097; 
 Wed, 09 Oct 2019 04:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-3-beata.michalska@linaro.org>
 <e5e66d9c-16ee-a700-7608-69ec19c32b47@linaro.org>
In-Reply-To: <e5e66d9c-16ee-a700-7608-69ec19c32b47@linaro.org>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 9 Oct 2019 12:45:42 +0100
Message-ID: <CADSWDzsf8=0q0bUH1iLdQ+rNgu3TU2Ee3QddhDZN5nBhH7yDSA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] Memory: Enable writeback for given
 memory region
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 shameerali.kolothum.thodi@huawei.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/10/19 2:56 AM, Beata Michalska wrote:
> > +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length);
> > +
> > +/* Clear whole block of mem */
> > +#define qemu_ram_block_writeback(rb)    \
> > +    qemu_ram_writeback(rb, 0, rb->used_length)
> > +
>
> Inline function, with its typechecking, is preferred.
>
>
Noted.
To be fixed in the next version.

BR
Beata
> r~

