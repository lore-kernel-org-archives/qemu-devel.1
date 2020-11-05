Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E3C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E44020739
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZsjebyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E44020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajX2-0003dv-9N
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQm-00048R-0X
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:16 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQh-0004pn-M1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id g12so2773431wrp.10
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uCs+X0itMjbvMk0yWT3IAMiCiy6to6triRO5oNOXhuI=;
 b=GZsjebyddibJv1BeSp1pS9QFQo75TKph+ojkOTGldmJpTWpQpB0xCwKLPzUu35aHAq
 BZ7t0eQaS1B0y60OgOCURv26JnJ2Ed2RQVDXJfrbaUK2NrweyK01M0W73OgN+e0rUOqj
 yIW9uhsjuzhYcU8yIU7rcNt3CJCJVN5mBJsQvdhQL4hjA2yRaUT2X3RJFIQBFRDUaZT5
 9FhzrrgMaeU+K4bP14ZlDHTbFmF+gY7eVdHLKFWXyYAe31KzmLMIkCIerrUIcniKvK3i
 XlwsPBchFOy7H0tAYOg+rSlLXQBc6JpHJ+a0mJg4SkXSW6sMBRZE9eXD7drmk0r3xlco
 VLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uCs+X0itMjbvMk0yWT3IAMiCiy6to6triRO5oNOXhuI=;
 b=oryLpeY5mUSzpnW6Wq/cDX/3fOhIzuAoZi6XSJSTyOYEHb4eMyTM3/mCuoIabYggbd
 /xA2cJnmdi6t4+ClUjFrElGN2bUkSQEHEcMerpeFnIdKfQXybCAVM2LGltEfuWuGGUlO
 WNZM8ei5D8zQGmzQ5YC9uBCYmHB3AOJg5KUwAwcBJw8jGmeuPc1i7HXpQSWkVg4ZhcfY
 xyvdirMtcKw7Fi1Pz5nPlMXQaGdZFJbbPyGKp87MLTGLlT7Rcfjzazv2PHMJh08bJmF9
 xe6a77WThsjsN5sprP5Y+XPXpvPB+wBAJOWfR7qKPZ4WCr49fMgOqTB72FZKFXG+I7Aq
 yypg==
X-Gm-Message-State: AOAM532rgh6WOaJh8lfqmiaB7ux9dpvn+oL/iE9+5f5nZU7LGRBmjvKj
 bbPxFmPgfsQZqhjtuW73VFxIOg==
X-Google-Smtp-Source: ABdhPJyyXmxG05QWc7n5bAtZC4+PYw3Z9KdzyXlJyfnL6oI7nVHVWB0PWgEEg2ZuU45fFV//a+jxvA==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr4263459wrs.127.1604598729939; 
 Thu, 05 Nov 2020 09:52:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h4sm3703532wrp.52.2020.11.05.09.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F7A91FF92;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  06/15] docs: add some documentation for the guest-loader
Date: Thu,  5 Nov 2020 17:51:44 +0000
Message-Id: <20201105175153.30489-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/guest-loader.rst | 54 ++++++++++++++++++++++++++++++++++++
 docs/system/index.rst        |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 docs/system/guest-loader.rst

diff --git a/docs/system/guest-loader.rst b/docs/system/guest-loader.rst
new file mode 100644
index 0000000000..37d03cbd89
--- /dev/null
+++ b/docs/system/guest-loader.rst
@@ -0,0 +1,54 @@
+..
+   Copyright (c) 2020, Linaro
+
+Guest Loader
+------------
+
+The guest loader is similar to the `generic-loader` although it is
+aimed at a particular use case of loading hypervisor guests. This is
+useful for debugging hypervisors without having to jump through the
+hoops of firmware and boot-loaders.
+
+The guest loader does two things:
+
+  - load blobs (kernels and initial ram disks) into memory
+  - sets platform FDT data so hypervisors can find and boot them
+
+This is what is typically done by a boot-loader like grub using it's
+multi-boot capability. A typical example would look like:
+
+.. parsed-literal::
+
+  |qemu_system| -kernel ~/xen.git/xen/xen \
+    -append "dom0_mem=1G,max:1G loglvl=all guest_loglvl=all" \
+    -device guest-loader,addr=0x42000000,kernel=Image,bootargs="root=/dev/sda2 ro console=hvc0 earlyprintk=xen" \
+    -device guest-loader,addr=0x47000000,initrd=rootfs.cpio
+
+In the above example the Xen hypervisor is loaded by the -kernel
+parameter and passed it's boot arguments via -append. The Dom0 guest
+is loaded into the areas of memory. Each blob will get
+`/chosen/module@<addr>` entry in the FDT to indicate it's location and
+size. Additional information can be passed with by using additional
+arguments.
+
+Currently the only supported machines which use FDT data to boot are
+the ARM and RiscV `virt` machines.
+
+Arguments
+^^^^^^^^^
+
+The full syntax of the guest-loader is::
+
+  -device guest-loader,addr=<addr>[,kernel=<file>,[bootargs=<args>]][,initrd=<file>]
+
+``addr=<addr>``
+  This is mandatory and indicates the start address of the blob.
+
+``kernel|initrd=<file>``
+  Indicates the filename of the kernel or initrd blob. Both blobs will
+  have the "multiboot,module" compatibility string as well as
+  "multiboot,kernel" or "multiboot,ramdisk" as appropriate.
+
+``bootargs=<args>``
+  This is an optional field for kernel blobs which will pass command
+  like via the `/chosen/module@<addr>/bootargs` node.
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 3cff0ca98f..b5cfe8ee93 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -25,6 +25,7 @@ Contents:
    ivshmem
    linuxboot
    generic-loader
+   guest-loader
    vnc-security
    tls
    gdb
-- 
2.20.1


