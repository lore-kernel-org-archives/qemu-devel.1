Received: from eggs.gnu.org ([2001:4830:134:3::10]:36532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCrDJ-0002vl-DU
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCrDI-0002G1-IT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:10:37 -0400
References: <20181017164200.22344-1-kwolf@redhat.com>
	<20181017164200.22344-10-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98977898-2cec-725b-8aa0-80c25e6583ce@redhat.com>
Date: Wed, 17 Oct 2018 14:10:22 -0500
MIME-Version: 1.0
In-Reply-To: <20181017164200.22344-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 9/9] block: Make auto-read-only=on
 default for -drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/17/18 11:42 AM, Kevin Wolf wrote:
> While we want machine interfaces like -blockdev and QMP blockdev-add to
> add as little auto-detection as possible so that management tools are
> explicit about their needs, -drive is a convenience option for human
> users. Enabling auto-read-only=on by default there enables users to use
> read-only images for read-only guest devices without having to specify
> read-only=on explicitly. If they try to attach the image to a read-write
> device, they will still get an error message.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   blockdev.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

However, the obligatory: "iotests coverage?"

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
