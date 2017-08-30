Received: from eggs.gnu.org ([2001:4830:134:3::10]:36292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6a4-0004zw-Jt
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6a1-00055M-FH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:15:08 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn6a1-00055I-7n
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:15:05 -0400
Received: by mail-wm0-x243.google.com with SMTP id l19so2456476wmi.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 10:15:05 -0700 (PDT)
Date: Wed, 30 Aug 2017 18:15:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830171502.GC24565@stefanha-x1.localdomain>
References: <87r2w6eq5n.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2w6eq5n.fsf@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Michael <fedora.dm0@gmail.com>
Cc: qemu-devel@nongnu.org

On Sat, Aug 19, 2017 at 10:58:44PM -0700, David Michael wrote:
> This allows building with "./configure --python=python3", where
> the python3 program is at least version 3.6.  It preserves
> compatibility with Python 2.  The changes include:
> 
>   - Avoiding "print" usage
>   - Using bytes with files opened in binary mode
>   - Switching .iteritems() to .items()
>   - Adding fallback imports for functions moved to other modules
> 
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
> 
> Hi,
> 
> I've been applying these changes when building on Fedora 26, which does
> not include any Python 2 packages by default.  It was tested with Python
> 2.7 and 3.6.
> 
> I just saw the list of scripts that need updating on the mailing list,
> and this doesn't cover all of them, but it is enough to build a binary
> for running virtual machines with KVM.  Maybe it is still useful as a
> starting point.
> 
> Thanks.
> 
> David
> 
>  configure            |  6 ++++--
>  scripts/qapi.py      | 31 ++++++++++++++++++++-----------
>  scripts/qapi2texi.py | 10 +++++-----
>  scripts/signrom.py   |  4 ++--
>  4 files changed, 31 insertions(+), 20 deletions(-)

Cool, thanks for contributing this!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
