Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508AFC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272042089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272042089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfKRb-0003A4-5m
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hfKPl-0002L2-6p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hfKPR-0005WX-M8
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:33:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hfKPP-0005KZ-MQ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:33:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so12365595wmj.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 01:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=M0Ho630Iw9f+gDCgXdYZ6dxrnR0PbhXPz9gl10vbPjQ=;
 b=csP9u9gKV3rMkk4++0DWNMXqZaCtHZ6IpLXL/kCWnAn4ab9CmsmPPbfDrZE9sjkKfA
 Fs8N7uF6WHRJXKDXRK56avtEtL0I9exOm/JjQ/rNByqnqTSIEQTQmYJLpGWfMsrQwJ33
 4W2ju97BKGifFIeopYdaUGvwk4PxDge3RkomaCrbZtcoVTZkcYQInws/LhOCTuuygbqm
 w0qyUvqW1iRpubp6LJytRJ5vd0a6YjTNUlhFf4ySxdMWxyHXvPr2KzIssF5K4zowmhqH
 16xPxV7BMAe1kfE+ehYqI1441QQFxkCNuTMrMsFD29IvaHvSch4Vc6GgejTJaHeUah6b
 KL2A==
X-Gm-Message-State: APjAAAV7ryzg4lyQdiASGMLdk+oy+j+kYvAIQ7TV0NbzzE/5hk17bfye
 ZkiJDnt/Y/gibxL8tV+CP6NC9w==
X-Google-Smtp-Source: APXvYqysvdA3msPi+hzEkEnC+tqnZOGDl29y4ktUdda+7eJOMMcTIhOFho46md38zomULXqs64aZ4w==
X-Received: by 2002:a1c:343:: with SMTP id 64mr15521728wmd.116.1561365177279; 
 Mon, 24 Jun 2019 01:32:57 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id u25sm9679489wmc.3.2019.06.24.01.32.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 01:32:56 -0700 (PDT)
Date: Mon, 24 Jun 2019 10:32:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190624083254.aoeizlwpet24ib52@steredhat>
References: <20190531064341.29730-1-philmd@redhat.com>
 <20190531073859.ojouyr3urzcarn4f@steredhat.homenet.telecomitalia.it>
 <5489328b-92d7-6595-a6da-3f27d0839882@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5489328b-92d7-6595-a6da-3f27d0839882@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] Makefile: Rename the 'vm-test' target as
 'vm-help'
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
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 01:03:28PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Stefano,
> 
> On 5/31/19 9:38 AM, Stefano Garzarella wrote:
> > On Fri, May 31, 2019 at 08:43:41AM +0200, Philippe Mathieu-Daudé wrote:
> >> We already have 'make check-help', use the 'make vm-help' form
> >> to display helps about VM testing. Keep the old target to not
> >> bother old customs.
> >>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >> ---
> >> Based-on: <20190530101603.22254-1-alex.bennee@linaro.org>
> >>           "testing/next queue"
> >> ---
> >>  Makefile                  | 4 ++--
> >>  docs/devel/testing.rst    | 4 ++--
> >>  tests/vm/Makefile.include | 5 +++--
> >>  3 files changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index f0be624f47..f67739df7c 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -9,7 +9,7 @@ SRC_PATH=.
> >>  UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
> >>      html info pdf txt \
> >>      help check-help print-% \
> >> -    docker docker-% vm-test vm-build-%
> >> +    docker docker-% vm-help vm-test vm-build-%
> >>  
> >>  print-%:
> >>  	@echo '$*=$($*)'
> >> @@ -1121,7 +1121,7 @@ endif
> >>  	@echo  'Test targets:'
> >>  	@echo  '  check           - Run all tests (check-help for details)'
> >>  	@echo  '  docker          - Help about targets running tests inside Docker containers'
> >> -	@echo  '  vm-test         - Help about targets running tests inside VM'
> >> +	@echo  '  vm-help         - Help about targets running tests inside VM'
> >>  	@echo  ''
> >>  	@echo  'Documentation targets:'
> >>  	@echo  '  html info pdf txt'
> >> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> >> index da2d0fc964..68aba3926e 100644
> >> --- a/docs/devel/testing.rst
> >> +++ b/docs/devel/testing.rst
> >> @@ -399,12 +399,12 @@ VM testing
> >>  
> >>  This test suite contains scripts that bootstrap various guest images that have
> >>  necessary packages to build QEMU. The basic usage is documented in ``Makefile``
> >> -help which is displayed with ``make vm-test``.
> >> +help which is displayed with ``make vm-help``.
> >>  
> >>  Quickstart
> >>  ----------
> >>  
> >> -Run ``make vm-test`` to list available make targets. Invoke a specific make
> >> +Run ``make vm-help`` to list available make targets. Invoke a specific make
> >>  command to run build test in an image. For example, ``make vm-build-freebsd``
> >>  will build the source tree in the FreeBSD image. The command can be executed
> >>  from either the source tree or the build dir; if the former, ``./configure`` is
> >> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> >> index 5e37063d32..b7311d7bd9 100644
> >> --- a/tests/vm/Makefile.include
> >> +++ b/tests/vm/Makefile.include
> >> @@ -8,8 +8,9 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
> >>  
> >>  .PRECIOUS: $(IMAGE_FILES)
> >>  
> >> -vm-test:
> >> -	@echo "vm-test: Test QEMU in preconfigured virtual machines"
> > 
> > What about adding something like this?
> > vm-test: vm-help
> > 	@echo ""
> > 	@echo "vm-test is deprecated, please use vm-help"
> 
> I wouldn't worry about deprecation warnings for dev tools, it would be
> just noise :)

Make sense :)

Cheers,
Stefano


