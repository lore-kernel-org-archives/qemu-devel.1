Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419AC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 22:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868DE20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 22:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868DE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLauP-0000BY-DK
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 18:07:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1hLasi-00076D-Jz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1hLahq-0007Ik-9p
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:54:31 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lwhsu.freebsd@gmail.com>)
	id 1hLahp-0007I3-V3; Tue, 30 Apr 2019 17:54:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id q11so7096261ywb.0;
	Tue, 30 Apr 2019 14:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7pJsaUZwY/m4/9XlKn0EdP7y/kKsHFKxz21fql2Hj74=;
	b=jtJH6KgUKKa5sp7IkLTq6AQDWfby5JneQRxXUFHJ9e6N5pvjcC62XqJebPN4Xg4Lha
	HQfMafpRDQqfPoVtbmW1WUky0FhPfQheeQor7JOIGBYnDvjdf8Cm5o++EjvvwKEtu33A
	/OcPAngRBvLxuUjfyaIUT8jwIA2BMMcE44bIVes35dU9/NWNcj0bzWeS3o2AZGwdOaU+
	pKxER9iVBI+LYdxhticdX1iM0ti1vo+bTvXOrtpK3ld6hraRtEkYSh6EiOuqgjjDXGyq
	LNu6mBXr6IEXAAWUjtInot246x+ipOC5qFnmBulrtfn90/JR+yu3kT2Ye7+oVkdhapRk
	7YMw==
X-Gm-Message-State: APjAAAVMAdAa9vb/LQCj3M2YpRcBRiJH7pIW/lOniZV00EK2+kJBXHkW
	pFUqz45ZLzMyOmd++kRoxX2tScwlbHeAocdzSD8=
X-Google-Smtp-Source: APXvYqxzFVEC6ikY6YsdKXdxQATaadvstgo9t09FTixIO1I8KTI6NdJyC6S2VNb1aD2bimu+jtLW7MewauB4nSk6Xfk=
X-Received: by 2002:a0d:e585:: with SMTP id
	o127mr58141442ywe.364.1556661266558; 
	Tue, 30 Apr 2019 14:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-6-thuth@redhat.com>
In-Reply-To: <20190428155451.15653-6-thuth@redhat.com>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Wed, 1 May 2019 06:54:15 +0900
Message-ID:
 <CAKBkRUwGEv2WsPdM0soWwaetfWU8m1fUkKN84H-tuYwOn7kPOg@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.161.66
Subject: Re: [Qemu-devel] [PATCH v2 5/8] cirrus / travis: Add gnu-sed and
 bash for macOS and FreeBSD
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>,
	Christophe Fergeau <cfergeau@redhat.com>, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430215415.elQshyoOULO_ntj3roqugIyhIXoSkqKqbexnFg4Alr4@z>

On Mon, Apr 29, 2019 at 12:55 AM Thomas Huth <thuth@redhat.com> wrote:
>
> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>

