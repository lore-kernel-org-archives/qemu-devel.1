Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B64AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36842240C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWrlSMId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36842240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZt7E-0005Mb-AT
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kZt6S-0004jX-Dw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:59:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kZt6P-0008EI-DD
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604397583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Hng8FF8rYKgUR62gX4zrbElssxECvV9gtRRJaSTRys=;
 b=SWrlSMIdC63nk+UWr4LVXE5j9nHXvKJWw69I/a30WVOWV7T2GKHedYOpc12gXugPfF1QNv
 JSrJxV1BRGrMmYoTvLicK5kmKArSgMuB0+6B8OyBHtIzon1i+EooeR/lS1OFJCfOPIzTZ4
 aPiFbnoLc0BlrJJn9TpE1stskTcOTT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-ayXy8H-_OKCHGs11E6V6HA-1; Tue, 03 Nov 2020 04:59:40 -0500
X-MC-Unique: ayXy8H-_OKCHGs11E6V6HA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751B71009E23;
 Tue,  3 Nov 2020 09:59:39 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-115-14.ams2.redhat.com [10.36.115.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEA9D2CFC6;
 Tue,  3 Nov 2020 09:59:35 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id AE19B3E0488; Tue,  3 Nov 2020 10:59:34 +0100 (CET)
Date: Tue, 3 Nov 2020 10:59:34 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org, libvir-list@redhat.com, kvm@vger.kernel.org
Subject: Re: Call for Volunteers: Summaries of a few KVMForum-2020 talks for
 an LWN article
Message-ID: <20201103095934.cqktlrq3zwxfewzj@paraplu>
References: <20201029142707.eyjimaffcwkbrwcw@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029142707.eyjimaffcwkbrwcw@paraplu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 03:27:07PM +0100, Kashyap Chamarthy wrote:
> Hi, folks
> 
> Like last year[1], we're aiming to submit a KVM Forum 2020 "recap"
> article for LWN.
> 
> This won't be a comprehensive summary of a lot of talks — LWN normally
> aims for 1500 words; they say "fewer can sometimes work, and more is
> generally OK too".  Given that, the write-up can cover about four
> topics, similar to previous year's recap.
> 
> So I'm looking for a couple of volunteers.  Meanwhile, I'll write LWN
> folks an email to see if they're amenable to this.  If they can't accept
> it for some reason, Plan-B is qemu.org blog articles.

Hi, it's me again.

LWN said they're open for a summary article and/or a couple of in-depth
talks -- if there are volunteers.  Generally LWN audience prefers fewer
talks that go deeper.

For an in-depth article, I'm more comfortable doing Eric Blake's "NBD
and Bitmaps: Building Blocks of Change Block Tracking" talk, as I'm
somewhat familar with the topic.

Let us know if anyone else wants to do an in-depth article on any of the
other KVM Forum talks.

[...]


-- 
/kashyap


