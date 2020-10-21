Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832AEC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B773A21D6C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mb2AT6Gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B773A21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAMV-0004hD-IV
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kVALY-0003xa-KI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kVALU-0002iv-81
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603272224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lLdsu4nmj+yaC2ZUPyUV9a6PA0EiQ3kP5QfCsDz0KsE=;
 b=Mb2AT6GuOgp4vEK0xUGalRNZjUiL2rv5Ew87iQ+wAcpTSggPOSUokHsCxjlVZ6AA7zYWGa
 9Yx0v/AbkHGkiODPyhwXyhoh5KmFLMFaRdU/sbSfKl8hi/8FE6C5s/4nNPbgSx8ouGZo+q
 Pzv/3UUIJEZt1YA6ls1GBy5WBWWL590=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-WzSGmdWjPiKIq2xjo5yfaw-1; Wed, 21 Oct 2020 05:23:42 -0400
X-MC-Unique: WzSGmdWjPiKIq2xjo5yfaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84CD5107ACF7;
 Wed, 21 Oct 2020 09:23:41 +0000 (UTC)
Received: from kaapi (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A120D5C1BB;
 Wed, 21 Oct 2020 09:23:36 +0000 (UTC)
Date: Wed, 21 Oct 2020 14:53:33 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] net: remove an assert call in eth_get_gso_type
In-Reply-To: <38575304-e5ff-c93e-c1e8-997d4148e579@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2010211440290.1506567@xnncv>
References: <20201021060550.1652896-1-ppandit@redhat.com>
 <38575304-e5ff-c93e-c1e8-997d4148e579@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gaoning Pan <pgn@zju.edu.cn>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Wed, 21 Oct 2020, Jason Wang wrote --+
| It should not be a guest error, since guest is allowed to send a packet 
| other than IPV4(6).

* Ah...sigh! :(

* I very hesitantly used guest_error mask, since it was g_assert-ing before.  
  To me both guest_error and log_unimp seem mismatching. Because no GSO is 
  also valid IIUC. That's why in patch v2 I used plain qemu_log(). But plain 
  qemu_log is also not good it seems.

* I'm okay either way. Please let me know which one to use. OR I'm fine if you 
  fix it while merging upstream too.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


