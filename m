Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D916FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7F820872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7F820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnm1-0005Pu-Ii
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCmgg-0002dp-9m
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCmgd-0007Mq-Au
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:25:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCmgd-0007MW-2D
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:25:07 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A3233CA16
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:25:05 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n3so204042wmf.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:openpgp:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=owKx3AAO13+eF6I46DWBkgO2nLulV/QmbRVj1+UqhuQ=;
 b=gqiHPRfszNnFWC1yaLFfnt0WoGv5LMfZeJaxLQp5ZPGJYrGbb9fIxEuH+omV/BsADW
 9xXY5QBp19ItVJLwl/ROx7WKAsXlYCsfkg8O87QxWgf5iGBNN+aeg5OEMuhVc4Ks0N+f
 uqxmEU/cmtbtt9t4dMVxUWX1ByM39ckaxKmGCuCVwPYttpnJN1WhV6FKWiuE7ZfSrfdO
 h5pGTlY/fND/jZ8wD6RGLYDadG8q/UGKiasylWFKjIf6MUkw683KN7duc34zngZaUU+h
 hxeW2XqZpNpCWwd2EDW11J4UPWI+QX325anhPZL7fKKhAhnqfWLtJHcl6mutZHy3UdHz
 areA==
X-Gm-Message-State: APjAAAVkrAiApRcbv9BbYYhRr1I5KGgpfTzGJA9VNTn5W9L4FXYm+YKt
 p6RMUbwgERTWKUJxi62Agcx1eDHOQMAx42fJ5KtXq3mSrdOW4oL5wa6tt1t8mmwH24T8q5nQ7Oh
 HQsHcL7entMtiLAw=
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr2824406wrp.278.1569338704271; 
 Tue, 24 Sep 2019 08:25:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUB061y3gFcqRKNZVA0qo8OM+ZkPCpIptj4Qhb3ge80Fktj+jNoWL/vJC/84atFfTvebwNAQ==
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr2824378wrp.278.1569338703968; 
 Tue, 24 Sep 2019 08:25:03 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g24sm2984805wrb.35.2019.09.24.08.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 08:25:03 -0700 (PDT)
To: QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: docker: how to use it when developing on QEMU?
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <44be7ab6-c648-9109-3d05-1afc57e9b021@redhat.com>
Date: Tue, 24 Sep 2019 17:25:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recently more developers are enthusiast to use Docker/Podman,
and have been confused by the different configurations currently in the
QEMU repository.

There are at least 3 kind of categories I use:

1/ Image used to build QEMU

These images should be restricted/updated to our "supported targets".
They are useful to (cross)build QEMU on variety of
host/target/distributions/distrib_versions.

Example:

- cross build Cris binary using the Fedora 30 toolchain on a Ubuntu
18.04 x86_64.
  host:Ubuntu18.04/x86_64 docker_image:fedora-cris-cross

- cross build MinGW64 binary using Debian 9 MXE toolchain on a Ubuntu
aarch64:
  host:Ubuntu18.04/x86_64 docker_image:debian-win64-cross

An image can not be meant to use on a daily basis, but to avoid
regression previous to release (I'd run them only on release candidate).

Example: building QEMU for the Gentoo PlayStation2 port:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg574468.html

2/ Image used to build test program used by QEMU

These images provide enough to build binaries you can then use to test
QEMU. If you want to build more of these binaries, there is probably a
better way. Here we are only interested in testing.

Example:

- Test PowerPC Linux-user binaries with qemu-powerpc-linux-user
  docker_image:debian-powerpc-user-cross

- Build EDK2 payload for Virt/AArch64
  It currently doesn't build with Fedora 30 and I'v to use a Fedora 29
image.

Another case I had is when I tried to build a kernel for the Mipssim
machine (supported by QEMU). The Linux kernel code has been removed, so
I had to checkout an old kernel which is not buildable with my recent
host GCC. Using a docker based on a very old distribution worked. Anyway
Thomas Huth found it is easier to use buildroot for pre-3.6 kernels.

Similarly, I am testing QEMU port from Stefan Weil, and he shared a
working binary supporting the MIPS AR7 target. To be able to use this
QEMU I use Debian Lenny and set
DEB_URL=https://snapshot.debian.org/archive/debian/20091004T111800Z.
Yes, this will instanciate a Debian from 10 years ago.

3/ Bisecting

Another of my docker uses is when bisecting before QEMU v3. I use image
using snapshot slighly older than the QEMU release, so my bisect script
can run without worrying about the library API incompatibilities or
newer GCC warnings.

So not all image have the same use. While they might not be useful to
build the latest QEMU, there are still useful for day-to-day development.

Anyhow I agree we should document that better. Maybe the wiki is a good
starting point.

Regards,

Phil.

