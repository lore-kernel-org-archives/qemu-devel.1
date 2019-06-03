Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7112C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9725923F2E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itYqi2QG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9725923F2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqp4-0007iQ-Px
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:32:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUX-0007X5-81
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUU-0004do-1O
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUR-0004Gj-MR
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id n9so477088wru.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=jNpy9tHxPkSPZ/2Idn45uExjC/vMdFuinTQ1rueNmsI=;
	b=itYqi2QG9kgnCmMYxUNUa/dPTJAQCTevI79mPsAy0otbzHsh06+w7nZbcYhbFkkX+f
	D1lrcjiNv1JlVV2TwzRpYAkmc3uJZQl+07Yk+kLTwuQHGkd09dh9pKcChBvxdKus/ult
	3rtqCLWetEiF4Zhtt8/U5+DvV7HKAlNfVisS83bOgytooERO0Kq6aCZrmO5yF2KZWszF
	LbW6IFj5ywh1iQLyYmnq6dFKOXeh9s8ql18gkVGmoAiia9TxQXTZxXnZ4f5Wnt+e2qXf
	dyt3nT++BGZ5oZ7lGaHY8TFpNvsa0/1rMqZCrJvW9j7mj7LJcayyB5GgXBVRMmK7Q+Ga
	s4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=jNpy9tHxPkSPZ/2Idn45uExjC/vMdFuinTQ1rueNmsI=;
	b=dB5TLH0ZgSzkYkp0jSaCHbvbLi99/o+7Z/YmNo8h1vUB//192gJ+l447fjlQHEDDJB
	T2X7I5sWpq0FzAKhyY2GUy6YrOCZqNXwLUBDcsvT0/XqTwJJRFz8aToAluJF9byR/rKW
	u37IcPO6Gie0RUydRancbJ6LEhM9zLP709TxQwiTEc4F4+w5KX75yuZBHJFD7tRVzE+0
	Vlj5OaxGOKyzYrlGVXZkjiMg8h8rFaZmHEPgRp6Ml8MZVTcV4qCX4n6v4HbBzLLUf6TA
	vzqdu6W5p31k3gMvLhoh2mcxPu1LhnCs0sePjc7V94e/mPcBQKOTbXo41Crad6lLBtrW
	VtwA==
X-Gm-Message-State: APjAAAUPwLb7lMhQHix8K3PbjbV6ytBBbcmyBIYfWOZ6VWBOSgvI9Syd
	8PHxCyNRmd/fSuROGFCtG09md+Mv
X-Google-Smtp-Source: APXvYqyeTRDUo1NPrvbpujwcDdsezWbYOWEK4OWW4D14kK36+Iv0eByLGXixlBFei6vex4FAR4vViw==
X-Received: by 2002:adf:f14a:: with SMTP id y10mr3389310wro.183.1559581868403; 
	Mon, 03 Jun 2019 10:11:08 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:41 +0200
Message-Id: <1559581843-3968-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 22/24] ci: store Patchew configuration in the
 tree
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

Patchew cannot yet retrieve the configuration from the QEMU Git tree, but
this is planned.  In the meanwhile, let's start storing it as YAML
so that the Patchew configuration (currently accessible only to administrators)
is public and documented.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .patchew.yml | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)
 create mode 100644 .patchew.yml

diff --git a/.patchew.yml b/.patchew.yml
new file mode 100644
index 0000000..988c292
--- /dev/null
+++ b/.patchew.yml
@@ -0,0 +1,302 @@
+---
+# Note: this file is still unused.  It serves as a documentation for the
+# Patchew configuration in case patchew.org disappears or has to be
+# reinstalled.
+#
+# Patchew configuration is available to project administrators at
+# https://patchew.org/api/v1/projects/1/config/ and can be configured
+# to YAML using the following Python script:
+#
+#     import json
+#     import sys
+#     import ruamel.yaml
+#
+#     json_str = sys.stdin.read()
+#     yaml = ruamel.yaml.YAML()
+#     yaml.explicit_start = True
+#     data = json.loads(json_str, object_pairs_hook=ruamel.yaml.comments.CommentedMap)
+#     ruamel.yaml.scalarstring.walk_tree(data)
+#     yaml.dump(data, sys.stdout)
+
+email:
+  notifications:
+    timeouts:
+      event: TestingReport
+      enabled: true
+      to_user: false
+      reply_subject: true
+      set_reply_to: true
+      in_reply_to: true
+      reply_to_all: false
+      subject_template: none
+      to: fam@euphon.net
+      cc: ''
+      body_template: |
+        {% if not is_timeout %} {{ cancel }} {% endif %}
+
+        Test '{{ test }}' timeout, log:
+
+        {{ log }}
+    ENOSPC:
+      event: TestingReport
+      enabled: true
+      to_user: false
+      reply_subject: false
+      set_reply_to: false
+      in_reply_to: true
+      reply_to_all: false
+      subject_template: Out of space error
+      to: fam@euphon.net
+      cc: ''
+      body_template: |
+        {% if passed %}
+          {{ cancel }}
+        {% endif %}
+
+        {% if 'No space left on device' in log %}
+        Tester {{ tester }} out of space when running {{ test }}
+
+          {{ log }}
+        {% else %}
+          {{ cancel }}
+        {% endif %}
+    FailureShort:
+      event: TestingReport
+      enabled: true
+      to_user: false
+      reply_subject: true
+      set_reply_to: true
+      in_reply_to: true
+      reply_to_all: true
+      subject_template: Testing failed
+      to: ''
+      cc: ''
+      body_template: |
+        {% if passed or not obj.message_id or is_timeout %}
+          {{ cancel }}
+        {% endif %}
+        {% if 'No space left on device' in log %}
+          {{ cancel }}
+        {% endif %}
+        Patchew URL: https://patchew.org/QEMU/{{ obj.message_id }}/
+
+        {% ansi2text log as logtext %}
+        {% if test == "checkpatch" %}
+        Hi,
+
+        This series seems to have some coding style problems. See output below for
+        more information:
+
+        {{ logtext }}
+        {% elif test == "docker-mingw@fedora" or test == "docker-quick@centos7" or test == "asan" %}
+        Hi,
+
+        This series failed the {{ test }} build test. Please find the testing commands and
+        their output below. If you have Docker installed, you can probably reproduce it
+        locally.
+
+        {% lines_between logtext start="^=== TEST SCRIPT BEGIN ===$" stop="^=== TEST SCRIPT END ===$" %}
+        {% lines_between logtext start="^=== OUTPUT BEGIN ===$" stop="=== OUTPUT END ===$" as output %}
+        {% grep_C output regex="\b(FAIL|XPASS|ERROR|WARN|error:|warning:)" n=3 %}
+        {% elif test == "s390x" or test == "FreeBSD" or test == "ppcle" or test == "ppcbe" %}
+        Hi,
+
+        This series failed build test on {{test}} host. Please find the details below.
+
+        {% lines_between logtext start="^=== TEST SCRIPT BEGIN ===$" stop="^=== TEST SCRIPT END ===$" %}
+        {% lines_between logtext start="^=== OUTPUT BEGIN ===$" stop="=== OUTPUT END ===$" as output %}
+        {% grep_C output regex="\b(FAIL|XPASS|ERROR|WARN|error:|warning:)" n=3 %}
+        {% else %}
+        {{ cancel }}
+        {% endif %}
+
+        The full log is available at
+        {{ log_url }}.
+        ---
+        Email generated automatically by Patchew [https://patchew.org/].
+        Please send your feedback to patchew-devel@redhat.com
+testing:
+  tests:
+    asan:
+      enabled: true
+      requirements: docker
+      timeout: 3600
+      script: |
+        #!/bin/bash
+        time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
+    docker-quick@centos7:
+      enabled: false
+      requirements: docker,x86_64
+      timeout: 3600
+      script: |
+        #!/bin/bash
+        time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
+    checkpatch:
+      enabled: true
+      requirements: ''
+      timeout: 600
+      script: |
+        #!/bin/bash
+        git rev-parse base > /dev/null || exit 0
+        git config --local diff.renamelimit 0
+        git config --local diff.renames True
+        git config --local diff.algorithm histogram
+        ./scripts/checkpatch.pl --mailback base..
+    docker-mingw@fedora:
+      enabled: true
+      requirements: docker,x86_64
+      timeout: 3600
+      script: |
+        #! /bin/bash
+        test "$(uname -m)" = "x86_64"
+    ppcle:
+      enabled: false
+      requirements: ppcle
+      timeout: 3600
+      script: |
+        #!/bin/bash
+        # Testing script will be invoked under the git checkout with
+        # HEAD pointing to a commit that has the patches applied on top of "base"
+        # branch
+        set -e
+        CC=$HOME/bin/cc
+        INSTALL=$PWD/install
+        BUILD=$PWD/build
+        mkdir -p $BUILD $INSTALL
+        SRC=$PWD
+        cd $BUILD
+        $SRC/configure --cc=$CC --prefix=$INSTALL
+        make -j4
+        # XXX: we need reliable clean up
+        # make check -j4 V=1
+        make install
+
+        echo
+        echo "=== ENV ==="
+        env
+
+        echo
+        echo "=== PACKAGES ==="
+        rpm -qa
+    ppcbe:
+      enabled: false
+      requirements: ppcbe
+      timeout: 3600
+      script: |
+        #!/bin/bash
+        # Testing script will be invoked under the git checkout with
+        # HEAD pointing to a commit that has the patches applied on top of "base"
+        # branch
+        set -e
+        CC=$HOME/bin/cc
+        INSTALL=$PWD/install
+        BUILD=$PWD/build
+        mkdir -p $BUILD $INSTALL
+        SRC=$PWD
+        cd $BUILD
+        $SRC/configure --cc=$CC --prefix=$INSTALL
+        make -j4
+        # XXX: we need reliable clean up
+        # make check -j4 V=1
+        make install
+
+        echo
+        echo "=== ENV ==="
+        env
+
+        echo
+        echo "=== PACKAGES ==="
+        rpm -qa
+    FreeBSD:
+      enabled: true
+      requirements: qemu-x86,x86_64,git
+      timeout: 3600
+      script: |
+        #!/bin/bash
+        # Testing script will be invoked under the git checkout with
+        # HEAD pointing to a commit that has the patches applied on top of "base"
+        # branch
+        if qemu-system-x86_64 --help >/dev/null 2>&1; then
+          QEMU=qemu-system-x86_64
+        elif /usr/libexec/qemu-kvm --help >/dev/null 2>&1; then
+          QEMU=/usr/libexec/qemu-kvm
+        else
+          exit 1
+        fi
+        make vm-build-freebsd J=21 QEMU=$QEMU
+        exit 0
+    docker-clang@ubuntu:
+      enabled: true
+      requirements: docker,x86_64
+      timeout: 3600
+      script: |
+        #!/bin/bash
+        time make docker-test-clang@ubuntu SHOW_ENV=1 J=14 NETWORK=1
+    s390x:
+      enabled: true
+      requirements: s390x
+      timeout: 3600
+      script: |
+        #!/bin/bash
+        # Testing script will be invoked under the git checkout with
+        # HEAD pointing to a commit that has the patches applied on top of "base"
+        # branch
+        set -e
+        CC=$HOME/bin/cc
+        INSTALL=$PWD/install
+        BUILD=$PWD/build
+        mkdir -p $BUILD $INSTALL
+        SRC=$PWD
+        cd $BUILD
+        $SRC/configure --cc=$CC --prefix=$INSTALL
+        make -j4
+        # XXX: we need reliable clean up
+        # make check -j4 V=1
+        make install
+
+        echo
+        echo "=== ENV ==="
+        env
+
+        echo
+        echo "=== PACKAGES ==="
+        rpm -qa
+  requirements:
+    x86_64:
+      script: |
+        #! /bin/bash
+        test "$(uname -m)" = "x86_64"
+    qemu-x86:
+      script: |
+        #!/bin/bash
+        if qemu-system-x86_64 --help >/dev/null 2>&1; then
+          :
+        elif /usr/libexec/qemu-kvm --help >/dev/null 2>&1; then
+          :
+        else
+          exit 1
+        fi
+    ppcle:
+      script: |
+        #!/bin/bash
+        test "$(uname -m)" = "ppc64le"
+    ppcbe:
+      script: |
+        #!/bin/bash
+        test "$(uname -m)" = "ppc64"
+    git:
+      script: |
+        #! /bin/bash
+        git config user.name > /dev/null 2>&1
+    docker:
+      script: |
+        #!/bin/bash
+        docker ps || sudo -n docker ps
+    s390x:
+      script: |
+        #!/bin/bash
+        test "$(uname -m)" = "s390x"
+git:
+  push_to: git@github.com:patchew-project/qemu
+  public_repo: https://github.com/patchew-project/qemu
+  url_template: https://github.com/patchew-project/qemu/tree/%t
-- 
1.8.3.1



