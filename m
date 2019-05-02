Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55174C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1892E2085A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjmYMO8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1892E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM4Ls-0007eK-8y
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 01:33:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hM4L5-0007LG-BN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hM4L2-0004Id-TV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:32:58 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hM4L2-0002oV-Gl
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:32:56 -0400
Received: by mail-ed1-x543.google.com with SMTP id g57so957410edc.12
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=fiqfkx5w/v6l/z4tVxxxAOoXMfWTvWJBTOo59NAvBXU=;
	b=KjmYMO8j53ZLZtyBOeACnEl86WvFqGL4F5ETitp0jDa77oh6DrNUKC7h60Kw91EMMk
	tMmwdNT7bvokpfPHN9F0LoPP0rVwz/vxAl9OCHOU7H7DBCYSS/YbUcIaGzJXQQupORaZ
	P/DW/FPe77qr/5JMlwl2yfWXH1xpgnJdjiAb0QcXCK2bg9UETmoPLTFVqILcmNWrDjOW
	P/YSD7Ct4WoodbWe5YH/IrMumLOnpgqdFsQa0yhGaik97tN9tl9B9zokSX+mn/ibNuzM
	pHB/dHN+cutJXJAOm/f+aBTQ4dShur0xEEMXGiwhzazlifSmzNKaox7YPO9BflKWH6Uo
	tO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=fiqfkx5w/v6l/z4tVxxxAOoXMfWTvWJBTOo59NAvBXU=;
	b=sHtIBa6+G3tY6l5zwOfTjB2awBhKf9PD7IItLEfrovYG0x3pcp2jfOSAA1JuTyWL47
	DwroA5lO4ta7va2XBCrB4IuUrZQBJdymYWyY1H9P+ifNsCOVHUlHeefqGzP6hMLiY2KA
	W8VZyWczE4a9P5bsSOegZMLPqsBzk14/3zKH4ub21muUlfVTv9lL+lrqvrZl80CBjQpq
	wnr4krIXFlv7iOxyb72zDw2T4AWkzcbmBOd0V7Su+Ow/YM9CEme7G0/j0IXyLzMjAN/0
	G9eH6b2aFfUiINxBwD/gSTPGoPe8J/XWmhGehd4AUB4oGqDbXdL30wt1w/CBrYikVzgc
	gRPg==
X-Gm-Message-State: APjAAAUrVW/+MTFIZlTi8VBrO41RxYVXTQNwR+jF027vxaKbLSDQOsiH
	D6is7iRkoqXcnpDn1IAqsTJqJrAx
X-Google-Smtp-Source: APXvYqxJABLhAc5hh3EMvJWrOfJSt/xyj2RYRpVHg+anvtKl5m1p1aovVq6/XAQ+59WlBA7pu1vyMQ==
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr790438ejr.91.1556775128710;
	Wed, 01 May 2019 22:32:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id q5sm7127819ejm.63.2019.05.01.22.32.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 22:32:07 -0700 (PDT)
Date: Thu, 2 May 2019 05:32:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <20190502053207.ix637eb6v7umujas@master>
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
	<155677104475.10667.17544832182226944733@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <155677104475.10667.17544832182226944733@c2072b67cc0c>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 0/3] Cleanup migration/ram.c
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: fam@euphon.net, pbonzini@redhat.com, richardw.yang@linux.intel.com,
	dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502053207.3nhK1tblwsNgQYZUILhbsWpu7kfDLDzCGvHBl1w8eBY@z>

On Wed, May 01, 2019 at 09:24:06PM -0700, no-reply@patchew.org wrote:
>Patchew URL: https://patchew.org/QEMU/20190430034412.12935-1-richardw.yang@linux.intel.com/
>
>
>
>Hi,
>
>This series failed the asan build test. Please find the testing commands and
>their output below. If you have Docker installed, you can probably reproduce it
>locally.
>
>=== TEST SCRIPT BEGIN ===
>#!/bin/bash
>time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
>=== TEST SCRIPT END ===
>
>  COPY    RUNNER
>    RUN test-debug in qemu:fedora 
>container_linux.go:247: starting container process caused "process_linux.go:258: applying cgroup configuration for process caused \"The maximum number of active connections for UID 0 has been reached\""
>/usr/bin/docker-current: Error response from daemon: oci runtime error: The maximum number of active connections for UID 0 has been reached.
>Traceback (most recent call last):
>  File "./tests/docker/docker.py", line 615, in <module>
>    sys.exit(main())
>

May I ask how I can reproduce this?

>
>The full log is available at
>http://patchew.org/logs/20190430034412.12935-1-richardw.yang@linux.intel.com/testing.asan/?type=message.
>---
>Email generated automatically by Patchew [https://patchew.org/].
>Please send your feedback to patchew-devel@redhat.com

-- 
Wei Yang
Help you, Help me

