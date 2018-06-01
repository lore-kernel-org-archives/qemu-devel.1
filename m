Received: from eggs.gnu.org ([2001:4830:134:3::10]:60918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOmUV-0003nJ-2w
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOmUQ-0008HW-UG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:01:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOmUQ-0008H4-Pv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:01:18 -0400
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e31963b7-b5c2-2cd4-92e6-7fc0ddbb881f@redhat.com>
Date: Fri, 1 Jun 2018 11:01:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 06/01/2018 10:39 AM, Ricardo Perez Blanco wrote:
> For debugging purposes it is very useful to:
>   - See the description of the field. This information is already filled
>     in but not shown in "qom-list" command.
>   - Display value of the field.
> 
> Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> ---

> +++ b/qapi/misc.json
> @@ -1328,10 +1328,12 @@
>   #
>   # @description: if specified, the description of the property.
>   #
> -# Since: 1.2
> +# @value: if specified, the value of the property.
> +#
> +# Since: 2.13

Not quite. The struct was first introduced in 1.2, and only 'value' was 
added in 3.0 (since we've renamed 2.13 into 3.0).  It should look like:

# @value: if specified, the value of the property (since 3.0)
#
# Since: 1.2

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
