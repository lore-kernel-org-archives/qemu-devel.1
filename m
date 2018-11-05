Received: from eggs.gnu.org ([2001:4830:134:3::10]:59622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJo2i-0001bz-T6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJnpt-0002sS-Dz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 17:59:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJnpt-0002rW-7C
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 17:59:09 -0500
References: <20181102002818.8568-1-viktor.prutyanov@phystech.edu>
	<20181102002818.8568-2-viktor.prutyanov@phystech.edu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebabe634-5357-dc6c-681e-cee9dba85263@redhat.com>
Date: Mon, 5 Nov 2018 16:58:55 -0600
MIME-Version: 1.0
In-Reply-To: <20181102002818.8568-2-viktor.prutyanov@phystech.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] contrib/elf2dmp: use GLib file mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: qemu-devel@nongnu.org

On 11/1/18 7:28 PM, Viktor Prutyanov wrote:
> Replace POSIX mmap with GLib g_mapped_file_new to make elf2dmp
> cross-paltform. After this patch there are no direct POSIX calls.

s/paltform/platform/

> 
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> ---
>   Makefile                      |  2 +-


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
