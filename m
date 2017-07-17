Received: from eggs.gnu.org ([2001:4830:134:3::10]:37813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWzcx-00061U-D4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWzcs-00084S-CU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:35:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWzcs-00083o-6X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:35:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D968A83F47
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 06:35:24 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 499CE600CA
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 06:35:23 +0000 (UTC)
Date: Mon, 17 Jul 2017 14:35:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717063521.GA7393@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

Today I've included a fourth type of the automatic patchew replies: FreeBSD.

So far we have these tests running by patchew on each patch series:

  * Docker tests
    Basically it is
        make docker-test-quick@centos6 \
             docker-test-build@min-glib \
             docker-test-mingw@fedora"

  * checkpatch.pl
    Each patch is fed to ./scripts/checkpatch.pl and all errors are reported.

  * s390x
    It runs on a machine shared by Fedora team, basically only "./configure and
    make", because "make check" hanging is tricky to deal with from an
    automation perspective. (Ideas?)

  * FreeBSD
    Like s390x.

Q1: In the worst case, you get four individual auto replies from patchew. Is
that too many? Do you prefer one reply with all the results concatenated into
one?

Q2: Some think the full log in the mail body is more than necessary. Is it
better or worse if it is a "tail -n 200" of the log in the body and the full log
attached?

Q3: What other tests do maintainers want? Different hosts? Different configure
combinations?

Q4: Any other improvements/features you want? (E.g. some documentation? :)

Fam
