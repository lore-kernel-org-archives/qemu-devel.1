Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FFD22268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV0x9O7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FFD22268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTrb-0002rI-AW
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUTpV-0001sF-0X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUTpS-0002E9-Fj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603108792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ge6Uqu/uP5YhwNY3l8LcQgQKlJPd6dM7i3DD+Dv9iM=;
 b=MV0x9O7W+7wZ12aof2JHt5xXdRoxazjhGAcyOcvOzXtci6lp7JP6HMpsnEOxZLHi7STp5U
 zKy44Z8NdZJzbDrXRs7pNujtNe0uSeyUrqK/ZSOA33l2THMw2It0lyYY6+zxexDnMT3p09
 VLv3HABqt+S6Uk/0xWHi8N26wnTy/TY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Xl9vZ474N4GFmNsqDElNdw-1; Mon, 19 Oct 2020 07:59:51 -0400
X-MC-Unique: Xl9vZ474N4GFmNsqDElNdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0965B1015C98;
 Mon, 19 Oct 2020 11:59:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AC5010016DA;
 Mon, 19 Oct 2020 11:59:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A39771132A08; Mon, 19 Oct 2020 13:59:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v2 3/8] migration: Add spaces around operator
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-4-git-send-email-yubihong@huawei.com>
 <20201013101003.GC2920@work-vm> <87a6wi1v4b.fsf@dusky.pond.sub.org>
 <90d55347-0f39-1ac7-f1a1-3982684b2213@huawei.com>
Date: Mon, 19 Oct 2020 13:59:47 +0200
In-Reply-To: <90d55347-0f39-1ac7-f1a1-3982684b2213@huawei.com> (Bihong Yu's
 message of "Mon, 19 Oct 2020 17:43:36 +0800")
Message-ID: <87h7qq4ea4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: zhengchuan@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bihong Yu <yubihong@huawei.com> writes:

> Yes, I used to think "const VMStateDescription *[]" was right, but when I search
> similar expressions, most of all are "xxx * []". Such as:
> fsdev/qemu-fsdev.c:54:        .opts = (const char * [])
> hw/intc/s390_flic_kvm.c:567:    .subsections = (const VMStateDescription * [])
> ...

All three variations occur in the code: no space, space on both sides,
space only on the left.

> So, I keep the same style. Should I change it to "const VMStateDescription *[]"?

Dropping the change to savevm.c should be fine.

Changing it to "VMStateDescription *[]" should be also fine.

I figure you can keep David's R-by in both cases.

[...]


