Received: from eggs.gnu.org ([2001:4830:134:3::10]:52147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ek9Qg-0007Aq-1J
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ek9Qf-0005MJ-7G
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:13:30 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a3fccfe3-024b-a195-32c9-ddc76c855ff8@redhat.com>
Date: Fri, 9 Feb 2018 08:13:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/27] qcow2: Use QCryptoBlockCreateOptions
 in qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> Instead of passing the encryption format name and the QemuOpts down, use
> the QCryptoBlockCreateOptions contained in BlockdevCreateOptions.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   block/qcow2.c | 62 +++++++++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 45 insertions(+), 17 deletions(-)
> 

> @@ -3010,6 +3026,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
>           ret = -EINVAL;
>           goto finish;
>       }
> +
>       encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
>       if (encryptfmt) {
>           if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {

Should this whitespace change belong to a different patch?

R-b still stands

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
