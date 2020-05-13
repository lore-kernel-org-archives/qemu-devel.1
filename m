Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD1CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F822054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7yeEvdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F822054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrmt-0002P3-CF
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYrlt-0001af-CJ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:50:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYrls-00080I-GX
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589377802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zeTXOJUfurJkA50kS6L23ANzVlHj1xQ8jg3LIragn2k=;
 b=P7yeEvdTAtNlgRjyXbVgBPeLIx2BLVDaUtwKTEu22NodwQ8BW5fcHFzWdf98DlP+Sr8is4
 FKIKEnZPSSgpsAEMkDNXxi1RwRyxb0+EYduzbVybomRb7coMbzJroAUPRKU5SJq8GaqV6J
 gbR9ZJhQgKj3rpLHtufpOleLaOhamFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-4JLBbM5qNL2SUvHA4zglEw-1; Wed, 13 May 2020 09:50:00 -0400
X-MC-Unique: 4JLBbM5qNL2SUvHA4zglEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2B280183C;
 Wed, 13 May 2020 13:49:59 +0000 (UTC)
Received: from kaapi (unknown [10.74.9.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBBB860CD1;
 Wed, 13 May 2020 13:49:46 +0000 (UTC)
Date: Wed, 13 May 2020 19:19:42 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
In-Reply-To: <20200512194759.nb42yurlnynr5yrw@mozz.bu.edu>
Message-ID: <nycvar.YSQ.7.76.2005131905010.1451610@xnncv>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
 <20200512190803.o6vr2shjmhsplsjx@mozz.bu.edu>
 <20200512194759.nb42yurlnynr5yrw@mozz.bu.edu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ren Ding <rding@gatech.edu>,
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Alex,

+-- On Tue, 12 May 2020, Alexander Bulekov wrote --+
| I noticed this since I found a similar issue recently, using a fuzzer. I 
| applied your patches, but I can still reproduce the heap-overflow, unless 
| I'm missing something:

Strange, because with uint16_t type, 'reply_queue_head' should not turn 
negative.

| cat << EOF | qemu-system-i386 -qtest stdio -nographic -monitor none \
| -serial none -M q35 -device megasas -device scsi-cd,drive=null0 \
| -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
| outl 0xcf8 0x80001814
| outl 0xcfc 0xc021
| outl 0xcf8 0x80001818
| outl 0xcf8 0x80001804
| outw 0xcfc 0x7
| outl 0xcf8 0x80001810
| outl 0xcfc 0xe10c0000
| outl 0xcf8 0x8000f810
| write 0x0 0x18 0x060017e1ff00f8ffffffff60efffffffffffffffffffffff
| write 0xff00 0x1 0x06
| write 0xc021e10c0040 0x81 0x755e08ff0000845e08ff0000935e08ff0000a25e08ff0000b15e08ff0000c05e08ff0000cf5e08ff0000de5e08ff0000ed5e08ff0000fc5e08ff00000b5e08ff00001a5e08ff0000295e08ff0000385e08ff0000475e08ff0000565e08ff0000655e08ff0000745e08ff0000835e08ff0000925e08ff0000a15e08ff0000b05e08
| -M pc-q35-5.0 -no-shutdown -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
| EOF

Are qemu options just above EOF right?

This leads to an assert failure below

  qemu/qtest.c:546:qtest_process_command: assertion failed: (words[1] && words[2] && words[3])
  ...
  Aborted                 (core dumped) /tmp/im/bin/qemu-system-x86_64 -qtest 
  stdio -nographic -monitor none -serial none -M q35 -device megasas -device 
  scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic < ins


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


