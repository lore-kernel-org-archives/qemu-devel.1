Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD80206B2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dh0zttEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD80206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwBL-0008F8-Pd
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kZw9o-0007Ji-Qk
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kZw9j-0003Gr-Mu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604409317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcY+gSyJOP+4RO5VFfCpl5otnP98uta6TwhvoHbpxFU=;
 b=Dh0zttEBGpalMHyH7mYhy0Rb7U0m2O6XY/VwKnuB+rhrQWoTH7JMN5ThfTLD8G03TiYNIV
 lgYDbq5UiycmGPp04HjN+u20s0fjJN5kHfUp/Wv97ehPMvG9SmAYXaoGWrnT/CMDRqVgJz
 BmVLWhz6VjjOqIbUQn32WjMxsa9hqXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-4CdDjtp9M5-h7CulC6b0Kg-1; Tue, 03 Nov 2020 08:15:15 -0500
X-MC-Unique: 4CdDjtp9M5-h7CulC6b0Kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C2C5E06BB;
 Tue,  3 Nov 2020 13:15:12 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4128A5B4D8;
 Tue,  3 Nov 2020 13:14:58 +0000 (UTC)
Date: Tue, 3 Nov 2020 14:14:55 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.2 v3] hw/mips: Remove the 'r4k' machine
Message-ID: <20201103131455.GN727443@angien.pipo.sk>
References: <20201102201311.2220005-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20201102201311.2220005-1-f4bug@amsat.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pkrempa@redhat.com;
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 21:13:11 +0100, Philippe Mathieu-Daudé wrote:
> We deprecated the support for the 'r4k' machine for the 5.0 release
> (commit d32dc61421), which means that our deprecation policy allows
> us to drop it in release 5.2. Remove the code.
> 
> To repeat the rationale from the deprecation note:
> - this virtual machine has no specification
> - the Linux kernel dropped support for it 10 years ago
> 
> Users are recommended to use the Malta board instead.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v3: Move to "Recently removed features" section
> ---
>  docs/system/deprecated.rst                    |  12 +-
>  .../devices/mips-softmmu-common.mak           |   1 -
>  hw/mips/r4k.c                                 | 318 ------------------
>  MAINTAINERS                                   |   6 -
>  hw/mips/Kconfig                               |  13 -
>  hw/mips/meson.build                           |   1 -
>  6 files changed, 6 insertions(+), 345 deletions(-)
>  delete mode 100644 hw/mips/r4k.c

To be honest, libvirt doesn't have a single mips-based VM definition in
the test-suite, so our mips support is rather theoretical.

On behalf of libvirt:

ACKed-by: Peter Krempa <pkrempa@redhat.com>


