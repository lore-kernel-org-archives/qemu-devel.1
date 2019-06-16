Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D1C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA742133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuYkkT+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA742133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcVZg-0003A4-OR
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 09:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dkarnikis@gmail.com>) id 1hcVYc-0002JB-Iy
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dkarnikis@gmail.com>) id 1hcVXg-0002ew-1L
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:49:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dkarnikis@gmail.com>) id 1hcVXc-0002aq-KY
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:49:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so7117975wru.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language;
 bh=Qcq2/BaCa/eNFlcs72MTRafxF58pzbDAx74lL1KXyZk=;
 b=LuYkkT+OpKL8WJqaQcwUFPnBYBHXlRuR1/eX6j+UHq7xnphZXURBN5jJS7mpqcy2rO
 6kvQptRJNDlwuD3QqgGuNfVMiUr4sg7UhVUPDkZxaIv33eIhmYMd+7IuBBR/+sKOIbTs
 7tjL03IU4jKIHPQg3El7I2HDqOuQAi4ceLJ/ufyAcWiMk4iVEejGpSFtXm5j0f1zxBjR
 L0AdeJOarKj9lFqUOsfcswzvEMYHo9l+gGKgQgIq38wX45zjw2/y5tIy0DPzYvTkRz15
 6DES/9fxnXVMK6VxW16LccqMsYF/cpFRGNHABeGafP6pqewjJgQ5FAy1faWtOz/aRtY/
 EgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language;
 bh=Qcq2/BaCa/eNFlcs72MTRafxF58pzbDAx74lL1KXyZk=;
 b=hUIp+ziSZZ0wcLbmBSqZtfnKYs1ZIqhuGbcAhcz7tVV4seuyu5GWdWdWFMBNzxDVYd
 9XeD4xXqBok4LaXvaQwHfaKXJNX9DJzvsxn2iXySBVxXJBe+u6DljEfN3jk4VP6OxwuK
 oeEimYLWsHQsDYfxxr9hs3/bKBnnmEgo9HUHrPYQVS0bGr6TXrJfWI9KNVfbooOx8by1
 I/89m6p6se0q8Z5DR1lH1QJGnmFs29oge82wTiwlQDu2zKYcbPxDCyg3dXFOxrZzIhii
 XvdcbwLws13XtM3DWxQoqheWIp9z5zL630O/N04/U7DjjNY54ytQUfm8QUyPbF5TWGfe
 Q4Wg==
X-Gm-Message-State: APjAAAULSS2QQ4VY8s692dEFEg6HSn42LpviFmwerUcaqw9oFXTAqi7z
 b0JN1PVhKAAeK39dBvIP2QSKKZRItHI=
X-Google-Smtp-Source: APXvYqw7vodhu/rGzERv0ihnOHAMcZGRz0P+K+pGedM0o2VnlZKUZLoIzG1h5VzWRTwee3vUSJadJQ==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr59717805wrn.31.1560692990907; 
 Sun, 16 Jun 2019 06:49:50 -0700 (PDT)
Received: from ?IPv6:2a02:587:801a:3e00:1aa6:f7ff:fe1e:4227?
 ([2a02:587:801a:3e00:1aa6:f7ff:fe1e:4227])
 by smtp.gmail.com with ESMTPSA id l18sm7561261wrv.38.2019.06.16.06.49.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 06:49:50 -0700 (PDT)
To: qemu-devel@nongnu.org
From: Dimitris Karnikis <dkarnikis@gmail.com>
Message-ID: <24d54a82-bbda-4edb-3ccb-d3144d2daac7@gmail.com>
Date: Sun, 16 Jun 2019 16:48:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Mapping of the guests user and kernel pages to host
 memory
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
I am interested in understanding on how QEMU maps the user and kernel
pages of a guest OS to the host OS memory (working on 3.1.0 but any 
version is acceptable with target x86-64 arch).
Since QEMU runs on user space, these pages will be also mapped on the 
user space of the host machine. So my question here is, where do the 
allocations take place, and in which place of the source code I could 
find the mapping.

Thank you for your time,
Dimitris
