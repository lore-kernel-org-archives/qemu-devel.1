Received: from eggs.gnu.org ([2001:4830:134:3::10]:33486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbyg-0006kh-HF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbyd-0001NN-F9
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:49:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbyd-0001N6-9D
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:49:23 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A772C04BD32
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:49:23 +0000 (UTC)
Received: from localhost (ovpn-116-33.gru2.redhat.com [10.97.116.33])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1MInM8i032299
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:49:22 -0500
Date: Wed, 22 Feb 2017 15:49:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170222184920.GE28403@thinpad.lan.raisama.net>
References: <20170116211124.29245-1-ehabkost@redhat.com>
	<20170116211124.29245-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170116211124.29245-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qapi-schema: Comment about full
 expansion of non-migration-safe models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Mon, Jan 16, 2017 at 07:11:22PM -0200, Eduardo Habkost wrote:
> Add a note warning that static expansion may not be 100% accurate
> when the CPU model is not migration-safe. This will be the case
> on x86 when expansing the "host" CPU model, because there are
> "host" features that can't have a migration-safe representation
> (e.g. "host-cache-info").
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to x86-next.

> ---
>  qapi-schema.json | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index ce20f16757..33d7ef1274 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3294,6 +3294,15 @@
>  #        migration-safe, but allows tooling to get an insight and work with
>  #        model details.
>  #
> +# Note: When a non-migration-safe CPU model is expanded in static mode, some
> +# features enabled by the CPU model may be omitted, because they can't be
> +# implemented by a static CPU model definition (e.g. cache info passthrough and
> +# PMU passthrough in x86). If you need an accurate representation of the
> +# features enabled by a non-migration-safe CPU model, use @full. If you need a
> +# static representation that will keep ABI compatibility even when changing QEMU
> +# version or machine-type, use @static (but keep in mind that some features may
> +# be omitted).
> +#
>  # Since: 2.8.0
>  ##
>  { 'enum': 'CpuModelExpansionType',
> -- 
> 2.11.0.259.g40922b1
> 
> 

-- 
Eduardo
