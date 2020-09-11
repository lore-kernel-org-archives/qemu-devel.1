Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA8C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBDA221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXcPuDfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBDA221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmBq-00077y-2P
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGmAz-0006Kb-AF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:45:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20441
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGmAx-0002rs-SL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599842726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uN3Bus+wqtgjJBDdJEx+GdZnfKMYS1EtHVnRYDk5FI=;
 b=gXcPuDfXuAxPB/J0zGbIHMNDqC4fAWWmP/srHRpQCq2ge+Q1YYyDNNbajX56uq+F2F0V7H
 QcJ/QMubCEh/i7w85p3IeOo1AgxEAWH5KfVhrxFgfcg79XIyK0LH4o8zFnzGBE+/ldFDm3
 luV3Vbmw3x4OA2CBZMBwcOGSIYaGxFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-N9-mAhN-NGmn5u9tubTeSA-1; Fri, 11 Sep 2020 12:45:24 -0400
X-MC-Unique: N9-mAhN-NGmn5u9tubTeSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 900181009446;
 Fri, 11 Sep 2020 16:45:23 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-62.ams2.redhat.com
 [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AFFC1002D57;
 Fri, 11 Sep 2020 16:45:18 +0000 (UTC)
Subject: Re: PATCH: Increase System Firmware Max Size
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
 <20200911150602.GH3310@work-vm> <20200911152353.GI1203593@redhat.com>
 <d7d0d37e-4bba-ab82-783d-06463d78d9cf@redhat.com>
 <20200911162138.GL1203593@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c021d04f-8ae4-d8be-c107-7ac89db9bb94@redhat.com>
Date: Fri, 11 Sep 2020 18:45:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200911162138.GL1203593@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "McMillan,
 Erich" <erich.mcmillan@hp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 18:21, Daniel P. Berrangé wrote:

> If OVMF maintainers want to reject
> feature proposals they have the right to do that regardless of what
> QEMU sets for max image size. As you say earlier, the existing size
> limit is already enourmous compared to what OVMF actually uses, so
> if this was a real problem it'd already exist.

Very good point -- I have indeed not realized this.

Laszlo


