Received: from eggs.gnu.org ([2001:4830:134:3::10]:54727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezltW-000809-Ux
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 12:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezljN-0005tq-HB
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 12:10:27 -0400
References: <6f10cd53d361a395aa0e85a9311ec4e9a8fc11e5.1521868451.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be650180-7aaf-8a7a-6601-92fce6ca2a95@redhat.com>
Date: Sat, 24 Mar 2018 06:44:28 -0500
MIME-Version: 1.0
In-Reply-To: <6f10cd53d361a395aa0e85a9311ec4e9a8fc11e5.1521868451.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-pr-helper: Actually allow users to
 specify pidfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 03/24/2018 12:14 AM, Michal Privoznik wrote:
> Due to wrong specification of arguments to getopt_long() any
> attempt to set pidfile resulted in:
> 
> 1) the default to be leaked
> 2) the @pidfile variable to be set to NULL (because optarg is
> NULL without this patch).

Broken in introduction with commit b855f8d, in 2.11.

> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

CC: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
