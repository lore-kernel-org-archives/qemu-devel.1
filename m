Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A4C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EC72468C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EC72468C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdiH-00048g-0I
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jBdhe-0003jw-2N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jBdhc-0008GH-NO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:09:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44750 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jBdhc-0007yu-BQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:09:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 367925BFBD1AE201AAF7;
 Tue, 10 Mar 2020 20:09:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 10 Mar 2020 20:09:27 +0800
Subject: Re: [RFC] cpus: avoid get stuck in pause_all_vcpus
To: <qemu-devel@nongnu.org>
References: <158383564824.20878.9634431361481694557@39012742ff91>
From: "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <fed91a01-c545-bcfa-7215-36d69ab0f2ac@huawei.com>
Date: Tue, 10 Mar 2020 20:09:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <158383564824.20878.9634431361481694557@39012742ff91>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, dgilbert@redhat.com, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=E5=9C=A8 2020/3/10 18:20, no-reply@patchew.org =E5=86=99=E9=81=93:
> Patchew URL: https://patchew.org/QEMU/20200310091443.1326-1-longpeng2@h=
uawei.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing command=
s and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>=20

Hi guys,
It seems this failure is NOT caused by my patch, so let's ignore it for t=
he
moment...

> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/qtest/wdt_ib700-test -m=3Dquick -k --tap < /dev/null | ./script=
s/tap-driver.pl --test-name=3D"wdt_ib700-test"=20
> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
> ---
> dbus-daemon[8273]: Could not get password database information for UID =
of current process: User "???" unknown or no memory to allocate password =
entry
>=20
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connec=
tion: assertion failed (err =3D=3D NULL): The connection is closed (g-io-=
error-quark, 18)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-tes=
t.c:114:get_connection: assertion failed (err =3D=3D NULL): The connectio=
n is closed (g-io-error-quark, 18)
> cleaning up pid 8273
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x=
86_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 664, in <module>
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',=
 '--label', 'com.qemu.instance.uuid=3D88af8ba44214464d881ef7c7786167f4', =
'-u', '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TA=
RGET_LIST=3Dx86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D=
', '-e', 'J=3D14', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_D=
IR=3D/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/v=
ar/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-a0j9h14_/src/docker-=
src.2020-03-10-05.52.52.1292:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tm=
p/qemu/run', 'test-debug']' returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D88af8ba44214464d88=
1ef7c7786167f4
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-a0j9h14_/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>=20
> real    27m55.506s
> user    0m8.248s
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200310091443.1326-1-longpeng2@huawei.com/test=
ing.asan/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
>=20


--=20
Regards,
Longpeng(Mike)


