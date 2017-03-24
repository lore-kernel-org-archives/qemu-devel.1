Received: from eggs.gnu.org ([2001:4830:134:3::10]:60373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crMuJ-0000v8-1k
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crMuI-000133-Dn
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:57:23 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crMuI-00012y-83
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:57:22 -0400
Received: by mail-wm0-x231.google.com with SMTP id n11so9863539wma.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:57:21 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 10:57:00 +0000
Message-ID: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu-system-s390x tests/boot-serial-test intermittent
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi; qemu-system-s390x seems to have an intermittent failure at
the moment -- it's been causing our Travis builds to flap. I actually
caught it doing this on one of my local test builds (which happens
to be aarch64 but I don't think that matters, since Travis is doing
x86 builds):

while  QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
255 + 1))} gtester -k --verbose -m=quick tests/boot-serial-test ; do
true; done
 TEST: tests/boot-serial-test... (pid=1122)
  /s390x/boot-serial/s390-ccw-virtio:                                  OK
PASS: tests/boot-serial-test
TEST: tests/boot-serial-test... (pid=1135)
  /s390x/boot-serial/s390-ccw-virtio:                                  OK
[skip lots more successes]
TEST: tests/boot-serial-test... (pid=1582)
  /s390x/boot-serial/s390-ccw-virtio:
Broken pipe
FAIL
GTester: last random seed: R02Se94f36f305f2edd8391a22749ec91143
(pid=1635)
FAIL: tests/boot-serial-test

Any ideas?
thanks
-- PMM
