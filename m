Received: from eggs.gnu.org ([2001:4830:134:3::10]:44833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9cGR-0001rF-O3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9cGO-0006vF-La
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9cGO-0006sE-Ea
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:04:08 -0400
Date: Fri, 20 Apr 2018 17:03:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180420200353.GH29865@localhost.localdomain>
References: <20180420181951.7252-1-ehabkost@redhat.com>
	<20180420181951.7252-21-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420181951.7252-21-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 20/24] avocado_qemu: Set QMP log level to INFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Apr 20, 2018 at 03:19:47PM -0300, Eduardo Habkost wrote:
> From: Amador Pahim <apahim@redhat.com>
> 
> Otherwise we will see the debug messages in our test logs.

Why don't we want to see the QMP debug messages when debugging is
enabled?

> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/avocado/avocado_qemu/test.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
> index b921151bae..308fdfa514 100644
> --- a/tests/avocado/avocado_qemu/test.py
> +++ b/tests/avocado/avocado_qemu/test.py
> @@ -235,6 +235,7 @@ class _VM(qemu.QEMUMachine):
>          self.username = username
>          self.password = password
>          super(_VM, self).__init__(qemu_bin, name=self.name, arch=arch)
> +        logging.getLogger('QMP').setLevel(logging.INFO)
>  
>      def get_console(self, console_address=None, prompt=r"[\#\$] "):
>          """
> -- 
> 2.14.3
> 

-- 
Eduardo
