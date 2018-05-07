Received: from eggs.gnu.org ([2001:4830:134:3::10]:60656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFjFN-0006yv-5g
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFjFI-00052J-Fz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:44:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fFjFI-00051p-Bz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:44:16 -0400
References: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
	<7e9e9dfd-795b-47f2-453a-59bf65f28229@redhat.com>
	<7274b001-02f2-6584-ea0a-c3d0f96d46b8@linux.ibm.com>
	<89dc884d-97af-4922-bd69-1cb7308399d8@redhat.com>
	<724592be-f5ac-7a40-8c26-5d2dd200ef82@linux.ibm.com>
	<ee680f5e-ac9a-479d-f65e-9f8ae9cfe5d4@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d37855b8-1dcd-04fe-fe80-3dcd609bded4@redhat.com>
Date: Mon, 7 May 2018 11:44:09 -0500
MIME-Version: 1.0
In-Reply-To: <ee680f5e-ac9a-479d-f65e-9f8ae9cfe5d4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] monitor: report entirety of hmp command
 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org

On 05/07/2018 09:30 AM, Collin Walling wrote:
> When a user incorrectly provides an hmp command, an error response will be
> printed that prompts the user to try "help <command name>". However, when
> the command contains multiple parts e.g. "info uuid xyz", only the last
> whitespace delimited string will be reported (in this example "info" will
> be dropped and the message will read "Try "help uuid" for more information",
> which is incorrect).
> 
> Let's correct this by capturing the entirety of the command from the command
> line -- excluding any extraneous characters.
> 

It's better to post a v2 patch as a new top-level thread instead of 
in-reply to an earlier version, as some of our automated tooling is more 
likely to see it.

> Reported-by: Mikhail Fokin <fokin@de.ibm.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   monitor.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
