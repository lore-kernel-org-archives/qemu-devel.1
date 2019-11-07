Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E2C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 20:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8FC214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ub4nWU56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8FC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnxK-0000Qw-9t
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 15:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iSnw7-0008Df-Um
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iSnw5-0002FF-J6
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:59:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30805
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iSnw5-0002DP-7h
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573156756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rszvN1kd9CTOv+VMfzpXXLAx08zFeBoitnKhOnIkrpM=;
 b=Ub4nWU56LWIyKmnHGixt+hc65rYpWpXzuc32P5SdEVoCWPl4xv0NUvig2rblOL8P4nWSf5
 QpnShoVSSD1RYQ5+7srbdEwUiJUKQjMNj2uDNmGFZJKNKn8i+Znf8MoQBLErxWb3d49NhJ
 2faU0++KWIEyz11InuTUoiRKtlPbDbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-FDUfZcEOOo-741NX5OJuUA-1; Thu, 07 Nov 2019 14:59:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B20F01005500
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-91.gru2.redhat.com
 [10.97.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF23D600F0;
 Thu,  7 Nov 2019 19:59:04 +0000 (UTC)
Subject: Re: Should QEMU's configure script check for bzip2 ?
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <da6cfaeb-420e-6e84-ca14-a75d900d65c0@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <313ea616-7ce4-2427-9f80-f489bf13d612@redhat.com>
Date: Thu, 7 Nov 2019 17:59:03 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <da6cfaeb-420e-6e84-ca14-a75d900d65c0@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FDUfZcEOOo-741NX5OJuUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/7/19 5:43 PM, Thomas Huth wrote:
>
> =C2=A0Hi,
>
> I just tried to compile QEMU on a freshly installed system.=20
> "configure" finished without problems, but during "make" I hit this=20
> error:
>
> =C2=A0 BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
> /bin/sh: bzip2: command not found
> make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
> make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
> make: *** Waiting for unfinished jobs....

This error happened with me a few times as well. And I always wondered=20
why bzip2 isn't checked on configure.

>
>
> Sure, it's easy to fix, but maybe "configure" should already check for=20
> the availablity of "bzip2", so that we then either skip the=20
> installation of the edk2 images if "bzip2" is not available, or bail=20
> out during "configure" already?

IMHO, it should be checked since bzip2 is a build dependency.

Thanks,

Wainer

>
>
> =C2=A0Thomas
>
>


