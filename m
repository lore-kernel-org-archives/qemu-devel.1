Received: from eggs.gnu.org ([2001:4830:134:3::10]:40713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4LV-0002TS-Rp
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4LU-0002Pi-Ut
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:07:57 -0400
References: <20180727141539.506-1-kwolf@redhat.com>
	<20180727141539.506-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7721290c-94f0-d203-10c0-8aa586c54600@redhat.com>
Date: Fri, 27 Jul 2018 10:07:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180727141539.506-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/3] block/qapi: Add 'qdev' field
 to query-blockstats result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

On 07/27/2018 09:15 AM, Kevin Wolf wrote:
> Like for query-block, the client needs to identify which BlockBackend
> the returned data is for. Anonymous BlockBackends are identified by the
> device model they are attached to. Add a 'qdev' field that contains the
> qdev ID or QOM path of the attached device model.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> @@ -879,7 +882,7 @@
>   # Since: 0.14.0
>   ##
>   { 'struct': 'BlockStats',
> -  'data': {'*device': 'str', '*node-name': 'str',
> +  'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
>              'stats': 'BlockDeviceStats',
>              '*parent': 'BlockStats',
>              '*backing': 'BlockStats'} }

Can we also update the example under query-blockstats a few lines later 
to show the added field?

At any rate, it looks helpful. Although this is borderline new feature, 
it resolves a need identified in libvirt using -blockdev, and so I can 
live with it as a 3.0 bugfix.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
