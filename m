Received: from eggs.gnu.org ([2001:4830:134:3::10]:38287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlHD-0005WP-KI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlHD-0005t8-0k
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:51:03 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-14-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbb7f552-fdc2-8dfd-3af2-9df7081faf6b@redhat.com>
Date: Tue, 27 Feb 2018 13:50:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-14-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 13/21] blockjobs: add commit, abort,
 clean helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> The completed_single function is getting a little mucked up with
> checking to see which callbacks exist, so let's factor them out.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockjob.c | 35 ++++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
