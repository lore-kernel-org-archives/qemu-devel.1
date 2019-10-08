Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A034DC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 22:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F64521721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 22:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F64521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHxXN-0004bT-EX
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 18:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHxVZ-0003RD-Vj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 17:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHxVY-0003tl-AL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 17:59:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1iHxVU-0003qq-JS; Tue, 08 Oct 2019 17:59:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B3BA88384C;
 Tue,  8 Oct 2019 21:58:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-109.rdu2.redhat.com
 [10.10.120.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D745FF6C2;
 Tue,  8 Oct 2019 21:58:43 +0000 (UTC)
Subject: Re: [PULL v2 0/8] Ide patches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>
References: <20191003193245.8993-1-jsnow@redhat.com>
 <CAFEAcA9Z92iuYwEUdsSpej_pGiAX6H6FBaGySqKxXHGjGRueNw@mail.gmail.com>
 <e8e86add-677c-4eb5-4629-aaadfd0be2a4@redhat.com>
 <e0945918-d1cf-abf8-218a-6c5e8be80b70@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6b00dc74-7267-8ce8-3271-5db269edb1b7@redhat.com>
Date: Tue, 8 Oct 2019 23:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e0945918-d1cf-abf8-218a-6c5e8be80b70@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 08 Oct 2019 21:58:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 19:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/7/19 7:35 PM, John Snow wrote:
>> On 10/7/19 8:33 AM, Peter Maydell wrote:
>>> On Thu, 3 Oct 2019 at 20:33, John Snow <jsnow@redhat.com> wrote:
>>>>
>>>> The following changes since commit
>>>> 7f21573c822805a8e6be379d9bcf3ad9effef3dc:
>>>>
>>>> =C2=A0=C2=A0 Merge remote-tracking branch
>>>> 'remotes/huth-gitlab/tags/pull-request-2019-10-01' into staging
>>>> (2019-10-01 13:13:38 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>> =C2=A0=C2=A0 https://github.com/jnsnow/qemu.git tags/ide-pull-reques=
t
>>>>
>>>> for you to fetch changes up to
>>>> f6d61c9509c56eea3cdd2d23b40d285601b1c1ca:
>>>>
>>>> =C2=A0=C2=A0 hd-geo-test: Add tests for lchs override (2019-10-03 14=
:36:54 -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> Pull request V2
>>>>
>>>> - Added signoff into the mirrored commits themselves (vs just the
>>>> email)
>>>> - Kudos to `stg-foreach stg edit --sign`
>>>>
>>>> ----------------------------------------------------------------
>>>
>>> Hi; the new tests in hd-geo-test seem to hang on
>>> big-endian hosts (both s390x and ppc64 hung here):
>>>
>>> linux1@lxub05:~/qemu/build/all$ QTEST_QEMU_IMG=3D./qemu-img
>>> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
>>> ./tests/hd-geo-test
>>> /x86_64/hd-geo/ide/none: OK
>>> /x86_64/hd-geo/ide/drive/cd_0: OK
>>> /x86_64/hd-geo/ide/drive/mbr/blank: OK
>>> /x86_64/hd-geo/ide/drive/mbr/lba: OK
>>> /x86_64/hd-geo/ide/drive/mbr/chs: OK
>>> /x86_64/hd-geo/ide/device/mbr/blank: OK
>>> /x86_64/hd-geo/ide/device/mbr/lba: OK
>>> /x86_64/hd-geo/ide/device/mbr/chs: OK
>>> /x86_64/hd-geo/ide/device/user/chs: OK
>>> /x86_64/hd-geo/ide/device/user/chst: OK
>>> /x86_64/hd-geo/override/ide:
>>>
>>
>> :(
>>
>>>
>>> thanks
>>> -- PMM
>>>
>>
>> Sam, can you investigate this?
>=20
> Not seeing my T-b tags makes me grumble because I don't remember which =
I
> reviewed and need to go check on the list.
>=20
> If the error is a endianess bug related to fw_cfg, you can add the
> "-trace fw_cfg*" in hd-geo-test::create_args() and rerun the tests on a
> BE system, the bug should appear straightly on stdout.
>=20
> Are FWLCHSEntry fields little-endian? Shouldn't
> get_boot_devices_lchs_list() use some le32_to_cpu() call for the LCHS
> values?
>=20

*One* problem is most likely in the find_fw_cfg_file() function, in patch=
 8.

+static uint16_t find_fw_cfg_file(QFWCFG *fw_cfg,
+                                 const char *filename)
+{
+    struct QemuCfgFile qfile;
+    uint32_t count, e;
+    uint16_t select;
+
+    count =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_FILE_DIR);
+    count =3D be32_to_cpu(count);
+    for (select =3D 0, e =3D 0; e < count; e++) {
+        qfw_cfg_read_data(fw_cfg, &qfile, sizeof(qfile));
+        if (!strcmp(filename, qfile.name)) {
+            select =3D be16_to_cpu(qfile.select);
+        }
+    }
+
+    return select;
+}

Note qfw_cfg_get_u32():

uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key)
{
    uint32_t value;
    qfw_cfg_get(fw_cfg, key, &value, sizeof(value));
    return le32_to_cpu(value);
}

This function assumes that the wire encoding of the value read is little
endian. So, calling this function is wrong; and calling be32_to_cpu()
afterwards does not help. Namely:

* On LE hosts, the find_fw_cfg_file() function happens to work, because:

- the le32_to_cpu() call in qfw_cfg_get_u32() does nothing (it's identity=
),
- the subsequent be32_to_cpu() call in find_fw_cfg_file() corresponds to
the *blob-specific* encoding of the "count" field, in the fw_cfg
directory blob. (Which is BE) Therefore we perform the one byte-swap
that we need.

* On BE hosts, stuff breaks, because:

- the le32_to_cpu() call in qfw_cfg_get_u32() swaps the byte-order,
- the subsequent be32_to_cpu() call in find_fw_cfg_file() does nothing,
- thus, ultimately we have byte-swapped the contents of the "count"
field of the directory blob, even though the blob-specific wire format
thereof is *already* BE (=3D host-endian). On a BE host, all in all, ther=
e
should be zero byte swaps for consuming "count".

Now, how to fix this: eliminate
- QemuCfgFile,
- find_fw_cfg_file(),
- and read_fw_cfg_file()

altogether, and call qfw_cfg_get_file(), from "tests/libqos/fw_cfg.c".

Some other tests look up fw_cfg directory entries with that function
already (see call sites in "tests/fw_cfg-test.c").

Thanks
Laszlo

