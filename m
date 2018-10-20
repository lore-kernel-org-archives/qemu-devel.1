Received: from eggs.gnu.org ([2001:4830:134:3::10]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfXE-0002MA-VT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfXD-00074q-Ql
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:54:32 -0400
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-7-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8be5c32e-58c7-1ba0-24d0-62487a832c9f@redhat.com>
Date: Fri, 19 Oct 2018 20:54:17 -0400
MIME-Version: 1.0
In-Reply-To: <20181019191523.12157-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/9] iotests: Explicitly inherit FDs in
 Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/19/18 3:15 PM, Max Reitz wrote:
> Python 3.4 introduced the inheritable attribute for FDs.  At the same
> time, it changed the default so that all FDs are not inheritable by
> default, that only inheritable FDs are inherited to subprocesses, and
> only if close_fds is explicitly set to False.
> 
> Adhere to this by setting close_fds to False when working with
> subprocesses that may want to inherit FDs, and by trying to
> set_inheritable() on FDs that we do want to bequeath to them.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
