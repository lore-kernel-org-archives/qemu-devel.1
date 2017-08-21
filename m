Received: from eggs.gnu.org ([2001:4830:134:3::10]:43873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1djj3T-0004Zx-6W
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1djj3O-0000AC-Ak
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1djj3O-00009B-4c
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:31:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170818222313.13391-1-eblake@redhat.com>
Date: Mon, 21 Aug 2017 11:31:18 +0200
In-Reply-To: <20170818222313.13391-1-eblake@redhat.com> (Eric Blake's message
	of "Fri, 18 Aug 2017 17:23:13 -0500")
Message-ID: <874lt16zdl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> We already have several files that knowingly require assert()
> to work.  While we do NOT want to encourage the use of
> 'assert(side-effects)' (that is a bad practice that prevents
> copy-and-paste of code to other projects that CAN disable
> assertions; plus it costs unnecessary reviewer mental cycles
> to remember our project policy on crippling asserts), we DO
> want to send a message that anyone that disables assertions
> has to tweak code in order to compile, making it obvious that
> we are not going to support their efforts.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> First mentioned as an idea here:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06084.html
> but I'm titling this RFC as I'm not 100% convinced we want to make
> it a project-wide, rather than a per-file decision.

I'm fine with project-wide, but does it have to be a hard error?  Can we
make it a warning?  Same effect by default, but it lets people
experiment more easily with --disable-werror.
