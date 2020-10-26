Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C3BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D358C22409
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLHYUjek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D358C22409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4op-0001l2-J9
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kX4lT-0006aB-Dl
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kX4lP-0003s8-7s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603727426;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FCQ2Ijhm4vdWKhQo1qCx9qir+Q1AWzQIaGf3I2SYIwk=;
 b=jLHYUjekb5sEZrrXZkFe3Sz7Qk95oVtrtV7aToQ+s/Ibefy6LhWwjF6ITL0G6hKhE07WpO
 osN03c7CvNnwGA2u2corZKIi+8vsR12LggpwmK0ij81VqgiWzhLzKSvdqtTGTsK2P8zA0E
 tq3TluRtdZXJRRBxrr0em2xIqqZP/AM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-GHF0XuyxMDGFPzhK8TzKFw-1; Mon, 26 Oct 2020 11:50:14 -0400
X-MC-Unique: GHF0XuyxMDGFPzhK8TzKFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03D65192AB60;
 Mon, 26 Oct 2020 15:50:13 +0000 (UTC)
Received: from redhat.com (ovpn-114-185.ams2.redhat.com [10.36.114.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CBA25C1C2;
 Mon, 26 Oct 2020 15:50:09 +0000 (UTC)
Date: Mon, 26 Oct 2020 15:50:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
Message-ID: <20201026155006.GE496050@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 10:51:43AM +0100, Paolo Bonzini wrote:
> On 23/10/20 22:06, Daniele Buono wrote:
> > This patch allows to compile QEMU with link-time optimization (LTO).
> > Compilation with LTO is handled directly by meson. This patch adds checks
> > in configure to make sure the toolchain supports LTO.
> > 
> > Currently, allow LTO only with clang, since I have found a couple of issues
> > with gcc-based LTO.
> > 
> > In case fuzzing is enabled, automatically switch to llvm's linker (lld).
> > The standard bfd linker has a bug where function wrapping (used by the fuzz*
> > targets) is used in conjunction with LTO.
> > 
> > Tested with all major versions of clang from 6 to 12
> > 
> > Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> 
> What are the problems like if you have GCC or you ar/linker are not up
> to the job?  I wouldn't mind omitting the tests since this has to be
> enabled explicitly by the user.

We temporarily disabled LTO in Fedora rawhide due to GCC bugs causing
wierd test suite asserts. Those were pre-release versions of GCC/binutils
though. I've just tested again and LTO works correctly, so I've enabled
LTO once again. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


