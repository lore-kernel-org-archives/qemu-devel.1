Received: from eggs.gnu.org ([2001:4830:134:3::10]:43249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4rx-0000HK-SL
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4rx-0001ne-3C
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:49:37 -0400
Date: Tue, 8 May 2018 11:49:27 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180508154927.GE6722@localhost.localdomain>
References: <20180503225648.13153-1-jsnow@redhat.com>
	<20180503225648.13153-6-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503225648.13153-6-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/5] qemu-img-cmds.hx: add
 passive-aggressive note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-trivial@nongnu.org

On Thu, May 03, 2018 at 06:56:48PM -0400, John Snow wrote:
> I'm kidding. It's very easy to forget there are per-command sections
> in the texi, and insane that we don't autogenerate those, too.
> 
> Until then, leave a little post-it note in this .hx file until I
> find a way to delete it.
>

Hopefully helps, but as you said the real fix is autogeneration.

Reviewed-by: Jeff Cody <jcody@redhat.com>

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-img-cmds.hx | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 84deb858af..3d2f7b26eb 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -6,6 +6,9 @@ HXCOMM DEF(command, callback, arg_string) is used to construct
>  HXCOMM command structures and help message.
>  HXCOMM HXCOMM can be used for comments, discarded from both texi and C
>  
> +HXCOMM When amending the TEXI sections, please remember to copy the usage
> +HXCOMM over to the per-command sections in qemu-img.texi.
> +
>  STEXI
>  @table @option
>  ETEXI
> -- 
> 2.14.3
> 
> 
