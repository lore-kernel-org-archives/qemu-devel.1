Received: from eggs.gnu.org ([2001:4830:134:3::10]:49553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1carEe-0003sC-BN
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1carEb-0004H3-8k
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:54:08 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1carEb-0004Gz-1d
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:54:05 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so24610323wmi.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 13:54:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170204100317.32425-1-rjones@redhat.com>
	<20170204100317.32425-2-rjones@redhat.com>
	<21e1f16f-59f3-479c-a8f7-42cf5ada40b4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1fef8862-3d19-c8fc-76e3-ce0ef30a6899@redhat.com>
Date: Mon, 6 Feb 2017 22:54:02 +0100
MIME-Version: 1.0
In-Reply-To: <21e1f16f-59f3-479c-a8f7-42cf5ada40b4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com, dplotnikov@virtuozzo.com, rkagan@virtuozzo.com, den@openvz.org



On 06/02/2017 20:04, Eric Blake wrote:
> This is not the right way to do things (it risks clearing any other FD_
> flags currently set on the fd, even though there aren't any such FD_
> flags in common use).

There aren't any such flags at all really, and because no one uses
F_GETFD, it's unlikely that there will ever be any.  Has any other POSIX
OS ever had one?

Paolo
