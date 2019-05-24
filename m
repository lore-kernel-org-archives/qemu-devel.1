Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E6C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5345120856
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5345120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBVO-0001m4-MU
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:49:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBNj-0004e8-LY
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBNi-0000Eu-KI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:41:15 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:33003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1hUBNi-0000E1-FQ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:41:14 -0400
Received: by mail-io1-f46.google.com with SMTP id z4so7980017iol.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 07:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=R1MCciCoJNDI4AF1rU4v6QDZvx8/SPcF+roZvnefftY=;
	b=gjB37WonCSOUzVw7EVYUyvC9MewXCZTVcTC2mxLGTWwiq42dvNX2JbfMcDFMbp8NoV
	oL4j8HtEI5ukKFQTdbqDjReHc2UhS3SHIS5AY4E8JFFh5FcSpX3nXNI1nRObHipge2vA
	nKWoE0UHGsusWnfiVbtehOJuBtGCzag3BLqfLupFUwC4WixlOmkfhQYCYfBlaPBXdNm2
	ET5eW6pCeSoACerUekK5AvAt10FTFr58/fCP/olotEbtqZthohSXkbz6zkpKhtLS2ukp
	kauvoSMe8EgbuVEqD9RIlT2DpCuW6Ao749tJL0zc/6cyEmx6SIkeNd4jsaG1vmxf1d7C
	I+eg==
X-Gm-Message-State: APjAAAUkNAfF8O0FuAMWoe4pBMe36Pe69356OiNY7IT2x+QslGtBXFvt
	lg4wUs0JK7jvDei7t+DwvwZ/IdLVif6EnP1/f1U=
X-Google-Smtp-Source: APXvYqzy/4FPu/OXwT4LXSDODCZsThPKJ6Xaql2dmOorHKtf1oCtaMEwJPtKPjzRMTDuzeG2mq9+ANbuJo+gtbEtNVU=
X-Received: by 2002:a6b:b907:: with SMTP id j7mr36539063iof.17.1558708873457; 
	Fri, 24 May 2019 07:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190521105344.11637-1-thuth@redhat.com>
	<20190521105344.11637-12-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-12-thuth@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 24 May 2019 04:12:01 -0400
Message-ID: <CAPyFy2A7Kd_=ni8QhWDwLC5b7SVX6s-5geywfmzcZfvYrWjcDw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.166.46
Subject: Re: [Qemu-devel] [PULL 11/13] tests/qemu-iotests: Do not hard-code
 the path to bash
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	Laurent Vivier <lvivier@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 07:04, Thomas Huth <thuth@redhat.com> wrote:
>
> bash is installed in a different directory on non-Linux systems like
> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> there, too.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Message-Id: <20190502084506.8009-4-thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Ed Maste <emaste@freebsd.org>

