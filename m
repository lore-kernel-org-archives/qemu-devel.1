Received: from eggs.gnu.org ([2001:4830:134:3::10]:55066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIJPZ-0006C6-Fg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIJPY-00031V-LQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:45:33 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-8-kwolf@redhat.com>
	<91b7384b-25f4-2141-8794-d1319aa19c2d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9fa0b85-ec19-f294-7040-033345cd9ae6@redhat.com>
Date: Mon, 14 May 2018 14:45:24 -0500
MIME-Version: 1.0
In-Reply-To: <91b7384b-25f4-2141-8794-d1319aa19c2d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/42] blockjob: Remove
 block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/11/2018 05:30 PM, Max Reitz wrote:
> On 2018-05-09 18:26, Kevin Wolf wrote:
>> Commit 81193349 removed the only use of block_job_pause/resume_all(),
>> which was in bdrv_drain_all(). The functions are now unused and can be
>> removed.
> 
> I have a strange liking for all-digit commit hash prefixes.

Especially when the first digit is 0, but then the rest includes an 8 or 
9.  (in the past, I've actually had a script transiently break when 
parsing commit ids, and it took me quite a while to figure out why the 
problem disappeared after I rebased, until I finally realized that it 
was because the script was choking on an attempt to parse an invalid 
octal number, only when I got lucky enough to land on a problematic 
commit id)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
