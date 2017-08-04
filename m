Received: from eggs.gnu.org ([2001:4830:134:3::10]:40710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ddd8F-00014G-GH
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ddd7W-000352-BO
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:59:15 -0400
Date: Fri, 4 Aug 2017 21:55:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170804135537.GB14780@lemon>
References: <87o9rvfonm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9rvfonm.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Is the use of bdrv_getlength() in vmdk_check()
 kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri, 08/04 15:28, Markus Armbruster wrote:
> Have a look at vmdk_check():
> 
>         if (ret == VMDK_OK &&
>             cluster_offset >= bdrv_getlength(extent->file->bs))
> 
> bdrv_getlength() can fail.  Does it do the right thing then?  For what
> it's worth, the comparison of its value is unsigned.

Sure, error handling should be done with bdrv_getlength() return value. I'll
send a patch.

Fam
