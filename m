Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E26C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DE123E06
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DE123E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1ee-00049r-H1
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:42:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1a0-00005I-NH
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1Zz-0002nS-Qn
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:32 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:41813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hW1Zz-0002n9-N2
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:31 -0400
Received: by mail-qk1-f178.google.com with SMTP id m18so1883817qki.8
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=L0AgkiXhLjFVQRi+vsOb3iccAaKRvAtIDXeiJDWz4Hs=;
	b=oPvVtgSiJBaRAWLiiXs0o6yIle7M7yh3nOmBWJzR8/7J2mHYMCPyj1pH0I1qEbKPjL
	t+u9s4XepjCRJX5vC6VL+KXr9dHAHxUf4vKfWs+TTDv0NcY8iH8rIKjSf6FSL4CQVfQq
	AY4G7fOGKRdWukqj5iPw4eUEdIM+QWl2FcaZlY3N5VyDgRpup4wbPDJxuvbkLFRyEm/C
	eXPAwmxHM95EYX9m5aI3ohn5dc+KiRtTe/+VeUWnHTrpFxsQ0aViO5JfP1OKcPOawKBy
	Bl8uhjq8yRVNezxIKg+vePPM4zNxZBt5CaQYOTZ27KWKid+GUTTD2tfyPfZjCrP8tzbI
	TOQQ==
X-Gm-Message-State: APjAAAU8ONLo7UxEFKRVfEBNo42wHfRFCdeXCkciv63MQi+e/aKIZNtj
	E1x3MTDqA7/+DHI7ZZ2psV+VLyVTDJY=
X-Google-Smtp-Source: APXvYqyEM2r4OvoVxryGCcC8ILFyJ2myC0/aqVmRup5Hkl1KabKOGuJOLMwiNwzkTr7Nb831w6pvFg==
X-Received: by 2002:a05:620a:1598:: with SMTP id
	d24mr6861179qkk.348.1559147850889; 
	Wed, 29 May 2019 09:37:30 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	n188sm3314813qkc.74.2019.05.29.09.37.29
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 09:37:30 -0700 (PDT)
Date: Wed, 29 May 2019 12:37:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1558448611-315074-1-git-send-email-imammedo@redhat.com>
References: <20190529163604.18560-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190529163604.18560-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.178
Subject: [Qemu-devel] [PULL 07/10] docs: smbios: remove family=x from type2
 entry description
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
Message-ID: <20190529163728.GsP7FP24MXD2WcPTwthfOEyEFbWZb8wuJXCQ-XrJbXc@z>

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


