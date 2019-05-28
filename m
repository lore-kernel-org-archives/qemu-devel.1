Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59F5C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A4E2183F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A4E2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40389 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgDA-0007MX-3R
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 13:48:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVgB3-0006JP-R8
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVgB2-0001tR-S9
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:46:21 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVgB2-0001sl-Li
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:46:20 -0400
Received: by mail-wr1-f46.google.com with SMTP id c2so6005105wrm.8
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 10:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NEk8wX2NIwEkLXYl6ms8IcjzfT4ja7S30uKg2RPzbr8=;
	b=mMQUXxypGuD7+t+VCKjw22XrcdBxGRS3uL+Msrr3QSQA5nSo67MnPBFbzAyDiZ2uSz
	QMGEjomwzsW8Dc6sTVegEX9onzXFlAJbHgt00FM+7/68wBUwNAYH0ZqoiYHu2cJnS1yI
	lw80oScQXNMoa52RKDVeQTvT/KbaU1r4WRUUmWyCol/48++gz7nSzAhC8aHIQgC1vsW3
	h4dAm4KNwVUy8Gh3uxzmKX+YHxsKg4n5sedb7PXazkA5SJSfnx22Lb5Q6c+x/a7tQ3Va
	QEU6DbOnqZBDq9PklwFn3NOAYK4h3eiQ3BGL4rMln67AUgEahE0vKz6HgZ4sCVsODUNw
	tWRw==
X-Gm-Message-State: APjAAAXFP0wo8VbBgF8gy0yHp2wa9td9xi0Y4j9+zbChmLBNVMT2gAc2
	VrJEYbEeUmU9bdPkaAUy3AZlKDfbaQQ=
X-Google-Smtp-Source: APXvYqyFNF09KHaB6gibisoPkaImPv+jCwXK06EpD63miKNfO5Tq+SAU+ffmR9YEMmoy/Rw51HRwGg==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr10172567wrp.188.1559065579470;
	Tue, 28 May 2019 10:46:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id
	v13sm3201326wmj.46.2019.05.28.10.46.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 10:46:19 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <87a7f7ov6q.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18bac6f1-3bd8-f4c1-3f19-34084cc9553b@redhat.com>
Date: Tue, 28 May 2019 19:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87a7f7ov6q.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.46
Subject: Re: [Qemu-devel] Make target check-report.tap is broken
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/19 10:11, Markus Armbruster wrote:
> Commit 9df43317b82 "test: replace gtester with a TAP driver" replaced
> targets check-report.xml and check-report.html by
> 
> check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
> 	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
> 
> This never worked: scripts/tap-merge.py does not exist.
> 
> Perhaps it accidentally wasn't committed.
> 
> Perhaps it's just a typoed tap-merge.pl.  But that one reads its intput
> from stdin.  Possible fix appended.

Indeed that's the right one.

Paolo

> Paolo, please advise.
> 
> 
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 1a3f17faa9..54d888fc5c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -905,7 +905,7 @@ check-report-unit.tap: $(check-unit-y)
>  # Reports and overall runs
>  
>  check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
> -	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
> +	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
>  
>  # FPU Emulation tests (aka softfloat)
>  #
> 


