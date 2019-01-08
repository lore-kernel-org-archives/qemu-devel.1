Received: from eggs.gnu.org ([209.51.188.92]:37152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggwhx-0001EM-Le
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggwhw-0001M6-FA
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:06:37 -0500
Date: Tue, 8 Jan 2019 20:06:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108190624.GM11492@linux.fritz.box>
References: <20181213175154.5242-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213175154.5242-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Replace qdict_put() by
 qdict_put_obj() where appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, ari@tuxera.com, mreitz@redhat.com, qemu-block@nongnu.org

Am 13.12.2018 um 18:51 hat Markus Armbruster geschrieben:
> Patch created mechanically by rerunning:
> 
>   $  spatch --sp-file scripts/coccinelle/qobject.cocci \
> 	    --macro-file scripts/cocci-macro-file.h \
> 	    --dir block --in-place
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks, applied to the block branch.

Kevin
