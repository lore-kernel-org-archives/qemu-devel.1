Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D943C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483E324672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="df14W4uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483E324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9wd-0004ZH-SR
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9qP-0004gj-K5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9qO-00084g-5N
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9qO-00084N-1I
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhFIalaTxU91OoV48DnFSPFNJm8dAicRjzIYIIHrgm0=;
 b=df14W4uU5zRFKdRpaO1ruSdB/SvGAtenE4t5IBhW9FpQJeYe2cdtdUI/6wPLjyXtmMVoUM
 lcXqGhX09zW6//vqrG5V0CkMZjFaTgJLmQquix8sD9YSqCRaprpIBo113GmqFBOqTufqkP
 vcUolyHgf9xjQ/r0T3mNq1E3vvs7y6Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-QOgTGeNuM3G95B4JYUv1pg-1; Wed, 22 Jan 2020 01:50:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so2574428wrm.23
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fOfds3FYn0MZPs9ppwu2iVTjnTK6UfVjQJxMiUG3xkc=;
 b=IUWA3gekm1BskcWnejX8KP/GDk3JtgxR3l3NDZ8BMxu1zBJcqS4P2pz75iNamImdYl
 DtnYz8f2CAX/TpnZUDCeqfA7o3za8x2yi0VlWqH9cAsuGuPmH4Avly26ewFdG1zBM1SB
 XUHuGcf2ywCdADMtX/g9Ej2wDW0EoFNgcW8DI5UwP95tDHtAvalkJqE6G3WRuhBZXDbg
 xoIDTT5J5N9SrdlM1Ajb1aQDRs3tfKH5FY8q4BT9+V8DHvNNMO5tf7lhmGucOvIqadxi
 XsX8HyaFD0NTl5u4EPEHnvVzP6z3caQiSsDrI2eRzwsFbi8oFQcEjo5bUz6U7Mq3ITQJ
 Cn0A==
X-Gm-Message-State: APjAAAW1tav3ZDSvxMb4TvGMdjcnXClZMOoa0FlmS6mgtg9TPN/QJGzS
 /41rZZVjsI3FqAS1+tPx6qc3imx+Aa+17nvOxpEaHzxSwIxRNy97DgrVPTMS0ohT/mHt+G+/IrJ
 rmcriX9L6npu6R7w=
X-Received: by 2002:adf:ee92:: with SMTP id b18mr8784568wro.281.1579675824164; 
 Tue, 21 Jan 2020 22:50:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdQlrbxWN/WmLmJoNENTrtKjaMbLN28809nFRCUwfmJyX8Fl3IbinJE+XCNnYVoim1DfOiAQ==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr8784535wro.281.1579675823939; 
 Tue, 21 Jan 2020 22:50:23 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 d8sm54802647wrx.71.2020.01.21.22.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:23 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] virtio, pc: fixes, features
Message-ID: <20200122015007-mutt-send-email-mst@kernel.org>
References: <20200122055115.429945-1-mst@redhat.com>
 <157967421148.8714.13063905979235625106@f6d1ed32ca6b>
MIME-Version: 1.0
In-Reply-To: <157967421148.8714.13063905979235625106@f6d1ed32ca6b>
X-MC-Unique: QOgTGeNuM3G95B4JYUv1pg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 10:23:32PM -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200122055115.429945-1-mst@redhat.=
com/
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

OK just a missing expected file. Will send v2.

> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Using expected file 'tests/data/acpi/q35/DSDT.acpihmat'
> acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-JWZVE=
0], Expected [aml:tests/data/acpi/q35/DSDT.acpihmat].
> to see ASL diff between mismatched files install IASL, rebuild QEMU from =
scratch and re-run tests with V=3D1 environment variable set**
> ERROR:/tmp/qemu-test/src/tests/qtest/bios-tables-test.c:490:test_acpi_asl=
: assertion failed: (all_tables_match)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/bios-tables-test.c=
:490:test_acpi_asl: assertion failed: (all_tables_match)
> make: *** [check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    iotest-qcow2: 049
>   TEST    iotest-qcow2: 050
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Dbf9f3c03d7fd4eeab2985d10a998dce8', '-u'=
, '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', =
'-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/=
var/tmp/patchew-tester-tmp-7wut4nre/src/docker-src.2020-01-22-01.10.32.9979=
:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' r=
eturned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dbf9f3c03d7fd4eeab298=
5d10a998dce8
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-7wut4nre/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>=20
> real    12m59.608s
> user    0m10.933s
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200122055115.429945-1-mst@redhat.com/testing.do=
cker-quick@centos7/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


