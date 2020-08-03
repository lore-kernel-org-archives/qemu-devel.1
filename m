Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37F020792
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuDde3d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37F020792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2dfn-0004Mu-4c
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k2den-0003Rw-8q
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:49:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k2del-0008Ci-15
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596473384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zv8LBIcMW0GyDhLA3Sp195wmw5zSC0/Eoz97WeXlaaw=;
 b=RuDde3d2NRQZm6UwHRa1kRoAV5xtONzKeKMB5BKTZpYCmjl051UZHezR+7/4Gt3L+2gs5J
 yEM5zeWgRulnUnZAHZZWGkiUaKE1hDFTQmQzSyKU9BgLUCYkr1WzZHer7Y35+p5eCDbaT4
 5B/H+c7lRf4n9pxdUwNgGvR7X8iPq2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-8ddcLcMRNPmYGPjHUbCvgw-1; Mon, 03 Aug 2020 12:49:40 -0400
X-MC-Unique: 8ddcLcMRNPmYGPjHUbCvgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85D5B1005504
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 16:49:39 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (unknown
 [10.10.115.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2891E8BED8;
 Mon,  3 Aug 2020 16:49:39 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Subject: qapi-schema esotera
Message-ID: <5bfa3895-304d-8372-c0db-fda4c1a1ba59@redhat.com>
Date: Mon, 3 Aug 2020 12:49:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UNION is split into two primary forms:

1. Simple (No discriminator nor base)
2. Flat (Discriminator and base)

In expr.py, I notice that we modify the perceived type of the 'type' 
expression based on the two union forms.

1a. Simple unions allow Array[T]
1b. Flat unions disallow Array[T]

 From the docs:

Syntax:
     UNION = { 'union': STRING,
               'data': BRANCHES,
               '*if': COND,
               '*features': FEATURES }
           | { 'union': STRING,
               'data': BRANCHES,
               'base': ( MEMBERS | STRING ),
               'discriminator': STRING,
               '*if': COND,
               '*features': FEATURES }
     BRANCHES = { BRANCH, ... }
     BRANCH = STRING : TYPE-REF
            | STRING : { 'type': TYPE-REF, '*if': COND }

Both arms use the same "BRANCHES" grammar production, which both use 
TYPE-REF.

     TYPE-REF = STRING | ARRAY-TYPE
     ARRAY-TYPE = [ STRING ]

Implying that List[T] should be allowed for both productions.
Can I ask for a ruling from the judges?

--js


