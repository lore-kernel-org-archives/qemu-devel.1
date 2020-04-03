Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F40C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5725206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQtEqn5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5725206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKR30-0003aZ-NC
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKR1f-0002pW-24
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKR1d-0005Bn-Qr
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:26:42 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKR1d-000598-D8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:26:41 -0400
Received: by mail-oi1-x244.google.com with SMTP id v134so6922269oie.11
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7/wH69qQJfAKMJ58ojW2R3zh87fecjEXP745WaRkag4=;
 b=jQtEqn5MwxriTJkZBzwDLW1Mnmb9IsgKnUZ8ORRZ6axORe2+hQpDXeOmOhF5msImTc
 5lE0oDg16xJxRNwJr0bIGQKq88QoowYyOfX6HAppqtjbpwF4JjbPoUDAGS88M+XcTKSU
 ZPIo1damz3ZxqrSviiBVPaoIl0lucNHwV5GRqLfK+NhGt0fJrP2jUn/NtK+ljnzk6VW2
 s5GNRkbBaBd9yG2bObN3FQ/DJ6FqN4ZbIytLeFeskJw3pkMo7ZgG6WBZlJFZrFbdWsyi
 neV3N/xXQ9Wr9/tjR1qgNuYvln5Vm0mdO96HldGKHmgEU/jgWtgLT42zZ2ThqJCF2gLR
 hyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7/wH69qQJfAKMJ58ojW2R3zh87fecjEXP745WaRkag4=;
 b=g+6JCsGiN4OEGvTBA2bDBWGDrFBquBcIzBhzqSZKfJhOBwsrZJPHXA3sULzoo3BCWz
 Z0G2GvEz+00LvcsUT6tuX6Egza7FlbD4b6td2Gv9tqWdLqTsAp4ejIHZxz0jKH9+ycMN
 /cIKmKv1OdAwcC7jzda/PrByXwMYRl4LNz2wB8Fn0fCfUPZKY6cQOSQXvRCF1XU9LZ50
 slq3vpa2U9oxOIfhNnitcdVPWl1Li9qFhgvm5AGuSdGpjPRg/C1PBmjSYK57A3X9K0yW
 e8oVASvOQYZyJEYnNjkNPDT1HaVhyd+SqIxmnIRV2yWXXjltA0jF3Jk4SIPVKlV7Ia10
 dXQA==
X-Gm-Message-State: AGi0PuYk8u4XmMa7Y3laEoCvHochPQuO3vwBvIQa8Fr56WjubbyhHY0g
 MgW4EizfpbyAzED0Uty+tIghF6Sxef9BHJXY86q14Q==
X-Google-Smtp-Source: APiQypJDTxObPCeQoFH4IgQLu9oT8ope4e9I6+fV/xUF+3vr2aYvKE1zYQrvUWkSUMUML9GdxjWCcFHcZn9xMNAu8VM=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr3894122oij.48.1585938400218; 
 Fri, 03 Apr 2020 11:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200324173630.12221-1-peter.maydell@linaro.org>
 <CAMxuvawMhTCHkx1CA7XG6watFre8SzHn7eHVQR7sYSXMmXiGBA@mail.gmail.com>
In-Reply-To: <CAMxuvawMhTCHkx1CA7XG6watFre8SzHn7eHVQR7sYSXMmXiGBA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 19:26:28 +0100
Message-ID: <CAFEAcA_4A7KEhVLFYVzgN-_hUb1asERBLoCKW+-xCe5BV3mkbg@mail.gmail.com>
Subject: Re: [PATCH for-5.0] dump: Fix writing of ELF section
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 at 17:49, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, Mar 24, 2020 at 6:36 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > In write_elf_section() we set the 'shdr' pointer to point to local
> > structures shdr32 or shdr64, which we fill in to be written out to
> > the ELF dump.  Unfortunately the address we pass to fd_write_vmcore()
> > has a spurious '&' operator, so instead of writing out the section
> > header we write out the literal pointer value followed by whatever is
> > on the stack after the 'shdr' local variable.
> >
> > Pass the correct address into fd_write_vmcore().
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks for the review; since nobody else has picked the patch
up I'll put it in via target-arm.next just for convenience.

-- PMM

