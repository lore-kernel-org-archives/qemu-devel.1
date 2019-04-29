Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B852C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB90E2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB90E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6BU-0000bf-27
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:19:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6Af-0000Js-KT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6Ae-0004uB-AB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:18:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hL6Ae-0004tR-1x
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05C5E1556B;
	Mon, 29 Apr 2019 13:18:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-111.ams2.redhat.com [10.36.116.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D38D317257;
	Mon, 29 Apr 2019 13:18:03 +0000 (UTC)
To: Li Qiang <liq3ea@gmail.com>
References: <20190424140643.62457-1-liq3ea@163.com>
	<2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
	<CAKXe6SLXrthYFrQGVQNT4hK1-22wrteMNyygZgx_j=jtDfYC6g@mail.gmail.com>
	<CAKXe6SL8XWMg1x8qztepjypgqdmXpZDj0G0AHU+BLV8OsbRjOg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <b1d3be69-a315-d990-45bc-daa02036b887@redhat.com>
Date: Mon, 29 Apr 2019 15:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SL8XWMg1x8qztepjypgqdmXpZDj0G0AHU+BLV8OsbRjOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 29 Apr 2019 13:18:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Laszlo Ersek <lersek@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429131802.whscNufd477lL-7F1IraSeesc1IfnnAqVyVV07p__ao@z>

On 29/04/2019 07.09, Li Qiang wrote:
>=20
>=20
> Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>> =E4=BA=8E2019=E5=B9=
=B44=E6=9C=8825=E6=97=A5=E5=91=A8
> =E5=9B=9B =E4=B8=8B=E5=8D=8810:29=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>     Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>> =E4=BA=8E2=
019=E5=B9=B44=E6=9C=88
>     25=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=
=93=EF=BC=9A
>=20
>         On 24/04/2019 16.06, Li Qiang wrote:
>         > In the disscuss of adding reboot timeout test case:
>         >
>         https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.=
html
>         >
>         > Philippe suggested we should uses the only related option for=
 one
>         > specific test. However currently we uses one QTestState for
>         all the
>         > test cases. In order to achieve Philippe's idea, I split the
>         test case
>         > for its own QTestState. As this patchset has changed a lot, I
>         don't bump
>         > the version.
>         >
>         > Change since v1:
>         > Add a patch to store the reboot_timeout as little endian
>         > Fix the endian issue per Thomas's review
>=20
>         The test still aborts on a big endian host:
>=20
>         $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
>         tests/fw_cfg-test
>         /x86_64/fw_cfg/signature: OK
>         /x86_64/fw_cfg/id: OK
>         /x86_64/fw_cfg/uuid: OK
>         /x86_64/fw_cfg/ram_size: OK
>         /x86_64/fw_cfg/nographic: OK
>         /x86_64/fw_cfg/nb_cpus: OK
>         /x86_64/fw_cfg/max_cpus: OK
>         /x86_64/fw_cfg/numa: OK
>         /x86_64/fw_cfg/boot_menu: OK
>         /x86_64/fw_cfg/reboot_timeout: **
>         ERROR:/home/thuth/devel/qemu/tests/fw_cfg-test.c:190:test_fw_cf=
g_reboot_timeout:
>         assertion failed (reboot_timeout =3D=3D 15): (251658240 =3D=3D =
15)
>         Aborted
>=20
>         251658240 is 0x0F000000, i.e. a byte-swapped 0xf =3D 15 ... i.e=
.
>         you still
>         got an endianess issue somewhere in the code.
>=20
>=20
>=20
>     Hmmmm,
>=20
>     I have thought a long time, still can't point where is wrong.
>=20
>     Let's from the result:=C2=A0
>     0x0f000000 in the big endian laid as this:
>     low ---> high
>     0x0f 00 00 00
>=20
>     As I have swapped before the compare so it is read as this:
>     low ---> high
>     00 00 00 0x0f
>=20
>     However from the store side:
>     the 15 in big endian is:
>     low ---> high
>     00 00 00 0x0f
>=20
>     But Before I store it, I convert it to little endian, so following
>     should be stored:
>     low ---> high
>     0x0f 00 00 00
>=20
>     Do you apply the patch 3 and recompile the qemu binary?
>=20
>=20
>=20
> Hello Thomas,=C2=A0
> I have tested again this and just store it as big endian(so that the
> store/load has different endianness),=C2=A0
> I don't see any error.=C2=A0

Uh, now this is embarrassing... I just tried again to see whether I
could find the issue, but now the test passes without problems!
I guess I simply only did a "make tests/fw_cfg-test" before and forgot
to recompile qemu itself. Big sorry for this!

Anyway, patch series works fine for me, so for the series:

Tested-by: Thomas Huth <thuth@redhat.com>

> Also, can we add these test=C2=A0sceneries(big-endian host) in our CI? =
so
> that the bot can report for every commit.

Patchew only runs on x86, but Peter has some big endian hosts for his
acceptance tests - so problems should be found during PULL requests at
least.

 Thomas

