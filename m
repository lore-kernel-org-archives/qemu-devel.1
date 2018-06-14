Received: from eggs.gnu.org ([2001:4830:134:3::10]:35275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRl1-0006Pq-8Z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRky-0002XN-8D
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:43 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:53666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTRky-0002W1-1p
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:40 -0400
Received: by mail-wm0-x22d.google.com with SMTP id x6-v6so10326143wmc.3
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 05:53:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 14 Jun 2018 13:53:34 +0100
Message-Id: <20180614125337.24950-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/3] Current Travis Patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Mine are mostly aimed at reducing the build time of a number of bits
of the matrix which keep tripping up on the time limit. I'll put the
pull-req in tomorrow if there are no major complaints.

Alex Bennée (2):
  travis: reduce coverage of gprof build
  travis: reduce time taken for trace-backend testing

Daniel P. Berrangé (1):
  travis: display config.log when configure fails

 .travis.yml | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.17.1
