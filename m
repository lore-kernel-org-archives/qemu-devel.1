Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC28C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD5F206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lkng61i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD5F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixSz0-0005l8-4Y
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 04:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ixSxo-0005Cb-PC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ixSxn-0000G6-Q9
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:51:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ixSxn-0000FY-Mt
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580464307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cviomzRg5yz5ZcSR0NOd41mAIG0BhpVfIN9+HBEchvc=;
 b=Lkng61i+tODMgqp0E4O+iNWaOqWVQgIK+5LgtoMZUCq8sf9/07gIROntZ3yw/8BOfm6DTS
 J7bFR1XdDNapk5TUxKPuAWEkbm8fPu9oPhDUexyfzZ8rkPqi2IkfeHSyVb2+K836hqk7d1
 wAQ5CsSVpjSeT8VGDfHX0/VuaamKHrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-eOUBiBKfOKCQqdFlQ1vMwg-1; Fri, 31 Jan 2020 04:51:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 691CF1005514;
 Fri, 31 Jan 2020 09:51:44 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA5AF811E3;
 Fri, 31 Jan 2020 09:51:38 +0000 (UTC)
Date: Fri, 31 Jan 2020 10:51:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 07/29] tests/acceptance: Use the 'arch' tag to verify
 QEMU binary target
Message-ID: <20200131105136.198adf4f.cohuck@redhat.com>
In-Reply-To: <20200129212345.20547-8-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-8-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: eOUBiBKfOKCQqdFlQ1vMwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 22:23:23 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> We already use the 'arch' tag in Avocado tests. Tests can set
> it to restrict their use on a particular target architecture.
>=20
> If the QEMU binary does not target the required architecture,
> the tests will be cancelled (skipped):
>=20
>   $ avocado --show=3Dapp run tests/acceptance/boot_linux_console.py
>    ...
>    (14/19) BootLinuxConsole.test_arm_cubieboard_initrd: CANCEL: Test expe=
cts arch 'arm' while QEMU binary is targetting 'mips' (0.16 s)
>    (15/19) BootLinuxConsole.test_arm_cubieboard_sata: CANCEL: Test expect=
s arch 'arm' while QEMU binary is targetting 'mips' (0.18 s)
>    (16/19) BootLinuxConsole.test_s390x_s390_ccw_virtio: CANCEL: Test expe=
cts arch 's390x' while QEMU binary is targetting 'mips' (0.14 s)
>    (17/19) BootLinuxConsole.test_alpha_clipper: CANCEL: Test expects arch=
 'alpha' while QEMU binary is targetting 'mips' (0.16 s)
>    (18/19) BootLinuxConsole.test_ppc64_pseries: CANCEL: Test expects arch=
 'ppc64' while QEMU binary is targetting 'mips' (0.18 s)
>    (19/19) BootLinuxConsole.test_m68k_q800: CANCEL: Test expects arch 'm6=
8k' while QEMU binary is targetting 'mips' (0.17 s)
>   RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 1 | WARN 0 | INTERRUPT 0 =
| CANCEL 16
>   JOB TIME   : 19.18 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


