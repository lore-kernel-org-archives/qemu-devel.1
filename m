Received: from eggs.gnu.org ([2001:4830:134:3::10]:40868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecac4-0007jL-Cy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecac1-0006rl-7S
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:38:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecac1-0006rS-10
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:37:57 -0500
Date: Fri, 19 Jan 2018 15:37:42 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119173742.GG15832@localhost.localdomain>
References: <20171114102246.22221-1-apahim@redhat.com>
	<20171114102246.22221-7-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114102246.22221-7-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 6/8] qemu.py: cleanup redundant calls
 in launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, crosa@redhat.com, muriloo@linux.vnet.ibm.com

On Tue, Nov 14, 2017 at 11:22:44AM +0100, Amador Pahim wrote:
> Now that shutdown() is guaranteed to always execute self._load_io_log()
> and self._post_shutdown(), their calls in 'except' became redundant and
> we can safely replace it by a call to shutdown().
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  scripts/qemu.py | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index d3824a7a0b..305d7bd098 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -212,11 +212,7 @@ class QEMUMachine(object):
>          try:
>              self._launch()
>          except:
> -            if self.is_running():
> -                self._popen.kill()
> -                self._popen.wait()
> -            self._load_io_log()
> -            self._post_shutdown()
> +            self.shutdown()
>  
>              LOG.debug('Error launching VM')
>              if self._qemu_full_args:
> -- 
> 2.13.6
> 
> 

-- 
Eduardo
