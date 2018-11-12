Received: from eggs.gnu.org ([2001:4830:134:3::10]:42876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMF0C-00012P-S6
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMF06-0001pd-UA
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:23:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMF06-0001km-HW
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:23:46 -0500
Date: Mon, 12 Nov 2018 14:23:37 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181112162337.GK12503@habkost.net>
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-4-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109150710.31085-4-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] Travis CI: make specified Python
 versions usable on jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Fri, Nov 09, 2018 at 10:07:09AM -0500, Cleber Rosa wrote:
> For the two Python jobs, which seem to have the goal of making sure
> QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions,
> the specified version is only applicable if a Python virtual
> environment is used.  To do that, it's necessary to define the
> (primary?) language of the job to be Python.
> 
> Also, Travis doesn't have a 3.0 Python installation available for the
> chosen distro, 3.2 being the lower version available.
> 
> Reference: https://docs.travis-ci.com/user/languages/python/#specifying-python-versions
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

This doesn't depend on patches 1 and 2, right?

The rest of the series will wait for the next release, but this
looks like something we want to merge before QEMU 3.1.

-- 
Eduardo
