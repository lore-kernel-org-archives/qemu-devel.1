Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6B5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B5A20883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="ze54xeBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B5A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDspH-0003gD-Ls
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:38:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDsoN-0003DT-Jn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDsoL-00006a-Sf
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:37:23 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDsoK-0008TB-2Q
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:37:21 -0400
Received: by mail-io1-xd42.google.com with SMTP id v4so14682909ioj.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=gX9NsXUd1ErUayh3aaMZYIRanGqtnledw62C6vGXhms=;
	b=ze54xeBVWjYns3BE/WfTaYQB3il+h+xD5OGL5FDpt33GWFFJrkOaLPxU6LnCs5z1oj
	vFnSVYvGTmkysW6uDAa6lPzlvNR6PqLv6dnmD8AwXwJNE20sfl+sHdMw/ZTEhIjyOzLi
	Bhq5nSNn6/2K/a2+2B+MiCduxPaibhtskaHymIJnkoE8jfNlcbmAwnz7Gtuhs/gKoXQT
	Pl2nvTXbO5wXmLysKQDJrRKprEKkC4xROq/iLwbPINnBQ3a5UFhAVhYltW/nJlJhpJ/U
	XA2jaDZRFcU4p3VSyVhWeJK86irxEltMEsWgWgk5KWA9tQVzUEb9dQIQPBzYfzwLY2In
	3kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=gX9NsXUd1ErUayh3aaMZYIRanGqtnledw62C6vGXhms=;
	b=gJuBWRzQfJm6qGs1dyvCJXLLD02TyuLo7e+PvcUW9K1GM/5Pn7rSt8HFUz9uAROm4I
	cF9c3fSgxSG0r7dAuOrmU5YsK1xTd675rFpQqTbatrfa9OJGtJySDJDUtVcKEN4tZuPM
	wvC1yLeVuDXE1HHTI2XHgEVRXNuNMdkCQ4LKehtA1Z1GGrb4y4x09H6Se4Nah7vwHrKr
	3LKtC0Te9bjQfcxXjcuyKhNct7//iICUWqTOV8k93L7kXa3Dzk1J35iPrYVoRjhdY6bk
	yqHj/cqno3GyNDBEUAMIH+j9hHnGkCwyhrKjbLrJGheNKngaSzl6hroxKi9WPbhdBupa
	baaw==
X-Gm-Message-State: APjAAAX9Ucz5T0tWY4kx7sFM6I0uPd2GzotaA5Sw5nPW+2iidt0Ek7uO
	+duXNu2Wqvm8ePqdrdAak6peng==
X-Google-Smtp-Source: APXvYqzl/mTVCZj6UJd4PKfPKZgk22Ku4kI8T1uXOs+RyU7Mqjh0COfup3ur9xQsnIZUDQ4a/LUoPQ==
X-Received: by 2002:a6b:5c0a:: with SMTP id z10mr15510236ioh.138.1554824232429;
	Tue, 09 Apr 2019 08:37:12 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	z24sm12676518ioi.67.2019.04.09.08.37.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:37:11 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
Date: Tue, 9 Apr 2019 11:37:10 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <98B3F0C7-6554-4455-B441-86605DA5D6C1@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH 01/10] block/pflash_cfi02: Add test for
 supported commands
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409153710.jvMd06L_jfzcH4T49piCWrN7LxFJTDzPWdsokEEoxVI@z>



On Apr 9, 2019, at 02:13, Thomas Huth <thuth@redhat.com> wrote:

> We'd like to get rid of global_qtest in the long run (since it is
> causing trouble for tests that run multiple instances of QEMU in
> parallel, e.g. migration tests)... so if it is feasible, please don't
> use it in new code anymore. Try to use a local variable in the =
function
> that call qtest_initf() and pass the test state around via a parameter
> to the functions that need it.

One of the patches introduces a FlashConfig structure which gets passed =
around to all the functions. I could stuff the local qtest in there. The =
earlier patches would still use global_qtest. Would that be acceptable =
or would you prefer that global_qtest not appear in any of the patches?

Or rather than putting it in the FlashConfig struct, I could just pass a =
separate parameter around. Whatever you prefer.

--=20
Stephen Checkoway






