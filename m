Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7A1C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AB72071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUNoOm9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AB72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZtTH-0007Fx-Qm
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iZtSH-0006no-OR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iZtSF-00030b-MX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:17:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24176
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iZtSF-000304-IY
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574846266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3ay6Hwx4LX1mIXIsGywKwNi1Xr4WUfia6IVhUw8YUo=;
 b=VUNoOm9kaSRnpZjhol3GZ0Jk6mEh2PnYiamGGIGrpXkYk2FUIWcBA3XJtteuQdwRlbkzmL
 J7pNxDk1je/UqPTOuwMcgHv9LCV/OlT34dMdlMnYUskrt3NowDagMwZa9RskOPxuUQNiXj
 74rWz892ik+Q2JSdV0XPdTsGwlgDoqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-OBthrqflNV2nsBeX-f8T4g-1; Wed, 27 Nov 2019 04:17:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FD5180183C
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:17:42 +0000 (UTC)
Received: from localhost (ovpn-117-23.ams2.redhat.com [10.36.117.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2D6D60BE2;
 Wed, 27 Nov 2019 09:17:36 +0000 (UTC)
Date: Wed, 27 Nov 2019 10:17:35 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PULL 0/5] i386 patches for QEMU 4.2-rc
Message-ID: <20191127091735.zgnq6xvso7hjhwda@jenstp.localdomain>
References: <157475994490.31055.5778115059405326734@37313f22b938>
 <e5352867-943c-6010-4700-78a0e25cea10@redhat.com>
 <20191127091401.GA3016@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191127091401.GA3016@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: OBthrqflNV2nsBeX-f8T4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 09:14:01AM +0000, Dr. David Alan Gilbert wrote:
>* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
>> On 11/26/19 10:19 AM, no-reply@patchew.org wrote:
>> > Patchew URL: https://patchew.org/QEMU/20191126085936.1689-1-pbonzini@r=
edhat.com/
>> >
>> > This series failed the docker-quick@centos7 build test. Please find th=
e testing commands and
>> > their output below. If you have Docker installed, you can probably rep=
roduce it
>> > locally.
>> >
>> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> > #!/bin/bash
>> > make docker-image-centos7 V=3D1 NETWORK=3D1
>> > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>> >
>> >    TEST    check-unit: tests/test-thread-pool
>> > wait_for_migration_fail: unexpected status status=3Dwait-unplug allow_=
active=3D1
>> > **
>> > ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:wait_for_migration=
_fail: assertion failed: (result)
>> > ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:=
wait_for_migration_fail: assertion failed: (result)
>> > make: *** [check-qtest-aarch64] Error 1
>>
>> Should we worry about this error?
>
>Interesting; that should be fixed by Jens'
>284f42a520cd9f5905abac2fa50397423890de8f - unless fix dev_unplug_pending
>is still lying;  it's showing we're still landing in 'wait-unplug' on
>aarch, because it's got a virtio-net by default; even though we've not
>got a failover device setup.  CCing Jens.

Hmm, I did test it. I'm looking into it.

regards
Jens


