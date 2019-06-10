Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B78EC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE66C206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkrMU7z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE66C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMEp-0007lD-RC
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 11:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haMAL-00045u-IW
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haMAC-0004fs-Is
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:24:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haMAC-0004ed-BJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:24:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so9651963wrs.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K8Hgqq2e8EMUIiN6wyue9Fr6gPXyqsBWKHC/oJYkuxQ=;
 b=EkrMU7z8WI1BklaW/59gvBRHcnk9nhEKdtrS3rKH4jXo90pjZ5GVZuokobou4IFqyb
 QI8S/dMnERoN53SUaxJ9ZCdebSnjwnENjqOCUlHJaRBfZKOSSmN9o9d3Z8UeqkIMGQhl
 FIrMBWu/xYm74+LJY8J8Ts+XOZqrRgDAkO6UCXol3kor59K4zfp1C6RE2lBi8js90YUc
 jHvTmdGhljHHXg50Cdmqv8ZadC9OJy3pXnfidE3CBsx6nBBI0GICJyRf/9PzOZALfz4m
 rtFxhvkqnBjjhc9bT7i5DlXd95llzDGJ6JxBIFGtYBDA+GrJlECsiagIfeg6UR9ZG536
 grRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K8Hgqq2e8EMUIiN6wyue9Fr6gPXyqsBWKHC/oJYkuxQ=;
 b=t+c1Qi4TVh59l5XCzdO1virko6lP3qwfaj/BHaZmPlgkKjaJXE4nM9dMBq38dA8P5z
 dqPjfPu3thyFXRt4RIFUPb+v2eXH45rP1AuHux0e/Ds4uC0mhq04B+6XpaVDUfBezo4D
 NDqwQ5oSeX3BRy60yMNaO/VbE1p3qox4rqmHPh4vy0uiV2KXJuiWMwmdzMjREXIGF4D1
 FqgRpTl8S5FXtJfiIXO1CInHduVZ8qUo8RLprFHDixKEAn+jPcpjh5NAIDV1HsNlyVUo
 5u3QEpCENgPq/RoeIHjdEHlpK/RT7Dolx1mJxLRdQnwgu3GaU0tsrRaXXyYYW+zdWQEE
 jTdA==
X-Gm-Message-State: APjAAAVw9RweZvf5ujw3m2u0QoVMzzsbjayADCjofIAMQAJeWM/gopXL
 DhQxTqitxaAcLkwZ2lvJvj8NJ5C38MeslA==
X-Google-Smtp-Source: APXvYqwO7HlS/r/fKMe6Tg99p+kgugtcCiDZoRKZv8ECYqdpP9ijKTkCk4fnMe4aQBJ7VzYcYRYGFw==
X-Received: by 2002:adf:f544:: with SMTP id j4mr32472656wrp.150.1560180286349; 
 Mon, 10 Jun 2019 08:24:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b203sm11945920wmd.41.2019.06.10.08.24.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 08:24:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 16:24:42 +0100
Message-Id: <20190610152444.20859-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 0/2] docs: build and install the 'specs' manual
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Sorry for the initial send where I sent only the cover
letter and forgot to tell git send-email to send the
patches as well...)

With the recent addition of the XIVE documentation, we
now have some actual .rST format documentation in
docs/specs, so we should start building and installing
this manual.

Patch 1 in this series fixes up some minor problems with
docs/specs/index.rst which we didn't notice because we
weren't building the manual. Patch 2 adds the makefile
and config runes to do the build and install.

NB: there's a trivial textual conflict in Makefile
with the 'convert qemu-ga' patch I sent earlier today;
this applies direct on top of master.

thanks
-- PMM


Peter Maydell (2):
  docs/specs/index.rst: Fix minor syntax issues
  docs: Build and install specs manual

 Makefile             |  7 ++++++-
 docs/specs/conf.py   | 16 ++++++++++++++++
 docs/specs/index.rst |  9 +++++----
 3 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 docs/specs/conf.py

-- 
2.20.1


