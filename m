Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqmk-0005vC-2I
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqmj-0002Kb-9v
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:14:30 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjqmj-0002KF-3e
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:14:29 -0500
Received: by mail-wr0-x232.google.com with SMTP id u108so78012003wrb.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 09:14:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 17:14:07 +0000
Message-ID: <CAFEAcA-XqZb22ov-PxxGJ8EnF-Yj+m-FETPY0n1kUcZDmskqxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, Qemu-block <qemu-block@nongnu.org>, namei.unix@gmail.com

On 2 March 2017 at 21:43, Markus Armbruster <armbru@redhat.com> wrote:
> Bad error handling, memory leaks, and lack of blockdev-add support.
>
> Markus Armbruster (15):
>   sheepdog: Defuse time bomb in sd_open() error handling
>   sheepdog: Fix error handling in sd_snapshot_delete()
>   sheepdog: Fix error handling sd_create()
>   sheepdog: Mark sd_snapshot_delete() lossage FIXME
>   sheepdog: Fix snapshot ID parsing in _open(), _create, _goto()
>   sheepdog: Don't truncate long VDI name in _open(), _create()
>   sheepdog: Report errors in pseudo-filename more usefully
>   sheepdog: Use SocketAddress and socket_connect()
>   sheepdog: Implement bdrv_parse_filename()
>   gluster: Drop assumptions on SocketTransport names
>   gluster: Don't duplicate qapi-util.c's qapi_enum_parse()
>   gluster: Plug memory leaks in qemu_gluster_parse_json()
>   qapi-schema: Rename GlusterServer to SocketAddressFlat
>   qapi-schema: Rename SocketAddressFlat's variant tcp to inet
>   sheepdog: Support blockdev-add
>
>  block/gluster.c      | 127 +++++++--------
>  block/sheepdog.c     | 436 +++++++++++++++++++++++++++++++++++++--------------
>  qapi-schema.json     |  38 +++++
>  qapi/block-core.json |  73 +++------
>  4 files changed, 443 insertions(+), 231 deletions(-)

Did you find these by looking at our Coverity results, or
cross-reference them against Coverity? (Coverity definitely
found the gluster leaks, for instance.)

thanks
-- PMM
