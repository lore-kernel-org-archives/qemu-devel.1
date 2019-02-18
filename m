Received: from eggs.gnu.org ([209.51.188.92]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gvngC-0005AM-CT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gvngA-0006zr-M6
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:30:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gvngA-0006eg-DB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:30:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B43078EBE
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 18:24:22 +0000 (UTC)
Date: Mon, 18 Feb 2019 15:24:10 -0300
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190218182409.GA2424@localhost.localdomain>
References: <20190218173723.26120-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218173723.26120-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: drop usage of ":avocado:
 enable"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

Hi, Cleber.

On Mon, Feb 18, 2019 at 12:37:23PM -0500, Cleber Rosa wrote:
> The Avocado test runner attemps to find its INSTRUMENTED (that is,
> Python based tests) in a manner that is as safe as possible to the
> user.  Different from plain Python unittest, it won't load or
> execute test code on an operation such as:
> 
>  $ avocado list tests/acceptance/
> 
> Before version 68.0, the logic implemented to identify INSTRUMENTED
> tests would require either the ":avocado: enable" or ":avocado:
> recursive" statement as a flag for tests that would not inherit
> directly from "avocado.Test".  This is not necessary anymore,
> and because of that the boiler plate statements can now be removed.
> 
> Reference: https://avocado-framework.readthedocs.io/en/68.0/release_notes/68_0.html#users-test-writers
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  docs/devel/testing.rst                 | 1 -
>  tests/acceptance/boot_linux_console.py | 1 -
>  tests/acceptance/linux_initrd.py       | 1 -
>  tests/acceptance/version.py            | 1 -
>  tests/acceptance/virtio_version.py     | 1 -
>  tests/acceptance/vnc.py                | 1 -
>  tests/requirements.txt                 | 2 +-
>  7 files changed, 1 insertion(+), 7 deletions(-)
> 
{...}
> 2.20.1
> 

Thanks,
-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
