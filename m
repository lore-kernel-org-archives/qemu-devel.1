Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFBFC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688FD206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DldctpyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688FD206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVDK3-0005TO-Jr
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 06:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iVDIs-0004XA-Ts
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iVDIr-0003nF-HR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:28:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iVDIr-0003lw-Dm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573730924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7a1gYFiDyBw42go8RGzm+B1KF18Nn2Cz1XCfk3DW2Q0=;
 b=DldctpyNvngjZ177wMXV7IoYBNMyuidsnzLJcIN4kZSwXMH2krnOiC3KeYIcIBySu/AVJQ
 XuFQ6OpL4z/efIfZvF46mcjBTRjnCtGRjImZD3vomKM5WJ3Jyv8/aH+qfcbhyWWxOoVxMX
 ssgNg0l+SMzw74alvP09soZ8NyID+s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-ZwWCOypIOs-Lrnphiwh2xw-1; Thu, 14 Nov 2019 06:28:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B2C101089D;
 Thu, 14 Nov 2019 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-89.ams2.redhat.com
 [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CCAF5C219;
 Thu, 14 Nov 2019 11:28:32 +0000 (UTC)
Subject: Re: [PATCH 2/2] tests: Add tests for query-netdevs command
To: Alexey Kirillov <lekiravi@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20191113212516.13606-1-lekiravi@yandex-team.ru>
 <20191113212516.13606-3-lekiravi@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0ef2f9bd-df33-b476-950a-d38eaa41659e@redhat.com>
Date: Thu, 14 Nov 2019 12:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113212516.13606-3-lekiravi@yandex-team.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZwWCOypIOs-Lrnphiwh2xw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 yc-core@yandex-team.ru, Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 22.25, Alexey Kirillov wrote:
> Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
> ---
>  tests/Makefile.include     |   2 +
>  tests/test-query-netdevs.c | 114 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 tests/test-query-netdevs.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 534ee48743..4d199e463b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -297,6 +297,7 @@ check-qtest-s390x-y +=3D tests/migration-test$(EXESUF=
)
>  check-qtest-generic-y +=3D tests/machine-none-test$(EXESUF)
>  check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
>  check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)
> +check-qtest-generic-y +=3D tests/test-query-netdevs$(EXESUF)

Please use -$(CONFIG_SLIRP) instead of "-y" here.

>  qapi-schema +=3D alternate-any.json
>  qapi-schema +=3D alternate-array.json
> @@ -844,6 +845,7 @@ tests/numa-test$(EXESUF): tests/numa-test.o
>  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o te=
sts/acpi-utils.o
>  tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libq=
os-obj-y)
>  tests/arm-cpu-features$(EXESUF): tests/arm-cpu-features.o
> +tests/test-query-netdevs$(EXESUF): tests/test-query-netdevs.o
> =20
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
>  =09$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $<=
 ,"LINK","$(TARGET_DIR)$@")
> diff --git a/tests/test-query-netdevs.c b/tests/test-query-netdevs.c
> new file mode 100644
> index 0000000000..2afde36114
> --- /dev/null
> +++ b/tests/test-query-netdevs.c
> @@ -0,0 +1,114 @@
> +/*
> + * QTest testcase for the query-netdevs
> + *
> + * Copyright Yandex N.V., 2019
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See

Please use "GNU GPL, version 2 or later" for new code (as described in
the bottom part of the LICENSE file in the top directory).

> + * the COPYING file in the top-level directory.
> + *
> + */
[...]
> +static void test_query_netdevs(void)
> +{
> +    const char *arch =3D qtest_get_arch();
> +    size_t correction =3D 0;
> +    QObject *resp;
> +    QTestState *state;
> +
> +    if (strcmp(arch, "arm") =3D=3D 0 ||
> +        strcmp(arch, "aarch64") =3D=3D 0 ||
> +        strcmp(arch, "tricore") =3D=3D 0) {
> +        g_test_skip("Not supported without machine type");

Since you're doing the check for the target architecture anyway, you
could also use "-M virt" for arm/aarch64 and "-M tricore_testboard" for
tricore, I think.

> +        return;
> +    }
> +
> +    /* Archs with default not unpluggable netdev */

maybe better: "Archs which still have a netdev despite of -nodefaults" ?

> +    if (strcmp(arch, "cris") =3D=3D 0 ||
> +        strcmp(arch, "microblaze") =3D=3D 0 ||
> +        strcmp(arch, "microblazeel") =3D=3D 0 ||
> +        strcmp(arch, "sparc") =3D=3D 0) {
> +        correction =3D 1;
> +    }

Just a matter of taste, but I like "g_str_equal()" more than the
old-fashioned "strcmp() =3D=3D 0".

 Thomas


