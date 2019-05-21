Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C8CC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D570A21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D570A21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2Qt-000185-19
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:55:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2P4-0008PW-HL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2P2-0004SV-UV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hT2P2-0004RR-NB
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:53:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EBF0308622C;
	Tue, 21 May 2019 10:53:51 +0000 (UTC)
Received: from thuth.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95B0D7841C;
	Tue, 21 May 2019 10:53:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:53:31 +0200
Message-Id: <20190521105344.11637-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 21 May 2019 10:53:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/13] qtests and some iotest patches
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
Cc: kwolf@redhat.com, lvivier@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 2259637b95bef3116cc262459271de08e038cc=
66:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-05-20 17:22:05 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-21

for you to fetch changes up to b3763a195cc167152df1f762b3c3a73f7db7677b:

  tests/qemu-iotests: Remove the "_supported_os Linux" line from many tes=
ts (2019-05-21 10:13:58 +0200)

----------------------------------------------------------------
I'll be away from keyboard starting next week, so I'd like to
get these patches merged before they bitrot again:
- some qtest patches to get rid of the global_qtest variable in
  more tests
- some iotests patches that have multiple reviews and thus should
  be ready to go
----------------------------------------------------------------

Thomas Huth (13):
      tests/libqtest: Remove unused global_qtest-related wrapper function=
s
      tests/libqtest: Fix description of qtest_vinitf() and qtest_initf()
      tests/libqos: Get rid of global_qtest dependency in qvring_init()
      tests/q35-test: Make test independent of global_qtest
      tests/numa-test: Use qtest_init() instead of qtest_start()
      tests/qom-test: Use qtest_init() instead of qtest_start()
      tests/device-introspect: Use qtest_init() instead of qtest_start()
      tests/hd-geo-test: Use qtest_init() instead of qtest_start()
      tests/qemu-iotests/005: Add a sanity check for large sparse file su=
pport
      tests/qemu-iotests/check: Pick a default machine if necessary
      tests/qemu-iotests: Do not hard-code the path to bash
      cirrus / travis: Add gnu-sed and bash for macOS and FreeBSD
      tests/qemu-iotests: Remove the "_supported_os Linux" line from many=
 tests

 .cirrus.yml                    |   4 +-
 .travis.yml                    |   1 +
 tests/device-introspect-test.c |  85 +++++++++++++++++--------------
 tests/hd-geo-test.c            |  76 +++++++++++++++-------------
 tests/libqos/virtio-mmio.c     |   2 +-
 tests/libqos/virtio-pci.c      |   3 +-
 tests/libqos/virtio.c          |  18 ++++---
 tests/libqos/virtio.h          |   3 +-
 tests/libqtest.c               |  11 +---
 tests/libqtest.h               | 112 +----------------------------------=
------
 tests/numa-test.c              |  53 ++++++++++---------
 tests/q35-test.c               |  39 +++++++-------
 tests/qemu-iotests/001         |   1 -
 tests/qemu-iotests/002         |   1 -
 tests/qemu-iotests/003         |   1 -
 tests/qemu-iotests/004         |   1 -
 tests/qemu-iotests/005         |   9 ++++
 tests/qemu-iotests/007         |   1 -
 tests/qemu-iotests/008         |   1 -
 tests/qemu-iotests/009         |   1 -
 tests/qemu-iotests/010         |   1 -
 tests/qemu-iotests/011         |   1 -
 tests/qemu-iotests/012         |   1 -
 tests/qemu-iotests/015         |   1 -
 tests/qemu-iotests/017         |   1 -
 tests/qemu-iotests/020         |   1 -
 tests/qemu-iotests/021         |   1 -
 tests/qemu-iotests/022         |   1 -
 tests/qemu-iotests/025         |   1 -
 tests/qemu-iotests/026         |   1 -
 tests/qemu-iotests/027         |   1 -
 tests/qemu-iotests/029         |   1 -
 tests/qemu-iotests/031         |   1 -
 tests/qemu-iotests/032         |   1 -
 tests/qemu-iotests/033         |   1 -
 tests/qemu-iotests/035         |   1 -
 tests/qemu-iotests/036         |   1 -
 tests/qemu-iotests/037         |   1 -
 tests/qemu-iotests/042         |   1 -
 tests/qemu-iotests/043         |   1 -
 tests/qemu-iotests/046         |   1 -
 tests/qemu-iotests/047         |   1 -
 tests/qemu-iotests/049         |   1 -
 tests/qemu-iotests/050         |   1 -
 tests/qemu-iotests/051         |   1 -
 tests/qemu-iotests/052         |   1 -
 tests/qemu-iotests/053         |   1 -
 tests/qemu-iotests/054         |   1 -
 tests/qemu-iotests/062         |   1 -
 tests/qemu-iotests/063         |   1 -
 tests/qemu-iotests/066         |   1 -
 tests/qemu-iotests/067         |   1 -
 tests/qemu-iotests/068         |   1 -
 tests/qemu-iotests/069         |   1 -
 tests/qemu-iotests/071         |   1 -
 tests/qemu-iotests/072         |   1 -
 tests/qemu-iotests/073         |   1 -
 tests/qemu-iotests/079         |   1 -
 tests/qemu-iotests/082         |   1 -
 tests/qemu-iotests/085         |   1 -
 tests/qemu-iotests/089         |   1 -
 tests/qemu-iotests/090         |   1 -
 tests/qemu-iotests/094         |   1 -
 tests/qemu-iotests/095         |   1 -
 tests/qemu-iotests/098         |   1 -
 tests/qemu-iotests/102         |   1 -
 tests/qemu-iotests/103         |   1 -
 tests/qemu-iotests/104         |   1 -
 tests/qemu-iotests/105         |   1 -
 tests/qemu-iotests/107         |   1 -
 tests/qemu-iotests/110         |   1 -
 tests/qemu-iotests/111         |   1 -
 tests/qemu-iotests/112         |   1 -
 tests/qemu-iotests/114         |   1 -
 tests/qemu-iotests/115         |   1 -
 tests/qemu-iotests/117         |   1 -
 tests/qemu-iotests/120         |   1 -
 tests/qemu-iotests/125         |   1 -
 tests/qemu-iotests/126         |   1 -
 tests/qemu-iotests/127         |   1 -
 tests/qemu-iotests/133         |   1 -
 tests/qemu-iotests/134         |   1 -
 tests/qemu-iotests/142         |   1 -
 tests/qemu-iotests/143         |   1 -
 tests/qemu-iotests/144         |   1 -
 tests/qemu-iotests/145         |   1 -
 tests/qemu-iotests/153         |   1 -
 tests/qemu-iotests/156         |   1 -
 tests/qemu-iotests/157         |   1 -
 tests/qemu-iotests/158         |   1 -
 tests/qemu-iotests/159         |   1 -
 tests/qemu-iotests/162         |   1 -
 tests/qemu-iotests/170         |   1 -
 tests/qemu-iotests/173         |   1 -
 tests/qemu-iotests/182         |   1 -
 tests/qemu-iotests/183         |   1 -
 tests/qemu-iotests/186         |   1 -
 tests/qemu-iotests/187         |   1 -
 tests/qemu-iotests/190         |   1 -
 tests/qemu-iotests/191         |   1 -
 tests/qemu-iotests/192         |   1 -
 tests/qemu-iotests/195         |   1 -
 tests/qemu-iotests/197         |   1 -
 tests/qemu-iotests/200         |   1 -
 tests/qemu-iotests/214         |   1 -
 tests/qemu-iotests/215         |   1 -
 tests/qemu-iotests/217         |   1 -
 tests/qemu-iotests/227         |   1 -
 tests/qemu-iotests/231         |   1 -
 tests/qemu-iotests/233         |   1 -
 tests/qemu-iotests/239         |   2 +-
 tests/qemu-iotests/240         |   3 +-
 tests/qemu-iotests/241         |   2 +-
 tests/qemu-iotests/243         |   2 +-
 tests/qemu-iotests/244         |   2 +-
 tests/qemu-iotests/247         |   1 -
 tests/qemu-iotests/check       |  13 ++++-
 tests/qom-test.c               |  28 +++++------
 118 files changed, 195 insertions(+), 371 deletions(-)

