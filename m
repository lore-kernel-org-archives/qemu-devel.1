Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC33C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6324B2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6324B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlzQQ-0004RW-NL
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 14:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jlzPd-0003tr-0O; Thu, 18 Jun 2020 14:37:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jlzPa-0001yi-Do; Thu, 18 Jun 2020 14:37:20 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05IIW8w5011543; Thu, 18 Jun 2020 14:37:13 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31r560hrjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 14:37:13 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IIZICp015459;
 Thu, 18 Jun 2020 18:37:13 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 31q6c8kmnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 18:37:13 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05IIZtrl17498506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2020 18:35:55 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 048C213604F;
 Thu, 18 Jun 2020 18:35:57 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F481136051;
 Thu, 18 Jun 2020 18:35:56 +0000 (GMT)
Received: from [9.160.87.86] (unknown [9.160.87.86])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 18 Jun 2020 18:35:56 +0000 (GMT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 0/7] Add several Power ISA 3.1 32/64-bit vector
 instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <159244093535.14731.6969971520904209345@d1fd068a5071>
Date: Thu, 18 Jun 2020 13:35:54 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <84B6B92A-4D73-4E9F-9152-D4E8E5B1D895@linux.vnet.ibm.com>
References: <159244093535.14731.6969971520904209345@d1fd068a5071>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-18_15:2020-06-18,
 2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180138
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 14:37:15
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 17, 2020, at 7:42 PM, no-reply@patchew.org wrote:
>=20
> Patchew URL: =
https://patchew.org/QEMU/20200618001127.34438-1-ljp@linux.ibm.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing =
commands and
> their output below. If you have Docker installed, you can probably =
reproduce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 =
NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D

It look like the errors generated below are not directly related to the =
code changes I made.
Does anyone know why it still reports errors?

Thanks,
Lijun

>=20
>  GEN     docs/interop/qemu-qmp-ref.html
>  GEN     docs/interop/qemu-qmp-ref.txt
>  GEN     docs/interop/qemu-qmp-ref.7
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  CC      qga/guest-agent-command-state.o
>  CC      qga/commands.o
>  CC      qga/main.o
> ---
>  GEN     docs/interop/qemu-ga-ref.html
>  GEN     docs/interop/qemu-ga-ref.txt
>  GEN     docs/interop/qemu-ga-ref.7
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  AS      pc-bios/optionrom/linuxboot.o
>  CC      pc-bios/optionrom/linuxboot_dma.o
>  AS      pc-bios/optionrom/multiboot.o
> ---
>  BUILD   pc-bios/optionrom/linuxboot.img
>  BUILD   pc-bios/optionrom/kvmvapic.raw
>  BUILD   pc-bios/optionrom/multiboot.raw
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  BUILD   pc-bios/optionrom/linuxboot.raw
>  BUILD   pc-bios/optionrom/linuxboot_dma.img
>  SIGN    pc-bios/optionrom/kvmvapic.bin
> ---
>  LINK    ivshmem-client
>  SIGN    pc-bios/optionrom/linuxboot_dma.bin
>  LINK    ivshmem-server
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  BUILD   pc-bios/optionrom/pvh.img
>  BUILD   pc-bios/optionrom/pvh.raw
>  SIGN    pc-bios/optionrom/pvh.bin
>  LINK    qemu-nbd
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    qemu-storage-daemon
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    qemu-img
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    qemu-io
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    qemu-edid
>  LINK    fsdev/virtfs-proxy-helper
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    scsi/qemu-pr-helper
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    qemu-bridge-helper
>  LINK    virtiofsd
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    vhost-user-input
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  LINK    qemu-ga
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
> /usr/bin/ld: =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors_vfork.S.o): warning: common of `__interception::real_vfork' =
overridden by definition from =
/usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_intercept=
ors.cpp.o)
>  GEN     x86_64-softmmu/hmp-commands.h
>  GEN     x86_64-softmmu/hmp-commands-info.h
>  GEN     x86_64-softmmu/config-target.h
> ---
>  CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>  CC      x86_64-softmmu/hw/display/vhost-user-gpu.o
>  CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
> /tmp/qemu-test/src/fpu/softfloat.c:3365:13: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>    absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven =
);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>            !
> /tmp/qemu-test/src/fpu/softfloat.c:3423:18: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>        absZ0 &=3D ~ ( ( (uint64_t) ( absZ1<<1 ) =3D=3D 0 ) & =
roundNearestEven );
>                 =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                 !
> /tmp/qemu-test/src/fpu/softfloat.c:3483:18: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>        absZ0 &=3D ~(((uint64_t)(absZ1<<1) =3D=3D 0) & =
roundNearestEven);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                 !
> /tmp/qemu-test/src/fpu/softfloat.c:3606:13: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>    zSig &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven =
);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>            !
> /tmp/qemu-test/src/fpu/softfloat.c:3760:13: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>    zSig &=3D ~ ( ( ( roundBits ^ 0x200 ) =3D=3D 0 ) & roundNearestEven =
);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>            !
> /tmp/qemu-test/src/fpu/softfloat.c:3987:21: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>                    ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & =
roundNearestEven );
>                    =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                    !
> /tmp/qemu-test/src/fpu/softfloat.c:4003:22: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>            zSig0 &=3D ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & =
roundNearestEven );
>                     =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                     !
> /tmp/qemu-test/src/fpu/softfloat.c:4273:18: error: bitwise negation of =
a boolean expression; did you mean logical negation? =
[-Werror,-Wbool-operation]
>        zSig1 &=3D ~ ( ( zSig2 + zSig2 =3D=3D 0 ) & roundNearestEven );
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                 !
> 8 errors generated.
> make[1]: *** [/tmp/qemu-test/src/rules.mak:69: fpu/softfloat.o] Error =
1
> make[1]: *** Waiting for unfinished jobs....
> /tmp/qemu-test/src/migration/ram.c:919:45: error: implicit conversion =
from 'unsigned long' to 'double' changes value from 18446744073709551615 =
to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>            xbzrle_counters.encoding_rate =3D UINT64_MAX;
>                                          ~ ^~~~~~~~~~
> /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
> ---
> 18446744073709551615UL
> ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make[1]: *** [/tmp/qemu-test/src/rules.mak:69: migration/ram.o] Error =
1
> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
> Traceback (most recent call last):
>  File "./tests/docker/docker.py", line 669, in <module>
>    sys.exit(main())
> ---
>    raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', =
'run', '--label', =
'com.qemu.instance.uuid=3Da8eb838f72414145ad19ca7b26a17318', '-u', =
'1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', =
'TARGET_LIST=3Dx86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', =
'V=3D', '-e', 'J=3D14', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', =
'CCACHE_DIR=3D/var/tmp/ccache', '-v', =
'/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', =
'/var/tmp/patchew-tester-tmp-51ztubho/src/docker-src.2020-06-17-20.37.27.9=
815:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', =
'test-debug']' returned non-zero exit status 2.
> =
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Da8eb838f72414145ad19c=
a7b26a17318
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-51ztubho/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>=20
> real    4m49.119s
> user    0m8.537s
>=20
>=20
> The full log is available at
> =
http://patchew.org/logs/20200618001127.34438-1-ljp@linux.ibm.com/testing.a=
san/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


