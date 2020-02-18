Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDDAC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75272173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3P5hn7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75272173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j435P-0003dz-Up
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j434d-0002of-Kf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j434c-0006fq-Mo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:38:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j434c-0006fV-J3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582033081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1URDudQA43tkpJJIFu7DKO6uQTr6PesR1xXXrF9Y2c=;
 b=O3P5hn7ukxkX9uf+MPm5cvi0DKtLJB53bgzl4bjq6Ji4vP6FbbZSeimXo/jkhLV7OCNIZx
 QToxFVRwBKqSLY5OpQDAH8zSfJtGjyyq5R/eTqIRrKPyVI5bwehaavidvr7dvBVY42M5BS
 UlwTh3eVrqGhw15HiCSv6O4S1+qj9ws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-uIsOl54QMvSEq936JB0tfw-1; Tue, 18 Feb 2020 08:38:00 -0500
Received: by mail-wr1-f70.google.com with SMTP id u8so10831722wrp.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 05:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dby0bbbTN0qoct6/4D46hB2yEK0ttVkxuhLtJTaK6Dg=;
 b=NWvVV4IIGMb3q2JgUby/+h8qleidaRs7T099UR8lvbkBSyjYkb4K3LtoVLmRVHFrw1
 Rg8vW0vpaNvdk51/psCgwpxDmRd2ydFs1iu7L6W3tcv+MBsHXd+D6vHVnVxK2b6vBL/p
 jJfpaP20Y93h7kB2Gsh+QlVNzhqKTAcEZeIdQl4sYZVIGn0rniyApQL/ZejN2zBd4iTR
 OLDQ3TBPWN6IjXpCyqGrfEmqgQVRie3/mL81mRVAhXL0oFDWcWP/DMqq07q68z+X9zPy
 m5Tc88BlXoiSueNvJ/BDfE7hWy6l6LvseqGd0DNgTebImMfz05oy3Hn7NM5Q93ZQe2P+
 Oy5g==
X-Gm-Message-State: APjAAAXxd+DjRwONRSxb5U6XW2modlSTE9kyrTW9/liJuF9yUoP7ePbx
 eNWfO6imvuOHLiS0u36lAoKsC3jmpMePWjfmGmAvEadaiuEwn8KzcRC78gXq8AoTxzOJQGvSe5p
 2RRFvWsVVuxi35SE=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr30422433wru.40.1582033078373; 
 Tue, 18 Feb 2020 05:37:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8hDFMvcWDGsMdhzfbuC6//7cdxLJHFb3/ibbb3aPXZNXbVys06zrGJrx35qPGtqKOS/lZ/g==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr30422420wru.40.1582033078219; 
 Tue, 18 Feb 2020 05:37:58 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c13sm6377395wrn.46.2020.02.18.05.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 05:37:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] .travis.yml: Expand OSX code coverage
Date: Tue, 18 Feb 2020 14:37:52 +0100
Message-Id: <20200218133755.26400-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218133755.26400-1-philmd@redhat.com>
References: <20200218133755.26400-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: uIsOl54QMvSEq936JB0tfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install more packages to cover more components:

    ./configure
    [...]
    host CPU          x86_64
    strip binaries    yes
    Cocoa support     yes
    TLS priority      NORMAL
    GNUTLS support    yes
    nettle            yes (3.4.1)
    libtasn1          yes
    PAM               yes
    iconv support     yes
    curses support    no
    curl support      yes
    Audio drivers     coreaudio
    vde support       yes
    HAX support       yes
    HVF support       yes
    TCG support       yes
    vhost-net support yes
    vhost-crypto support yes
    vhost-user support yes
    vhost-user-fs support yes
    libusb            yes
    libiscsi support  yes
    libssh support    yes
    lzo support       yes
    snappy support    yes
    bzip2 support     yes
    lzfse support     yes
    [...]

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 5887055951..08ef2c011c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -279,10 +279,19 @@ matrix:
         homebrew:
           packages:
             - ccache
+            - libgcrypt
+            - libiscsi
+            - libssh2
+            - libusb
+            - lzfse
+            - lzo
+            - gettext
             - glib
-            - pixman
             - gnu-sed
+            - pixman
             - python
+            - snappy
+            - vde
           update: true
       before_script:
         - brew link --overwrite python
--=20
2.21.1


