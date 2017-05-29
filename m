Received: from eggs.gnu.org ([2001:4830:134:3::10]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFNvX-0003pi-Q9
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFNvT-0007Pf-Rz
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFNvT-0007OK-Lg
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 850314E4D0
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 16:53:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170526181200.17227-1-ehabkost@redhat.com>
	<20170526181200.17227-3-ehabkost@redhat.com>
Date: Mon, 29 May 2017 18:53:47 +0200
In-Reply-To: <20170526181200.17227-3-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Fri, 26 May 2017 15:11:59 -0300")
Message-ID: <874lw3zjs4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qemu.py: Add QEMUMachine.exitcode()
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Allow the exit code of QEMU to be queried by scripts.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 16934f1e02..ebe1c4b919 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -88,6 +88,10 @@ class QEMUMachine(object):
>      def is_running(self):
>          return self._popen and (self._popen.returncode is None)
>  
> +    def exitcode(self):
> +        if self._popen:
> +            return self._popen.returncode
> +

Falling off the function's end returns None.  Do we really want to rely
on that?

For what it's worth, I checked the Python Language Reference, found it
less than clear, so I tried it out, too.

>      def get_pid(self):
>          if not self.is_running():
>              return None
