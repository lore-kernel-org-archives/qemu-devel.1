Received: from eggs.gnu.org ([2001:4830:134:3::10]:57286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDSu2-0006Qp-7s
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDStx-00041B-Cc
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:48:26 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f40b58a9-6c63-39fc-b8ef-f830e77f1e68@redhat.com>
References: <cover.1495536228.git.berto@igalia.com>
	<504d7d07c4227d4615b72f46deb34ba77efbea2c.1495536228.git.berto@igalia.com>
	<f40b58a9-6c63-39fc-b8ef-f830e77f1e68@redhat.com>
Date: Wed, 24 May 2017 11:48:17 +0200
Message-ID: <w51vaoqtwke.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/7] qcow2: Remove unused Error in
 do_perform_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

On Tue 23 May 2017 10:21:49 PM CEST, Eric Blake wrote:

>> qcow2_encrypt_sectors() does not need an Error parameter, and we're
>> not checking its value anyway, so we can safely remove it.
>
> Misleading. You are NOT removing the Error parameter from
> qcow2_encrypt_sectors(), but rather are explicitly ignoring any errors
> by passing NULL.

Ok, I'll update the comment in the next revision with something like
what you suggest.

Berto
