Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6B420658
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEriDPHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6B420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7eEB-0005SL-Ur
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7eDb-000527-2q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:26:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7eDZ-0006Qi-9c
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597667184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7kWSts9KkxpQXjj8kfB3LeAtJ3OCKDudgevuIMI83o=;
 b=XEriDPHXRZ8ZUudbAavsbJosP2vhPufbIXdpFNfdPTKzn12J+EcRLKyApQVGDuhaZA7qFh
 /ym7uWIyky+ulNaIQOCwZsRbIRzB7RccqwltQ/M5tty8EG5wqO6URjqCJY2QQU4YGy++Nv
 lD9iNG3iTG+7xLnKi66Vkw3nBSziAtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-O-Prp0LAM0OyfCpE6_6kXA-1; Mon, 17 Aug 2020 08:26:21 -0400
X-MC-Unique: O-Prp0LAM0OyfCpE6_6kXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 058F751BC
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 12:26:21 +0000 (UTC)
Received: from gondolin (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 387307A3B7;
 Mon, 17 Aug 2020 12:26:20 +0000 (UTC)
Date: Mon, 17 Aug 2020 14:26:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
Message-ID: <20200817142617.0ab2b9f3.cohuck@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Aug 2020 05:10:56 -0400
Paolo Bonzini <pbonzini@redhat.com> wrote:

> News since v1:
> * automatically generate dependencies for sphinx manuals [Peter]
> * fixes for ARM KVM build [Peter]
> * work around old libiscsi in vhost-user-scsi.c [Peter]
> * hack to support default c:/Program Files/QEMU prefix on mingw cross compilation [Peter]
> * added --enable-gettext/--disable-gettext [Peter]
> * test for setuptools presence [Peter]
> * fixes for Darwin [Peter, Roman]
> * do not invoke system Meson through Python, always use embedded Meson with --python [Roman]
> * improvements and fixes to clean and distclean targets [Stefano]
> * avoid (incorrect?) ubsan failure from CONFIG_BDRV_*_WHITELIST [Alexander]
> * move --s390-pgste to Meson, removed QEMU_CFLAGS/QEMU_LDFLAGS for config-target.mak
> * remove some dead configure assignments
> * update build system docs on how to add configure options, convert to rST
> * moved installation of edk2 blobs and descriptors to Meson
> * build and install elf2dmp on Windows too
> * included headers renamed to .c.inc instead of .inc
> 
> Available from https://gitlab.com/bonzini/qemu branch meson-poc-next.

The good news: This seems to produce working binaries on my laptop and
my s390x systems.

The bad news: The build on the s390x system with Fedora 30 (yes, I
know) seems to be lacking various devices. The output of
'qemu-system-s390x -device ?' misses all of the
-transitional/-non-transitional varieties for virtio-pci devices, as
well as some of the vhost-user devices, and, rather bizarrely, the
gen15* and some of the z14 cpu models (this is on a z12, so it's not
that all 'newer' models are missing, and I don't think the system we
build on should influence the generation of models, even with an older
compiler). I checked the output from 'qemu-system-x86_64 -device ?',
and it is missing the -transitional/-non-transitional virtio-pci
devices as well (did not check if anything else is missing as well).
The builds on the F31 (x86) and F32 (s390x, with -Werror disabled)
systems are fine.

Any idea? If it is a case of old tools/libraries, I think we need to
make sure that older supported distros (Debian stable?) still work fine.


