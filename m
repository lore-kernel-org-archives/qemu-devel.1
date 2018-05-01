Received: from eggs.gnu.org ([2001:4830:134:3::10]:37245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fDc5O-0005lY-Fc
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fDc5K-0003nE-Cj
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:41:18 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:47944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fDc5K-0003kM-6H
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:41:14 -0400
Date: Tue, 1 May 2018 22:41:11 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180501204110.t2suo47pgiktopsa@var.youpi.perso.aquilenet.fr>
References: <20180316062822.15425-1-famz@redhat.com>
	<20180316062822.15425-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316062822.15425-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13 v3 1/2] slirp: Add "query-usernet"
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Hello,

I'm sorry I didn't find the time to have a look at it before.

In general it looks good, just a few things:

Samuel

Fam Zheng, le ven. 16 mars 2018 14:28:21 +0800, a ecrit:
> +        if (!net_hub_id_for_client(&s->nc, &vlan)) {

That makes me think that IIUC, we shouldn't call them vlan, as mentioned
in the recent vlan->hub renaming patches.

> +{ 'struct': 'UsernetInfo',
> +  'data': {
> +    'id':              'str',
> +    'vlan':            'int',

and here as well, I guess.

> +void slirp_connection_info(Slirp *slirp, Monitor *mon)
> +{
> +    const char *state;
> +    char buf[64];
> +    UsernetInfo info = { };
> +    UsernetConnectionList *cl;
> +
> +    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Port   "
> +                        "Dest. Address  Port RecvQ SendQ\n");
> +
> +    usernet_get_info(slirp, &info);

Mmm, I don't see the content of info being freed here?

Samuel
