Received: from eggs.gnu.org ([209.51.188.92]:59237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gvogv-0002Dc-93
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gvogt-0003ct-7H
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:35:01 -0500
Date: Mon, 18 Feb 2019 16:34:28 -0300
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190218193427.GB4582@localhost.localdomain>
References: <20190206162901.19082-1-crosa@redhat.com>
	<20190206162901.19082-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206162901.19082-2-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] Introduce a Python module structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, Feb 06, 2019 at 11:29:01AM -0500, Cleber Rosa wrote:
> This is a simple move of Python code that wraps common QEMU
> functionality, and are used by a number of different tests
> and scripts.
> 
> By treating that code as a real Python module, we can more easily:
>  * reuse code
>  * have a proper place for the module's own unittests
>  * apply a more consistent style
>  * generate documentation
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  configure                                  |  1 +
>  scripts/qemu.py => python/qemu/__init__.py | 11 ++++++-----
>  {scripts/qmp => python/qemu}/qmp.py        |  0
>  {scripts => python/qemu}/qtest.py          |  5 +++--
>  scripts/device-crash-test                  |  2 ++
>  scripts/qmp/__init__.py                    |  0
>  scripts/qmp/qemu-ga-client                 |  5 ++++-
>  scripts/qmp/qmp-shell                      |  4 +++-
>  scripts/render_block_graph.py              |  2 ++
>  tests/acceptance/avocado_qemu/__init__.py  |  5 ++---
>  tests/acceptance/virtio_version.py         |  2 +-
>  tests/migration/guestperf/engine.py        |  7 ++++---
>  tests/qemu-iotests/235                     |  2 +-
>  tests/qemu-iotests/238                     |  2 +-
>  tests/qemu-iotests/iotests.py              |  4 ++--
>  tests/vm/basevm.py                         |  2 +-
>  16 files changed, 33 insertions(+), 21 deletions(-)
>  rename scripts/qemu.py => python/qemu/__init__.py (98%)
>  rename {scripts/qmp => python/qemu}/qmp.py (100%)
>  rename {scripts => python/qemu}/qtest.py (98%)
>  delete mode 100644 scripts/qmp/__init__.py
> 
{...}
> 

Thanks,
-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
