Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19268C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAA1214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xy6a/kzI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rNn1a8lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAA1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izljk-0006hX-0n
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1izliw-00066E-1z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1izliu-0006cq-9y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:17:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1izliu-0006b5-1R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:17:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016IFEu9118530;
 Thu, 6 Feb 2020 18:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lnYvUmZuRtethVMs/y5ortAcbc8orYP9U/RAQEAaRhE=;
 b=xy6a/kzIzC4lqGIwL5tqu2Hkukd1z5dYtaww51rZZekb3jPVcO0cNi6F97qdXUGGvJuy
 a9CBGb3biITNyM+vwIK4kHIeIP7aJkjBtXSBsptO7wRlJDhQ6yM+xW81RvzPC04Jpk4F
 8CTqws5pA2UQGRgfAf+zpshM5+GCL/P/Wgxpk2oV36rofES0eV+8VmPIN675X2wkr5qz
 5LY4mHo+TYUSQNXk2RkMc8EfuMh+74dN2KuNtKMLTgFTLNJ6QwvD6I5iHM4V3D461SRi
 PQKe6Jp6DBzXU0Ty4w2odwcoTN0hFQZTwALhLLduWB3tp3tdDtsGpDzNx0wyVvKTaCDy Lw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=lnYvUmZuRtethVMs/y5ortAcbc8orYP9U/RAQEAaRhE=;
 b=rNn1a8lWyH0RxUOTkloqy83TPgNuxpWK3ZlpKJFQ6ySKJ6aOVo3M6+Qx5rDtQJRmv9yw
 2SLe7ps2u4DoqlipuL34Ae9ZrXEsVg1EdWxCAcouXKGjwnunA1TyFjy+hSHHxeUG2Q4p
 XTYx0bpPuJ5vRluKnBr3vIWTUHGdkHpHsHyUP+LeXsnN856V+T6JQlC+t0yJSal/Nuky
 6VfloJX7N8Z36FBG9Lq58UZ/M7pQGh1B8WSnT7LnJLVoIgO9aO2R5sVruHmE+O+rYaxY
 4KOqx9ApDSvLIyF1uDFoXeWNs/e+9lRBxbYJxWPjEItvGWrywkkp3N0zm80JBkAF+l1x Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2xykbpbg3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2020 18:17:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016IE7w0144359;
 Thu, 6 Feb 2020 18:17:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2y0mjuvtx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2020 18:17:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016IHl0i020867;
 Thu, 6 Feb 2020 18:17:47 GMT
Received: from [10.175.182.212] (/10.175.182.212)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 06 Feb 2020 10:17:46 -0800
Subject: Re: [PATCH v2 09/29] tests/acceptance: Use 'machine' tag to check if
 available in QEMU binary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-10-philmd@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <e1100e02-33aa-02a4-c59b-ad04f214972a@oracle.com>
Date: Thu, 6 Feb 2020 18:17:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060134
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 016IFEu9118530
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 21:23, Philippe Mathieu-Daud=C3=A9 wrote:
> We already use the 'machine' tag in Avocado tests.
> If the requested machine is not available in the QEMU binary,
> the tests will be cancelled (skipped):
>=20
>    $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_model_=
versions.py
>     ...
>     (04/11) CascadelakeArchCapabilities.test_4_1: CANCEL: Test expects =
machine 'pc-i440fx-4.1' which is missing from QEMU binary (0.10 s)
>     (05/11) CascadelakeArchCapabilities.test_4_0: CANCEL: Test expects =
machine 'pc-i440fx-4.0' which is missing from QEMU binary (0.11 s)
>     ...
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index e7d5affe24..53ec8512d1 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file_=
_), '..', '..', '..')
>   sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>  =20
>   from qemu.binutils import binary_get_arch
> +from qemu.binutils import binary_get_machines
>   from qemu.binutils import binary_get_version
>   from qemu.machine import QEMUMachine
>  =20
> @@ -118,9 +119,6 @@ class Test(avocado.Test):
>           self.arch =3D self.params.get('arch',
>                                       default=3Dself._get_unique_tag_va=
l('arch'))
>  =20
> -        self.machine =3D self.params.get('machine',
> -                                       default=3Dself._get_unique_tag_=
val('machine'))
> -
>           # Verify qemu_bin
>           default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>           self.qemu_bin =3D self.params.get('qemu_bin',
> @@ -151,6 +149,15 @@ class Test(avocado.Test):
>               if bin_arch !=3D self.arch:
>                   self.cancel(fmt.format(self.arch, bin_arch))
>  =20
> +        # Verify machine
> +        self.machine =3D self.params.get('machine',
> +                                       default=3Dself._get_unique_tag_=
val('machine'))
> +        logger.debug('machine: {}'.format(self.machine))
> +        if self.machine:
> +            fmt =3D "Test expects machine '{}' which is missing from Q=
EMU binary"
> +            if self.machine not in binary_get_machines(self.qemu_bin):
> +                self.cancel(fmt.format(self.machine))
> +

Starting with this patch:

$ avocado run --filter-by-tags arch:x86_64 tests/acceptance
...
/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc: CANCEL: Test=20
expects machine 'pc' which is missing from QEMU binary (0.05 s)
...

$ x86_64-softmmu/qemu-system-x86_64 -machine help
Supported machines are:
microvm              microvm (i386)
pc                   Standard PC (i440FX + PIIX, 1996) (alias of=20
pc-i440fx-5.0)
...

but checking via QMP, 'pc' (and 'q35') is listed as 'alias'
...
         {
             "hotpluggable-cpus": true,
             "name": "pc-i440fx-5.0",
             "numa-mem-supported": true,
             "default-cpu-type": "qemu64-x86_64-cpu",
             "is-default": true,
             "cpu-max": 255,
             "deprecated": false,
             "alias": "pc"
         },
...

Does 'alias' need to be checked by binary_get_machines() in Patch8 as=20
well as 'name'?

Regards,
Liam



