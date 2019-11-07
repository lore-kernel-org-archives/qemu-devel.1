Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2760C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0D42075C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0pt6+P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnhq-0002dg-SB
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iSnh2-00028m-OC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iSnh0-0006dc-Aw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:43:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32712
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iSnh0-0006bU-3r
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573155821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vO3kCgFKP/PqxBGWAlPPuYSJEOuMQW5/MsuYKzxM9X4=;
 b=g0pt6+P7P6fbiDJOSphxdsmR2Y365dnwYGhzae3Xf6Sfjwj9Zq9h2Cm/16SOg1cptGRlNY
 vVa6ggd6PaFaXRpFBEkstSMoCB3r88T1e5U9UVtTXeDx8htNdL1SVCwr3lPxCmh6CABX36
 1616UuIDXoNHW6W0d/UUAOXAMDOqY00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-xfAJRNzqNTy--XQSOHjeyA-1; Thu, 07 Nov 2019 14:43:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DE0A1800D6B
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-31.ams2.redhat.com
 [10.36.116.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C1E160FC5;
 Thu,  7 Nov 2019 19:43:29 +0000 (UTC)
To: QEMU Developers <qemu-devel@nongnu.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Should QEMU's configure script check for bzip2 ?
Message-ID: <da6cfaeb-420e-6e84-ca14-a75d900d65c0@redhat.com>
Date: Thu, 7 Nov 2019 20:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xfAJRNzqNTy--XQSOHjeyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


  Hi,

I just tried to compile QEMU on a freshly installed system. "configure"=20
finished without problems, but during "make" I hit this error:

   BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
/bin/sh: bzip2: command not found
make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
make: *** Waiting for unfinished jobs....

Sure, it's easy to fix, but maybe "configure" should already check for=20
the availablity of "bzip2", so that we then either skip the installation=20
of the edk2 images if "bzip2" is not available, or bail out during=20
"configure" already?

  Thomas


