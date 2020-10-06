Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC9C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D279206DD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FevOmft+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D279206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqX3-0006yz-92
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPqWM-00067i-Co
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPqWK-00053N-Rv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602004380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ecw/oDaOz6r43dlJaHQO7jUdOZeTkTda+ilLu1x8ENE=;
 b=FevOmft+Rx66BXyvvLqsTTXesWTUTVFeNt19Xgfnj7ZB3tyostW0w1OZf2lT5K5JMKfGOl
 zkMeHDqLphm5tsS1+I8s4wy95wQ66kqGzyPcGciOCvcoaVJSj88aXuKymvkFEtxbGvIWsT
 jUJaJ/4uonPPbwYc9knx/F1pjoPrf5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-cAG4-EWpN3W3wp6ZgI1zXA-1; Tue, 06 Oct 2020 13:12:58 -0400
X-MC-Unique: cAG4-EWpN3W3wp6ZgI1zXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EFC0835B4F
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 17:12:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 222DB55770;
 Tue,  6 Oct 2020 17:12:53 +0000 (UTC)
Subject: Re: [PATCH 0/3] docs: Include QTest protocol and libqtest API on
 documentation
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201005205228.697463-1-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <64fc2c1a-0751-6b6a-1499-9dae8c7ea100@redhat.com>
Date: Tue, 6 Oct 2020 19:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201005205228.697463-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/2020 22.52, Eduardo Habkost wrote:
> This moves the QTest section of testing.rst to a separate
> document, and include the QTest Protocol specification and
> libqtest API reference in the document.
> 
> Eduardo Habkost (3):
>    docs: Move QTest documentation to its own document
>    docs/devel/qtest: Include protocol spec in document
>    docs/devel/qtest: Include libqtest API reference
> 
>   docs/devel/index.rst          |  1 +
>   docs/devel/qtest.rst          | 72 ++++++++++++++++++++++++++++++++++
>   docs/devel/testing.rst        | 47 +---------------------
>   tests/qtest/libqos/libqtest.h | 20 +++++-----
>   softmmu/qtest.c               | 73 +++++++++++++++++++++++++++++++----
>   5 files changed, 150 insertions(+), 63 deletions(-)
>   create mode 100644 docs/devel/qtest.rst

FWIW:

Acked-by: Thomas Huth <thuth@redhat.com>


