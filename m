Received: from eggs.gnu.org ([2001:4830:134:3::10]:54606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejiWY-0003mU-Q4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejiWV-0002m2-IW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:29:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ejiWV-0002l4-FM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:29:43 -0500
Date: Thu, 8 Feb 2018 09:29:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180208092928.GN20703@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-3-lcapitulino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207175014.11157-3-lcapitulino@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qmp: document query-cpus performance
 issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, ehabkost@redhat.com, mihajlov@linux.vnet.ibm.com

On Wed, Feb 07, 2018 at 12:50:14PM -0500, Luiz Capitulino wrote:
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  qapi-schema.json | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 82d6f12b53..0665a14dba 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -526,6 +526,10 @@
>  #
>  # Returns a list of information about each virtual CPU.
>  #
> +# WARNING: This command incurs a performance penalty for latency
> +#          sensitive workloads and hence it's not recommended to
> +#          to be used in production. Use query-cpus-fast instead

I suggest being more explicit about exactly what the problem is, so people
understand implications if they choose to still use it. ie

  This command causes vCPU threads to exit to userspace, which causes
  an small interruption guest CPU execution. This will have a negative
  impact on realtime guests and other latency sensitive guest workloads.
  It is recommended to use query-cpus-fast instead of this command to
  avoid the vCPU interruption.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
