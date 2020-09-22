Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE42C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2389A2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wtu50vxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2389A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfkP-0000r7-6X
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKfbK-0005mi-6k
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKfbI-0006XK-8h
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NQROmubNRzjDNlUJtaBjm/wgwvnsgYrHOc9B0RolBQ=;
 b=Wtu50vxnAhIHvOoIWGeSnpzHem8eWm1O4wlc+qm/yJZyQzCU8/kRBu3WozusmWvbRBG95B
 KhI158tB4CYJkO7KMxQ53wTKtaPfn4LIciawisoP+zcSBEPX3huYKisNO1GiS+xtBMpIey
 oe2ZjmLgM29wSYB4iRXH/2eLx745/xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-pFZbjvROPwi9ihyKJJtZMQ-1; Tue, 22 Sep 2020 06:32:41 -0400
X-MC-Unique: pFZbjvROPwi9ihyKJJtZMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E625801AB5;
 Tue, 22 Sep 2020 10:32:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-122.ams2.redhat.com [10.36.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDA875DA7B;
 Tue, 22 Sep 2020 10:32:38 +0000 (UTC)
Subject: Re: [PATCH 0/1] block: future of sheepdog storage driver ?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200922090147.1993705-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0073f0f8-2a59-9bad-3088-4790ec07fe31@redhat.com>
Date: Tue, 22 Sep 2020 12:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200922090147.1993705-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Liu Yuan <namei.unix@gmail.com>, sheepdog@lists.wpkg.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/2020 11.01, Daniel P. Berrangé wrote:
[...]
> Does someone have a compelling reason for QEMU to keep supporting
> this driver, other than the fact that it already exists ?
> 
> If not, it looks like a candidate for deprecating in QEMU with a
> view to later removing it.

I think you gave enough examples why this is a good candidate for
deprecation. So I'd say: Simply send a patch to deprecate it. That's
what's our deprecation process is good for. If someone still cares for
sheepdog, they then can speak up and we can revert the patch that put it
on the deprecation list.

 Thomas


