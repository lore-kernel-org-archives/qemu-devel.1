Received: from eggs.gnu.org ([2001:4830:134:3::10]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flXak-0005z4-2a
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flXag-0005Ex-N7
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:45:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1flXag-0005ET-HV
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:45:50 -0400
Date: Fri, 3 Aug 2018 18:45:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180803104546.GA21719@lemon.usersys.redhat.com>
References: <20180803085230.30574-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803085230.30574-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/vm: various minor improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, patches@linaro.org

On Fri, 08/03 09:52, Peter Maydell wrote:
> The setup I had for my BSD VMs broke today, so I thought I'd
> have a look at using the tests/vm/ support for building QEMU
> inside BSD VMs rather than re-rolling my own. This patchset
> fixes some rough edges I ran into along the way:
>  * fixes support for non-KVM accelerators
>  * propagates J=n setting into 'make check' in the VM
>  * propagates V=1 setting into 'make' and 'make check' in the VM
>  * uses --output-sync so that J=n settings don't mangle output
>  * bumps the RAM settings so J=n doesn't cause the guest to
>    run out of memory and kill the compiler

Queued for 3.1. Thanks!

Fam
