Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BCAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23BC2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7j6u6Cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23BC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eBW-0007lr-2k
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e7D-0008Bz-7A
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e7C-0001Kl-7T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e7C-0001KY-3t
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiwsHxYwluw0cuqUGGkA84vK67eK7P8CIbL4qQHkagU=;
 b=i7j6u6CnobDzPROWYSc0HKFpfSYmfqaHtFJgUD//dXOdvca/zle1kUT1OyQ8P0xt36Gghu
 iDxynAKbb4NebQ2boVQfTTXsPgsFO57yJJ0Igb3GkzWGxLjEVJFqDAEPSSPDNgGItWr71I
 G6/HSbyodjTEW63yqSUWwjnGHtOcxIw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-GtnUaRC7NrCgOVbWh7L1cg-1; Fri, 28 Feb 2020 06:47:32 -0500
X-MC-Unique: GtnUaRC7NrCgOVbWh7L1cg-1
Received: by mail-wr1-f71.google.com with SMTP id u18so1216089wrn.11
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=to/q+TAGTTV4TMCuXzmoJpC1A+khKH9U1vgS0Q0SFBQ=;
 b=D8iEzpD0X99HPpcrC6rnYXtaTaHEHUB47d5o1BEwmj04zDIyFHH/w2O17YXiLHNV+s
 PWPRDZUctpGlhC8hV36dO6Ak7fwPb8u8Nw4OIyIibNfvuOuD1WxSBNWd+Y7MRN+sIWCk
 5mFF77OnxxSmzQ7BiwM24+9u+iFLg8mUCgIFTrGdGH69YtnXy3kCZ2BKO9hagatCnBkE
 TUPb2UikL6sr6HnYIuNjt9aayQrUHLSCcDbZe8ZUb8djPTjuy2eItLaOJbsEsdaISWTk
 Q2Hq+n/vPGd/ogBLtZszh5ihSdB+rcPylZnCs0QvBI04+pBluNjLfhbgoF1fhfUaeb90
 dL/g==
X-Gm-Message-State: APjAAAXEDkKHkDRT7sWcn9oyMb8cWx1OKH7sTo9wmDF30GhzD9noxg0r
 GHjNiwQX+AqsDNOEnR6D5i1RJMjV0YPCCo3dReJaqA+RsKvDBy1QYfDHcfw97Qr72Fj1qS2l1IZ
 RdJIT3SPlzkZKXDQ=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr4730030wrw.182.1582890450753; 
 Fri, 28 Feb 2020 03:47:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbYVgKMpk9DJ8B7pHReS32Q1gRnOWtmkXXObPKFyp+aHeVvajmQ2zyC3PKEWm6GwHFHu/Rzw==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr4730013wrw.182.1582890450581; 
 Fri, 28 Feb 2020 03:47:30 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id f1sm12392933wro.85.2020.02.28.03.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/18] hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
Date: Fri, 28 Feb 2020 12:46:38 +0100
Message-Id: <20200228114649.12818-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

alpha_sys.h does not use anything from the "hw/ide.h" header.
Remove it.

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/alpha/alpha_sys.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index bc0a286226..e2c02e2bbe 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -6,7 +6,6 @@
 #include "target/alpha/cpu-qom.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-#include "hw/ide.h"
 #include "hw/boards.h"
 #include "hw/intc/i8259.h"
=20
--=20
2.21.1


