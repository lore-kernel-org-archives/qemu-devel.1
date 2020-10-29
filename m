Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6499C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B228204EF
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6EbxwWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B228204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY93K-0000ax-1L
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kY8tf-0003hf-Ix
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kY8td-00062g-3M
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603981638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fBTdTzXftXjdXEiq+IVzjM1JZMchfhSQf6olbJWSTHo=;
 b=S6EbxwWY/mfQ4bGFnYnrdt0KInPtWzOU27qKT0taKY2ZBRUeJn8g7YlNEl0ftRD80tM2Cx
 R/F2F6Jmg5B+as+/OECi9EAD7bIOZf8oVOx9N1N+EfnIgZLtS6VkGJwUQUqwvbnw1GEIGQ
 fulh8psoW3GY5uwVxUMFCGrdSm5a5wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-H1sufUnaMX-1bgWHGNBfhA-1; Thu, 29 Oct 2020 10:27:14 -0400
X-MC-Unique: H1sufUnaMX-1bgWHGNBfhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1629E101EBEA;
 Thu, 29 Oct 2020 14:27:13 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-114-128.ams2.redhat.com
 [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEC8819930;
 Thu, 29 Oct 2020 14:27:08 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 1B8373E047D; Thu, 29 Oct 2020 15:27:07 +0100 (CET)
Date: Thu, 29 Oct 2020 15:27:07 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org, libvir-list@redhat.com, kvm@vger.kernel.org
Subject: Call for Volunteers: Summaries of a few KVMForum-2020 talks for an
 LWN article
Message-ID: <20201029142707.eyjimaffcwkbrwcw@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, folks

Like last year[1], we're aiming to submit a KVM Forum 2020 "recap"
article for LWN.

This won't be a comprehensive summary of a lot of talks — LWN normally
aims for 1500 words; they say "fewer can sometimes work, and more is
generally OK too".  Given that, the write-up can cover about four
topics, similar to previous year's recap.

So I'm looking for a couple of volunteers.  Meanwhile, I'll write LWN
folks an email to see if they're amenable to this.  If they can't accept
it for some reason, Plan-B is qemu.org blog articles.

- KVM Forum 2020 schedule: https://kvmforum2020.sched.com/  
- And LWN.net's author guidelines: https://lwn.net/op/AuthorGuide.lwn

I volunteer to summarize Janosch Frank's "The Common Challenges of
Secure VMs" talk.

Let me know, on-list or off-list, on what topic you'd like to pick.

PS: Just like it was noted in the last year's call for volunteers, we
    will not ask LWN.net for money.

[1] https://lwn.net/Articles/805097/ -- A recap of KVM Forum 2019
[2] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03536.html

-- 
/kashyap


