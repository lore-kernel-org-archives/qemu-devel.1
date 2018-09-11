Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzjHA-0006hA-Bi
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzj2l-0002Wn-OV
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:49:28 -0400
References: <20180911083706.5378-1-mahaocong_work@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <415d6345-d422-e069-dda6-290f63c806a8@redhat.com>
Date: Tue, 11 Sep 2018 08:49:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180911083706.5378-1-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/1] qemu-img: add new function to
 remove bitmap in image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ma Haocong <mahaocong_work@163.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On 9/11/18 3:37 AM, Ma Haocong wrote:
> Hello,
> 
> In our scene, we need to delete dirty-bitmap created by using qmp command
> 'block-dirty-bitmap-add'. we can use qmp command 'block-dirty-bitmap-remove'
> to remove bitmap. Then I think that we should add a new function in qemu-img
> to do the same work.
> 
> The command format is: qemu-img removebmp file-name bitmap-name

John was working on a more general 'qemu-img bitmap' command that did 
multiple operations from qemu-img, rather than just remove. That feels 
like a more extensible approach than adding a new command for every 
individual bitmap operation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
