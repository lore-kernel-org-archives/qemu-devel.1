Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CC5C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC361206FC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTPrDuZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC361206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLuN4-0000Zo-Ky
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLuM0-0008Tu-Jp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLuLz-0004Bp-0F
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:30:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601065802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAy2Usa1Xgi+r6n7+Zd4qQIRov37JJVapv3XtfOmTn4=;
 b=MTPrDuZB38N88DpFO16oz9V2Y07I9dz3o6RiZssIyBEe+Qz+LaRNS1abnlyop6eN0BtD1j
 SNoNZwhldEJyT7OwfB2m0YqUUVc0uKAXCcMmXCjB8NbUnFrmtlQyIDTWaycWUmJFPxwQfU
 pOmCDemtg0aY39JpPjGfpfJx5ec16Ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-o_NpM6qZMEyZh-WRPGDZxA-1; Fri, 25 Sep 2020 16:30:00 -0400
X-MC-Unique: o_NpM6qZMEyZh-WRPGDZxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8AF3100747A;
 Fri, 25 Sep 2020 20:29:58 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F7F919C78;
 Fri, 25 Sep 2020 20:29:57 +0000 (UTC)
Date: Fri, 25 Sep 2020 16:29:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Message-ID: <20200925202956.GV3717385@habkost.net>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
 <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kang,
 Luwei" <luwei.kang@intel.com>, "Strong, Beeman" <beeman.strong@intel.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 10:23:49PM +0200, Paolo Bonzini wrote:
> On 25/09/20 18:54, Eduardo Habkost wrote:
> > On Fri, Sep 25, 2020 at 04:42:26PM +0000, Strong, Beeman wrote:
> >> LIP=0 will differ from LIP=1 behavior only when CSbase is non-zero, which requires 32-bit code.  In that case a LIP=0 implementation will provide only the EIP offset from CSbase in IP packets (like TIP or FUP), while LIP=1 implementation will provide the full LIP (CSbase + EIP offset).
> >>
> > Thanks.  Is it possible to make KVM emulate LIP=0 behavior
> > correctly on LIP=1 hosts, or vice versa?
> 
> No, it's not possible.  KVM doesn't have a say on what the processor
> writes in the tracing packets.

Can KVM refuse to enable packet generation if CSbase is not zero
and CPUID.(EAX=14H,ECX=0)[bit 31] seen by guest is different from
host?

-- 
Eduardo


