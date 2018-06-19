Received: from eggs.gnu.org ([2001:4830:134:3::10]:54577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVEOu-0001A8-My
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVEOq-0002gO-7D
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:02:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVEOq-0002gC-2R
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:02:12 -0400
References: <20180618175958.29073-1-armbru@redhat.com>
	<20180618175958.29073-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac17cafd-6133-c6c9-c25e-08145c5a3be4@redhat.com>
Date: Tue, 19 Jun 2018 06:02:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180618175958.29073-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qapi: Open files with
 encoding='utf-8'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: tamiko@43-1.org, arfrever.fta@gmail.com

On 06/18/2018 12:59 PM, Markus Armbruster wrote:
> Python 2 happily reads UTF-8 files in text mode, but Python 3 requires
> either UTF-8 locale or an explicit encoding passed to open().  Commit
> d4e5ec877ca fixed this by setting the en_US.UTF-8 locale.  Falls apart
> when the locale isn't be available.
> 
> Matthias Maier and Arfrever Frehtes Taifersar Arahesis proposed to use
> binary mode instead, with manual conversion from bytes to str.  Works,
> but opening with an explicit encoding is simpler, so do that.
> 
> Since Python 2's open() doesn't support the encoding parameter, we
> need to suppress it with a version check.
> 
> Reported-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
> Reported-by: Matthias Maier <tamiko@43-1.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/common.py | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
