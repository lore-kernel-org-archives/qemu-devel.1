Received: from eggs.gnu.org ([2001:4830:134:3::10]:57185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9ID-0004Uh-96
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9IA-0002Dn-3l
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:25:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo9I9-0002Ce-Vi
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:25:30 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-23-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14b86d58-b157-374c-5ed1-3feec05aa364@redhat.com>
Date: Fri, 10 Aug 2018 10:25:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/56] json: Report first rather than last
 parse error
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

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Quiz time!  When a parser reports multiple errors, but the user gets
> to see just one, which one is (on average) the least useful one?

:)

> 
> Reproducer: feeding
> 
>      {"abc\xC2ijk": 1}\n
> 
> to QMP produces
> 
>      {"error": {"class": "GenericError", "desc": "JSON parse error, key is not a string in object"}}
> 
> Report the first error instead.  The reproducer now produces
> 
>      {"error": {"class": "GenericError", "desc": "JSON parse error, invalid UTF-8 sequence in string"}}

Yes, definite improvement.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
