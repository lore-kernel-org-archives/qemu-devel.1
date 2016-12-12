Received: from eggs.gnu.org ([2001:4830:134:3::10]:36556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGV5z-0005hU-4Z
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGV5w-0000MD-2e
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:13:03 -0500
Received: from [2a01:4f8:140:52e5::2] (port=35592 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGV5v-0000DM-SV
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:13:00 -0500
Date: Mon, 12 Dec 2016 19:12:37 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161212181237.3aymdmenxeu2kwjj@grep.be>
References: <20161205234235.5728-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205234235.5728-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] doc: Propose NBD_FLAG_INIT_ZEROES
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, stefanha@gmail.com, qemu-devel@nongnu.org, pbonzini@redhat.com

Hi Eric,

I'm not opposed to this proposal, per se, but there seems to be some
disagreement (by Kevin, for instance) on whether this extension is at
all useful.

If you can clarify that, I'll be happy to merge it.

On Mon, Dec 05, 2016 at 05:42:35PM -0600, Eric Blake wrote:
> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
> team discovered that it is useful if a server can advertise
> whether an export is in a known-all-zeroes state at the time
> the client connects.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  doc/proto.md | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> This replaces the following qemu patch attempt:
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00357.html
> which tried to add NBD_CMD_HAS_ZERO_INIT with poor semantics. The
> semantics in this proposal should be much better.
> 
> Patch is to the merge of the master branch and the
> extension-write-zeroes branch.  By the way, qemu 2.8 is due
> to be released "real soon now", and implements NBD_CMD_WRITE_ZEROES,
> so maybe it is time to consider promoting the extension-write-zeroes
> branch into master.
> 
> diff --git a/doc/proto.md b/doc/proto.md
> index afe71fc..7e4ec7f 100644
> --- a/doc/proto.md
> +++ b/doc/proto.md
> @@ -697,6 +697,11 @@ The field has the following format:
>    the export.
>  - bit 9, `NBD_FLAG_SEND_BLOCK_STATUS`: defined by the experimental
>    `BLOCK_STATUS` [extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-blockstatus/doc/proto.md).
> +- bit 10, `NBD_FLAG_INIT_ZEROES`: Indicates that the server guarantees
> +  that at the time transmission phase begins, all offsets within the
> +  export read as zero bytes.  Clients MAY use this information to
> +  avoid writing to sections of the export that should still read as
> +  zero after the client is done writing.
> 
>  Clients SHOULD ignore unknown flags.
> 
> -- 
> 2.9.3
> 
> 
> ------------------------------------------------------------------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today.http://sdm.link/xeonphi
> _______________________________________________
> Nbd-general mailing list
> Nbd-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nbd-general
> 

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
