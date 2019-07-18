Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D928C76196
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4A4204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4A4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzrP-0007qt-1V
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnzrD-0007S1-Ux
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnzrC-0001oH-RX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:25:35 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnzrC-0001nq-LB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:25:34 -0400
Received: by mail-wr1-f53.google.com with SMTP id n9so2212833wrr.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 23:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:openpgp:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=/mcUmga2KFF3MsqVNLM4UQV/kfzUAlAkH6man98BBHM=;
 b=eZ7fjQW7y4F++yHaMFT27avFMLUFo69daR/Cx17cSBHg9ZJmXGgOModLvdm3EHgKMa
 km7M1KkjPbiCmk24+h9A1chqMI8TjICXG7jQgipEtuahmFufrWoRf9JmWPx2buLQ9R07
 P7Is80ripP200HVR96oisMYfcTGBz/5NkpfG1nKXEaWE6cfA0HChNVxQUqQ36c2q7v5u
 AZaJghAcyxmTZNtZZ0iUA42N1hzRg1rbTED5jZSx+mYl0tV9c3bZgS/9i70dCvMDC2uc
 Thu7Po83QkDVmvGxSeI9is7FcgqCzCw0ZdXU6+EJKYUak9FWo4wUbwgn5ta9QBUEwdXp
 BcXQ==
X-Gm-Message-State: APjAAAWjBu99PNo1svKIynTVfOYQqu1mFfbmOxOTCN1ms3YGotrAUNj5
 g1oAH9JWq561iLOdq91ssb9D5Q==
X-Google-Smtp-Source: APXvYqx+3XuLvBuwIpKFK0cbglrADTQrpmcvqzvXdC9huN+dQ2F7x/k/AE6n5N/ZPkpym55saUosPQ==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr46094758wrp.287.1563431133584; 
 Wed, 17 Jul 2019 23:25:33 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id h14sm25037556wrs.66.2019.07.17.23.25.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 23:25:33 -0700 (PDT)
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cb727b5d-683f-115d-f3c0-06f5a6761aea@redhat.com>
Date: Thu, 18 Jul 2019 08:25:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.53
Subject: [Qemu-devel] No archives to download from www.qemu.org/download/
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

When building from the GitHub generated archive
(https://github.com/qemu/qemu/archive/v4.1.0-rc0.tar.gz)
we get:

---
$ ./configure

ERROR: missing file /tmp/qemu-4.1.0-rc0/ui/keycodemapdb/README

This is not a GIT checkout but module content appears to
be missing. Do not use 'git archive' or GitHub download links
to acquire QEMU source archives. Non-GIT builds are only
supported with source archives linked from:

  https://www.qemu.org/download/

Developers working with GIT can use scripts/archive-source.sh
if they need to create valid source archives.
---

Now there are no archive to download at this url...

However from the last mail from Michael Roth, we use:

http://download.qemu-project.org/

Which contains all archives.

Should we update the url display by ./configure?
Or sync the other website?

Regards,

Phil.

