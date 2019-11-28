Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06127C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76092176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6n+9Mpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76092176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaRqZ-0001V8-S3
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 17:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iaR69-0006p5-Qr
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 16:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iaR61-0000r8-2b
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 16:13:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iaR60-0000iN-T8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 16:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574975583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1g0/LQfikkaOgIwQGuStDaIwD3mq/a32lN001UsYBE=;
 b=C6n+9MpeCCeRVQ4YDXt8jbkIu2h6+MUb22QDpzT54vHtgqCD9Me0Gb6EAzS3+mM8Z+s8Xw
 JTi6vSvE+7UME15wHpahOTWGuWR3yjpot7YZEYIezYdFrE8CdZeu8VGA9kFLDv8D3++9lY
 +dajEAvIEMbp1bLHXk5AythRHL84q2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-FD8tvYigNKSzC7smUu-YkA-1; Thu, 28 Nov 2019 16:13:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A95C8017CC
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 21:13:00 +0000 (UTC)
Received: from localhost (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4DB55C1B2;
 Thu, 28 Nov 2019 21:12:56 +0000 (UTC)
Date: Thu, 28 Nov 2019 22:12:55 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PULL 0/5] i386 patches for QEMU 4.2-rc
Message-ID: <20191128211255.cl54hykhxoygdqdj@jenstp.localdomain>
References: <157475994490.31055.5778115059405326734@37313f22b938>
 <e5352867-943c-6010-4700-78a0e25cea10@redhat.com>
 <20191127091401.GA3016@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191127091401.GA3016@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FD8tvYigNKSzC7smUu-YkA-1
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

I've run this test  on aarch64 in a loop today for a few hours but could no=
t
reproduce this error.

One bug I found is that in primary_unplug_device() I look at the
virtio guest feature bits instead of the negotiated bits. But I don't
think this could lead to the above problem because even if the check
for the feature bit fails, primary_unplug_pending would still return
false because no primary device was set and n->primary_dev is NULL.=20

I'll keep the test running until I can reproduce it.=20

regards
Jens


