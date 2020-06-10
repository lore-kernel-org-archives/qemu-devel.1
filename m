Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84327C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505512070B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCs/CU52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505512070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3Vw-0008Kn-GT
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj3Ud-0007Sd-1l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:22:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40525)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj3UF-00047Z-Ob
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:22:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id r15so2376142wmh.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OAb7OXn+2uI1Ii8cVpOqqdMdYIGnCxCxoGCxZMdg7yM=;
 b=mCs/CU52nZBstzM29HOm27EYsd7QVE8Ph5BBmO86nPs0zjehGsyoqaHwKoxKbMKWj6
 mr6GNwhVsVKzpOHCdlCuKyjDpTBUt6l7DVvrgjfZLeNZXomyT81AlBkW/Ofu87JjmL4D
 bb9YU7gXng0jEFYU9bFGop3w6Vu0SIq6w7gvttTMhSMjs7Az4WGX8WKuRfh1s2vPQJtd
 PvHb1/yPCdwM1JM44o1d3KTnKuP4Lh08Pcq+XXDpGf+1YhzOtpqKzwuxfJT+3YZyLm9d
 1jZExmY3SYcLlk9MT8XeHTp5BIRj1pSE4PIAPMsHfffzdvxsxhxiznCQ6OY6OVmSTZ0B
 vrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OAb7OXn+2uI1Ii8cVpOqqdMdYIGnCxCxoGCxZMdg7yM=;
 b=ZvAADjoXfWzx/UNrcCX19/r5sDUkFRxWsE5HfkVLQIoplqcPLBxuHPQsyFFkQWNeYR
 WczWRSnM7Vnn733XVnRZKY9fP0/uIau8Y0FA9rrtVb4p6TQ7RRR+BJ/irzoquvMQkVw9
 xklHrRVe7J3UqxopGKY+ZY2iQAsXbkmmHb2b7SYR/ctKZQgLIvSmiZb89X7j2b/J5jGf
 94yGixhz99Tge9kPGJuBvYjvxyGqno+jm5t0aQAHKLV/FIl56vnvkrr3itrMRoPwT3jN
 wydUvKOQnOI1BYDcE2OJlEhdToMk9ySXWutOLKLYkOp75rkFJsrVaceiK9Wx61y+SQX0
 1I8Q==
X-Gm-Message-State: AOAM530FqTobdnswO0R5jZQDG4L1pDWHbGNPDNm05RjJp4XgfX0+0i9j
 nsbwZnHWytMCSPu08Bys5N40gA==
X-Google-Smtp-Source: ABdhPJwTfVX7R4mAGcGrxsfC6QcDGFQmMFUXh2ZXzVyUEL2rAbeecClU6u5DddGm9SD4JlWpETRulw==
X-Received: by 2002:a1c:a901:: with SMTP id s1mr4205536wme.66.1591806110459;
 Wed, 10 Jun 2020 09:21:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o6sm432446wrp.3.2020.06.10.09.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 09:21:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DDA311FF7E;
 Wed, 10 Jun 2020 17:21:47 +0100 (BST)
References: <BL0PR2101MB1026A0AC34665437F4B7D4FED6820@BL0PR2101MB1026.namprd21.prod.outlook.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Henry <robhenry@microsoft.com>
Subject: Re: Failure of test 'basic gdbstub support'
In-reply-to: <BL0PR2101MB1026A0AC34665437F4B7D4FED6820@BL0PR2101MB1026.namprd21.prod.outlook.com>
Date: Wed, 10 Jun 2020 17:21:47 +0100
Message-ID: <87sgf251t0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Henry <robhenry@microsoft.com> writes:

> The newish test 'basic gdbstub support' fails for me on an out-of-the-box=
  build on a host x86_64.  (See below for the config.log head.)
>
> Is this failure expected?  If so, where can I see that in the various
> CI engines you have running them?

No it shouldn't fail - if the GDB doesn't attach we should be skipping
the test.

>
> In digging through the test driver python code in tests/tcg/multiarch/gdb=
stub/sha1.py I see that the test assumes that a breakpoint on the function =
SHA1Init is a breakpoint at the 1st assignment statement; the 1st next exec=
utes the 1st assignment statement, etc.
>
> This is a very fragile assumption.  It depends on the compiler used to
> compile sha1.c;

True - certainly for "native" built test images.

>it depends on the optimization level; it depends on the accuracy of the
>pc mapping in the debug info;

All test cases are built -O0 -g3 so should have full debug info.

>it depends on gdb.

This is out biggest problem at the moment because it seems support for
socket based debug is fairly new for gdb.

>
> Better would be to change SHA1Init to do its work, and then call
> another non-inlined function taking a context pointer, and then
> examine context->state[0] and context->state[1].

We are also trying to test the step and next functionality is working
here.

>
> Thanks in advance
>
> TEST    basic gdbstub support
> make[2]: ***
> [/mnt/robhenry/qemu_robhenry_amd64/qemu/tests/tcg/multiarch/Makefile.targ=
et:51:
> run-gdbstub-sha1] Error 2

Can you let me know what the contents of:

  cat tests/tcg/x86_64-linux-user/run-gdbstub-sha1.out

is please?
>
>  QEMU configure log Tue 09 Jun 2020 02:45:06 PM PDT
> # Configured with: '../configure' '--disable-sdl' '--enable-gtk' '--extra=
-ldflags=3D-L/usr/lib' '--enable-plugins' '--target-list=3Dx86_64-softmmu x=
86_64-linux-user'


--=20
Alex Benn=C3=A9e

