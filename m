Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D29C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A63A20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A63A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOBE-0007x2-6E
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7K-0004EU-JO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7I-0007b1-K5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7D-0007YK-7f; Tue, 01 Oct 2019 15:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 54F9783F3C;
 Tue,  1 Oct 2019 19:47:18 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE02060619;
 Tue,  1 Oct 2019 19:47:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/67] iotests: Honor $IMGOPTS in Python tests
Date: Tue,  1 Oct 2019 21:46:08 +0200
Message-Id: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 01 Oct 2019 19:47:18 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First of all: Sorry.


Second:

Based-on: My block branch
          (https://github.com/XanClic/qemu.git block)

Based-on: 20190917234549.22910-1-jsnow@redhat.com
          (=E2=80=9Ciotests: use python logging=E2=80=9D)

Based-on: 20190927094242.11152-1-mreitz@redhat.com
          (=E2=80=9Ciotests: Allow ./check -o data_file=E2=80=9D)

Based-on: 20190917092004.999-1-mreitz@redhat.com
          (=E2=80=9Ciotests: Selfish patches=E2=80=9D)

Based-on: 20191001174827.11081-1-mreitz@redhat.com
          (=E2=80=9Cblock: Skip COR for inactive nodes=E2=80=9D)


OK, now:

Hi,

My recent series =E2=80=9Ciotests: Allow ./check -o data_file=E2=80=9D en=
abled our bash
tests to interpret the data_file qcow2 option.  It didn=E2=80=99t do anyt=
hing
for Python tests because those currently completely ignore all image
format options.

This is where it gets hairy.  To do so, we need two things: First of
all, whatever way Python tests use to create images needs to interpret
$IMGOPTS.  Second, when deleting image files, they must not use a plain
os.remove(), but a special function that will clean up data files, too.

The heap of patches in this series comes from making the Python tests
use these new functions.

Most Python tests just run qemu-img through a helper function that does
not care about the exact subcommand to create images.  I could add
$IMGOPTS support to it, but that doesn=E2=80=99t feel quite right to me, =
and it
wouldn=E2=80=99t reduce the patch count because we still need a special r=
emoval
function.


This series is structured as follows:
- Patches 1 through 7 add support to handle image files differently from
  other files (consider $IMGOPTS when creating them, consider data files
  when deleting them, separate ImagePaths from FilePaths, and so on)

- Patches 8 and 9 add two filters we=E2=80=99ll need in the next range:

- Patches 10 through 13 address some issues in a handful of tests that
  just need to be changed a little so they can overall work with some
  format options

- Patch 14 makes all tests pass unsupported_imgopts where there are
  options that they cannot support.

- Patches 15 through 65 make all Python tests use the new functions
  introduced in the first 7 patches so they no longer ignore $IMGOPTS.

  I felt like this is much better than munching everything together into
  a single big commit (better to rebase, better to review), and I don=E2=80=
=99t
  really like ideas like =E2=80=9CJust do five patches that each address =
ten
  iotests=E2=80=9D.

  But I=E2=80=99m still very much open to suggestions on how to combine t=
hese
  many small patches to reduce the overall patch count.

- Patch 66 ensures that Python tests always use the new function to
  create test images so they won=E2=80=99t bypass $IMGOPTS.

- Patch 67 cleans up.  qemu_img_log() is only used for image creation,
  and I don=E2=80=99t see the point in that.  The output is predictable a=
nd it
  is very unlikely to fail.  We can see in the bash tests that regularly
  we basically just filter everything from it anyway.
  (So this series replaces log(qemu_img_pipe()) instances by asserting
  that image creation did not fail.)
  ((qemu_img_create() obviously no longer has any use after this
  series.))


After this series, running the iotests with -o compat=3D0.10,
-o refcount_bits=3D1, and -o 'data_file=3D$TEST_IMG.data_file' does
something sensible even for the Python tests, and it passes.


Max Reitz (67):
  iotests.py: Read $IMGOPTS
  iotests.py: Add @skip_for_imgopts()
  iotests.py: Add unsupported_imgopts
  iotests.py: create_test_image, remove_test_image
  iotests.py: Add ImagePaths
  iotests.py: Add image_path()
  iotests.py: Filter data_file in filter_img_info
  iotests.py: Add filter_json_filename()
  iotests.py: Add @hide_fields to img_info_log
  iotests/169: Skip persistent cases for compat=3D0.10
  iotests/224: Filter json:{} from commit command
  iotests/228: Filter json:{} filenames
  iotests/242: Hide refcount bit information
  iotests: Use unsupported_imgopts in Python tests
  iotests/030: Honor $IMGOPTS
  iotests/040: Honor $IMGOPTS
  iotests/041: Honor $IMGOPTS
  iotests/044: Honor $IMGOPTS
  iotests/045: Honor $IMGOPTS
  iotests/055: Honor $IMGOPTS
  iotests/056: Honor $IMGOPTS
  iotests/057: Honor $IMGOPTS
  iotests/065: Honor $IMGOPTS
  iotests/096: Honor $IMGOPTS
  iotests/118: Honor $IMGOPTS
  iotests/124: Honor $IMGOPTS
  iotests/129: Honor $IMGOPTS
  iotests/132: Honor $IMGOPTS
  iotests/139: Honor $IMGOPTS
  iotests/147: Honor $IMGOPTS
  iotests/148: Honor $IMGOPTS
  iotests/151: Honor $IMGOPTS
  iotests/152: Honor $IMGOPTS
  iotests/155: Honor $IMGOPTS
  iotests/163: Honor $IMGOPTS
  iotests/165: Honor $IMGOPTS
  iotests/169: Honor $IMGOPTS
  iotests/194: Honor $IMGOPTS
  iotests/196: Honor $IMGOPTS
  iotests/199: Honor $IMGOPTS
  iotests/202: Honor $IMGOPTS
  iotests/203: Honor $IMGOPTS
  iotests/205: Honor $IMGOPTS
  iotests/208: Honor $IMGOPTS
  iotests/208: Honor $IMGOPTS
  iotests/216: Honor $IMGOPTS
  iotests/218: Honor $IMGOPTS
  iotests/219: Honor $IMGOPTS
  iotests/222: Honor $IMGOPTS
  iotests/224: Honor $IMGOPTS
  iotests/228: Honor $IMGOPTS
  iotests/234: Honor $IMGOPTS
  iotests/235: Honor $IMGOPTS
  iotests/236: Honor $IMGOPTS
  iotests/237: Honor $IMGOPTS
  iotests/242: Honor $IMGOPTS
  iotests/245: Honor $IMGOPTS
  iotests/246: Honor $IMGOPTS
  iotests/248: Honor $IMGOPTS
  iotests/254: Honor $IMGOPTS
  iotests/255: Honor $IMGOPTS
  iotests/256: Honor $IMGOPTS
  iotests/257: Honor $IMGOPTS
  iotests/258: Honor $IMGOPTS
  iotests/262: Honor $IMGOPTS
  iotests.py: Forbid qemu_img*('create', ...)
  iotests.py: Drop qemu_img_log(), qemu_img_create()

 tests/qemu-iotests/030        |  69 ++++++------
 tests/qemu-iotests/040        |  42 ++++----
 tests/qemu-iotests/041        | 108 +++++++++----------
 tests/qemu-iotests/044        |  11 +-
 tests/qemu-iotests/045        |  26 ++---
 tests/qemu-iotests/055        |  41 +++----
 tests/qemu-iotests/056        |  30 +++---
 tests/qemu-iotests/057        |  10 +-
 tests/qemu-iotests/065        |  21 ++--
 tests/qemu-iotests/096        |   5 +-
 tests/qemu-iotests/118        |  26 ++---
 tests/qemu-iotests/124        |  29 +++--
 tests/qemu-iotests/129        |  11 +-
 tests/qemu-iotests/132        |   6 +-
 tests/qemu-iotests/139        |  15 ++-
 tests/qemu-iotests/147        |  11 +-
 tests/qemu-iotests/148        |   5 +-
 tests/qemu-iotests/151        |  10 +-
 tests/qemu-iotests/152        |   6 +-
 tests/qemu-iotests/155        |  29 +++--
 tests/qemu-iotests/163        |  29 ++---
 tests/qemu-iotests/165        |  10 +-
 tests/qemu-iotests/169        |  23 ++--
 tests/qemu-iotests/194        |   9 +-
 tests/qemu-iotests/196        |  10 +-
 tests/qemu-iotests/199        |  10 +-
 tests/qemu-iotests/202        |   9 +-
 tests/qemu-iotests/203        |   9 +-
 tests/qemu-iotests/205        |   7 +-
 tests/qemu-iotests/206        |   5 +-
 tests/qemu-iotests/208        |   5 +-
 tests/qemu-iotests/209        |   9 +-
 tests/qemu-iotests/216        |  11 +-
 tests/qemu-iotests/218        |   6 +-
 tests/qemu-iotests/219        |   5 +-
 tests/qemu-iotests/222        |  13 +--
 tests/qemu-iotests/224        |  33 +++---
 tests/qemu-iotests/224.out    |   4 +-
 tests/qemu-iotests/228        |  25 ++---
 tests/qemu-iotests/228.out    |   8 +-
 tests/qemu-iotests/234        |   9 +-
 tests/qemu-iotests/235        |   7 +-
 tests/qemu-iotests/236        |   6 +-
 tests/qemu-iotests/237        |  15 +--
 tests/qemu-iotests/237.out    |   6 --
 tests/qemu-iotests/242        |  21 ++--
 tests/qemu-iotests/242.out    |   5 -
 tests/qemu-iotests/245        |  21 ++--
 tests/qemu-iotests/246        |  11 +-
 tests/qemu-iotests/248        |  14 ++-
 tests/qemu-iotests/254        |  10 +-
 tests/qemu-iotests/255        |  20 ++--
 tests/qemu-iotests/255.out    |   8 --
 tests/qemu-iotests/256        |  10 +-
 tests/qemu-iotests/257        |  18 ++--
 tests/qemu-iotests/258        |  16 +--
 tests/qemu-iotests/262        |   5 +-
 tests/qemu-iotests/iotests.py | 197 +++++++++++++++++++++++++++-------
 58 files changed, 654 insertions(+), 496 deletions(-)

--=20
2.21.0


