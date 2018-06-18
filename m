Received: from eggs.gnu.org ([2001:4830:134:3::10]:36724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV1oV-0000YH-Ly
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV1oR-0005B8-Lc
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:35:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fV1oR-0005B1-Fy
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:35:47 -0400
Date: Mon, 18 Jun 2018 18:35:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180618213545.GK24764@localhost.localdomain>
References: <20180618175958.29073-1-armbru@redhat.com>
	<20180618175958.29073-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618175958.29073-3-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] Revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, tamiko@43-1.org, arfrever.fta@gmail.com

On Mon, Jun 18, 2018 at 07:59:58PM +0200, Markus Armbruster wrote:
> From: Matthias Maier <tamiko@43-1.org>
> 
> This commit removes the PYTHON_UTF8 workaround. The problem with setting
> 
>   LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8
> 
> is that the en_US.UTF-8 locale might not be available. In this case
> setting above locales results in build errors even though another UTF-8
> locale was originally set [1]. The only stable way of fixing the
> encoding problem is by explicitly annotating encoding/decoding in the
> python script.
> 
> [1] https://bugs.gentoo.org/657766
> 
> Signed-off-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
> Signed-off-by: Matthias Maier <tamiko@43-1.org>
> Message-Id: <20180615220205.6929-3-tamiko@43-1.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
