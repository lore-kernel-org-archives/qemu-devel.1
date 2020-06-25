Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600C1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA8A20706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4BZKeY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA8A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQ08-0004L4-F9
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joPzU-0003ch-SA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:24:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joPzT-0001kR-FS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593084262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XEGD+TVcqei5yMMOMOrijIifjC0+DK8Rqsz3SE5OBI=;
 b=K4BZKeY87gRq12ZqMiDHtoyo9u+sJkdMDyng6thpT5+bUyupns7Krr2C0xb6W9/bAghIuX
 gFjxfWT0bUotb0S5tOTRltV3aoeWuz2Mcy0xWBNYSXzt6R+7hcCPshX6lh2iWHnd0xTztY
 M48MJv8laZ1uwWouW2rX7ZkNQItZNdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-muYVH_2oM0GWjTl6_NEKKw-1; Thu, 25 Jun 2020 07:24:20 -0400
X-MC-Unique: muYVH_2oM0GWjTl6_NEKKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD556464;
 Thu, 25 Jun 2020 11:24:18 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 890D25C1BB;
 Thu, 25 Jun 2020 11:24:09 +0000 (UTC)
Date: Thu, 25 Jun 2020 16:54:05 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 7/9] tz-ppc: add dummy read/write methods
In-Reply-To: <86ed036e-cbf1-834d-59d9-af6db7b750ef@redhat.com>
Message-ID: <nycvar.YSQ.7.77.849.2006251651010.92950@xnncv>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-8-ppandit@redhat.com>
 <7ffe6cd9-fc23-3fdf-6c57-7bb0af0dd030@redhat.com>
 <nycvar.YSQ.7.77.849.2006251427210.92950@xnncv>
 <86ed036e-cbf1-834d-59d9-af6db7b750ef@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-308640593-1593084258=:92950"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-308640593-1593084258=:92950
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Thu, 25 Jun 2020, Philippe Mathieu-Daudé wrote --+
| On 6/25/20 11:18 AM, P J P wrote:
| > |  g_assert_not_reached();
| > 
| > This will likely be called in tz_ppc_dummy_accepts() above. Do we still 
| > want to revise this patch? considering read/write callbacks are 
| > unreachable.
| 
| So a simple comment in each read/write might be sufficient (removing the
| qemu_log_mask calls).

  Okay. Will wait for other reviews, before sending a revised series v3. Hope 
that's okay.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-308640593-1593084258=:92950--


