Received: from eggs.gnu.org ([2001:4830:134:3::10]:50799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciRFp-000896-A0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciRFo-0006tc-HS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:46:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1488220970.git.jcody@redhat.com>
	<cover.1488220970.git.jcody@redhat.com>
	<963f4d61ffcef289b8030bed4be9b9849e2056fe.1488220970.git.jcody@redhat.com>
Date: Mon, 27 Feb 2017 20:46:32 +0100
In-Reply-To: <963f4d61ffcef289b8030bed4be9b9849e2056fe.1488220970.git.jcody@redhat.com>
	(Jeff Cody's message of "Mon, 27 Feb 2017 13:58:44 -0500")
Message-ID: <87innv5sdj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/5] block/rbd: don't copy strings in
 qemu_rbd_next_tok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Jeff Cody <jcody@redhat.com> writes:

> This patch is prep work for parsing options for .bdrv_parse_filename,
> and using QDict options.
>
> The function qemu_rbd_next_tok() searched for various key/value pairs,
> and copied them into buffers.  This will soon be an unnecessary extra
> step, so we will now return found strings by reference only, and
> offload the responsibility for safely handling/coping these strings to
> the caller.
>
> This also cleans up error handling some, as the callers now rely on
> the Error object to determine if there is a parse error.
>
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
