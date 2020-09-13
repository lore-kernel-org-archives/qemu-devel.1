Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47B7C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B3D20639
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PysrgOn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B3D20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHOuG-0001wa-BV
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 06:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kHOtB-0000bY-1i
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:05:41 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:41068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kHOt9-0002CY-8S
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:05:40 -0400
Received: by mail-ej1-x635.google.com with SMTP id lo4so19154899ejb.8
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C3CKsHFEXu9QF+enjHbXNt7O5KP6EoU9+3Nd9C1nI+E=;
 b=PysrgOn1KOoy+Rrr62V9LgwmznOkxMN4TRVVgETdjMwzSYbhgQ4oYSK29Oz9vEaLuu
 xrtsHWcrYCj9pnSpfg/rPFGfBDXxPktiaMcbNLIcN4bMwOkTGz2ap00B5NFrnlvY4IqB
 lhiYBp2e/K/fYVNHl3iKvDvFuS9b8vjr2G6kNKL8SWoOdZOlqtXbdsI9NQsOv4oSM8VE
 31ChV43kL2BhCW9pgXpbLJtFrP8ZqZ79sx4TfJRXb2ug2VjiJJz8arfeiFsUlQ8u/m+e
 ELg1WhcfeQfHRnBlARlN6jEEobVvQn+O3jQxOLXXWbkJlNe42hF2jD7i5MaADQenSX1Z
 xyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=C3CKsHFEXu9QF+enjHbXNt7O5KP6EoU9+3Nd9C1nI+E=;
 b=gRDeZ74vKvjhGcYWhAb9dv+AB5yYzdyapKbx3McPLg0L8TRXspAj7px7grB8O/SSEp
 qyvw2GbPsY/2rnLGbte8QZ5yw9zqeG82J1y5MOvIOSFWgMyfI7+sXvNKU0Q3x8DKkhuL
 XV+FNaLrV/KJKDoZ/LeOLpX7mhT9BlOBAgX2f5E9hs0KVre58hKGDMNz1u76EcaHD5Vq
 xTFEwrDS965TpGHWyPviWiq5S2g/dEfe1FTy8TzyTyQwXVHE0F0Gu97s/8qZ9LdArUSg
 g7lmX6XqouUr1Iog9T/AEX7WGGWSKadPl+KoIA2OaUDlq7VYQggfnKzjWWYpetAdKgvH
 YAag==
X-Gm-Message-State: AOAM530PX6XsZIUgfyShkaYfrZJbCXxIiBgv8mjj79gB5MsNslQlTPYv
 ejBorPpMatGVZXvrQolh8MP1JdHC4Sg=
X-Google-Smtp-Source: ABdhPJx3RQuLTjrKkaozgy/f5LysaQpPqHCLbcblRqGj+UmT1mCOj9eKPFByms1KO5RFunOf2wgV1w==
X-Received: by 2002:a17:906:4a19:: with SMTP id
 w25mr9312700eju.199.1599991536827; 
 Sun, 13 Sep 2020 03:05:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:9c8:f845:9041:a5ee])
 by smtp.gmail.com with ESMTPSA id
 g11sm6690286edj.85.2020.09.13.03.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 03:05:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
Date: Sun, 13 Sep 2020 12:05:31 +0200
Message-Id: <20200913100534.22084-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now meson_options.txt lists less than a dozen options, but about
40 more could come as configure tests are converted and moved to
meson.build.  Each option needs code in configure to parse it and pass
the option down to Meson as a -D command-line argument; in addition the
default must be duplicated between configure and meson_options.txt.

This series tries to remove the code duplication by passing unknown
--enable and --disable options to a Python program, and using
Meson's introspection support to match those to meson_options.txt

The disadvantages are:

- because we parse command-line options before meson is available,
the introspection output is stored in the source tree.  The output
is slightly modified using the "jq" tool in order to ensure that it's
stable and that modifications to meson_buildoptions.txt do not cause
horrible conflicts.  This is the main reason for the unattractive
diffstat (the number of JSON lines added is higher than the number
of configure lines removed, though of course the latter are code
that must be maintained manually and the former is not).

- we now need Python to generate the full help, so if Python is
missing we can only print a partial message and direct the user
to specify the interpreter with --python.  It would be possible to fix
this by rewriting the script in Perl (at least on Fedora, JSON::PP is
always installed if Perl is, because it's a dependency for CPAN; I'd
have to check Ubuntu and the BSDs), or if we want to write it as a
Bourne shell script, to further massage the introspection output into
for example TAB-separated values.

Opinions are welcome on whether this is worthwhile and how to solve
the above doubts.

Paolo

Paolo Bonzini (3):
  configure: quote command line arguments in config.status
  configure: early test for Python
  configure: automatically parse command line for meson -D options

 Makefile                                |   6 ++
 configure                               | 107 ++++++++-----------
 docs/devel/build-system.rst             |  35 +------
 meson-buildoptions.json                 | 130 ++++++++++++++++++++++++
 scripts/configure-parse-buildoptions.py |  94 +++++++++++++++++
 5 files changed, 280 insertions(+), 92 deletions(-)
 create mode 100644 meson-buildoptions.json
 create mode 100644 scripts/configure-parse-buildoptions.py

-- 
2.26.2


