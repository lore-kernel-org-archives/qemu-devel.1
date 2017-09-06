Received: from eggs.gnu.org ([2001:4830:134:3::10]:56483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dph8I-0000vU-Pf
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dph8D-00082t-TO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:41:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dph8D-00082Z-P7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:41:05 -0400
Date: Wed, 6 Sep 2017 16:41:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170906204102.GA25558@flamenco>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
	<1504729728-23279-3-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504729728-23279-3-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [RFC 2/6] plugin: add initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 06, 2017 at 16:28:44 -0400, Emilio G. Cota wrote:
> --- /dev/null
> +++ b/plugin.c
> @@ -0,0 +1,519 @@
(snip)
> +    /*
> +     * @lock protects the struct as well as ctx->uninstalling.
> +     * The lock must be acquired by all API ops. Since some API ops
> +     * call plugin code repeatedly (e.g. vcpu_for_each), we keep
> +     * a counter to allow for recursive acquisitions.
> +     */
> +    QemuMutex lock;

This comment is outdated. The lock is not recursive anymore (it used to be).

		E.
