Received: from eggs.gnu.org ([209.51.188.92]:41481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzO9w-00008I-Eb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzO9u-0004gk-DV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:03:44 -0500
References: <60952760a82dc603b836ca41fd0f9b1325cad635.camel@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f30ec53-6cac-d2cb-5fdb-db9ab3438c85@redhat.com>
Date: Thu, 28 Feb 2019 10:03:37 -0600
MIME-Version: 1.0
In-Reply-To: <60952760a82dc603b836ca41fd0f9b1325cad635.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] trivial fix of malloc to g_new in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>

On 2/28/19 9:35 AM, Aarushi Mehta wrote:
> 
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
> Note that since thunking occurs throughout the lifetime of the QEMU instance, 
> there is no matching 'free' to correct

This sentence is vital to the patch, so it belongs above the --- and
S-o-b as part of the commit message.

> It might be valuable to edit the BiteSizedTasks to reflect that g_new is favoured over g_malloc

And I've done that now, by emphasizing the discussion in HACKING (rather
than repeating it on the wiki):
https://wiki.qemu.org/index.php?title=Contribute/BiteSizedTasks&diff=8247&oldid=8242

With the improved commit message,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
