Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1342DC33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D660521835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASZZicy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D660521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9TN-0003Nr-VN
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9Sk-0002yr-EP
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9Sh-0006Qv-NS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:26:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9Sh-0006QY-Jo
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579674358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+CP+HYNibMgz8xhLZs71Q8Vhzgso3BoxeM4ot9NYFc=;
 b=ASZZicy2XC8TZWWDd+rl7Gw/DRP5V/PlndBGxStckgA2ThIiRbVJOjlYv1IDasLOVZBZdv
 m44dH4NV6iLK+gVMQqtQAtHdIbyfhJUm48eBxgq+oQ5HW4JZiGhEJLxOex3UnuxL+rxrMQ
 haQAadz46HdgBNOtOmDC6yPNt2zs+xQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-n2Bs92PQNh-uaMvF5HrD9g-1; Wed, 22 Jan 2020 01:25:53 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so2572578wrp.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9AJ/5+myMk/lt7ENFbrWLCfNnU49MJy5ELIt0UsuBz4=;
 b=VTDlAPRnjpkOH6Q8GtDa8IEqmm91gslcWWG9Ok284mBnQegc5AgVFp03FfMRm1n98N
 frkk9WHKdrA1WT7gBek7Eu7hqYFI/umwc3d6OjYXjsv66Ujkia3IxhjBk2QOckbGoRuc
 dPr5jRHeSWxSgiQyAqAGbzt2tzAZj7+4k4Ryt9tJiEROphEOGCRIGxHs51JYArXCETir
 M40m+qvrYvVIUv1UaKOkh3GLU54A5DlE34NwQpSjoh+qJu7x/IvpfzXH6Kj+TYfbbKTD
 z57YDf0+hkskd31rs+S2Keke3C6PppZycSpOdIU7cIq/V5+ogNCjbRpx6uQepIAE23gr
 Naog==
X-Gm-Message-State: APjAAAWTAMDaxH/lJa8rnTI1Tzlh0Uoa4qVkgOKjgvZsbSTUDviUisxa
 1yKdR7jU87FSRngVc9IjN7a/40SFiEPeF1EqzDeQJVdDQMs7ak4LnE2sZYCz5vNSFphpyMWtBq/
 /gIYaGG5uMZwHKhQ=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr9432435wru.398.1579674352203; 
 Tue, 21 Jan 2020 22:25:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0gngqesLwnZWMRk6blJIdlfwArLUbujrpEjNtzqqg4nsb4Sj8NoyehC2S/ssYA0HZrcHsaQ==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr9432410wru.398.1579674351901; 
 Tue, 21 Jan 2020 22:25:51 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 f1sm57304053wro.85.2020.01.21.22.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:25:51 -0800 (PST)
Date: Wed, 22 Jan 2020 01:25:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] virtio, pc: fixes, features
Message-ID: <20200122012517-mutt-send-email-mst@kernel.org>
References: <20200122055115.429945-1-mst@redhat.com>
 <157967421148.8714.13063905979235625106@f6d1ed32ca6b>
MIME-Version: 1.0
In-Reply-To: <157967421148.8714.13063905979235625106@f6d1ed32ca6b>
X-MC-Unique: n2Bs92PQNh-uaMvF5HrD9g-1
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

Oops. Trying to figure out what went wrong now.

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


