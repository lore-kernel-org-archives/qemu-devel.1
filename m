Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39FAC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FF42072C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmEcoqdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FF42072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1H2M-0001nx-JC
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 16:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1H0e-0000oz-Qt
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1H0b-0005cn-Vb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:54:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1H0b-0005WX-Q8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581371664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4tGA5Mi+zktgPR4OwyscvVyBPEn50wv2Y/ZzxgboXM=;
 b=PmEcoqdEf2vyVrUs1+WewDG2immKGggI7L64tiHbry32uBbSEyoW+mEN0KgTr17VQ5/WWh
 933yFP5eUolxo1vs82o8v66x7RYxCKxucC0I4zaih/s0uumqTXI1uIU2OCso7Z6xQtgeFF
 TWE3UtjnbG4GLIEaknUyzlu0ohIwvqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-jXvbLjHeMCi-4fDuJctwqA-1; Mon, 10 Feb 2020 16:54:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D22418FF663;
 Mon, 10 Feb 2020 21:54:15 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECDA65C1D4;
 Mon, 10 Feb 2020 21:54:14 +0000 (UTC)
Subject: Re: [qemu PATCH 0/3] NBD_INFO_INIT_STATE extension
To: qemu-devel@nongnu.org
References: <158137149691.31823.13885885177793565059@a1bbccc8075a>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <69dd4619-7472-2bb8-c526-81c16e9a6764@redhat.com>
Date: Mon, 10 Feb 2020 15:54:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158137149691.31823.13885885177793565059@a1bbccc8075a>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: jXvbLjHeMCi-4fDuJctwqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: vsementsov@virtuozzo.com, rjones@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 3:51 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200210214109.751734-1-eblake@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #! /bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-mingw@fedora J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    CC      block/block-copy.o
>    CC      block/crypto.o
> /tmp/qemu-test/src/block/block-backend.c: In function 'blk_known_zeroes':
> /tmp/qemu-test/src/block/block-backend.c:2136:12: error: implicit declaration of function 'bdrv_known_zeroes'; did you mean 'blk_known_zeroes'? [-Werror=implicit-function-declaration]
>       return bdrv_known_zeroes(blk_bs(blk));
>              ^~~~~~~~~~~~~~~~~

Patchew didn't find my Based-on tag in 0/3 (maybe because it wasn't the 
actual cover letter?)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


