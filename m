Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CDFC47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F6B20731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U30xWxJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F6B20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFD7-0002tD-7j
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jUF9P-0008JL-5Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jUF77-0005GN-Qz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:47:14 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:34217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jUF49-0001e3-GR; Thu, 30 Apr 2020 15:41:49 -0400
Received: by mail-io1-xd41.google.com with SMTP id f3so2788305ioj.1;
 Thu, 30 Apr 2020 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W3Z1SmoA9/EiEkkUdnPjK8U7/UeISeTAqHxbvQN5Jlk=;
 b=U30xWxJpCTvkDhC/CbaK5ZU1ANMRBtvFZKkCcB4qfzfGo2wQGStWJYuIPqX3o3pXeJ
 1absiA+eawXRDKjj0Y4rYUNomVRfSYGFl2VSBzr0t6+ZgPrhg90kXeJY/S1x97Iz1950
 6/FKHZ85IopR2dCOwQf2ysASsAtQGWalJnzsJEE8FwSKJBTAb8B0E7SzcOXjctVsunJi
 6bkOHg1oX+9cw7dvW0U5WW6LFKcje2FScigUCi3brZLm6/55MCRGKxe+3bGXoDBsCXgR
 M/vlgwpPdAqrPi5Ktw8FJAZzkbdkhiRqY4AO8gKMvZD8z8r2tYtWPI95wK5P9SI59yVs
 II4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W3Z1SmoA9/EiEkkUdnPjK8U7/UeISeTAqHxbvQN5Jlk=;
 b=CzyKvjKSkxA4Qheip4rEMqcPzYVVxMZ7PE+DXR35I21tTNGiyPSMVxynj1U5ZlHHjy
 kdSxfvaR+8KxPJeh4t2rOhqHeiCmxg2OY+vZcYBU/BJ+X7TkwQF3a5xv7pS9ugH16ObO
 nQXCPg5v6gSKcVaxr3fLRvG42KRQv9xTJ3+g6LCX9vbyHeZJKD64+j0fI2q5Jz2ZrAHe
 H8YDFmW3//f2HultWcJKgto5csJ+ttF7OQ554e2zeBth9001nqA4bV5oAuQNst8XePwN
 aZxE3MAPtqHZUcAUFaBFiAOtBcsj9pQjZLWwrG9l/AVqwV6hvxsMvmuMjEWFGkQA//To
 aoNg==
X-Gm-Message-State: AGi0PubtiU3mQuhNt9TKVa/dNIqayCLnV7U7wprtiR2GoSraqrkVKYi1
 3+x+dGlMYlGvqGCCI/PPhoL8hyPPJKSnCt8sssE=
X-Google-Smtp-Source: APiQypK4c94NgdEAYNZ2/BfjWKUf59MNXOebsIy+FTlnHLoSQ/J9Q6thl4zBCe7FQ8E/c1a0xSaVyp1bGW/UALqNkDo=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr450375ioj.42.1588275707609;
 Thu, 30 Apr 2020 12:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
 <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
 <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
 <CAKmqyKPJ6QqUULrDj9NX_bLdnjsjzPOGcCBH5q23fG=ScT_NzA@mail.gmail.com>
 <CAC41xo32aWNZteKP-95AtFXQo3w_Ey-7MA0-dL_uJmEMScAuhg@mail.gmail.com>
In-Reply-To: <CAC41xo32aWNZteKP-95AtFXQo3w_Ey-7MA0-dL_uJmEMScAuhg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2020 12:33:13 -0700
Message-ID: <CAKmqyKOnpJQUHVnzGVBjPkib-Z1vfdWqLx1HmfbGascFFG4DVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: Jose Martins <josemartins90@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 2:08 PM Jose Martins <josemartins90@gmail.com> wrote:
>
> > Your change just made it true for whenever virtulisation is enabled
> > (in which case we don't need it).
>
> This is exactly my point. As I said in the commit message, the spec
> clearly tells us that "Interrupts for higher-privilege modes, y>x, are
> always globally enabled regardless of the setting of the global yIE
> bit for the higher-privilege mode.". HS is clearly a higher-privilege
> mode than either VS or VU. So, if virtualization is enabled, HS level

I'm not sure HS is a higher privilege mode.

HS is privilege encoding 1, which is the same as VS (VU is obviously lower).

Alistair

> interrupts must be considered enabled independently of the state of
> the actual sie bit in mstatus_hs.

