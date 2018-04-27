Received: from eggs.gnu.org ([2001:4830:134:3::10]:44232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6480abf97=anthony.perard@citrix.com>)
	id 1fC4Rb-0004ur-MK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6480abf97=anthony.perard@citrix.com>)
	id 1fC4RX-0000UV-Ot
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:33:51 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:53257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=6480abf97=anthony.perard@citrix.com>)
	id 1fC4RX-0000Tw-G2
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:33:47 -0400
Date: Fri, 27 Apr 2018 15:33:42 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180427143342.GA15594@perard>
References: <20180426135755.GI29865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180426135755.GI29865@localhost.localdomain>
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Apr 26, 2018 at 10:57:55AM -0300, Eduardo Habkost wrote:
> So, for anybody that runs automated QEMU tests once in a while,
> can we know:
> 
> * What test cases are you running?  Where can we get more
>   information about the tests you run?
> * When do you run them?  What triggers a new test run?

FYI, we do test QEMU with Xen. But that mostly integration test. I guess
not much of QEMU is tested.

osstest run with the upstream QEMU tree about once a day, if the tree as
changed or if the last test run failed. The test result is sent to
xen-devel ml.

As for what is runned, it mostly starts Xen guests, do migrate, with
different configuration.

Regards,

-- 
Anthony PERARD
