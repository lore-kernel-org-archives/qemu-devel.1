Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D629CC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A194921479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlSH+1GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A194921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7N4K-00011F-OT
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7N3J-0008VZ-L1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7N3I-0000x5-3b
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:02:09 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:32885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7N3H-0000w1-UZ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:02:08 -0400
Received: by mail-ot1-x32f.google.com with SMTP id g25so11980011otl.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PxJv/9iL2G0t7Qc+NPT3dOGX5ON7H18UM/PU3Pag8Is=;
 b=HlSH+1GGf6Z1eNQ3s3I8NzjHUhCNIQlocgXYKYOy2f/DrWPhwtcFFpE9pnVMoAfX5U
 WB3LNIkQaKizJFeQjR45kL/AiwWZmENKImnu+Vtmq0CNlbF3DGBXjZOwPU5d8Nph5238
 UASBPXK/81M/pz+NhUE7JMe+98v6sDGThZjdSkByfvc+QGlAAK+77OsbTFNoxdvuP/QD
 WvexrWtkqWZpW8vmWm02dniieREz4iUSonNMzF+vI3WpANQHQuuYyijyaZJgW3iF67q8
 X4/0b8F1KDBYvzeZRdtcKVomcHycKjPQco0CshqN1cepl4fDAh94nCnNs9R6keI6XIQK
 sIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PxJv/9iL2G0t7Qc+NPT3dOGX5ON7H18UM/PU3Pag8Is=;
 b=FidM0KOnmKOpuUcc6uu4OFQxVlWgn+bbBDSVZgFEj3Zuz1E6ZuJJyxGST95ANzMiFp
 20hYO8YYLmKZ+tX3IyuhV7HsxEg03oocjHKUky6u24hOPk1m4i/UVnV1RB8H8xbn9Flm
 72Bf6hZeU6q06aeuTd+toudD1PbCcQEC5Tx92kk0EQWBVJHACHvEhPF5KMG3QjJsMsME
 /tn4UP8XVCY3/ahhIMDMVHVRbpqsN6XCAjCqUFnfh8JWdpU8Fb7fLn6UM6Yo+w/GV+oD
 wcnLQB9bPWsfHF+4/bEMBLm6N1HETc1Ow3pX7nljgr0Qn4yJBDewRqLtv7MRAOlB3UNI
 dBtg==
X-Gm-Message-State: APjAAAU8P2VW7sg6rjqLgjOZSCIuQ7t4FSLP1jjytjhMnA6lTFJngkB/
 Nh+19pEVf+iqKJJ8k4SN8uL3hASe1ycEPmv4swTsow==
X-Google-Smtp-Source: APXvYqwJNo4yQUHUcA9vWY4cN7zQdz9LXr0O/GXqI1BQdUiNgz1gbzfaWSL0Nja3TOkmfxLZOBveyhx0pejXdezC53Y=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr17018257otq.97.1568048527128; 
 Mon, 09 Sep 2019 10:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+O=T+HN6ueMMq-Dt2X1mB2e8a9BdEFg3gnkgcNAcKHw78UEg@mail.gmail.com>
 <a4bd9d6a-4aa2-a912-db16-80d558e6c5b3@redhat.com>
In-Reply-To: <a4bd9d6a-4aa2-a912-db16-80d558e6c5b3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 18:01:55 +0100
Message-ID: <CAFEAcA9kUxnN2z4-5aDHCwrVQH1jgSm7BTKw5+fmCX=KPn8nMA@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] Greetings qemu folks
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
Cc: Toe Dev <devtoe82@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Sep 2019 at 17:56, John Snow <jsnow@redhat.com> wrote:
> On 9/7/19 9:58 AM, Toe Dev wrote:
> > 2) My main target is to output a lot of this to console cause I new to qemu
> > and I want fast                    feedback on stuff like this. I try start
> > qemu with -D option but the log files never have been              written
> > by qemu, but either no success.
> >
>
> QEMU doesn't output a lot of information by default, `-D` might be kind
> of misleading. (Actually, I've never used it...)

-D just sets the filename for output of -d debug logging. It won't
actually log anything there unless you use the -d option to specify
what to log.

The -d logs are largely useful for doing TCG (emulation) development
work; if KVM is what you care about then tracepoints are probably
more helpful. (Tracepoints work with TCG as well.)

thanks
-- PMM

