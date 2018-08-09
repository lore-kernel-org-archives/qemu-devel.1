Received: from eggs.gnu.org ([2001:4830:134:3::10]:36249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlXT-0004GB-HL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlXP-0003zp-GA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:03:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnlXP-0003zc-B6
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:03:39 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <536be1d2-05ed-44f8-405c-5a821bee6d82@redhat.com>
Date: Thu, 9 Aug 2018 09:03:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/56] check-qjson: Cover escaped
 characters more thoroughly, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> Cover surrogates, invalid escapes, and noncharacters.  This
> demonstrates that valid surrogate pairs are misinterpreted, and
> invalid surrogates and noncharacters aren't rejected.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 53 ++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 45 insertions(+), 8 deletions(-)
> 

> +        { "\\u12x", NULL },
> +        { "\\u123x", NULL },
> +        { "\\u12345", "\341\210\2645" },
> +        { "\\u12345", "\341\210\2645" },

Why is this one duplicated?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
