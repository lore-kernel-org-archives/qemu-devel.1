Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C5922D03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAOy+vqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C5922D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bq1-0000FX-Hx
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1k3bp3-0007ov-5e
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:04:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1k3bp1-0003lK-F9
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596704662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vMKYD/ey/VzMfZzMSwjJNZwByZEeIBL4APJJ9Zwl/pI=;
 b=SAOy+vqbGwMgjkFzdHlH84mlvhDu/5WYnVHRa9BS6VyVRSI2nUdoGldk3gufvZ3Y99GI4y
 mh/zw47SPuEnLmVgFc5N8EY7DuOjkOmjr0RP+9tnOiA69GrFFmZfjPzczr+yachN2mQfDV
 BYBUnat2a2MhJ3ysjDMpQgRho+TcJxY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-32PAdu7UM3e5ddcRWMAsLA-1; Thu, 06 Aug 2020 05:03:12 -0400
X-MC-Unique: 32PAdu7UM3e5ddcRWMAsLA-1
Received: by mail-ed1-f69.google.com with SMTP id c16so1888439edt.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 02:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vMKYD/ey/VzMfZzMSwjJNZwByZEeIBL4APJJ9Zwl/pI=;
 b=CgQdMhiTBE73dY1YvVkDII1EIgtc4gY7JQnTCCLj3RfAjtOY0Pleck5xCDIvBlV4RX
 8l/WQgCUYcvYbN3RQqRatJntm0Zvlj63oyRmR4mAOxKUYkq5BhKZaBTcTlT945rgnHUC
 vy05relunp6V62YKBRUTZqA6WZsRg3+t1rYFTzN9lDz1FyhUdvHzwo0OkG8bPSYoWdaH
 pP/uyd/ztFltVdMQ1i9gVAPHw6Lj/z2uRyacnPbOhLmvPJwXQO7ggM4Ujzu9E1wiwgIc
 wNai1DsraysSdqjxF8gNBoctvA0n3QehMY72wukLiUS0/DtKIu3ZB11mQQa0bTIBP4U4
 721w==
X-Gm-Message-State: AOAM531AcDdSwIBys7xSe1lvkT/GDPq0D8Jpwpk28+ti9JrIQU8z61a4
 7LonmFUrEoLrLJKqs5etDynWDerCULIEM4YDluxNGKWRR6oaYKr6dfkoSYhZbAqj2lEGPElNyTu
 0vy3X2VGyti/Q7CQ=
X-Received: by 2002:a50:e719:: with SMTP id a25mr2976828edn.15.1596704588461; 
 Thu, 06 Aug 2020 02:03:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw91ZM9+8ciIm+RqcuymMQWmhYIGWDLd56btEjhTTglUq9py3XkzHGfxfmYBFbFaOXs0QEthg==
X-Received: by 2002:a50:e719:: with SMTP id a25mr2976811edn.15.1596704588287; 
 Thu, 06 Aug 2020 02:03:08 -0700 (PDT)
Received: from auriga.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 g24sm3035681eds.42.2020.08.06.02.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 02:03:07 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/1] qga: add command guest-get-disk
Date: Thu,  6 Aug 2020 11:03:05 +0200
Message-Id: <cover.1596704579.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds command to list root disks of the VM.

The patch does compile on master but to work properly it requires changes to
qemu-ga by Thomas Huth in series: Allow guest-get-fsinfo also for non-PCI
devices.

Tomáš Golembiovský (1):
  qga: add command guest-get-disks

 qga/commands-posix.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c | 83 ++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 13 +++++++
 3 files changed, 186 insertions(+), 1 deletion(-)

-- 
2.25.0


