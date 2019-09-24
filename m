Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC756C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24CB2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24CB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoH0-0001Un-HR
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iCnBW-0002OV-Vk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iCnBT-0000zZ-UT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:57:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iCnBT-0000xA-Ii
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:56:59 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7EEC7FDCA
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:56:56 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id y10so2476540qti.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l3tIqcGMb/otnY2p0zARiTOKlmtvbRBPPKhUXkgpAFE=;
 b=Pc3NoT70UDHy1o1W7k8PZLhNyr9mSTSSS+lfatG8xlbIKugvnUtyDRvZBVNLMfKG38
 H7bkmMNNH/Z98KVqBLp2hSV1neGZsnk6tmJBvo9pRTUwF+rbkJudcf1RraNzbERXdFNc
 KaHQwubGgX9pQdogzf4dj3hQpnjRaaWHUfRunK4vD8QQ0w17QfI0NkwY229HkkOmt4ig
 B9Kuj/zH+0PnQpotciuwMFvuH8fNFMG4IVW22XPuE3oZj2UU99eJphxwTjocoX7chx4U
 InVVEeq2/yRjoZgVolMGtszKrZg3Er1LfsLkoExPoSdqHL0QEhm6RdUPkExQHTX+St1o
 v79w==
X-Gm-Message-State: APjAAAXCeZIY2WRcJcIwT+YuQGMfOdSLbx/FkX6vbX9bBdrjs4je2XXG
 zGYoh6qoE3zQgJ/VfLwFOZnE62gam3vJoGPHMNhIVQtvBbHH8GBFI7hffaFgQXJSmRYpj34ibKH
 69URABR4wY4/E74w=
X-Received: by 2002:ac8:78c:: with SMTP id l12mr3622384qth.132.1569340616002; 
 Tue, 24 Sep 2019 08:56:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxm2DihXhnOeJmJQ2xBVSw0bZic/2AOqtToaoKi/gR/K9zgZbRei3Nf9ESlKf2kfn34KqnqUw==
X-Received: by 2002:ac8:78c:: with SMTP id l12mr3622357qth.132.1569340615729; 
 Tue, 24 Sep 2019 08:56:55 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id j137sm1200393qke.64.2019.09.24.08.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:56:54 -0700 (PDT)
Date: Tue, 24 Sep 2019 11:56:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: asan: false positive? (Was Re: [Qemu-devel] [PATCH v2] vhost-user:
 save features if the char dev is closed)
Message-ID: <20190924115524-mutt-send-email-mst@kernel.org>
References: <20190918084834.9729-1-amorenoz@redhat.com>
 <156882660456.17151.6049472857437201023@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156882660456.17151.6049472857437201023@5dec9699b7de>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ddstreet@canonical.com, Peter Maydell <peter.maydell@linaro.org>,
 amorenoz@redhat.com, pezhang@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 10:10:05AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190918084834.9729-1-amorenoz@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the asan build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   CC      qobject/qlit.o
>   CC      qobject/qjson.o
> 
> Encoding error:
> 'utf-8' codec can't decode byte 0x95 in position 799: invalid start byte
> The full traceback has been saved in /tmp/sphinx-err-mhg776xj.log, if you want to report the issue to the developers.
>   CC      qobject/qobject.o
> 
> 
> The full log is available at
> http://patchew.org/logs/20190918084834.9729-1-amorenoz@redhat.com/testing.asan/?type=message.

What happened here?
Does anyone know?

> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

