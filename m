Received: from eggs.gnu.org ([209.51.188.92]:58129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgCV-0000BK-Tf
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgCU-00062y-Uk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:29:43 -0500
Date: Mon, 21 Jan 2019 18:29:16 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121202915.GJ17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-12-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-12-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/18] scripts/qemu.py: support adding a
 console with the default serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Thu, Jan 17, 2019 at 01:56:21PM -0500, Cleber Rosa wrote:
> The set_console() utility function traditionally adds a device either
> based on the explicitly given device type, or based on the machine type,
> a known good type of device.
> 
> But, for a number of machine types, it may be impossible or
> inconvenient to add the devices my means of "-device" command line
> options, and then it may better to just use the "-serial" option and
> let QEMU itself, based on the machine type, set the device
> accordingly.
> 
> To achieve that, the behavior of set_console() now flags the intention
> to add a console device on launch(), and if no explicit device type is
> given, and there's no definition on CONSOLE_DEV_TYPES, the "-serial"
> is going to be added to the QEMU command line, instead of raising
> exceptions.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  scripts/qemu.py | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
{...}
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
