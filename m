Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B1C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0A9208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukyub8OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0A9208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLGk-0003EW-06
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLG4-0002ZR-5Y; Mon, 07 Sep 2020 13:48:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:52181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLG1-0000KB-BD; Mon, 07 Sep 2020 13:48:47 -0400
Received: by mail-pj1-x1034.google.com with SMTP id a9so3809638pjg.1;
 Mon, 07 Sep 2020 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bcR6KqjaA/LUSrkPYJg7y52yR0MbnvsmmNCmafodfc8=;
 b=ukyub8OUasqXd0ScXfdwuiJm3q++lagY2P/yvOgv5pyaUAsvsKFYmEXXe8/RgqIA+3
 rkomiFmq/TFivSgGMTdIdYk0iWrL1pvFMWF0CedeH5fCrah/I0pp1SC7rzsInkRJcLKJ
 crsCjkD6cge5KuNDT4v8srQoNgt203db4w3TNnolE1Ks/6fj0bmjekcyvLo7OvXJ7tAe
 vbGFF9p1xArzjEGi0syzBwv1xNNJpDDiwNapt/FBv37CYollGouARuz+pjEuLG+Xnuti
 oW7Um0hCdpysqQBUtbfYZyBybbVPv7qUydfr8FvG1gH6kpJW3YkltC1EvrfuCau5yaFt
 iQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bcR6KqjaA/LUSrkPYJg7y52yR0MbnvsmmNCmafodfc8=;
 b=a+FZuY9XN1nr/4B4h1w1FEffou4e0TptXRjK5a8E+NuGwiD12CKcfHHaRbta9P4kk8
 rSsAmmGmFe0QEZu7yWVcLrx4W3indjCfXED8drmetbNAWcnf3RNX52c39owmOfPMpf5Y
 vse/4vVyWpKR3e7K9Gb2fP3BZ0VLsnrgH5BW+4MUqRjwqS8KFKz2q9yAA4JG0gZeY3HX
 d7PhTiUpAObT6X/PBTJUFfCYcR0Sd1P/RGES1QuR4lqFbDg1vX+82LBLZYHqn+52dnBI
 keIFeFBewC1Wo+on4kpe3lrioOgzdlIoIMCOhZzJeSpbfm8iHp4ctPHEGXtrS3rG2MWz
 F4Mw==
X-Gm-Message-State: AOAM5331jVe+1ZJfFfxFDfSKlB++wayx9KL403ALiMeXMPqsvWbroW5M
 IbtPkCpUmiWS+aJvvIx0x9hHhbQciAge/WT+
X-Google-Smtp-Source: ABdhPJyeV7D4VWcuaJDLT18ErN1crDIMd+OD+W6MlpfcNvVExZytZc/VKMBFhv/KemcoVTCWWOUN+A==
X-Received: by 2002:a17:90a:fa8b:: with SMTP id
 cu11mr383834pjb.10.1599500922769; 
 Mon, 07 Sep 2020 10:48:42 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 72sm15339307pfx.79.2020.09.07.10.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 10:48:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] meson: Use -b to ignore CR vs. CR-LF issues on Windows
Date: Tue,  8 Sep 2020 01:48:28 +0800
Message-Id: <20200907174828.1768-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Or the tests result would cause following test failure:
Running test QAPI doc
  LINK    tests/check-qdict.exe
--- C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/../cirrus-ci-build/tests/qapi-schema/doc-good.texi	2020-09-02 10:26:02.396028200 -0700
+++ C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/tests/qapi-schema/doc-good-qapi-doc.texi	2020-09-02 10:43:09.849568200 -0700
@@ -1,319 +1,319 @@
-@c AUTOMATICALLY GENERATED, DO NOT MODIFY
-
-@section Section
-
-@subsection Subsection
-
-@strong{strong} @emph{with emphasis}
-@code{var} @{in braces@}
-@itemize @bullet
-@item
-List item one
-@item
-Two, multiple
-lines
-
-@item
-Three
-Still in list
-
-@end itemize
-
-Not in list
-@itemize @minus
-@item
-Second list
-Note: still in list
-
-@end itemize
-
-Note: not in list
-@enumerate
-@item
-Third list
-is numbered
-
-@item
-another item
-
-@example
-example
-@end example
-
-@example
-multiple lines
-@end example
-
-
-@end enumerate
-
-Returns: the King
-Since: the first age
-Notes:
-
-@enumerate
-@item
-Lorem ipsum dolor sit amet
-
-@item
-Ut enim ad minim veniam
-
-@end enumerate
-
-Duis aute irure dolor
-
-Example:
-
--> in
-<- out
-Examples:
-@itemize @minus
-@item
-@strong{verbatim}
-@item
-@{braces@}
-@end itemize
-
-
-
-@deftp {Enum} Enum
-
-
-
-@b{Values:}
-@table @asis
-@item @code{one}
-The @emph{one} @{and only@}
-@*@b{If:} @code{defined(IFONE)}
-@item @code{two}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{enum-feat}
-Also @emph{one} @{and only@}
-@end table
-@code{two} is undocumented
-
-@b{If:} @code{defined(IFCOND)}
-@end deftp
-
-
-
-@deftp {Object} Base
-
-
-
-@b{Members:}
-@table @asis
-@item @code{base1: Enum}
-the first member
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant1
-
-A paragraph
-
-Another paragraph (but no @code{var}: line)
-
-@b{Members:}
-@table @asis
-@item @code{var1: string}
-Not documented
-@*@b{If:} @code{defined(IFSTR)}
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{variant1-feat}
-a feature
-@item @code{member-feat}
-a member feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant2
-
-
-
-@end deftp
-
-
-
-@deftp {Object} Object
-
-
-
-@b{Members:}
-@table @asis
-@item The members of @code{Base}
-@item The members of @code{Variant1} when @code{base1} is @t{"one"}
-@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{union-feat1}
-a feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} SugaredUnion
-
-
-
-@b{Members:}
-@table @asis
-@item @code{type}
-One of @t{"one"}, @t{"two"}
-@item @code{data: Variant1} when @code{type} is @t{"one"}
-@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{union-feat2}
-a feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Alternate} Alternate
-
-
-
-@b{Members:}
-@table @asis
-@item @code{i: int}
-an integer
-@code{b} is undocumented
-@item @code{b: boolean}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{alt-feat}
-a feature
-@end table
-
-@end deftp
-
-
-@subsection Another subsection
-
-
-@deftypefn Command {} cmd
-
-
-
-@b{Arguments:}
-@table @asis
-@item @code{arg1: int}
-the first argument
-@item @code{arg2: string} (optional)
-the second
-argument
-@item @code{arg3: boolean}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Note:}
-@code{arg3} is undocumented
-
-@b{Returns:}
-@code{Object}
-
-@b{TODO:}
-frobnicate
-
-@b{Notes:}
-@itemize @minus
-@item
-Lorem ipsum dolor sit amet
-@item
-Ut enim ad minim veniam
-
-@end itemize
-
-Duis aute irure dolor
-
-@b{Example:}
-@example
--> in
-<- out
-@end example
-
-@b{Examples:}
-@example
-- *verbatim*
-- @{braces@}
-@end example
-
-@b{Since:}
-2.10
-
-@end deftypefn
-
-
-
-@deftypefn Command {} cmd-boxed
-
-If you're bored enough to read this, go see a video of boxed cats
-
-@b{Arguments:} the members of @code{Object}
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Example:}
-@example
--> in
-
-<- out
-@end example
-
-@end deftypefn
-
-
-
-@deftypefn Event {} EVT-BOXED
-
-
-
-@b{Arguments:} the members of @code{Object}
-
-@b{Features:}
-@table @asis
-@item @code{feat3}
-a feature
-@end table
-
-@end deftypefn
-
+@c AUTOMATICALLY GENERATED, DO NOT MODIFY
+
+@section Section
+
+@subsection Subsection
+
+@strong{strong} @emph{with emphasis}
+@code{var} @{in braces@}
+@itemize @bullet
+@item
+List item one
+@item
+Two, multiple
+lines
+
+@item
+Three
+Still in list
+
+@end itemize
+
+Not in list
+@itemize @minus
+@item
+Second list
+Note: still in list
+
+@end itemize
+
+Note: not in list
+@enumerate
+@item
+Third list
+is numbered
+
+@item
+another item
+
+@example
+example
+@end example
+
+@example
+multiple lines
+@end example
+
+
+@end enumerate
+
+Returns: the King
+Since: the first age
+Notes:
+
+@enumerate
+@item
+Lorem ipsum dolor sit amet
+
+@item
+Ut enim ad minim veniam
+
+@end enumerate
+
+Duis aute irure dolor
+
+Example:
+
+-> in
+<- out
+Examples:
+@itemize @minus
+@item
+@strong{verbatim}
+@item
+@{braces@}
+@end itemize
+
+
+
+@deftp {Enum} Enum
+
+
+
+@b{Values:}
+@table @asis
+@item @code{one}
+The @emph{one} @{and only@}
+@*@b{If:} @code{defined(IFONE)}
+@item @code{two}
+Not documented
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{enum-feat}
+Also @emph{one} @{and only@}
+@end table
+@code{two} is undocumented
+
+@b{If:} @code{defined(IFCOND)}
+@end deftp
+
+
+
+@deftp {Object} Base
+
+
+
+@b{Members:}
+@table @asis
+@item @code{base1: Enum}
+the first member
+@end table
+
+@end deftp
+
+
+
+@deftp {Object} Variant1
+
+A paragraph
+
+Another paragraph (but no @code{var}: line)
+
+@b{Members:}
+@table @asis
+@item @code{var1: string}
+Not documented
+@*@b{If:} @code{defined(IFSTR)}
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{variant1-feat}
+a feature
+@item @code{member-feat}
+a member feature
+@end table
+
+@end deftp
+
+
+
+@deftp {Object} Variant2
+
+
+
+@end deftp
+
+
+
+@deftp {Object} Object
+
+
+
+@b{Members:}
+@table @asis
+@item The members of @code{Base}
+@item The members of @code{Variant1} when @code{base1} is @t{"one"}
+@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{If:} @code{IFTWO})
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{union-feat1}
+a feature
+@end table
+
+@end deftp
+
+
+
+@deftp {Object} SugaredUnion
+
+
+
+@b{Members:}
+@table @asis
+@item @code{type}
+One of @t{"one"}, @t{"two"}
+@item @code{data: Variant1} when @code{type} is @t{"one"}
+@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code{IFTWO})
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{union-feat2}
+a feature
+@end table
+
+@end deftp
+
+
+
+@deftp {Alternate} Alternate
+
+
+
+@b{Members:}
+@table @asis
+@item @code{i: int}
+an integer
+@code{b} is undocumented
+@item @code{b: boolean}
+Not documented
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{alt-feat}
+a feature
+@end table
+
+@end deftp
+
+
+@subsection Another subsection
+
+
+@deftypefn Command {} cmd
+
+
+
+@b{Arguments:}
+@table @asis
+@item @code{arg1: int}
+the first argument
+@item @code{arg2: string} (optional)
+the second
+argument
+@item @code{arg3: boolean}
+Not documented
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{cmd-feat1}
+a feature
+@item @code{cmd-feat2}
+another feature
+@end table
+
+@b{Note:}
+@code{arg3} is undocumented
+
+@b{Returns:}
+@code{Object}
+
+@b{TODO:}
+frobnicate
+
+@b{Notes:}
+@itemize @minus
+@item
+Lorem ipsum dolor sit amet
+@item
+Ut enim ad minim veniam
+
+@end itemize
+
+Duis aute irure dolor
+
+@b{Example:}
+@example
+-> in
+<- out
+@end example
+
+@b{Examples:}
+@example
+- *verbatim*
+- @{braces@}
+@end example
+
+@b{Since:}
+2.10
+
+@end deftypefn
+
+
+
+@deftypefn Command {} cmd-boxed
+
+If you're bored enough to read this, go see a video of boxed cats
+
+@b{Arguments:} the members of @code{Object}
+
+@b{Features:}
+@table @asis
+@item @code{cmd-feat1}
+a feature
+@item @code{cmd-feat2}
+another feature
+@end table
+
+@b{Example:}
+@example
+-> in
+
+<- out
+@end example
+
+@end deftypefn
+
+
+
+@deftypefn Event {} EVT-BOXED
+
+
+
+@b{Arguments:} the members of @code{Object}
+
+@b{Features:}
+@table @asis
+@item @code{feat3}
+a feature
+@end table
+
+@end deftypefn
+
make: *** [Makefile.mtest:85: check-qapi-doc] Error 1
make: *** Waiting for unfinished jobs....
Running test QAPI doc
--- C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/../cirrus-ci-build/tests/qapi-schema/doc-good.texi	2020-09-02 10:26:02.396028200 -0700
+++ C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/tests/qapi-schema/doc-good-qapi-doc.texi	2020-09-02 10:43:09.849568200 -0700
@@ -1,319 +1,319 @@
-@c AUTOMATICALLY GENERATED, DO NOT MODIFY
-
-@section Section
-
-@subsection Subsection
-
-@strong{strong} @emph{with emphasis}
-@code{var} @{in braces@}
-@itemize @bullet
-@item
-List item one
-@item
-Two, multiple
-lines
-
-@item
-Three
-Still in list
-
-@end itemize
-
-Not in list
-@itemize @minus
-@item
-Second list
-Note: still in list
-
-@end itemize
-
-Note: not in list
-@enumerate
-@item
-Third list
-is numbered
-
-@item
-another item
-
-@example
-example
-@end example
-
-@example
-multiple lines
-@end example
-
-
-@end enumerate
-
-Returns: the King
-Since: the first age
-Notes:
-
-@enumerate
-@item
-Lorem ipsum dolor sit amet
-
-@item
-Ut enim ad minim veniam
-
-@end enumerate
-
-Duis aute irure dolor
-
-Example:
-
--> in
-<- out
-Examples:
-@itemize @minus
-@item
-@strong{verbatim}
-@item
-@{braces@}
-@end itemize
-
-
-
-@deftp {Enum} Enum
-
-
-
-@b{Values:}
-@table @asis
-@item @code{one}
-The @emph{one} @{and only@}
-@*@b{If:} @code{defined(IFONE)}
-@item @code{two}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{enum-feat}
-Also @emph{one} @{and only@}
-@end table
-@code{two} is undocumented
-
-@b{If:} @code{defined(IFCOND)}
-@end deftp
-
-
-
-@deftp {Object} Base
-
-
-
-@b{Members:}
-@table @asis
-@item @code{base1: Enum}
-the first member
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant1
-
-A paragraph
-
-Another paragraph (but no @code{var}: line)
-
-@b{Members:}
-@table @asis
-@item @code{var1: string}
-Not documented
-@*@b{If:} @code{defined(IFSTR)}
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{variant1-feat}
-a feature
-@item @code{member-feat}
-a member feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant2
-
-
-
-@end deftp
-
-
-
-@deftp {Object} Object
-
-
-
-@b{Members:}
-@table @asis
-@item The members of @code{Base}
-@item The members of @code{Variant1} when @code{base1} is @t{"one"}
-@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{union-feat1}
-a feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} SugaredUnion
-
-
-
-@b{Members:}
-@table @asis
-@item @code{type}
-One of @t{"one"}, @t{"two"}
-@item @code{data: Variant1} when @code{type} is @t{"one"}
-@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{union-feat2}
-a feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Alternate} Alternate
-
-
-
-@b{Members:}
-@table @asis
-@item @code{i: int}
-an integer
-@code{b} is undocumented
-@item @code{b: boolean}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{alt-feat}
-a feature
-@end table
-
-@end deftp
-
-
-@subsection Another subsection
-
-
-@deftypefn Command {} cmd
-
-
-
-@b{Arguments:}
-@table @asis
-@item @code{arg1: int}
-the first argument
-@item @code{arg2: string} (optional)
-the second
-argument
-@item @code{arg3: boolean}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Note:}
-@code{arg3} is undocumented
-
-@b{Returns:}
-@code{Object}
-
-@b{TODO:}
-frobnicate
-
-@b{Notes:}
-@itemize @minus
-@item
-Lorem ipsum dolor sit amet
-@item
-Ut enim ad minim veniam
-
-@end itemize
-
-Duis aute irure dolor
-
-@b{Example:}
-@example
--> in
-<- out
-@end example
-
-@b{Examples:}
-@example
-- *verbatim*
-- @{braces@}
-@end example
-
-@b{Since:}
-2.10
-
-@end deftypefn
-
-
-
-@deftypefn Command {} cmd-boxed
-
-If you're bored enough to read this, go see a video of boxed cats
-
-@b{Arguments:} the members of @code{Object}
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Example:}
-@example
--> in
-
-<- out
-@end example
-
-@end deftypefn
-
-
-
-@deftypefn Event {} EVT-BOXED
-
-
-
-@b{Arguments:} the members of @code{Object}
-
-@b{Features:}
-@table @asis
-@item @code{feat3}
-a feature
-@end table
-
-@end deftypefn
-
+@c AUTOMATICALLY GENERATED, DO NOT MODIFY
+
+@section Section
+
+@subsection Subsection
+
+@strong{strong} @emph{with emphasis}
+@code{var} @{in braces@}
+@itemize @bullet
+@item
+List item one
+@item
+Two, multiple
+lines
+
+@item
+Three
+Still in list
+
+@end itemize
+
+Not in list
+@itemize @minus
+@item
+Second list
+Note: still in list
+
+@end itemize
+
+Note: not in list
+@enumerate
+@item
+Third list
+is numbered
+
+@item
+another item
+
+@example
+example
+@end example
+
+@example
+multiple lines
+@end example
+
+
+@end enumerate
+
+Returns: the King
+Since: the first age
+Notes:
+
+@enumerate
+@item
+Lorem ipsum dolor sit amet
+
+@item
+Ut enim ad minim veniam
+
+@end enumerate
+
+Duis aute irure dolor
+
+Example:
+
+-> in
+<- out
+Examples:
+@itemize @minus
+@item
+@strong{verbatim}
+@item
+@{braces@}
+@end itemize
+
+
+
+@deftp {Enum} Enum
+
+
+
+@b{Values:}
+@table @asis
+@item @code{one}
+The @emph{one} @{and only@}
+@*@b{If:} @code{defined(IFONE)}
+@item @code{two}
+Not documented
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{enum-feat}
+Also @emph{one} @{and only@}
+@end table
+@code{two} is undocumented
+
+@b{If:} @code{defined(IFCOND)}
+@end deftp
+
+
+
+@deftp {Object} Base
+
+
+
+@b{Members:}
+@table @asis
+@item @code{base1: Enum}
+the first member
+@end table
+
+@end deftp
+
+
+
+@deftp {Object} Variant1
+
+A paragraph
+
+Another paragraph (but no @code{var}: line)
+
+@b{Members:}
+@table @asis
+@item @code{var1: string}
+Not documented
+@*@b{If:} @code{defined(IFSTR)}
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{variant1-feat}
+a feature
+@item @code{member-feat}
+a member feature
+@end table
+
+@end deftp
+
+
+
+@deftp {Object} Variant2
+
+
+
+@end deftp
+
+
+
+@deftp {Object} Object
+
+
+
+@b{Members:}
+@table @asis
+@item The members of @code{Base}
+@item The members of @code{Variant1} when @code{base1} is @t{"one"}
+@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{If:} @code{IFTWO})
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{union-feat1}
+a feature
+@end table
+
+@end deftp
+
+
+
+@deftp {Object} SugaredUnion
+
+
+
+@b{Members:}
+@table @asis
+@item @code{type}
+One of @t{"one"}, @t{"two"}
+@item @code{data: Variant1} when @code{type} is @t{"one"}
+@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code{IFTWO})
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{union-feat2}
+a feature
+@end table
+
+@end deftp
+
+
+
+@deftp {Alternate} Alternate
+
+
+
+@b{Members:}
+@table @asis
+@item @code{i: int}
+an integer
+@code{b} is undocumented
+@item @code{b: boolean}
+Not documented
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{alt-feat}
+a feature
+@end table
+
+@end deftp
+
+
+@subsection Another subsection
+
+
+@deftypefn Command {} cmd
+
+
+
+@b{Arguments:}
+@table @asis
+@item @code{arg1: int}
+the first argument
+@item @code{arg2: string} (optional)
+the second
+argument
+@item @code{arg3: boolean}
+Not documented
+@end table
+
+@b{Features:}
+@table @asis
+@item @code{cmd-feat1}
+a feature
+@item @code{cmd-feat2}
+another feature
+@end table
+
+@b{Note:}
+@code{arg3} is undocumented
+
+@b{Returns:}
+@code{Object}
+
+@b{TODO:}
+frobnicate
+
+@b{Notes:}
+@itemize @minus
+@item
+Lorem ipsum dolor sit amet
+@item
+Ut enim ad minim veniam
+
+@end itemize
+
+Duis aute irure dolor
+
+@b{Example:}
+@example
+-> in
+<- out
+@end example
+
+@b{Examples:}
+@example
+- *verbatim*
+- @{braces@}
+@end example
+
+@b{Since:}
+2.10
+
+@end deftypefn
+
+
+
+@deftypefn Command {} cmd-boxed
+
+If you're bored enough to read this, go see a video of boxed cats
+
+@b{Arguments:} the members of @code{Object}
+
+@b{Features:}
+@table @asis
+@item @code{cmd-feat1}
+a feature
+@item @code{cmd-feat2}
+another feature
+@end table
+
+@b{Example:}
+@example
+-> in
+
+<- out
+@end example
+
+@end deftypefn
+
+
+
+@deftypefn Event {} EVT-BOXED
+
+
+
+@b{Arguments:} the members of @code{Object}
+
+@b{Features:}
+@table @asis
+@item @code{feat3}
+a feature
+@end table
+
+@end deftypefn
+
make: *** [Makefile.mtest:63: check-qapi-schema] Error 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qapi-schema/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..f1449298b0 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -220,6 +220,6 @@ qapi_doc = custom_target('QAPI doc',
 
 # "full_path()" needed here to work around
 # https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
-- 
2.28.0.windows.1


