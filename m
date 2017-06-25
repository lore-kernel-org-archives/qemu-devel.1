Received: from eggs.gnu.org ([2001:4830:134:3::10]:42453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dPFRq-0007ip-98
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 17:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dPFRn-0000wJ-65
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 17:52:02 -0400
Received: from st13p21im-asmtp003.me.com ([17.164.152.25]:64043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tblodt@icloud.com>) id 1dPFRn-0000uB-20
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 17:51:59 -0400
Received: from process-dkim-sign-daemon.st13p21im-asmtp003.me.com by
	st13p21im-asmtp003.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016)) id <0OS400O00HMMMZ00@st13p21im-asmtp003.me.com> for
	qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:51:54 +0000 (GMT)
Received: from icloud.com ([127.0.0.1]) by st13p21im-asmtp003.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016))
	with ESMTPSA id <0OS4006M1I2E4F10@st13p21im-asmtp003.me.com> for
	qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:51:54 +0000 (GMT)
From: Theodore Dubois <tblodt@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-id: <CC588DAB-E108-4D59-867D-B0BCC98CA6A3@icloud.com>
Date: Sun, 25 Jun 2017 14:51:47 -0700
Subject: [Qemu-devel] glue(glue(ld, USUFFIX), _p)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In include/exec/cpu_ldst_useronly_template.h, there=E2=80=99s references =
to glue(glue(ld, USUFFIX), _p), which would expand to a call to a =
function looking something like uint32_t lduw_p(void *) (for example). =
Where is this function defined?

~Theodore
