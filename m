Received: from eggs.gnu.org ([209.51.188.92]:60614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grPO0-0004XT-7I
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grPNu-0003aE-KM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:45:16 -0500
Date: Wed, 6 Feb 2019 16:44:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190206164452.288a30ff.cohuck@redhat.com>
In-Reply-To: <20190202005610.24048-20-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-20-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/20] Boot Linux Console Test: add a
 test for s390x + s390-ccw-virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

On Fri,  1 Feb 2019 19:56:09 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> Just like the previous tests, boots a Linux kernel on a s390x target
> using the s390-ccw-virtio machine.
> 
> Because it's not possible to have multiple VT220 consoles,
> '-nodefaults' is used, so that the one set with set_console() works
> correctly.
> 
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
