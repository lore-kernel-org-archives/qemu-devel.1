Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1267DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 07:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87B72396F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 07:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="M0YmnN2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87B72396F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmYIH-00043N-Rx
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 03:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jmYHP-0003Lr-51
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 03:51:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:34450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jmYHJ-0002df-MP
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 03:51:10 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05K7lLBO000389; Sat, 20 Jun 2020 00:50:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Bv2hjpX7N6bCMGjL/a3z0JxbnND8bu/bP+A+pnmlSFY=;
 b=M0YmnN2IWTFztqyoA1ois9waXV3clcZckE+/l0dX6xpDVhPK4Y+/ezOOCpnSap4FUrPD
 kjli1lC5PJu49t4a3IyYemnTu2ol5uz/qDhXnottFhXXuOZZsQgYNoPVJLZ+NK+1wttw
 9hNMaAzp/xfUIS242Y7ksFNh5rU+Vfz5kBJjS4cESkjMkF4mgh5yJ6BjuoYCJuHqEeCy
 /8yHhU0tO+RXfQhR5HdV4B0vpw7gcTmoDAicQGQiPW3lBB+yQwyiIN+MpejZwZb+6Crn
 U0L5flzosXdoTm6jOM6zpnaxbkMt8b12LTJgV7cGtYUIBaB5CYOigsV5nchfxenNHDXh aQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-002c1b01.pphosted.com with ESMTP id 31q66m0gb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2020 00:50:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIIXfmI6TrokKXXvDOWDSWzPfM3GRXiIwv0af+9ekAAnPHhVFtEKhAvXE9+bMpNug8xE8jXGoBynBf3scx5HZIAkyEQuwTRqQPry2syGeZv5xBAI3ConfQIMtFLbNngTyv9dZDPaa9jQJvAi2wx983OADZzdr2vPhIXCS2I5e3xkvb2k1jVd8qvwM80YkeZFbz968olrK6VmUuoUK8NcpmcRbrwDuHJxlsMJyChcs1/zKE+MjPnoh9oKxPxI4Hf+VAmBUE/jYgp2Fjtf8PJbV0HMVDkZzzlJmTvjU9KlyeA0k5BShQZcvwsVdv4sDiAuEpZ4Q4dshK+s5xVoW/zLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv2hjpX7N6bCMGjL/a3z0JxbnND8bu/bP+A+pnmlSFY=;
 b=ItTge4xL9q+c9mzRr8OXRGeDDVajQON/ChPxR7duIOzg0ubWtc23Xhs0zMQLfDOpnViW2BrhOnCm506cTlkcqtSPC+0ukLsGtBOWPsqfVhXn4TlcI28csp5hGYXAHWzdwoVC57SLgWqJ2Cec0SIc0jZFSR6ckVLQ78XMx5BYi3/Xw5SR96jg5+l7rXjA9rGtmYSBV6YpLeXAvZRpZ27U5SBWe0Kr7LIkO1YjW2IAEdkxOylwXwfWI916U67aOb9SVO5KVSBHN4zIDOsH6gSt162d1AyhaiZ/k9OX2eZLlih2ZKybqKuRfb3Eqtib9bJuRLJig3tepQIJ5cfWpZ6h/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5822.namprd02.prod.outlook.com (2603:10b6:208:112::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 07:50:34 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01%7]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 07:50:34 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH V3] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Thread-Topic: [PATCH V3] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Thread-Index: AQHWQ9oY/vhYOtq2AE2Ak/9M4Bsvz6jbe2cAgAWr2IA=
Date: Sat, 20 Jun 2020 07:50:33 +0000
Message-ID: <1C605C61-A738-4834-A2BF-37CE70D1C047@nutanix.com>
References: <159232765040.9045.3345507563074475276@d1fd068a5071>
In-Reply-To: <159232765040.9045.3345507563074475276@d1fd068a5071>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [115.110.205.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ba19882-4185-42e0-2f56-08d814ee9d16
x-ms-traffictypediagnostic: MN2PR02MB5822:
x-microsoft-antispam-prvs: <MN2PR02MB5822FAD68A618ECA7BDB64B7F1990@MN2PR02MB5822.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0440AC9990
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jv8hchJMMHXJoUsxflGG/DqFgQP/rHOfnWZpRTmBrNc6I2elEK35BOMMjHQ7WTLOWVEaxQ+x314aw9D8zGrGyPUCS/dkhSj8VCdHRFMJ9DkCvjs96BkaIVjlRxKQPl2slqEP7Z1+g/ZRDJMEB5GmCuKZqqLIrsaqeGZRQEBLejm80YZk8TgxRhrm0aIA/vgmL+HCCd6HCrg/57HDsmxovJ+YQ4O9SluFMWj5QpRzbTrbhchstjqHqJwqCCItyp5DZfz7EZYQH/GWshuuyGjT8pWJMGnpmgtMPRBuPssNxAQ+LW2Lh+hbjh+ORuek0Hopx/GpBKbLQ/AZXqZA9YKn2vLYxJSvqIztOyXQOgMvsT18Glfz2oz5E0sJJ96qScTFz7L+CvQNOjrxg24+1FHSDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(26005)(6506007)(6916009)(53546011)(66446008)(4326008)(86362001)(66556008)(2616005)(316002)(66476007)(966005)(83380400001)(64756008)(2906002)(6512007)(44832011)(8936002)(6486002)(71200400001)(36756003)(186003)(8676002)(54906003)(66946007)(76116006)(91956017)(5660300002)(30864003)(478600001)(33656002)(559001)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cqDEmMnzKYX935h8dLvYNf5J3GfZNPDjf4ZCLX/0y4IgZmTbUrMum6T86S4R75RvvbgDf3OieBjbNRM+AoizTMnKz92jiWMaHHPfdmnoTyk1hkRAh5xJG9Iodbdi8Xdw1Y9fnpLa2tZQbLjND/o4jj2w6U/UfKti1NJTJgCqWARhHzXuEFj9Y71dtQ9vHY01VNFoD1FpQLPWGZ+zwf3dNfB4iMWgcqCCT93sVPuNSEV/w6fwAi6tNaOPbFLyFAXNdpez1riDOKWxxg4g8yL+DABeFPffH+CRcSRSCH4TaomkEUntDHuAFgio0eYzYqKfyS6qAcwSQe+BtBK/6nVmCt0j9R3QMJFyW8R39Og8uQVpuUoAByN0ecLRkIWO4e/IxgIJu1MvOoFgPbhQvpno3ysRrB/JTcufAe1fYfO8D1fktcRZ/H8qpALIQ1WhASIeESHyar27avHyhhZN4vUp0Azpn+ox6fztA/lCtSinhHV9teQ/3HXvwynSTVQTLr5/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5C5A17E406074B44A7C70BEFFFC22160@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba19882-4185-42e0-2f56-08d814ee9d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2020 07:50:33.9955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ko/wWY1gj3J+tAWYmAxuSmorOs87CdRZExmHN137Kkh5eEcXPAMSXE4r7w0/7e52oXc0etIvypHyyYciRFyHhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5822
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-20_02:2020-06-19,
 2020-06-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 03:51:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This failure seems to be happening even without my patch in my workspace. S=
o I do not think this is related to my change.

Traceback (most recent call last):
  File "./tests/docker/docker.py", line 664, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 660, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 382, in run
    as_user=3Dargs.run_as_current_user)
  File "./tests/docker/docker.py", line 341, in run
    quiet=3Dquiet)
  File "./tests/docker/docker.py", line 233, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib64/python3.6/subprocess.py", line 311, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.q=
emu.instance.uuid=3D2297c9d77300410d88f152f5fdf1ba99', '-u', '16671', '--se=
curity-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_LIST=3Dx86_64-so=
ftmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e'=
, 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', '-=
v', '/home/ani.sinha/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/=
home/ani.sinha/work/ahv/rpmsrc/qemu-kvm/docker-src.2020-06-20-06.55.00.1135=
87:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-debug']' =
returned non-zero exit status 2.
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D2297c9d77300410d88f152=
f5fdf1ba99
make[1]: *** [docker-run] Error 1
make[1]: Leaving directory `/home/ani.sinha/work/ahv/rpmsrc/qemu-kvm'
make: *** [docker-run-test-debug@fedora] Error 2




> On Jun 16, 2020, at 10:44 PM, no-reply@patchew.org wrote:
>=20
> Patchew URL: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patch=
ew.org_QEMU_1592310699-2D58916-2D1-2Dgit-2Dsend-2Demail-2Dani.sinha-40nutan=
ix.com_&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DIIUxIyRwG4RGy57y2nvMNYcDk=
qW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgCLkSzOo9Gw6b5hCJ6ap5u8&s=3Dpc3W=
ypysbMar_37tB0vsF22N_0e-lRx1dAoByIRrnmQ&e=3D=20
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing commands =
and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NE=
TWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> PASS 32 test-opts-visitor /visitor/opts/range/beyond
> PASS 33 test-opts-visitor /visitor/opts/dict/unvisited
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests=
/test-coroutine -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl -=
-test-name=3D"test-coroutine"=20
> =3D=3D6255=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6255=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffcb8986000; bottom 0x7f7dfe920000; size: 0x007eba066000 =
(544286859264)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 1 test-coroutine /basic/no-dangling-access
> ---
> PASS 1 fdc-test /x86_64/fdc/cmos
> PASS 2 fdc-test /x86_64/fdc/no_media_on_start
> PASS 3 fdc-test /x86_64/fdc/read_without_media
> =3D=3D6280=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 fdc-test /x86_64/fdc/media_change
> PASS 5 fdc-test /x86_64/fdc/sense_interrupt
> PASS 6 fdc-test /x86_64/fdc/relative_seek
> ---
> PASS 11 test-aio /aio/event/wait
> PASS 12 test-aio /aio/event/flush
> PASS 13 test-aio /aio/event/wait/no-flush-cb
> =3D=3D6290=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 14 test-aio /aio/timer/schedule
> PASS 15 test-aio /aio/coroutine/queue-chaining
> PASS 16 test-aio /aio-gsource/flush
> ---
> PASS 28 test-aio /aio-gsource/timer/schedule
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests=
/test-aio-multithread -m=3Dquick -k --tap < /dev/null | ./scripts/tap-drive=
r.pl --test-name=3D"test-aio-multithread"=20
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> =3D=3D6295=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 2 test-aio-multithread /aio/multi/schedule
> PASS 3 test-aio-multithread /aio/multi/mutex/contended
> PASS 12 fdc-test /x86_64/fdc/read_no_dma_19
> PASS 13 fdc-test /x86_64/fdc/fuzz-registers
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/ide-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"ide-test"=20
> =3D=3D6322=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 1 ide-test /x86_64/ide/identify
> =3D=3D6328=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
> PASS 2 ide-test /x86_64/ide/flush
> =3D=3D6339=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 ide-test /x86_64/ide/bmdma/simple_rw
> **
> ERROR:/tmp/qemu-test/src/tests/test-aio-multithread.c:365:test_multi_fair=
_mutex: assertion failed (counter =3D=3D atomic_counter): (90146 =3D=3D 901=
47)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/test-aio-multithread.c:3=
65:test_multi_fair_mutex: assertion failed (counter =3D=3D atomic_counter):=
 (90146 =3D=3D 90147)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:648: check-unit] Err=
or 1
> make: *** Waiting for unfinished jobs....
> =3D=3D6345=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 ide-test /x86_64/ide/bmdma/trim
> =3D=3D6351=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6357=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6363=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6369=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6375=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6381=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6387=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6393=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6399=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 5 ide-test /x86_64/ide/bmdma/various_prdts
> =3D=3D6405=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6405=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffd1bfdc000; bottom 0x7f811fddc000; size: 0x007bfc200000 =
(532510932992)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 6 ide-test /x86_64/ide/bmdma/no_busmaster
> PASS 7 ide-test /x86_64/ide/flush/nodev
> =3D=3D6416=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 8 ide-test /x86_64/ide/flush/empty_drive
> =3D=3D6421=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 9 ide-test /x86_64/ide/flush/retry_pci
> =3D=3D6427=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 10 ide-test /x86_64/ide/flush/retry_isa
> =3D=3D6433=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 11 ide-test /x86_64/ide/cdrom/pio
> =3D=3D6439=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 12 ide-test /x86_64/ide/cdrom/pio_large
> =3D=3D6445=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 13 ide-test /x86_64/ide/cdrom/dma
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/ahci-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-drive=
r.pl --test-name=3D"ahci-test"=20
> =3D=3D6459=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 1 ahci-test /x86_64/ahci/sanity
> =3D=3D6465=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 2 ahci-test /x86_64/ahci/pci_spec
> =3D=3D6471=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 ahci-test /x86_64/ahci/pci_enable
> =3D=3D6477=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 ahci-test /x86_64/ahci/hba_spec
> =3D=3D6483=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 5 ahci-test /x86_64/ahci/hba_enable
> =3D=3D6489=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 6 ahci-test /x86_64/ahci/identify
> =3D=3D6495=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 7 ahci-test /x86_64/ahci/max
> =3D=3D6501=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 8 ahci-test /x86_64/ahci/reset
> =3D=3D6507=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6507=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffce6f97000; bottom 0x7f1aa27aa000; size: 0x00e2447ed000 =
(971811770368)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero
> =3D=3D6513=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6513=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffd21206000; bottom 0x7f39807fe000; size: 0x00c3a0a08000 =
(840213495808)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low
> =3D=3D6519=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6519=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7fff6cbeb000; bottom 0x7f2c023f9000; size: 0x00d36a7f2000 =
(908024815616)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high
> =3D=3D6525=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6525=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffc13fcf000; bottom 0x7f8e559f9000; size: 0x006dbe5d6000 =
(471345225728)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero
> =3D=3D6531=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6531=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffdbc4f1000; bottom 0x7ffa1d3f9000; size: 0x00039f0f8000 =
(15553495040)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low
> =3D=3D6537=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6537=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7fff49ff9000; bottom 0x7f8232df9000; size: 0x007d17200000 =
(537258885120)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high
> =3D=3D6543=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6543=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffd10b42000; bottom 0x7f6ef29f9000; size: 0x008e1e149000 =
(610390020096)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero
> =3D=3D6549=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6549=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffea5219000; bottom 0x7f1031bfe000; size: 0x00ee7361b000 =
(1024137998336)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low
> =3D=3D6555=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6555=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffedf363000; bottom 0x7f43faba1000; size: 0x00bae47c2000 =
(802697256960)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high
> =3D=3D6561=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero
> =3D=3D6567=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low
> =3D=3D6573=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high
> =3D=3D6579=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6579=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffda3846000; bottom 0x7f1d5a7aa000; size: 0x00e04909c000 =
(963298050048)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero
> =3D=3D6585=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6585=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffe2f2ba000; bottom 0x7f0dd35f9000; size: 0x00f05bcc1000 =
(1032332251136)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low
> =3D=3D6591=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6591=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7fff1cfb1000; bottom 0x7f96b65fe000; size: 0x0068669b3000 =
(448398045184)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high
> =3D=3D6597=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6597=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffe17936000; bottom 0x7f57beff9000; size: 0x00a65893d000 =
(714450653184)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero
> =3D=3D6603=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6603=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffcaa231000; bottom 0x7f3f65bba000; size: 0x00bd44677000 =
(812896448512)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low
> =3D=3D6609=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6609=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffd81483000; bottom 0x7f050959a000; size: 0x00f877ee9000 =
(1067164012544)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 26 ahci-test /x86_64/ahci/io/pio/lba48/double/high
> =3D=3D6615=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6615=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffc35356000; bottom 0x7f8d18ff9000; size: 0x006f1c35d000 =
(477214658560)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 27 ahci-test /x86_64/ahci/io/pio/lba48/long/zero
> =3D=3D6621=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6621=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffc9f37f000; bottom 0x7f728d5fe000; size: 0x008a11d81000 =
(593004859392)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 28 ahci-test /x86_64/ahci/io/pio/lba48/long/low
> =3D=3D6627=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6627=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7fffcb2a3000; bottom 0x7ffa3eff9000; size: 0x00058c2aa000 =
(23826440192)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 29 ahci-test /x86_64/ahci/io/pio/lba48/long/high
> =3D=3D6633=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero
> =3D=3D6639=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 31 ahci-test /x86_64/ahci/io/pio/lba48/short/low
> =3D=3D6645=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 32 ahci-test /x86_64/ahci/io/pio/lba48/short/high
> =3D=3D6651=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 33 ahci-test /x86_64/ahci/io/dma/lba28/fragmented
> =3D=3D6657=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry
> =3D=3D6663=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero
> =3D=3D6669=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low
> =3D=3D6675=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high
> =3D=3D6681=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero
> =3D=3D6687=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low
> =3D=3D6693=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high
> =3D=3D6699=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6699=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffe36248000; bottom 0x7f83347fd000; size: 0x007b01a4b000 =
(528308547584)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero
> =3D=3D6706=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6706=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffc92855000; bottom 0x7f9cdbbfd000; size: 0x005fb6c58000 =
(411088289792)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low
> =3D=3D6713=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6713=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffc90f81000; bottom 0x7f523d576000; size: 0x00aa53a0b000 =
(731547480064)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high
> =3D=3D6720=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero
> =3D=3D6726=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low
> =3D=3D6732=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high
> =3D=3D6738=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero
> =3D=3D6744=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low
> =3D=3D6750=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high
> =3D=3D6756=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero
> =3D=3D6762=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 51 ahci-test /x86_64/ahci/io/dma/lba48/double/low
> =3D=3D6768=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high
> =3D=3D6774=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6774=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffc95b38000; bottom 0x7f367ad76000; size: 0x00c61adc2000 =
(850854158336)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 53 ahci-test /x86_64/ahci/io/dma/lba48/long/zero
> =3D=3D6781=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6781=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7fff9e8b6000; bottom 0x7f88d81fd000; size: 0x0076c66b9000 =
(510135078912)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 54 ahci-test /x86_64/ahci/io/dma/lba48/long/low
> =3D=3D6788=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6788=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffedce8e000; bottom 0x7fec6fbfd000; size: 0x00126d291000 =
(79140818944)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 55 ahci-test /x86_64/ahci/io/dma/lba48/long/high
> =3D=3D6795=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 56 ahci-test /x86_64/ahci/io/dma/lba48/short/zero
> =3D=3D6801=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low
> =3D=3D6807=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high
> =3D=3D6813=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 59 ahci-test /x86_64/ahci/io/ncq/simple
> =3D=3D6819=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 60 ahci-test /x86_64/ahci/io/ncq/retry
> =3D=3D6825=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 61 ahci-test /x86_64/ahci/flush/simple
> =3D=3D6831=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 62 ahci-test /x86_64/ahci/flush/retry
> =3D=3D6837=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6843=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 63 ahci-test /x86_64/ahci/flush/migrate
> =3D=3D6851=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6857=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 64 ahci-test /x86_64/ahci/migrate/sanity
> =3D=3D6865=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6871=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple
> =3D=3D6879=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6885=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted
> =3D=3D6893=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6899=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple
> =3D=3D6907=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6913=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted
> =3D=3D6921=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 69 ahci-test /x86_64/ahci/cdrom/eject
> =3D=3D6926=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single
> =3D=3D6932=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi
> =3D=3D6938=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single
> =3D=3D6944=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D6944=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffd0ae20000; bottom 0x7fa7e19fe000; size: 0x005529422000 =
(365764419584)
> False positive error reports may follow
> For details see https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_google_sanitizers_issues_189&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg=
&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgC=
LkSzOo9Gw6b5hCJ6ap5u8&s=3Dc2lE321GhK0UAWVNcYgh_BrHTqG22KUMfVOm6YJi5Jc&e=3D=
=20
> PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi
> =3D=3D6950=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/hd-geo-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-dri=
ver.pl --test-name=3D"hd-geo-test"=20
> PASS 1 hd-geo-test /x86_64/hd-geo/ide/none
> =3D=3D6964=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0
> =3D=3D6970=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank
> =3D=3D6976=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/lba
> =3D=3D6982=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs
> =3D=3D6988=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank
> =3D=3D6994=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba
> =3D=3D7000=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs
> =3D=3D7006=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs
> =3D=3D7011=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst
> =3D=3D7017=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7021=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7025=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7029=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7033=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7037=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7041=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7045=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7048=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 11 hd-geo-test /x86_64/hd-geo/override/ide
> =3D=3D7055=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7059=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7063=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7067=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7071=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7075=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7079=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7083=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7086=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 12 hd-geo-test /x86_64/hd-geo/override/scsi
> =3D=3D7093=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7097=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7101=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7105=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7109=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7113=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7117=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7121=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7124=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 13 hd-geo-test /x86_64/hd-geo/override/scsi_2_controllers
> =3D=3D7131=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7135=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7139=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7143=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7146=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 14 hd-geo-test /x86_64/hd-geo/override/virtio_blk
> =3D=3D7153=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7157=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7160=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 15 hd-geo-test /x86_64/hd-geo/override/zero_chs
> =3D=3D7167=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7171=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7175=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7179=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7182=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 16 hd-geo-test /x86_64/hd-geo/override/scsi_hot_unplug
> =3D=3D7189=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7193=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7197=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7201=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D7204=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 17 hd-geo-test /x86_64/hd-geo/override/virtio_hot_unplug
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/boot-order-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap=
-driver.pl --test-name=3D"boot-order-test"=20
> PASS 1 boot-order-test /x86_64/boot-order/pc
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7273=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP'
> Using expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7279=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP'
> Using expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7286=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.tis'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7293=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.bridge'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7299=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.mmio64'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7305=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.ipmibt'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7311=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.cphp'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7318=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.memhp'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7324=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.numamem'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7330=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.dimmpxm'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7339=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/q35/FACP.acpihmat'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7346=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP.bridge'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7352=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP.ipmikcs'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7358=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP.cphp'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7365=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP.memhp'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7371=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP.numamem'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7377=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP.dimmpxm'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7386=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
>=20
> Looking for expected file 'tests/data/acpi/pc/FACP.acpihmat'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> PASS 1 i440fx-test /x86_64/i440fx/defaults
> PASS 2 i440fx-test /x86_64/i440fx/pam
> PASS 3 i440fx-test /x86_64/i440fx/firmware/bios
> =3D=3D7478=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/fw_cfg-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-dri=
ver.pl --test-name=3D"fw_cfg-test"=20
> PASS 1 fw_cfg-test /x86_64/fw_cfg/signature
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/drive_del-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-=
driver.pl --test-name=3D"drive_del-test"=20
> PASS 1 drive_del-test /x86_64/drive_del/without-dev
> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
> =3D=3D7571=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/wdt_ib700-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-=
driver.pl --test-name=3D"wdt_ib700-test"=20
> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
> ---
> PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init
> PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1
> PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug
> =3D=3D7766=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/usb-hcd-ehci-test -m=3Dquick -k --tap < /dev/null | ./scripts/t=
ap-driver.pl --test-name=3D"usb-hcd-ehci-test"=20
> PASS 1 usb-hcd-ehci-test /x86_64/ehci/pci/uhci-port-1
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/usb-hcd-xhci-test -m=3Dquick -k --tap < /dev/null | ./scripts/t=
ap-driver.pl --test-name=3D"usb-hcd-xhci-test"=20
> PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init
> PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug
> =3D=3D7784=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas
> PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/cpu-plug-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-d=
river.pl --test-name=3D"cpu-plug-test"=20
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7920=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7926=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7932=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/tpm-crb-swtpm-test -m=3Dquick -k --tap < /dev/null | ./scripts/=
tap-driver.pl --test-name=3D"tpm-crb-swtpm-test"=20
> SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not in =
PATH or missing --tpm2 support
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8031=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8037=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 migration-test /x86_64/migration/fd_proto
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8044=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8050=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 4 migration-test /x86_64/migration/validate_uuid
> PASS 5 migration-test /x86_64/migration/validate_uuid_error
> PASS 6 migration-test /x86_64/migration/validate_uuid_src_not_set
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8100=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8106=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 8 migration-test /x86_64/migration/auto_converge
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8114=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8120=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 9 migration-test /x86_64/migration/postcopy/unix
> PASS 10 migration-test /x86_64/migration/postcopy/recovery
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8149=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8155=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 11 migration-test /x86_64/migration/precopy/unix
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8163=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8169=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 12 migration-test /x86_64/migration/precopy/tcp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8177=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8183=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 13 migration-test /x86_64/migration/xbzrle/unix
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8191=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8197=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 14 migration-test /x86_64/migration/multifd/tcp/none
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8315=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 15 migration-test /x86_64/migration/multifd/tcp/cancel
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8371=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8377=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 16 migration-test /x86_64/migration/multifd/tcp/zlib
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8433=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8439=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 17 migration-test /x86_64/migration/multifd/tcp/zstd
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/test-x86-cpuid-compat -m=3Dquick -k --tap < /dev/null | ./scrip=
ts/tap-driver.pl --test-name=3D"test-x86-cpuid-compat"=20
> PASS 1 test-x86-cpuid-compat /x86/cpuid/parsing-plus-minus
> ---
> PASS 1 machine-none-test /x86_64/machine/none/cpu_option
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/qmp-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"qmp-test"=20
> PASS 1 qmp-test /x86_64/qmp/protocol
> =3D=3D8878=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 2 qmp-test /x86_64/qmp/oob
> PASS 3 qmp-test /x86_64/qmp/preconfig
> PASS 4 qmp-test /x86_64/qmp/missing-any-arg
> ---
> PASS 16 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82562/pci-=
device/pci-device-tests/nop
> PASS 17 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82801/pci-=
device/pci-device-tests/nop
> PASS 18 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ES1370/pci-=
device/pci-device-tests/nop
> =3D=3D9296=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 19 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/pci=
-device/pci-device-tests/nop
> PASS 20 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/meg=
asas-tests/dcmd/pd-get-info/fuzz
> PASS 21 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ne2k_pci/pc=
i-device/pci-device-tests/nop
> PASS 22 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tulip/pci-d=
evice/pci-device-tests/nop
> PASS 23 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tulip/tulip=
-tests/tulip_large_tx
> PASS 24 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/nvme/pci-de=
vice/pci-device-tests/nop
> =3D=3D9311=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 25 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/nvme/nvme-t=
ests/oob-cmb-access
> =3D=3D9316=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 26 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/pcnet/pci-d=
evice/pci-device-tests/nop
> PASS 27 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/pci-ohci/pc=
i-device/pci-device-tests/nop
> PASS 28 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/pci-ohci/pc=
i-ohci-tests/ohci_pci-test-hotplug
> ---
> PASS 35 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/sdhci-pci/s=
dhci/sdhci-tests/registers
> PASS 36 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tpci200/ipa=
ck/ipoctal232/ipoctal232-tests/nop
> PASS 37 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tpci200/pci=
-device/pci-device-tests/nop
> =3D=3D9376=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 38 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-p=
ci/pci-device/pci-device-tests/nop
> PASS 39 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-p=
ci/virtio/virtio-tests/nop
> PASS 40 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-p=
ci/virtio-9p/virtio-9p-tests/config
> ---
> PASS 50 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-p=
ci/virtio-9p/virtio-9p-tests/fs/readdir/basic
> PASS 51 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-ball=
oon-pci/pci-device/pci-device-tests/nop
> PASS 52 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-ball=
oon-pci/virtio/virtio-tests/nop
> =3D=3D9387=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 53 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk-pci-tests/msix
> =3D=3D9393=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 54 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk-pci-tests/idx
> =3D=3D9399=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 55 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk-pci-tests/nxvirtq
> =3D=3D9405=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 56 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk-pci-tests/hotplug
> =3D=3D9411=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 57 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk/virtio-blk-tests/indirect
> =3D=3D9417=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 58 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk/virtio-blk-tests/config
> =3D=3D9423=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 59 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk/virtio-blk-tests/basic
> =3D=3D9429=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 60 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-blk-=
pci/virtio-blk/virtio-blk-tests/resize
> PASS 61 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-=
pci/virtio-net/virtio-net-tests/basic
> PASS 62 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-=
pci/virtio-net/virtio-net-tests/rx_stop_cont
> ---
> PASS 70 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-rng-=
pci/virtio-rng-pci-tests/hotplug
> PASS 71 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-rng-=
pci/pci-device/pci-device-tests/nop
> PASS 72 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-rng-=
pci/virtio/virtio-tests/nop
> =3D=3D9521=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 73 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi=
-pci/virtio-scsi-pci-tests/iothread-attach-node
> =3D=3D9532=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 74 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi=
-pci/pci-device/pci-device-tests/nop
> =3D=3D9537=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 75 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi=
-pci/virtio-scsi/virtio-scsi-tests/hotplug
> =3D=3D9542=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 76 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi=
-pci/virtio-scsi/virtio-scsi-tests/unaligned-write-same
> PASS 77 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-seri=
al-pci/pci-device/pci-device-tests/nop
> PASS 78 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-seri=
al-pci/virtio/virtio-tests/nop
> ---
>    raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Dde673b0e75fb45e28370b5286b953622', '-u'=
, '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3Dx86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e',=
 'J=3D14', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_DIR=3D/var/=
tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccach=
e:z', '-v', '/var/tmp/patchew-tester-tmp-d0ersclp/src/docker-src.2020-06-16=
-12.30.22.23989:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 't=
est-debug']' returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dde673b0e75fb45e28370=
b5286b953622
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-d0ersclp/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>=20
> real    43m47.486s
> user    0m8.778s
>=20
>=20
> The full log is available at
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__patchew.org_logs_15=
92310699-2D58916-2D1-2Dgit-2Dsend-2Demail-2Dani.sinha-40nutanix.com_testing=
.asan_-3Ftype-3Dmessage&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DIIUxIyRwG=
4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgCLkSzOo9Gw6b5hC=
J6ap5u8&s=3DitlqLgoNJYBkrwSQOMaBZFQDOAdwFiG5yHaz3gaRO_8&e=3D .
> ---
> Email generated automatically by Patchew [https://urldefense.proofpoint.c=
om/v2/url?u=3Dhttps-3A__patchew.org_&d=3DDwIGaQ&c=3Ds883GpUCOChKOHiocYtGcg&=
r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DcpLfEzDc9TG6RQRXS4UEgCL=
kSzOo9Gw6b5hCJ6ap5u8&s=3D2cfhvHsPI5LFSCsxhWaWAWuOVtBOA226NIb_qfE1Kf4&e=3D ]=
.
> Please send your feedback to patchew-devel@redhat.com


