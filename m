Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5525FECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F7521924
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F7521924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQAM-0008RH-08
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iFQ0B-0001Mr-HJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iFQ09-0000gw-BW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iFQ03-0000Wo-5G; Tue, 01 Oct 2019 17:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E6D13082138;
 Tue,  1 Oct 2019 21:48:00 +0000 (UTC)
Received: from [10.18.17.165] (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D455E1001B01;
 Tue,  1 Oct 2019 21:47:59 +0000 (UTC)
Subject: Re: [PATCH 00/67] iotests: Honor $IMGOPTS in Python tests
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191001194715.2796-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cbb8017a-898b-5658-d176-a76537e3b264@redhat.com>
Date: Tue, 1 Oct 2019 17:47:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 01 Oct 2019 21:48:00 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/1/19 3:46 PM, Max Reitz wrote:
> First of all: Sorry.
>=20

Thank you for finding the time to do it.

>=20
> Second:
>=20
> Based-on: My block branch
>           (https://github.com/XanClic/qemu.git block)
>=20
> Based-on: 20190917234549.22910-1-jsnow@redhat.com
>           (=E2=80=9Ciotests: use python logging=E2=80=9D)
>=20
> Based-on: 20190927094242.11152-1-mreitz@redhat.com
>           (=E2=80=9Ciotests: Allow ./check -o data_file=E2=80=9D)
>=20
> Based-on: 20190917092004.999-1-mreitz@redhat.com
>           (=E2=80=9Ciotests: Selfish patches=E2=80=9D)
>=20
> Based-on: 20191001174827.11081-1-mreitz@redhat.com
>           (=E2=80=9Cblock: Skip COR for inactive nodes=E2=80=9D)
>=20
>=20
> OK, now:
>=20
> Hi,
>=20
> My recent series =E2=80=9Ciotests: Allow ./check -o data_file=E2=80=9D =
enabled our bash
> tests to interpret the data_file qcow2 option.  It didn=E2=80=99t do an=
ything
> for Python tests because those currently completely ignore all image
> format options.
>=20
> This is where it gets hairy.  To do so, we need two things: First of
> all, whatever way Python tests use to create images needs to interpret
> $IMGOPTS.  Second, when deleting image files, they must not use a plain
> os.remove(), but a special function that will clean up data files, too.
>=20
> The heap of patches in this series comes from making the Python tests
> use these new functions.
>=20
> Most Python tests just run qemu-img through a helper function that does
> not care about the exact subcommand to create images.  I could add
> $IMGOPTS support to it, but that doesn=E2=80=99t feel quite right to me=
, and it
> wouldn=E2=80=99t reduce the patch count because we still need a special=
 removal
> function.
>=20
>=20
> This series is structured as follows:
> - Patches 1 through 7 add support to handle image files differently fro=
m
>   other files (consider $IMGOPTS when creating them, consider data file=
s
>   when deleting them, separate ImagePaths from FilePaths, and so on)

OK, that makes sense. I suppose we've been playing a bit fast and loose
with these such things.

>=20
> - Patches 8 and 9 add two filters we=E2=80=99ll need in the next range:
>=20
> - Patches 10 through 13 address some issues in a handful of tests that
>   just need to be changed a little so they can overall work with some
>   format options
>=20
> - Patch 14 makes all tests pass unsupported_imgopts where there are
>   options that they cannot support.
>=20
> - Patches 15 through 65 make all Python tests use the new functions
>   introduced in the first 7 patches so they no longer ignore $IMGOPTS.
>=20
>   I felt like this is much better than munching everything together int=
o
>   a single big commit (better to rebase, better to review), and I don=E2=
=80=99t
>   really like ideas like =E2=80=9CJust do five patches that each addres=
s ten
>   iotests=E2=80=9D.
>=20

This is the right approach, for the exact reasons you specify.

>   But I=E2=80=99m still very much open to suggestions on how to combine=
 these
>   many small patches to reduce the overall patch count.
>=20

You could group them by release windows, if you really wanted to;

- [...etc...]
- Update iotests added for 3.2
- Update iotests added for 4.0
- Update iotests added for 4.1
- Individual patches thereafter

But maybe that doesn't really solve anything for anyone. If you didn't
find a more obvious grouping for these, I'd just leave it alone. I'll
get to reviewing them.

> - Patch 66 ensures that Python tests always use the new function to
>   create test images so they won=E2=80=99t bypass $IMGOPTS.
>=20
> - Patch 67 cleans up.  qemu_img_log() is only used for image creation,
>   and I don=E2=80=99t see the point in that.  The output is predictable=
 and it
>   is very unlikely to fail.  We can see in the bash tests that regularl=
y
>   we basically just filter everything from it anyway.
>   (So this series replaces log(qemu_img_pipe()) instances by asserting
>   that image creation did not fail.)
>   ((qemu_img_create() obviously no longer has any use after this
>   series.))
>=20
>=20
> After this series, running the iotests with -o compat=3D0.10,
> -o refcount_bits=3D1, and -o 'data_file=3D$TEST_IMG.data_file' does
> something sensible even for the Python tests, and it passes.
>=20

No minor accomplishment.

I'll make sure to review at least 1-14, but not before Friday.

>=20
> Max Reitz (67):
>   iotests.py: Read $IMGOPTS
>   iotests.py: Add @skip_for_imgopts()
>   iotests.py: Add unsupported_imgopts
>   iotests.py: create_test_image, remove_test_image
>   iotests.py: Add ImagePaths
>   iotests.py: Add image_path()
>   iotests.py: Filter data_file in filter_img_info
>   iotests.py: Add filter_json_filename()
>   iotests.py: Add @hide_fields to img_info_log
>   iotests/169: Skip persistent cases for compat=3D0.10
>   iotests/224: Filter json:{} from commit command
>   iotests/228: Filter json:{} filenames
>   iotests/242: Hide refcount bit information
>   iotests: Use unsupported_imgopts in Python tests
>   iotests/030: Honor $IMGOPTS
>   iotests/040: Honor $IMGOPTS
>   iotests/041: Honor $IMGOPTS
>   iotests/044: Honor $IMGOPTS
>   iotests/045: Honor $IMGOPTS
>   iotests/055: Honor $IMGOPTS
>   iotests/056: Honor $IMGOPTS
>   iotests/057: Honor $IMGOPTS
>   iotests/065: Honor $IMGOPTS
>   iotests/096: Honor $IMGOPTS
>   iotests/118: Honor $IMGOPTS
>   iotests/124: Honor $IMGOPTS
>   iotests/129: Honor $IMGOPTS
>   iotests/132: Honor $IMGOPTS
>   iotests/139: Honor $IMGOPTS
>   iotests/147: Honor $IMGOPTS
>   iotests/148: Honor $IMGOPTS
>   iotests/151: Honor $IMGOPTS
>   iotests/152: Honor $IMGOPTS
>   iotests/155: Honor $IMGOPTS
>   iotests/163: Honor $IMGOPTS
>   iotests/165: Honor $IMGOPTS
>   iotests/169: Honor $IMGOPTS
>   iotests/194: Honor $IMGOPTS
>   iotests/196: Honor $IMGOPTS
>   iotests/199: Honor $IMGOPTS
>   iotests/202: Honor $IMGOPTS
>   iotests/203: Honor $IMGOPTS
>   iotests/205: Honor $IMGOPTS
>   iotests/208: Honor $IMGOPTS
>   iotests/208: Honor $IMGOPTS
>   iotests/216: Honor $IMGOPTS
>   iotests/218: Honor $IMGOPTS
>   iotests/219: Honor $IMGOPTS
>   iotests/222: Honor $IMGOPTS
>   iotests/224: Honor $IMGOPTS
>   iotests/228: Honor $IMGOPTS
>   iotests/234: Honor $IMGOPTS
>   iotests/235: Honor $IMGOPTS
>   iotests/236: Honor $IMGOPTS
>   iotests/237: Honor $IMGOPTS
>   iotests/242: Honor $IMGOPTS
>   iotests/245: Honor $IMGOPTS
>   iotests/246: Honor $IMGOPTS
>   iotests/248: Honor $IMGOPTS
>   iotests/254: Honor $IMGOPTS
>   iotests/255: Honor $IMGOPTS
>   iotests/256: Honor $IMGOPTS
>   iotests/257: Honor $IMGOPTS
>   iotests/258: Honor $IMGOPTS
>   iotests/262: Honor $IMGOPTS
>   iotests.py: Forbid qemu_img*('create', ...)
>   iotests.py: Drop qemu_img_log(), qemu_img_create()
>=20
>  tests/qemu-iotests/030        |  69 ++++++------
>  tests/qemu-iotests/040        |  42 ++++----
>  tests/qemu-iotests/041        | 108 +++++++++----------
>  tests/qemu-iotests/044        |  11 +-
>  tests/qemu-iotests/045        |  26 ++---
>  tests/qemu-iotests/055        |  41 +++----
>  tests/qemu-iotests/056        |  30 +++---
>  tests/qemu-iotests/057        |  10 +-
>  tests/qemu-iotests/065        |  21 ++--
>  tests/qemu-iotests/096        |   5 +-
>  tests/qemu-iotests/118        |  26 ++---
>  tests/qemu-iotests/124        |  29 +++--
>  tests/qemu-iotests/129        |  11 +-
>  tests/qemu-iotests/132        |   6 +-
>  tests/qemu-iotests/139        |  15 ++-
>  tests/qemu-iotests/147        |  11 +-
>  tests/qemu-iotests/148        |   5 +-
>  tests/qemu-iotests/151        |  10 +-
>  tests/qemu-iotests/152        |   6 +-
>  tests/qemu-iotests/155        |  29 +++--
>  tests/qemu-iotests/163        |  29 ++---
>  tests/qemu-iotests/165        |  10 +-
>  tests/qemu-iotests/169        |  23 ++--
>  tests/qemu-iotests/194        |   9 +-
>  tests/qemu-iotests/196        |  10 +-
>  tests/qemu-iotests/199        |  10 +-
>  tests/qemu-iotests/202        |   9 +-
>  tests/qemu-iotests/203        |   9 +-
>  tests/qemu-iotests/205        |   7 +-
>  tests/qemu-iotests/206        |   5 +-
>  tests/qemu-iotests/208        |   5 +-
>  tests/qemu-iotests/209        |   9 +-
>  tests/qemu-iotests/216        |  11 +-
>  tests/qemu-iotests/218        |   6 +-
>  tests/qemu-iotests/219        |   5 +-
>  tests/qemu-iotests/222        |  13 +--
>  tests/qemu-iotests/224        |  33 +++---
>  tests/qemu-iotests/224.out    |   4 +-
>  tests/qemu-iotests/228        |  25 ++---
>  tests/qemu-iotests/228.out    |   8 +-
>  tests/qemu-iotests/234        |   9 +-
>  tests/qemu-iotests/235        |   7 +-
>  tests/qemu-iotests/236        |   6 +-
>  tests/qemu-iotests/237        |  15 +--
>  tests/qemu-iotests/237.out    |   6 --
>  tests/qemu-iotests/242        |  21 ++--
>  tests/qemu-iotests/242.out    |   5 -
>  tests/qemu-iotests/245        |  21 ++--
>  tests/qemu-iotests/246        |  11 +-
>  tests/qemu-iotests/248        |  14 ++-
>  tests/qemu-iotests/254        |  10 +-
>  tests/qemu-iotests/255        |  20 ++--
>  tests/qemu-iotests/255.out    |   8 --
>  tests/qemu-iotests/256        |  10 +-
>  tests/qemu-iotests/257        |  18 ++--
>  tests/qemu-iotests/258        |  16 +--
>  tests/qemu-iotests/262        |   5 +-
>  tests/qemu-iotests/iotests.py | 197 +++++++++++++++++++++++++++-------
>  58 files changed, 654 insertions(+), 496 deletions(-)
>=20

