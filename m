Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DCDC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8532064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8532064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNsb-0002TS-9S
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNnc-0006Ra-Gc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNna-0008IY-P7
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNnW-0008As-SL; Tue, 15 Oct 2019 10:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0F643091D42;
 Tue, 15 Oct 2019 14:27:32 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 430655C1D6;
 Tue, 15 Oct 2019 14:27:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/21] iotests: Allow ./check -o data_file
Date: Tue, 15 Oct 2019 16:27:08 +0200
Message-Id: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 15 Oct 2019 14:27:33 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The cover letter from v1 (explaining the motivation behind this series
and the general structure) is here:

https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01323.html


For v2, I=E2=80=99ve tried to address Maxim=E2=80=99s comments:
- Patch 1 through 3: New
- Patch 4: Only print feature bits instead of blacklisting stuff that we
           don=E2=80=99t need
- Patch 5:
  - Fix typo
  - Add comment why 098 needs compat=3D1.1
- Patch 16: Use _check_test_img
- Patch 17: Use the new _filter_json_filename
- Patch 18: Rethink the incompatible feature filter approach: Instead of
            filtering out the data_file bit, just check whether the
            dirty bit is present (because that is all we want to know)
- Patch 19: Use the new _filter_json_filename
- Patch 20: Rebase conflicts due to the changes to patch 5
- Patch 21:
  - Add and use _get_data_file
  - Add a comment how the data_file_filter in _filter_qemu_img_map works


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/21:[down] 'iotests/qcow2.py: Add dump-header-exts'
002/21:[down] 'iotests/qcow2.py: Split feature fields into bits'
003/21:[down] 'iotests: Add _filter_json_filename'
004/21:[0060] [FC] 'iotests: Filter refcount_order in 036'
005/21:[0003] [FC] 'iotests: Replace IMGOPTS by _unsupported_imgopts'
006/21:[----] [--] 'iotests: Drop compat=3D1.1 in 050'
007/21:[----] [--] 'iotests: Let _make_test_img parse its parameters'
008/21:[----] [--] 'iotests: Add -o and --no-opts to _make_test_img'
009/21:[----] [--] 'iotests: Inject space into -ocompat=3D0.10 in 051'
010/21:[----] [--] 'iotests: Replace IMGOPTS=3D by -o'
011/21:[----] [--] 'iotests: Replace IMGOPTS=3D'' by --no-opts'
012/21:[----] [--] 'iotests: Drop IMGOPTS use in 267'
013/21:[----] [--] 'iotests: Avoid qemu-img create'
014/21:[----] [--] 'iotests: Use _rm_test_img for deleting test images'
015/21:[----] [--] 'iotests: Avoid cp/mv of test images'
016/21:[0004] [FC] 'iotests: Make 091 work with data_file'
017/21:[0004] [FC] 'iotests: Make 110 work with data_file'
018/21:[0002] [FC] 'iotests: Make 137 work with data_file'
019/21:[0004] [FC] 'iotests: Make 198 work with data_file'
020/21:[0002] [FC] 'iotests: Disable data_file where it cannot be used'
021/21:[0034] [FC] 'iotests: Allow check -o data_file'


Max Reitz (21):
  iotests/qcow2.py: Add dump-header-exts
  iotests/qcow2.py: Split feature fields into bits
  iotests: Add _filter_json_filename
  iotests: Filter refcount_order in 036
  iotests: Replace IMGOPTS by _unsupported_imgopts
  iotests: Drop compat=3D1.1 in 050
  iotests: Let _make_test_img parse its parameters
  iotests: Add -o and --no-opts to _make_test_img
  iotests: Inject space into -ocompat=3D0.10 in 051
  iotests: Replace IMGOPTS=3D by -o
  iotests: Replace IMGOPTS=3D'' by --no-opts
  iotests: Drop IMGOPTS use in 267
  iotests: Avoid qemu-img create
  iotests: Use _rm_test_img for deleting test images
  iotests: Avoid cp/mv of test images
  iotests: Make 091 work with data_file
  iotests: Make 110 work with data_file
  iotests: Make 137 work with data_file
  iotests: Make 198 work with data_file
  iotests: Disable data_file where it cannot be used
  iotests: Allow check -o data_file

 tests/qemu-iotests/005           |  2 +-
 tests/qemu-iotests/007           |  5 ++-
 tests/qemu-iotests/014           |  2 +
 tests/qemu-iotests/015           |  5 ++-
 tests/qemu-iotests/019           |  6 +--
 tests/qemu-iotests/020           |  6 +--
 tests/qemu-iotests/024           | 10 ++---
 tests/qemu-iotests/026           |  5 ++-
 tests/qemu-iotests/028           |  2 +-
 tests/qemu-iotests/029           |  7 ++--
 tests/qemu-iotests/031           |  9 ++--
 tests/qemu-iotests/031.out       | 36 ++++++++--------
 tests/qemu-iotests/036           | 15 ++++---
 tests/qemu-iotests/036.out       | 66 ++++-------------------------
 tests/qemu-iotests/039           | 27 +++++-------
 tests/qemu-iotests/039.out       | 22 +++++-----
 tests/qemu-iotests/043           |  4 +-
 tests/qemu-iotests/046           |  2 +
 tests/qemu-iotests/048           |  4 +-
 tests/qemu-iotests/050           |  8 +---
 tests/qemu-iotests/051           |  7 ++--
 tests/qemu-iotests/053           |  4 +-
 tests/qemu-iotests/058           |  7 ++--
 tests/qemu-iotests/059           | 20 ++++-----
 tests/qemu-iotests/060           | 12 +++---
 tests/qemu-iotests/060.out       | 20 ++++-----
 tests/qemu-iotests/061           | 61 ++++++++++++++-------------
 tests/qemu-iotests/061.out       | 72 ++++++++++++++++----------------
 tests/qemu-iotests/062           |  3 +-
 tests/qemu-iotests/063           | 18 ++++----
 tests/qemu-iotests/063.out       |  3 +-
 tests/qemu-iotests/066           |  3 +-
 tests/qemu-iotests/067           |  6 ++-
 tests/qemu-iotests/068           |  4 +-
 tests/qemu-iotests/069           |  2 +-
 tests/qemu-iotests/071           |  7 +++-
 tests/qemu-iotests/073           |  2 +
 tests/qemu-iotests/074           |  4 +-
 tests/qemu-iotests/079           |  3 +-
 tests/qemu-iotests/080           |  7 ++--
 tests/qemu-iotests/081           |  6 +--
 tests/qemu-iotests/085           | 18 ++++----
 tests/qemu-iotests/085.out       |  8 ++--
 tests/qemu-iotests/088           |  2 +-
 tests/qemu-iotests/090           |  2 +
 tests/qemu-iotests/091           |  2 +-
 tests/qemu-iotests/091.out       |  2 -
 tests/qemu-iotests/092           |  2 +-
 tests/qemu-iotests/094           |  4 +-
 tests/qemu-iotests/095           |  5 ++-
 tests/qemu-iotests/098           |  6 ++-
 tests/qemu-iotests/099           | 10 +++--
 tests/qemu-iotests/103           |  5 ++-
 tests/qemu-iotests/106           |  2 +-
 tests/qemu-iotests/108           |  8 ++--
 tests/qemu-iotests/109           |  4 +-
 tests/qemu-iotests/110           | 11 +++--
 tests/qemu-iotests/110.out       |  4 +-
 tests/qemu-iotests/111           |  3 +-
 tests/qemu-iotests/112           | 37 ++++++++--------
 tests/qemu-iotests/114           |  2 +
 tests/qemu-iotests/115           |  3 +-
 tests/qemu-iotests/121           |  9 ++--
 tests/qemu-iotests/122           |  6 ++-
 tests/qemu-iotests/123           |  4 +-
 tests/qemu-iotests/125           |  2 +-
 tests/qemu-iotests/137           | 17 +++++---
 tests/qemu-iotests/137.out       |  6 +--
 tests/qemu-iotests/138           |  5 ++-
 tests/qemu-iotests/141           |  4 +-
 tests/qemu-iotests/142           |  2 +-
 tests/qemu-iotests/144           |  4 +-
 tests/qemu-iotests/153           | 12 ++----
 tests/qemu-iotests/156           | 10 ++++-
 tests/qemu-iotests/159           |  2 +-
 tests/qemu-iotests/160           |  3 +-
 tests/qemu-iotests/161           |  4 +-
 tests/qemu-iotests/170           |  2 +-
 tests/qemu-iotests/172           |  6 +--
 tests/qemu-iotests/173           |  3 +-
 tests/qemu-iotests/174           |  2 +-
 tests/qemu-iotests/175           |  2 +-
 tests/qemu-iotests/176           |  7 +++-
 tests/qemu-iotests/178           |  6 +--
 tests/qemu-iotests/182           |  2 +-
 tests/qemu-iotests/183           |  2 +-
 tests/qemu-iotests/185           |  4 +-
 tests/qemu-iotests/187           |  6 +--
 tests/qemu-iotests/190           |  4 +-
 tests/qemu-iotests/191           | 11 ++---
 tests/qemu-iotests/195           |  2 +-
 tests/qemu-iotests/197           |  6 +--
 tests/qemu-iotests/198           |  6 ++-
 tests/qemu-iotests/198.out       |  4 +-
 tests/qemu-iotests/200           |  7 ++--
 tests/qemu-iotests/201           |  6 +--
 tests/qemu-iotests/214           |  3 +-
 tests/qemu-iotests/215           |  6 +--
 tests/qemu-iotests/217           |  3 +-
 tests/qemu-iotests/220           |  5 ++-
 tests/qemu-iotests/225           |  2 +-
 tests/qemu-iotests/229           |  3 +-
 tests/qemu-iotests/232           |  4 +-
 tests/qemu-iotests/243           | 10 +++--
 tests/qemu-iotests/244           | 15 ++++---
 tests/qemu-iotests/247           |  4 +-
 tests/qemu-iotests/249           |  4 +-
 tests/qemu-iotests/250           |  5 ++-
 tests/qemu-iotests/252           |  2 +-
 tests/qemu-iotests/265           |  2 +-
 tests/qemu-iotests/267           | 17 +++++---
 tests/qemu-iotests/common.filter | 47 ++++++++++++++++++++-
 tests/qemu-iotests/common.rc     | 63 ++++++++++++++++++++++++----
 tests/qemu-iotests/qcow2.py      | 23 ++++++++--
 114 files changed, 599 insertions(+), 451 deletions(-)

--=20
2.21.0


