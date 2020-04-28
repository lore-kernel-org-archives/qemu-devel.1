Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4819CC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10296206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDLQaW9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10296206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMYL-0005zf-43
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTMSt-0006xg-IK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTMS9-0003Eg-8V
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:23:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jTM4d-0003ir-OH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:58:39 -0400
Received: by mail-ot1-x343.google.com with SMTP id j4so31405335otr.11
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l2hpbDrVJDciMglrrU6QNbB6BSWSRP9sNw8h+DZwl/E=;
 b=EDLQaW9E3CXg8He4UmN+mR0fEW7PkVCjsogjpBqyWB2YHXKapUzAqLVnU7d2Qr1vAt
 ljhC6vEWo4GcdS2pKiRUyJRmhXk7m9zGQ3C15wRycRhjNFTwmSi0bnJnhFSZKHVNxtKG
 EAMFrmSiAQkxGOjWqIlzA3Yu7v82FM9lhKKu4EszxgsQtM+kG8dLouG9omH0EKjBOv5m
 fSuA8ARjSnuClyTLewRIms/YsPHpwEpos2XkBYZFM4j5v1gjObMC7cQGsAzVATsFLM6E
 nr5A0jn5r8ZO63XZPhxrZtPZYCufHrqMDV+7Qc7agQIq0B0ySdpebP1Va8M0/t7vvpog
 7ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l2hpbDrVJDciMglrrU6QNbB6BSWSRP9sNw8h+DZwl/E=;
 b=j8GpzCEhd3kbsKjphNvNHyttuioXmg0LEXmMCDnCIyy5dlA9erVHc2EcTAc6ovQSpG
 XafUuo7igsW7k/O/JwiG5cjJvH9MsOeiqHg6+AE0mZR956/2u8I7Bp8kolh+GsbTmfFE
 X9Ou1/JAqwOqqopQ3V/cWyFkCCQI5AdpBGobO1l8WLMdao0oLIB7Vca4ypIkMeAx6iUt
 9zaDQUjDq9HyWtHaOSGEskqVemEH5+DqcLYcf0JxrYEOgQNJTfYSwFiPMDOxKhhcfS9f
 U+/uyh+f4jPQIiu4eMd3ez8uxKHaGB3+Epju4fBv8z+TnVhqTf2OMEWXPev+o5hSyrqm
 B2cA==
X-Gm-Message-State: AGi0Pub2ksy651zMHNAk+a9yMdRemhDu4KhLHZvc8JpaO7CKFnv4WWIk
 Phgnkp7dsWJEKNRVIKV/GXRd2tV9YbamhnIHGccPlg==
X-Google-Smtp-Source: APiQypIrD3QflSxSxLsW4iAYUu9Iyq5O44bhWnqv0s1vyoi6VmbguW78rAQZAx4jY7BePqINbh4ZmrXF2AJEaNtw3Rs=
X-Received: by 2002:aca:897:: with SMTP id 145mr209020oii.48.1588064317665;
 Tue, 28 Apr 2020 01:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200428062847.7764-1-gorbak25@gmail.com>
 <20200428062847.7764-2-gorbak25@gmail.com>
In-Reply-To: <20200428062847.7764-2-gorbak25@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2020 09:58:26 +0100
Message-ID: <CAFEAcA-Ze1phEVK7DoFEtHY_qzyDd1tnakYRqwURD0YWMEGvEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix undefined behaviour
To: Grzegorz Uriasz <gorbak25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: artur@puzio.waw.pl, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, QEMU Developers <qemu-devel@nongnu.org>,
 j.nowak26@student.uw.edu.pl, Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Apr 2020 at 08:50, Grzegorz Uriasz <gorbak25@gmail.com> wrote:
>
> Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
> ---
>  hw/xen/xen_pt_load_rom.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

The subject doesn't match the patch contents and there is
no long-form part of the commit message explaining why...

thanks
-- PMM

