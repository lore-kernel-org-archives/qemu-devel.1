Received: from eggs.gnu.org ([2001:4830:134:3::10]:48216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfO2x-0000U0-EI
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfO2w-0002Dj-6I
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:17:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dfO2v-0002Cg-Vp
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:17:02 -0400
Received: by mail-wr0-x243.google.com with SMTP id f38so3131121wrf.4
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 03:17:00 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 9 Aug 2017 11:16:58 +0100
Message-ID: <CAJSP0QVrCm6TfgU0dsXbudaW3gmGo0YQTTWbNypx6st6mKcSKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Making QEMU build with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: ross@burtonini.com

Ross created a bug to track Python 3 support:

  https://bugs.launchpad.net/qemu/+bug/1708462

Currently most Python code in QEMU is for Python 2.6+ only.  There
have only been a few patches adding Python 3 support to certain
scripts so far.

In this email I want to highlight the most important scripts that need
Python 3 support.  Volunteers are welcome!

Python scripts needed to build QEMU are the highest priority.  They
are invoked by ./configure or make.  I've identified the following:

scripts/signrom.py
scripts/qapi*.py
scripts/modules/module_block.py
scripts/tracetool*

Anyone wishing to tackle a script listed here, please reply to this
email thread to avoid duplicating work.

The fundamentals of adding Python 3 support are:

1. The script must work correctly under both Python 2.6+ and Python 3.
Only use language or standard library features that are available in
both Python versions.
2. Compare Python 2.6 vs Python 3 documentation to find a common
subset.  There is often a Pythonic solution that does not require
writing explicit wrappers.
3. Avoid third-party package dependencies - QEMU currently has none!
That means do not use 'six' or 'python-future'.  Our use of Python
isn't that fancy, but if you feel a third party package is essential
the please justify it.
4. If you decide to do PEP8 cleanups, make them separate patches so
review is easy.

Getting started info (but do not rely on 'python-future'):
http://www.python-future.org/compatible_idioms.html

Once the build scripts are converted the next most important group of
Python scripts are the tests.  This is where the bulk of the work
lies.

I have tracetool on my todo list and hope to add Python 3 support in QEMU 2.11.

Stefan
