Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF71C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83507206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaWeAslk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83507206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeXfr-0001rP-Ee
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 01:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeXf5-0001PD-78
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:34:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeXf3-0006s4-RK
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590730467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QkOzN0DkY3Hy6nhZaaidHHsLx60fE7NAy5+T1odMZfk=;
 b=LaWeAslkMBkF1py4Szn9f7timlRXw/fVsggPEANrEvmJLZuwQAWQJR7r4oAsqeOe4kbcve
 sTQP1hsaX6zhbjwbYzX6unMiA6AA7KpxhyJMgqwVUL2phUzySbv2UN+q/pM9iFw3QxXZYJ
 t72UWaxej0Rz/ZAKy40kANh/drqip+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Nw1eYXItMYKDaBmhsGrr1A-1; Fri, 29 May 2020 01:34:23 -0400
X-MC-Unique: Nw1eYXItMYKDaBmhsGrr1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BAC6460;
 Fri, 29 May 2020 05:34:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-144.ams2.redhat.com [10.36.112.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75D482B6E4;
 Fri, 29 May 2020 05:34:20 +0000 (UTC)
Subject: Re: [PATCH v4 1/4] hw/riscv: spike: Remove deprecated ISA specific
 machines
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1590704110.git.alistair.francis@wdc.com>
 <bf556e99b3e7cc1b5388641117858e11b147f9b3.1590704110.git.alistair.francis@wdc.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e9a72108-3253-4d61-15ca-c7160e7c5434@redhat.com>
Date: Fri, 29 May 2020 07:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bf556e99b3e7cc1b5388641117858e11b147f9b3.1590704110.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/2020 00.16, Alistair Francis wrote:
> The ISA specific Spike machines have been deprecated in QEMU since 4.1,
> let's finally remove them.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>  docs/system/deprecated.rst |  17 +--
>  include/hw/riscv/spike.h   |   6 +-
>  hw/riscv/spike.c           | 217 -------------------------------------
>  3 files changed, 12 insertions(+), 228 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


