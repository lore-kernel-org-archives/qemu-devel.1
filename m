Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D92C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5C92067C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hr8OKmIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5C92067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWC3-00079M-Uo
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDW9j-0003J8-1I
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:02:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDW9h-0000QH-B6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBZkgyPn2tMrU3wpqI8ygh7fYXrL1AZhv/zr9+cbOz0=;
 b=hr8OKmIWIstPVR55LTQwh+ZGq7oHiIlOBp3ir0qmZhMMoquta0CtpFeJiKN8uzM0xc81Gm
 MitQ4T1AN93lmQYZ5RKC7p7Rs6LsI8ReNF5owyOP+erVEkIuAjxAGvpVB+nOq/IVSDBrqg
 P5WxezU93fXKnJzvI0Nr3yVXtjkjzbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-2uHJPzbcMOaCqbfWCRRRRQ-1; Wed, 02 Sep 2020 13:02:37 -0400
X-MC-Unique: 2uHJPzbcMOaCqbfWCRRRRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFB74800FFF;
 Wed,  2 Sep 2020 17:02:35 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9334C5D9D3;
 Wed,  2 Sep 2020 17:02:33 +0000 (UTC)
Date: Wed, 2 Sep 2020 22:32:30 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] sd: sdhci: check data_count is within fifo_buffer
In-Reply-To: <816b3dbe-527f-1bec-a0cf-555e44068a56@amsat.org>
Message-ID: <nycvar.YSQ.7.78.906.2009022216510.2047119@xnncv>
References: <20200827115336.1851276-1-ppandit@redhat.com>
 <816b3dbe-527f-1bec-a0cf-555e44068a56@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-2029472028-1599066155=:2047119"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-2029472028-1599066155=:2047119
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Tue, 1 Sep 2020, Philippe Mathieu-Daudé wrote --+
| >  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1
| 
| This directory is 3 months old, I can't find it on the list...
| Did I missed that or did the list eat the report?

  No, it was reported to [qemu-security] contacts. These are few last 
remaining old issues. We shall have better response time now.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-2029472028-1599066155=:2047119--


