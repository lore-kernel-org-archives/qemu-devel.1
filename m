Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73DCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5580421906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVaUe9s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5580421906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHIM-0006eo-8f
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iNHDx-000412-Je
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iNHDs-0006ko-6E
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:02:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iNHDm-0006fV-Aj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571839361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2N0r/3ZPUWbWhS7qcO9YRvvvG9oDdigYbWU9QZaPE1I=;
 b=iVaUe9s1GVg93MEzODp2lsezlkZEekyA+Uw4fLluj72V0UaJUNJLkJMHew/iYEfyqtM6hP
 mNhPwYqcP+yyLck+c5XJQ/dFwmHBneoYQdCozWt97Bpavr1y8y1D9Kvd/WGUulCSYprP8O
 FPIMx0Bi0RtKkxTy06FkfQ3MigWHWfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-3KqLCC6_Nka6NuAEdweo7A-1; Wed, 23 Oct 2019 10:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96F655EE
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 14:01:35 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DAB360852
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 14:01:35 +0000 (UTC)
Subject: Re: [PULL 0/3] NBD patches for 2019-10-22
To: qemu-devel@nongnu.org
References: <157183175375.17590.12883932088108636951@37313f22b938>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4c896e81-5857-ed06-0cf8-455299f4f0f4@redhat.com>
Date: Wed, 23 Oct 2019 09:01:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157183175375.17590.12883932088108636951@37313f22b938>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3KqLCC6_Nka6NuAEdweo7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 6:55 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191023020126.24991-1-eblake@redha=
t.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>    TEST    check-unit: tests/test-qht-par
>    TEST    check-qtest-x86_64: tests/hd-geo-test
> **
> ERROR:/tmp/qemu-test/src/tests/migration-test.c:1316:test_migrate_auto_co=
nverge: assertion failed (remaining < expected_threshold): (100003840 < 100=
000000)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:1316:te=
st_migrate_auto_converge: assertion failed (remaining < expected_threshold)=
: (100003840 < 100000000)

Random race? I could not reproduce it, and don't see how this series=20
would break that test.


> The full log is available at
> http://patchew.org/logs/20191023020126.24991-1-eblake@redhat.com/testing.=
docker-quick@centos7/?type=3Dmessage.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


