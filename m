Received: from eggs.gnu.org ([2001:4830:134:3::10]:37304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywX-0008Ng-Ki
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywV-0001v6-8P
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:01 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywV-0001uc-1O
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:06:59 -0400
Received: by mail-wm0-x243.google.com with SMTP id l1-v6so47011275wmb.2
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:06:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:47 +0100
Message-Id: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/8] Travis stability and a few docker
 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Again the final patch won't make it into a pull-request but I'm just
keeping it around to keep track of failures. So far my numerous
re-builds have been mainly plain timeouts.

The alternate co-routine builds are sailing the closest to timeout
purgatory which makes me think we should limit the scope of the
testing - I'm not sure how much of the unit tests or qapi tests are
likely to exercise the co-routine code. Is it likely only the
(currently not run) block tests really exercise this area of code?

I've also updated the Travis image to be more recent. I noticed while
doing so that the Travis clang was newer than our hand crafted tools
so I took the opportunity to drop them and just concentrate on
exercising the python stuff. It might be worth just limiting the
target list for those tests to x86_64 only though?

There are also a couple of Philippe's patches which I should have
queued ages ago. If we get some quick reviews I can turn around a pull
request by the end of the week.

Alex Bennée (6):
  .travis.yml: disable linux-user build for gcov
  docker: update Travis docker image
  .travis.yml: rationalise clang testing
  .travis.yml: make current setup explicit
  .travis.yml: update GCC sanitizer build to GCC 7
  tests/Makefile: mark flakey tests (!UPSTREAM)

Philippe Mathieu-Daudé (2):
  docker: sort images list displayed by 'make docker'
  docker: do not display deprecated images in 'make docker' help

 .travis.yml                            | 82 +++++---------------------
 tests/Makefile.include                 |  4 ++
 tests/docker/Makefile.include          |  5 +-
 tests/docker/dockerfiles/travis.docker |  7 ++-
 4 files changed, 28 insertions(+), 70 deletions(-)

-- 
2.17.0
