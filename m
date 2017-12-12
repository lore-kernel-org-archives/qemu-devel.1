Received: from eggs.gnu.org ([2001:4830:134:3::10]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOoba-0008Nq-AG
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOobX-0003YS-2d
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:44:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOobW-0003Y8-Sj
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:44:31 -0500
Date: Tue, 12 Dec 2017 17:44:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171212174416.GJ2409@work-vm>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-14-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 13/26] qmp: introduce some capability
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> Introduce qmp_cap_enabled() and qmp_oob_enabled() helpers.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index 097312e65f..9666115259 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1038,6 +1038,16 @@ static void monitor_init_qmp_commands(void)
>                           qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
>  }
>  
> +static bool qmp_cap_enabled(Monitor *mon, QMPCapability cap)
> +{
> +    return mon->qmp.qmp_caps[cap];
> +}
> +
> +static bool qmp_oob_enabled(Monitor *mon)
> +{
> +    return qmp_cap_enabled(mon, QMP_CAPABILITY_OOB);
> +}
> +
>  static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
>                             Error **errp)
>  {
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
