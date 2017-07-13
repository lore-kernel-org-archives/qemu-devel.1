Received: from eggs.gnu.org ([2001:4830:134:3::10]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVay0-000500-Ba
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVaxu-0004Q9-EB
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:28 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVaxu-0004Pi-9V
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:22 -0400
Received: by mail-qt0-x236.google.com with SMTP id 32so33585429qtv.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:03:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 13 Jul 2017 07:03:09 -0300
Message-Id: <20170713100311.20037-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH RESEND 0/2] avoid Travis CI "no log output
 for 10 minutes" failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hi, still trying to reduce Travis false negatives...

Suggested yesterday on IRC:
  pm215: this one seems to be that we hit the "10 minutes with no output" limit
  stefanha: f4bug: We could literally have a SIGALRM that wakes up to print out a '.' :-)

Let's try with an easy shell script.

This doesn't solve the 50min TO problem which is a different issue, but seems
to work a bit more stable:

https://travis-ci.org/philmd/qemu/builds/253032034

tagged 'RFC' because it's just a PoC script without comment.

Regards,

Phil.

PD: sorry, resent since I forgot to Cc: qemu-devel@nongnu.org :S

Philippe Mathieu-Daudé (2):
  scripts: helper to keep console alive
  travis: use console aliveness script

 .travis.yml          |  2 +-
 MAINTAINERS          |  1 +
 scripts/aliveness.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100755 scripts/aliveness.sh

-- 
2.13.2
