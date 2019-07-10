Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6689C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C71920651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C71920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9Aa-0002VG-Ov
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hl99L-0001yO-JB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hl99J-0001f2-HM
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:44:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hl99J-0001Wq-Ar
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:44:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so1555653wmg.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dvm/LfsO8LAlcpZEYkYC/Gf/ZCoLJHvhP+cogibKqbc=;
 b=gTnKX3k2rg5yPQvfl+GUskDIA44CO4ghfYJiqLX2mycpmCO4Tl8nOhYYtvwyTFnGbj
 HqwYKvc7c00W50yVMhjP7k0jEhe49uWQG+OpHca/Ps1Kr3bqfPs2hMqjFOdV0aAzMLnC
 1Ym7aWZj2oFaQsRG3CpZDlBsggg7oHaEY4M6LcX5/TVD9LPkdj6miylfqR5FURoohPrl
 jMNzgVyGRynEqj4lReaXsSWGhwKDROxwSk9UW55GWSrpPy9uZNbYDYAPJpVuRz/jXI1r
 tCvytJOtOF+EGHuZd4jExznCl0a0dsUeJ8AfzsRCUTPQI2HhMAxymoI8Vdu7cL+qIpeO
 cnWA==
X-Gm-Message-State: APjAAAVkpz54b+/RLhec4UoWTCkGIzFlrOCbQSFvCSidGhKqrUVyq6R5
 dWm96gF0C/GuD71Im3ST3gUSXw==
X-Google-Smtp-Source: APXvYqyGpOFJuRPo/fJF/3XK3Ht9MV8M+nHjZpq+pxdils2FKsHzecfCHyS6WUYFLgaShMH0Ah9uWQ==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr4319532wmb.4.1562751866431; 
 Wed, 10 Jul 2019 02:44:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id o11sm1758811wmh.37.2019.07.10.02.44.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 02:44:25 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 debarshi@redhat.com
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-3-marcandre.lureau@redhat.com>
 <b6823a5f-658e-19c9-6bb4-559a12517a66@redhat.com>
 <CAMxuvay5jPM6AnsZtLYvVB+nb4nopGnRP=BWxUctA1aZNaMdog@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8e76f7d-a96f-3ed4-4c6e-d9ad48b5490e@redhat.com>
Date: Wed, 10 Jul 2019 11:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAMxuvay5jPM6AnsZtLYvVB+nb4nopGnRP=BWxUctA1aZNaMdog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 2/5] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, "P. Berrange, Daniel" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Debarshi Ray <rishi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 10:39, Marc-André Lureau wrote:
>> Why not do this in docker.py (either as part of patch 1 or separately)?
>>  Also, can you document in a comment why this is not needed with docker?
>
> Doing it in docker.py would probably mean parsing and tweaking
> arguments given to Docker.run(). Since it's a "temporary" work around,
> I would rather have it at the top-level caller, in the Makefile.

On the other hand that splits the choice of docker vs. podman in two 
places, and Python is a better place to implement workarounds.

It's not hard to move the workaround there.  The "-u $(shell id -u)" 
option could be replaced by a "--run-as-current-user" option parsed by 
RunCommand, not unlike --add-current-user that BuildCommand already 
supports.

Something like this (untested of course :)):

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaf5396b85..019191f1a1 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -212,7 +212,7 @@ docker-run: docker-qemu-src
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
 		$(DOCKER_SCRIPT) run 					\
-			$(if $(NOUSER),,-u $(shell id -u)) 		\
+			$(if $(NOUSER),,--run-as-current-user) 		\
 			--security-opt seccomp=unconfined		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 53a8c9c801..92c02aeed8 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -333,8 +333,12 @@ class RunCommand(SubCommand):
     def args(self, parser):
         parser.add_argument("--keep", action="store_true",
                             help="Don't remove image when command completes")
+        parser.add_argument("--run-as-current-user", action="store_true",
+                            help="Run container using the current user's uid")
 
     def run(self, args, argv):
+        if args.use_current_user:
+            argv = [ "-u", str(os.getuid()) ] + argv
         return Docker().run(argv, args.keep, quiet=args.quiet)
 
 

Paolo

> I am not very familiar with podman or docker, so I am not able to tell
> you why docker does work by default.  @Debarshi Ray might know, as he
> helped me finding a workaround.


