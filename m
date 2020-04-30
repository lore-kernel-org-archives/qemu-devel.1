Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E24C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0142B208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLFacWtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0142B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBp7-0004KO-60
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBdD-00008m-R9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBZv-000358-9L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:01:47 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:36017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jUBZu-00034r-0u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:22 -0400
Received: by mail-qv1-xf41.google.com with SMTP id w18so3258270qvs.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M/HVPJJsarEjIjVx4H78Iqo7kCS5rt82H++LHRaHDJU=;
 b=TLFacWtWa1DrBh1fkALLRqkqNoJAYQa45Wt4IZLzxN9fpv/T3BdPfsvsPJvkV72H9l
 JqxdCWv1/Iqloa1QBEty/kkTJ+N6z/6CdkwVxrTboATRfEgiBAsm1NJPy6BaTSU5eRwv
 YskAxAbuf+UFapSW0PO3cLhrOGG0i3GX3mc/V4qIr6IHIq0PwNn8TCsVnhYubkWltDhn
 KRrSMbaRWyaTOcTzDHserKk+M/tlxq03pwu1V5PBzWdPpPyWJOIuE3ol28LYfsBdmZrr
 Wl7n9ZZ5qlmHeKW9tFAiGHhk1XJrRBZ84umnjUxCb5073DeyUIeXyvZdrCgXI+GvwdGE
 NwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M/HVPJJsarEjIjVx4H78Iqo7kCS5rt82H++LHRaHDJU=;
 b=CViV1FULxQZYy2de/c/xeeNomGVCx2LliUYTsRRblp9E12VyArRBKBlVtyw0AAGRwG
 iZKPbDbfoZq/IIPBncpxBf/wSFJHVsJIa12MBCB3j+naXQnBY8qALnPCxOWplGRXa4SA
 l4Js14V9ucR3f1j4OS0LkLPTsTGlyx6eOxpZ69xJhBi+LFugSd8/Cchodj4XGhmJLAWK
 D36dUIjExxUybNCEPOmT1eLiCKzd31X0gDLn2NlBZy2f3qrdQFNN9AEu3i8fzkzDguZZ
 ICq2npqj8/ENjAzBVnbQi40kwZS8/cPQ3JWvzUe4RqI457+E4DahoVEGnTIhAHSgBqfl
 t8IQ==
X-Gm-Message-State: AGi0PuYVxX6sPa/FUuFl0IqHb+eyeYmRr8JrJD2aYrQh+2eNnWFPqT1W
 /sS4lgNvNjo7nWw1ZvJTp9gLvyH6j1T8YA==
X-Google-Smtp-Source: APiQypJrScLC4ti9F1XL/xs9u8X+zVO11U1xzxM5ASC2IWCmQdVsJVsRFpVxabskQq4cGN3KKGDnSg==
X-Received: by 2002:a0c:da87:: with SMTP id z7mr3635295qvj.141.1588262300075; 
 Thu, 30 Apr 2020 08:58:20 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:7489:3328:3806:7c3])
 by smtp.gmail.com with ESMTPSA id v16sm305254qkf.80.2020.04.30.08.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 08:58:19 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/9] tests/vm: Add support for aarch64 VMs
Date: Thu, 30 Apr 2020 11:57:09 -0400
Message-Id: <20200430155718.212-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is version 5 of the patch series to 
add support for aarch64 VMs in the vm-build infrastructure.
 - Ubuntu 20.04 aarch64 VM
 - CentOS 8 aarch64 VM

v4: https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg03558.html

Changes in v5
- Updated the Ubuntu aarch64 VM from 18.04 to 20.04.
- Changed the creation of the flash drives to be silent to stdout.
- Changed handling of qemu_args from yaml file to preserve quoted strings.  
  This allows us to put something like this in the yaml as part of the 
  qemu_args, and preserve the quotes: -append "root=/dev/vda1 console=ttyAMA0"
- Fix issue in CentOS aarch64 VM where python was not set up.

Robert Foley (9):
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: add --boot-console switch
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  tests/vm: Add workaround to consume console

 configure                         |  25 +++
 python/qemu/console_socket.py     | 162 +++++++++++++++++
 python/qemu/machine.py            |  23 ++-
 tests/vm/Makefile.include         |  27 +++
 tests/vm/aarch64vm.py             | 105 +++++++++++
 tests/vm/basevm.py                | 282 ++++++++++++++++++++++++------
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 227 ++++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 ++++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +-
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           | 117 +++++++++++++
 15 files changed, 1098 insertions(+), 91 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64

-- 
2.17.1


