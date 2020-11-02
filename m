Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86532225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrXhzdMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86532225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZf0t-0001Pz-EO
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kZezz-0000jf-Nn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kZezx-00031O-Ro
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604343367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lycTEsYB+uVxyBhV+TAFc2KRRIUnh+tET9Q7u27LSck=;
 b=HrXhzdMmXi+VEjAQnIGggM0oVgwRDZi5NURVNL/at4mlxAJTSt54QZQ834Ispw5rWdyHrR
 2KDWZUJj8DbdNNmmNfS1HmJa9W1uKx8lxFYatk2TmkzWFvGtEWha1Q+c5C1fCrnh0aYNLd
 fIKA/UxdDcLmiUWaxuCPMIAn20WMiXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-uj425gYeMfqxlVWL0SkRJg-1; Mon, 02 Nov 2020 13:56:06 -0500
X-MC-Unique: uj425gYeMfqxlVWL0SkRJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43BDA1074645
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 18:55:26 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3C4660CCC;
 Mon,  2 Nov 2020 18:55:25 +0000 (UTC)
Date: Mon, 2 Nov 2020 13:55:24 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 7/7] tests/acceptance: Add virtiofs_submounts.py
Message-ID: <20201102185524.GT5733@habkost.net>
References: <20201102161859.156603-1-mreitz@redhat.com>
 <20201102161859.156603-8-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102161859.156603-8-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 05:18:59PM +0100, Max Reitz wrote:
> This test invokes several shell scripts to create a random directory
> tree full of submounts, and then check in the VM whether every submount
> has its own ID and the structure looks as expected.
> 
> (Note that the test scripts must be non-executable, so Avocado will not
> try to execute them as if they were tests on their own, too.)
> 
> Because at this commit's date it is unlikely that the Linux kernel on
> the image provided by boot_linux.py supports submounts in virtio-fs, the
> test will be cancelled if no custom Linux binary is provided through the
> vmlinuz parameter.  (The on-image kernel can be used by providing an
> empty string via vmlinuz=.)
> 
> So, invoking the test can be done as follows:
> $ avocado run \
>     tests/acceptance/virtiofs_submounts.py \
>     -p vmlinuz=/path/to/linux/build/arch/x86/boot/bzImage
> 
> This test requires root privileges (through passwordless sudo -n),
> because at this point, virtiofsd requires them.  (If you have a
> timestamp_timeout period for sudoers (e.g. the default of 5 min), you
> can provide this by executing something like "sudo true" before invoking
> Avocado.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Fixes the issue detected in v3.

Tested-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo


