Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0837CC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5AB244DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5AB244DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4X5-00019i-Md
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:10:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY4Vw-0000Ox-8R
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY4Vu-0008J7-O6
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:09:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY4Vu-0008Fv-I6
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:09:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so6499598wrn.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 01:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=j3E4MDJbT0lsVnGHgtyyyrCLL+utJeo+mGPDrU+42nE=;
	b=M+enL8OCHcWrU4TWfdC3qKyvLOEUB0e5jGuUOcaT5kjotk5HG1kqKXiO814wyjLZXX
	KjPCpFbwHjq8tv7FZwAJz4NSCNd+NAWSq+fAX6sKcTjnebCT5B+sk9EX5KvX3NhB/PeB
	CGQ743D+NiARTfV99vGAEgP0SKag763REH7+XV0MVmvL1YPgOWSJ5XvaSZcYZUpl98V/
	Xl6jMRB3R2H7BeBAXaHOW+Xps+gOkgfxtHsfgPMGOUqhsTEoEG+xTNn9mFegt+5EYR+a
	jXlSC61/t718kxTDm1yc4sIxTYaXt1kZcU8eFOzUFpBc+Fpzt5RMO4Kj7tHcsMSUvyVM
	PfCg==
X-Gm-Message-State: APjAAAXihJVxzVBS9taTbyVdMirHtv8jJKoIrx7VtHMPdAYouEVrR8y0
	eGOsFZ1qDdJAIk+YBb31xxLALg==
X-Google-Smtp-Source: APXvYqySHlc085Slt+t79m0Qqz3xRbQIGLUquPtT1x5op99mTlB61srcuCMOw82RFeAV/AMiEoz1fA==
X-Received: by 2002:adf:e352:: with SMTP id n18mr18709704wrj.82.1559635785156; 
	Tue, 04 Jun 2019 01:09:45 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	l8sm12634614wrw.56.2019.06.04.01.09.44
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 01:09:44 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190604080010.23186-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ff72b9fc-003f-275a-d382-860f2a483d60@redhat.com>
Date: Tue, 4 Jun 2019 10:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604080010.23186-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] test: Fix make target check-report.tap
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/19 10:00 AM, Markus Armbruster wrote:
> Fix a fat-fingered invocation of tap-merge.pl in the recipe of target
> check-report.tap.
> 
> Fixes: 9df43317b82 "test: replace gtester with a TAP driver"
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 46a36c2c95..34df040583 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -904,7 +904,7 @@ check-report-unit.tap: $(check-unit-y)
>  # Reports and overall runs
>  
>  check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
> -	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
> +	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")

Paolo, did you intend to submit a new tap-merge.py script in commit
9df43317b82?

>  
>  # FPU Emulation tests (aka softfloat)
>  #
> 

