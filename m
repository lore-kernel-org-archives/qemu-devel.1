Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702D0C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA00221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQywt5UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA00221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVB8a-0004QK-Md
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kVB7f-0003np-De
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kVB7d-00044o-TG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603275213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kuhgrjMcqvT0vC5w6BeuSuCAjzmvzSe9YSXgt7V7Ops=;
 b=BQywt5UUYgICq4PbZosB77A+txR1BUDj0BY+bgXzINWrx7lfWau/6Y8IhF+irHzTDo11eX
 sZa8kn06AT8wQYtH7CuytBAzwUsYex0N4unpTs6V5mWeJ+J8Ft1nfdCTnkSQcokTOQRHeG
 gPaUzb7AG+1qZgljWJRoqEVaufyqhMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-voo_0FPkNLC7nRP53K076g-1; Wed, 21 Oct 2020 06:13:31 -0400
X-MC-Unique: voo_0FPkNLC7nRP53K076g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4459210E2183;
 Wed, 21 Oct 2020 10:13:30 +0000 (UTC)
Received: from kaapi (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B2DA19C78;
 Wed, 21 Oct 2020 10:13:23 +0000 (UTC)
Date: Wed, 21 Oct 2020 15:43:20 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] net: remove an assert call in eth_get_gso_type
In-Reply-To: <7e971323-0b9a-2c32-2e09-705249f3f2de@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2010211527580.1506567@xnncv>
References: <20201020140050.1623109-1-ppandit@redhat.com>
 <CAFEAcA_Bg12kvGAjg127_XpfeJdj9er-e2VEF9YnkNyVUDQ9OQ@mail.gmail.com>
 <7e971323-0b9a-2c32-2e09-705249f3f2de@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-858163811-1603275209=:1506567"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gaoning Pan <pgn@zju.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-858163811-1603275209=:1506567
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Wed, 21 Oct 2020, Philippe Mathieu-Daudé wrote --+
| $ git grep qemu_log\( | wc -l
| 661
| 
| This function seems used mostly by very old code.
| It is declared in "qemu/log-for-trace.h" which looks like an internal API.
| 
| Should we add a checkpatch rule to refuse new uses of qemu_log()?

* That'll help, if it's not meant to be called directly.

* Better still would be to make qemu_log() static, called only via 
  qemu_log_mask(). That way compiler will show an error if qemu_log() is 
  called directly.

* While at it, could it be made to print '__func__' string by default?


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-858163811-1603275209=:1506567--


