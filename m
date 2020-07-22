Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C2CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308F02071A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Okss2ghP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308F02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyG0u-00020g-Fu
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 10:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jferlan@redhat.com>)
 id 1jyG08-0001JT-PO
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:45:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jferlan@redhat.com>)
 id 1jyG06-00040W-Pc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595429141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zolzpZrrxc1z869f79W+okedx2Io/bJEpGhNzpWV8dI=;
 b=Okss2ghPqHGhUi7pWvKGkcK1BBbhrA0Om4cfwXfRV/m9LHyrT+BA9xa2unQCsK8Bx2ukp6
 mXgiOGZ46UIVnuyJWzjplQ3PZSF/bnikUc3bYko0AjdSxbKQbA7XQ/aMPq1hs6meSyhqRw
 aOUFYEeDMEY5713q8U9suGGZYlvA9oI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-BnhVOCfaOa-UBC7Kz-hSow-1; Wed, 22 Jul 2020 10:45:39 -0400
X-MC-Unique: BnhVOCfaOa-UBC7Kz-hSow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AFA819253DA
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 14:45:38 +0000 (UTC)
Received: from unknown0050b6a41c42.attlocal.net (ovpn-113-12.phx2.redhat.com
 [10.3.113.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C2FE7B41E
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 14:45:38 +0000 (UTC)
Subject: Re: Virt Storage/Block meeting minutes - 01-Jul-2020
From: John Ferlan <jferlan@redhat.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <b9949b69-5ae8-c54a-5083-7ac1f43a4f5f@redhat.com>
Message-ID: <9d0fe4c9-94fd-cadd-c68f-47bf906c8eb5@redhat.com>
Date: Wed, 22 Jul 2020 10:45:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b9949b69-5ae8-c54a-5083-7ac1f43a4f5f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jferlan@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yikes - wrong list! Fingers and brain not in sync, sorry for the noise.

John


