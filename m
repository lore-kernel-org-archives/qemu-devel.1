Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E24C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7337220739
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fm+iAqjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7337220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxeA-0005um-Bm
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kMxcX-0004ly-Hb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kMxcU-0006Mh-Q7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:11:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601316683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btmN//G0YPyqa0fEQ2Fm2oTJiGxcs1TJaARsQyJHvTo=;
 b=Fm+iAqjm0ANWi1RKd0cZ5OiRiVa67g3eg5/CpEJ7M7EV2ak0yZ8T+xBPXCZ7Ct0kLmuvpB
 evQj2fsI+gAzAKFqzr2v2reqy5bZnyZe67oj23dEiHqaogXS2utxYHYmIpodlsl2FjgJ4b
 WROBeqpZsqAZ/y2CXyg6ArHJrhM851c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-UDmCFKJRPz2oyobzT09HSw-1; Mon, 28 Sep 2020 14:11:11 -0400
X-MC-Unique: UDmCFKJRPz2oyobzT09HSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 906DE18BA284;
 Mon, 28 Sep 2020 18:11:10 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-138.ams2.redhat.com
 [10.36.113.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A7EE60C13;
 Mon, 28 Sep 2020 18:11:00 +0000 (UTC)
Subject: Re: [PATCH v5] hw/i386/pc: add max combined fw size as machine
 configuration option
To: "McMillan, Erich" <erich.mcmillan@hp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200925033623.3968-1-erich.mcmillan@hp.com>
 <8818a3ae-cab6-5de4-adbd-19198d26b6e7@redhat.com>
 <CS1PR8401MB0327982D7F9414360E440656F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a5050849-2b66-3d90-3e89-70be07a53c0d@redhat.com>
Date: Mon, 28 Sep 2020 20:10:59 +0200
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB0327982D7F9414360E440656F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/25/20 19:14, McMillan, Erich wrote:

> On an unrelated note, it seems that my patches are no longer appearing in https://lists.nongnu.org/archive/html/qemu-devel/2020-09/index.html is this because I need to cc qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> rather than –to?

Cc: and To: are equally fine. I can see both your v5 and v6 postings there:

https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09212.html
https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09577.html

The qemu-devel list is very busy, plus <https://lists.nongnu.org/> hosts
a very large number of other lists -- so updates to the WebUI are done
in batches (I think once every 30 minutes, but I could be out of date on
that). A fresh posting almost never shows up immediately on the WebUI.
(I believe it may be delivered to subscribers via actual email more
quickly.)

Thanks
Laszlo


