Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA26C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52766206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qA9JkOcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52766206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqlL-0001K9-Dv
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVa-0006no-0h
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVX-0006px-BR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id v12so3932482wmh.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KVVuW3PO55zfdvToP+0jRG2qg+98RNhIlL0hnILKI6I=;
 b=qA9JkOcCC6Gq25FojZ6HoRs9QvsrqA8jpoSWBhFIJnpgedjyTd3FLPlsQZtGElwocQ
 u4EVy/n5NbRf3B6VV9r18N5uI0DMa4HYV3SKMSLhRUZKcGPDK+3+l7WPtWtQkuSY1wF0
 LScE6QlmKxzxqAFaVh27Ey+emGQTs8mNTCjYwLP9p3t3qZmrYN9pjEREqv78jnbwTt3v
 +3FCdNXJXUU9MO8mHq7SaIjEUfGVKwNXbHEFINDHdMnMC45bbIbcB8HoMUkRTgBLn/mi
 prBIDwi5VGviah/MJ1rcxRm3O6HfrEMHiEKrj8v6RWzoDBMQhMnwbNkhEVUYAJyiTpdr
 QB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KVVuW3PO55zfdvToP+0jRG2qg+98RNhIlL0hnILKI6I=;
 b=C0lrOWvHtDdOSGKHgaTCf2Qms2VqdxaA3x3Y19sYPLzG1O5jiLhtAOZZSImzkPTGxZ
 6vbd9Z91L2FI6zgJBozc8Nl+v3auAEeMuftFb3h261yvZT4o9X9bWmQFfqAlEe+zGmYd
 uB9ztiTYozgE6lj29/Musqo0KW+Ql1QCGulG2PAMm+14m/sF4tLRG72oF+7TigN83bVL
 ELeNRX8MPfWoRugWb5MJ4n29mDvJmvwi2o/ZCY99PxtnRU3eik8eVwClXpdvZh1n/hKo
 JdfotttuKX/44rzuQGipGQcN5gA6Fi8Ly7BY/cGaCEtkDv8Pz6KkkSqoFsmboZxQuRA9
 VppQ==
X-Gm-Message-State: AOAM531Zr5kC9MQmYtT+gWasshXQUZ1JTwAFP33tYnv9GQdI4V5jp2HK
 8VZPhXtPFqCbN8Rhy92/z8Ym2DfeI9MYakiF
X-Google-Smtp-Source: ABdhPJy4zgNme3wSMP2iF40f1MpkUDOpwN/zgVFjbSiXqPNytebTK07qPxzOxdCY+j1zTgPyN44TDQ==
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr3978841wmg.92.1601051016312; 
 Fri, 25 Sep 2020 09:23:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/21] tests/qapi-schema: Add test of the rST QAPI
 doc-comment outputn
Date: Fri, 25 Sep 2020 17:23:10 +0100
Message-Id: <20200925162316.21205-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test of the rST output from the QAPI doc-comment generator,
similar to what we currently have that tests the Texinfo output.

This is a bit more awkward with Sphinx, because the generated
output is not 100% under our control the way the QAPI-to-Texinfo
generator was. However, in practice Sphinx's plaintext output
generation has been identical between at least Sphinx 1.6 and
3.0, so we use that. (The HTML output has had changes across
versions). We use an exact-match comparison check, with the
understanding that perhaps changes in a future Sphinx version
might require us to implement something more clever to cope
with variation in the output.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The meson.build changes are remarkably clunky, but this
appears to be unavoidable...
---
 tests/qapi-schema/doc-good.rst |   5 +
 tests/qapi-schema/doc-good.txt | 288 +++++++++++++++++++++++++++++++++
 tests/qapi-schema/meson.build  |  55 +++++++
 3 files changed, 348 insertions(+)
 create mode 100644 tests/qapi-schema/doc-good.rst
 create mode 100644 tests/qapi-schema/doc-good.txt

diff --git a/tests/qapi-schema/doc-good.rst b/tests/qapi-schema/doc-good.rst
new file mode 100644
index 00000000000..1e4c23305a1
--- /dev/null
+++ b/tests/qapi-schema/doc-good.rst
@@ -0,0 +1,5 @@
+..
+   Test Sphinx manual that pulls in the test schema file. We will generate
+   a plain-text output file and compare it against a reference.
+
+.. qapi-doc:: tests/qapi-schema/doc-good.json
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
new file mode 100644
index 00000000000..6ca03d49d0d
--- /dev/null
+++ b/tests/qapi-schema/doc-good.txt
@@ -0,0 +1,288 @@
+Section
+*******
+
+
+Subsection
+==========
+
+*with emphasis* "var" {in braces}
+
+* List item one
+
+* Two, multiple lines
+
+* Three Still in list
+
+Not in list
+
+* Second list Note: still in list
+
+Note: not in list
+
+1. Third list is numbered
+
+2. another item
+
+Returns: the King Since: the first age Notes:
+
+1. Lorem ipsum dolor sit amet
+
+2. Ut enim ad minim veniam
+
+Duis aute irure dolor
+
+Example:
+
+-> in <- out Examples: - *verbatim* - {braces}
+
+
+"Enum" (Enum)
+-------------
+
+
+Values
+~~~~~~
+
+"one" (**If: **"defined(IFONE)")
+   The _one_ {and only}
+
+"two"
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"enum-feat"
+   Also _one_ {and only}
+
+"two" is undocumented
+
+
+If
+~~
+
+"defined(IFCOND)"
+
+
+"Base" (Object)
+---------------
+
+
+Members
+~~~~~~~
+
+"base1": "Enum"
+   the first member
+
+
+"Variant1" (Object)
+-------------------
+
+A paragraph
+
+Another paragraph (but no "var": line)
+
+
+Members
+~~~~~~~
+
+"var1": "string" (**If: **"defined(IFSTR)")
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"variant1-feat"
+   a feature
+
+"member-feat"
+   a member feature
+
+
+"Variant2" (Object)
+-------------------
+
+
+"Object" (Object)
+-----------------
+
+
+Members
+~~~~~~~
+
+The members of "Base"
+The members of "Variant1" when "base1" is ""one""
+The members of "Variant2" when "base1" is ""two"" (**If: **"IFTWO")
+
+Features
+~~~~~~~~
+
+"union-feat1"
+   a feature
+
+
+"SugaredUnion" (Object)
+-----------------------
+
+
+Members
+~~~~~~~
+
+"type"
+   One of "one", "two"
+
+"data": "Variant1" when "type" is ""one""
+"data": "Variant2" when "type" is ""two"" (**If: **"IFTWO")
+
+Features
+~~~~~~~~
+
+"union-feat2"
+   a feature
+
+
+"Alternate" (Alternate)
+-----------------------
+
+
+Members
+~~~~~~~
+
+"i": "int"
+   an integer "b" is undocumented
+
+"b": "boolean"
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"alt-feat"
+   a feature
+
+
+Another subsection
+==================
+
+
+"cmd" (Command)
+---------------
+
+
+Arguments
+~~~~~~~~~
+
+"arg1": "int"
+   the first argument
+
+"arg2": "string" (optional)
+   the second argument
+
+"arg3": "boolean"
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"cmd-feat1"
+   a feature
+
+"cmd-feat2"
+   another feature
+
+
+Note
+~~~~
+
+"arg3" is undocumented
+
+
+Returns
+~~~~~~~
+
+"Object"
+
+
+TODO
+~~~~
+
+frobnicate
+
+
+Notes
+~~~~~
+
+* Lorem ipsum dolor sit amet
+
+* Ut enim ad minim veniam
+
+Duis aute irure dolor
+
+
+Example
+~~~~~~~
+
+   -> in
+   <- out
+
+
+Examples
+~~~~~~~~
+
+   - *verbatim*
+   - {braces}
+
+
+Since
+~~~~~
+
+2.10
+
+
+"cmd-boxed" (Command)
+---------------------
+
+If you're bored enough to read this, go see a video of boxed cats
+
+
+Arguments
+~~~~~~~~~
+
+The members of "Object"
+
+Features
+~~~~~~~~
+
+"cmd-feat1"
+   a feature
+
+"cmd-feat2"
+   another feature
+
+
+Example
+~~~~~~~
+
+   -> in
+
+   <- out
+
+
+"EVT-BOXED" (Event)
+-------------------
+
+
+Arguments
+~~~~~~~~~
+
+The members of "Object"
+
+Features
+~~~~~~~~
+
+"feat3"
+   a feature
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 83a0a68389b..0c4a6a2936f 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -224,3 +224,58 @@ qapi_doc = custom_target('QAPI doc',
 test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
+
+# Test the document-comment document generation code by running a test schema
+# file through Sphinx's plain-text builder and comparing the result against
+# a golden reference. This is in theory susceptible to failures if Sphinx
+# changes its output, but the text output has historically been very stable
+# (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
+# texinfo or HTML generation, both of which have had changes. We might
+# need to add more sophisticated logic here in future for some sort of
+# fuzzy comparison if future Sphinx versions produce different text,
+# but for now the simple comparison suffices.
+qapi_doc_out = custom_target('QAPI rST doc',
+                             output: ['doc-good.txt'],
+                             input: files('doc-good.json', 'doc-good.rst'),
+                             build_by_default: build_docs,
+                             depend_files: sphinx_extn_depends,
+                             # We use -E to suppress Sphinx's caching, because
+                             # we want it to always really run the QAPI doc
+                             # generation code. It also means we don't
+                             # clutter up the build dir with the cache.
+                             command: [SPHINX_ARGS,
+                                       '-b', 'text', '-E',
+                                       '-c', meson.source_root() / 'docs',
+                                       '-D', 'master_doc=doc-good',
+                                       meson.current_source_dir(),
+                                       meson.current_build_dir()])
+
+# Fix possible inconsistency in line endings in generated output and
+# in the golden reference (which could otherwise cause test failures
+# on Windows hosts). Unfortunately diff --strip-trailing-cr
+# is GNU-diff only. The odd-looking perl is because we must avoid
+# using an explicit '\' character in the command arguments to
+# a custom_target(), as Meson will unhelpfully replace it with a '/'
+# (https://github.com/mesonbuild/meson/issues/1564)
+qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
+                                  output: ['doc-good.txt.nocr'],
+                                  input: qapi_doc_out[0],
+                                  build_by_default: build_docs,
+                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                  capture: true)
+
+qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
+                                  output: ['doc-good.ref.nocr'],
+                                  input: files('doc-good.txt'),
+                                  build_by_default: build_docs,
+                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                  capture: true)
+
+if build_docs
+  # "full_path()" needed here to work around
+  # https://github.com/mesonbuild/meson/issues/7585
+  test('QAPI rST doc', diff, args: ['-u', qapi_doc_ref_nocr[0].full_path(),
+                                    qapi_doc_out_nocr[0].full_path()],
+       depends: [qapi_doc_ref_nocr, qapi_doc_out_nocr],
+       suite: ['qapi-schema', 'qapi-doc'])
+endif
-- 
2.20.1


