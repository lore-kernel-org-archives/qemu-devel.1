Received: from eggs.gnu.org ([2001:4830:134:3::10]:59557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diHro-0004Mo-1j
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diHrk-0002el-40
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diHrj-0002e3-To
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:17:28 -0400
Date: Thu, 17 Aug 2017 18:17:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170817101717.GD616@lemon>
References: <20170817024746.5961-1-famz@redhat.com>
	<20170817024746.5961-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817024746.5961-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 04/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

> +        self._args = [ \
> +            "-nodefaults", "-enable-kvm", "-m", "2G",
> +            "-smp", os.environ.get("J", "4"), "-cpu", "host",

Forgot to change "J" to a command argument. Will fix when dropping RFC.

Fam
