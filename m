Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EF4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690BC216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690BC216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSliw-0000yc-C5
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:05:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlh1-0008QT-DB
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlgz-0002Bu-UU
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlgy-0002As-1j; Mon, 20 May 2019 13:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BB603086200;
	Mon, 20 May 2019 17:03:09 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BC11608A7;
	Mon, 20 May 2019 17:03:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:08 +0200
Message-Id: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 20 May 2019 17:03:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/54] s390x update
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bc=
b7:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into =
staging (2019-05-16 13:15:08 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190520

for you to fetch changes up to f9de88d07258b7288b59ebca77ff1da75b0e8e9f:

  s390x/cpumodel: wire up 8561 and 8562 as gen15 machines (2019-05-20 08:=
35:42 +0200)

----------------------------------------------------------------
s390x update:
- have the bios tolerate bootmap signature entries
- next chunk of vector instruction support in tcg
- a headers update against Linux 5.2-rc1
- add more facilities and gen15 machines to the cpu model

----------------------------------------------------------------

Christian Borntraeger (8):
  s390x/cpumodel: ignore csske for expansion
  s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
  s390x/cpumodel: msa9 facility
  s390x/cpumodel: vector enhancements
  s390x/cpumodel: enhanced sort facility
  s390x/cpumodel: add Deflate-conversion facility
  s390x/cpumodel: add gen15 defintions
  s390x/cpumodel: wire up 8561 and 8562 as gen15 machines

Cornelia Huck (3):
  s390/ipl: cast to SCSIDevice directly
  s390/css: handle CCW_FLAG_SKIP
  linux headers: update against Linux 5.2-rc1

David Hildenbrand (40):
  s390x/tcg: Implement VECTOR ADD
  s390x/tcg: Implement VECTOR ADD COMPUTE CARRY
  s390x/tcg: Implement VECTOR ADD WITH CARRY
  s390x/tcg: Implement VECTOR ADD WITH CARRY COMPUTE CARRY
  s390x/tcg: Implement VECTOR AND (WITH COMPLEMENT)
  s390x/tcg: Implement VECTOR AVERAGE
  s390x/tcg: Implement VECTOR AVERAGE LOGICAL
  s390x/tcg: Implement VECTOR CHECKSUM
  s390x/tcg: Implement VECTOR ELEMENT COMPARE *
  s390x/tcg: Implement VECTOR COMPARE *
  s390x/tcg: Implement VECTOR COUNT LEADING ZEROS
  s390x/tcg: Implement VECTOR COUNT TRAILING ZEROS
  s390x/tcg: Implement VECTOR EXCLUSIVE OR
  s390x/tcg: Implement VECTOR GALOIS FIELD MULTIPLY SUM (AND ACCUMULATE)
  s390x/tcg: Implement VECTOR LOAD COMPLEMENT
  s390x/tcg: Implement VECTOR LOAD POSITIVE
  s390x/tcg: Implement VECTOR (MAXIMUM|MINIMUM) (LOGICAL)
  s390x/tcg: Implement VECTOR MULTIPLY AND ADD *
  s390x/tcg: Implement VECTOR MULTIPLY *
  s390x/tcg: Implement VECTOR NAND
  s390x/tcg: Implement VECTOR NOR
  s390x/tcg: Implement VECTOR NOT EXCLUSIVE OR
  s390x/tcg: Implement VECTOR OR
  s390x/tcg: Implement VECTOR OR WITH COMPLEMENT
  s390x/tcg: Implement VECTOR POPULATION COUNT
  s390x/tcg: Implement VECTOR ELEMENT ROTATE LEFT LOGICAL
  s390x/tcg: Implement VECTOR ELEMENT ROTATE AND INSERT UNDER MASK
  s390x/tcg: Implement VECTOR ELEMENT SHIFT
  s390x/tcg: Implement VECTOR SHIFT LEFT (BY BYTE)
  s390x/tcg: Implement VECTOR SHIFT LEFT DOUBLE BY BYTE
  s390x/tcg: Implement VECTOR SHIFT RIGHT ARITHMETIC
  s390x/tcg: Implement VECTOR SHIFT RIGHT LOGICAL *
  s390x/tcg: Implement VECTOR SUBTRACT
  s390x/tcg: Implement VECTOR SUBTRACT COMPUTE BORROW INDICATION
  s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW INDICATION
  s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW COMPUTE BORROW
    INDICATION
  s390x/tcg: Implement VECTOR SUM ACROSS DOUBLEWORD
  s390x/tcg: Implement VECTOR SUM ACROSS QUADWORD
  s390x/tcg: Implement VECTOR SUM ACROSS WORD
  s390x/tcg: Implement VECTOR TEST UNDER MASK

Jason J. Herne (1):
  s390-bios: Skip bootmap signature entries

Markus Armbruster (1):
  pc-bios/s390-ccw: Clean up harmless misuse of isdigit()

Thomas Huth (1):
  pc-bios/s390: Update firmware image with "Skip bootmap signature
    entries" fix

--=20
2.20.1


