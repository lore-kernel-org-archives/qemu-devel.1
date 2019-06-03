Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E7C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243D82730A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243D82730A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrR4-00042R-7D
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:11:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOI-00027Q-GF
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOG-0000T0-28
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:01 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrOB-0008Oc-IL
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:56 -0400
Received: by mail-qt1-f171.google.com with SMTP id s57so3389714qte.8
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=L0AgkiXhLjFVQRi+vsOb3iccAaKRvAtIDXeiJDWz4Hs=;
	b=i11fcbM3vwrEq7ebp4DlE1YshTlVgDEcGOMTU9gIDr+bEISklUxOR5r6GN9OVDGYKV
	LSHcHtmG7w1qETshVlWT11Oe5UUhLUlj078RsYUR9qu8sdlZnCadYxbXzd+U+tcStVmo
	odi/98lj4OQlXEEnya16seTqEJ5peXddawmj7WCPn8urlQk5ZMO5ypLsvyIS1awN1OBf
	mYFaswL16PU+E/eZ7UbQensNaWc9Emrv6n9Dc3hgwjs96e3e80SEim8vaAMeukKWtQKO
	yz9RIYvvvqWyZS+8m/sXmUzJLS1xm9Wz7gMwbh+KlPu1S13q0+6NE4b8Ui2UOpoBW2Ii
	bUiQ==
X-Gm-Message-State: APjAAAV/r1yns/r2NSWJSkOh0tDjCU5w7QZ6uHOLmIiaSGIHS2qIASff
	NeWgZIQ5VCKM/a3mv7dim+yPEb8Rhe8=
X-Google-Smtp-Source: APXvYqzFITFPmD26PYU8x6QnU+L2jFR+2wyMfm9x2Kl2ADFWjnZgXjxUbnFZWzr2vncug4OiSfepzw==
X-Received: by 2002:ac8:2809:: with SMTP id 9mr25353460qtq.4.1559585327260;
	Mon, 03 Jun 2019 11:08:47 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	q79sm7586923qka.54.2019.06.03.11.08.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:08:46 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:08:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1558448611-315074-1-git-send-email-imammedo@redhat.com>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.171
Subject: [Qemu-devel] [PULL v2 06/14] docs: smbios: remove family=x from
 type2 entry description
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190603180845.XFYAT-jWkHHZnAjRHVurPre6Q6yIMsrFqggPlJRELdI@z>

From: Igor Mammedov <imammedo@redhat.com>

'family' option is not part of type 2 table and if user tries to use it
as such QEMU will error out with an unknow option error.
Drop it from docs lest it confuse users.

Fixes: b155eb1d04 ("smbios: document cmdline options for smbios type 2-4, 17 structures")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1558448611-315074-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 39dc170429..0d8beb4afd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2080,7 +2080,7 @@ Specify SMBIOS type 0 fields
 @item -smbios type=1[,manufacturer=@var{str}][,product=@var{str}][,version=@var{str}][,serial=@var{str}][,uuid=@var{uuid}][,sku=@var{str}][,family=@var{str}]
 Specify SMBIOS type 1 fields
 
-@item -smbios type=2[,manufacturer=@var{str}][,product=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,location=@var{str}][,family=@var{str}]
+@item -smbios type=2[,manufacturer=@var{str}][,product=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,location=@var{str}]
 Specify SMBIOS type 2 fields
 
 @item -smbios type=3[,manufacturer=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,sku=@var{str}]
-- 
MST


