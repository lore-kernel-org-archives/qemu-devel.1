Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31305C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08D7205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAYHZS0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08D7205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviOw-0007wy-AI
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jviOJ-0007TB-MA
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:28:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jviOI-0003Wg-42
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594823289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=NHkonzKyaJUONMciab36p/2KZYaTtetqNBd9lKV2594=;
 b=hAYHZS0eVxdR8nbWDIwJnnyBWc+Cfho/6/ZvzuWKkfA5eG8otQXCpnyl6kDQfEx5VGlv8S
 YQ7GWR+ScT04s93l35igqkK+6/riKqcP7v0fpN59jzUX7kRoA4sPY6A9/q0VeESmyeyb/D
 LQVzR4VbSm5JnGNGtDigCIwiHrK08Y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-3NI1SWhPM5K4eRiIXR-Izw-1; Wed, 15 Jul 2020 10:28:04 -0400
X-MC-Unique: 3NI1SWhPM5K4eRiIXR-Izw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4713780183C;
 Wed, 15 Jul 2020 14:28:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-26.ams2.redhat.com [10.36.112.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36FDD6FEF5;
 Wed, 15 Jul 2020 14:27:59 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/2] hw: Mark nd_table[] misuse in realize methods
 FIXME
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-3-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5865965e-7075-0a6d-1e75-3ce174df68b6@redhat.com>
Date: Wed, 15 Jul 2020 16:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200715140440.3540942-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, alistair@alistair23.me,
 mark.cave-ayland@ilande.co.uk, sundeep.lkml@gmail.com, b.galvani@gmail.com,
 nieklinnenbank@gmail.com, qemu-arm@nongnu.org, palmer@dabbelt.com,
 edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/2020 16.04, Markus Armbruster wrote:
> nd_table[] contains NIC configuration for boards to pick up.  Device
> code has no business looking there.  Several devices do it anyway.
> Two of them already have a suitable FIXME comment: "allwinner-a10" and
> "msf2-soc".  Copy it to the others: "allwinner-h3", "xlnx-versal",
> "xlnx,zynqmp", "sparc32-ledma", "riscv.sifive.u.soc".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/allwinner-h3.c | 1 +
>  hw/arm/xlnx-versal.c  | 1 +
>  hw/arm/xlnx-zynqmp.c  | 1 +
>  hw/dma/sparc32_dma.c  | 1 +
>  hw/riscv/sifive_u.c   | 1 +
>  5 files changed, 5 insertions(+)

Maybe we should add an entry to
https://wiki.qemu.org/Contribute/BiteSizedTasks for this?

Reviewed-by: Thomas Huth <thuth@redhat.com>


