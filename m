Received: from eggs.gnu.org ([2001:4830:134:3::10]:32905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1du7zk-0004CB-0p
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1du7ze-0004p6-Gb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1du7ze-0004ob-9m
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:10:34 -0400
Date: Tue, 19 Sep 2017 10:10:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170919021028.GB11534@lemon.lan>
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-5-famz@redhat.com>
	<234e0e32-0f16-c621-6062-a2ee140efdf6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234e0e32-0f16-c621-6062-a2ee140efdf6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 04/13] tests: Add a test key pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

On Mon, 09/18 10:17, Eric Blake wrote:
> On 09/17/2017 09:43 PM, Fam Zheng wrote:
> > This will be used by setup test user ssh.
> 
> Shouldn't the commit message have more details about WHY we are checking
> in a private key? The conversation last time included useful gems such as:
> 
> Some guests require the key to exist prior to provisioning the guest,
> and reusing a pre-built key avoids consuming entropy every time the
> testsuite is run.  Because the private key is well-known, care must be
> taken to use the key ONLY in situations that cannot be compromised by
> external network clients.

Yeah. Not everyone looks at the commit message, I'll add a tests/keys/README to
document that.

Fam
