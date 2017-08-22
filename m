Received: from eggs.gnu.org ([2001:4830:134:3::10]:42350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkABg-0004nz-8N
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkABb-0001EM-Od
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:29:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dkABb-0001Du-JI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:29:43 -0400
Date: Tue, 22 Aug 2017 22:29:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170822142937.GH3210@lemon>
References: <20170822044155.2451-1-famz@redhat.com>
	<40d04f21-011e-1736-ed62-1d205926d60a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d04f21-011e-1736-ed62-1d205926d60a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 08/22 15:58, Paolo Bonzini wrote:
> On 22/08/2017 06:41, Fam Zheng wrote:
> > as it is not easy to automate. (The ideal approach is like the ubuntu.i386
> > script, which configures the guest on top of an official released image, fully
> > automatically.)
> 
> Out of curiosity, why can't the 32-bit test use containers instead?

It can.

This one is here just because what are distributed by hub.docker.com are x86_64
environments. Of course it's possible to do 32-bit builds with them, the i386
image just provides a bit more authenticity. I'm not counting on it to catch
more bugs than the mingw 32bit cross-build, but this makes a good example of
using basevm.py.

Fam
