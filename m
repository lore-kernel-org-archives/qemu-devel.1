Received: from eggs.gnu.org ([2001:4830:134:3::10]:51571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDxdN-0006Ek-N0
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDxdK-0000kz-JD
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:41:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fDxdK-0000kF-C5
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:41:46 -0400
References: <20180502073034.15141-1-famz@redhat.com>
	<20180502073034.15141-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60f2d927-9846-7da2-7067-62f0167a2b58@redhat.com>
Date: Wed, 2 May 2018 14:41:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180502073034.15141-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] slirp: Add "query-usernet" QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/02/2018 02:30 AM, Fam Zheng wrote:
> HMP "info usernet" has been available but it isn't ideal for programmed
> use cases. This closes the gap in QMP by adding a counterpart
> "query-usernet" command. It is basically translated from
> the HMP slirp_connection_info() loop, which now calls the QMP
> implementation and prints the data, just like other HMP info_* commands.
> 
> The TCPS_* macros are now defined as a QAPI enum.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---

> +##
> +# @UsernetInfo:
> +#
> +# SLIRP usernet information.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'UsernetInfo',
> +  'data': {
> +    'id':              'str',
> +    'hub':             'int',
> +    'connections':     ['UsernetConnection']
> +} }
> +
> +##
> +# @query-usernet:
> +#
> +# Return SLIRP network information.
> +#
> +# Since: 2.13
> +#
> +# Example:
> +#
> +# -> { "execute": "query-usernet", "arguments": { } }
> +# <- { "return": [
> +#         {
> +#             "promiscuous": true,
> +#             "name": "vnet0"

That example looks wrong; I'm expecting 'id', 'hub', and another array 
'connections'.

> +#         }
> +#       ]
> +#    }
> +#
> +##
> +{ 'command': 'query-usernet',
> +  'returns': ['UsernetInfo'] }

Other than the botched example, the qapi additions look okay to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
