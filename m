Received: from eggs.gnu.org ([2001:4830:134:3::10]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftEqc-0001lL-Fv
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftEqY-0001CJ-70
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:22:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ftEqX-0001A2-A9
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:22:01 -0400
References: <20180824135312.1606-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f5e48b3-4fa1-1ff4-0775-1d36604cad3f@redhat.com>
Date: Fri, 24 Aug 2018 11:21:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180824135312.1606-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] slirp: Implement RFC2132 TFTP server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, brad@comstyle.com

On 08/24/2018 08:53 AM, Fam Zheng wrote:
> This new usernet option can be used to add data for option 66 (tftp
> server name) in the BOOTP reply, which is useful in PXE based automatic
> OS install such as OpenBSD.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---

> +++ b/qapi/net.json
> @@ -174,6 +174,8 @@
>   #
>   # @guestfwd: forward guest TCP connections
>   #
> +# @tftp-server-name: (optional) RFC2132 "TFTP server name" string (Since 3.1)

The doc generator automatically marks up optional members these days, so 
you can drop '(optional)' from this line.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
