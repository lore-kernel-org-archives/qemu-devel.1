Received: from eggs.gnu.org ([209.51.188.92]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkMu-0004sY-FI
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkLi-0002b2-Hm
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:45:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzkLi-0002Xr-Ae
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:45:22 -0500
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af1fb55b-cb3d-f3d4-2edc-7ce23c54ed36@redhat.com>
Date: Fri, 1 Mar 2019 09:45:18 -0600
MIME-Version: 1.0
In-Reply-To: <20190301154051.23317-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] tests/qapi-schema: Make test-qapi.py
 print arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, quintela@redhat.com

On 3/1/19 9:40 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Sparse on the why, but I can guess - you intend for the rest of the
series to fix the bug where we don't generate arrays in the same module
as their underlying type when their only use is in a different module,
but to prove that works you need them listed in dump output.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
