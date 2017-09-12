Received: from eggs.gnu.org ([2001:4830:134:3::10]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1driFC-0000Th-7Z
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1driF8-00081M-E5
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:16:38 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1driF8-0007zx-75
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:16:34 -0400
Received: by mail-wm0-x241.google.com with SMTP id p17so8851970wmd.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 03:16:34 -0700 (PDT)
Date: Tue, 12 Sep 2017 11:16:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170912101629.GE6123@stefanha-x1.localdomain>
References: <2896466deb1ff8d832e39ce389ce268ee38e4e4f.1504935362.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2896466deb1ff8d832e39ce389ce268ee38e4e4f.1504935362.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4] pci: Set err to errp directly rather
 than through error_propagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Sat, Sep 09, 2017 at 02:22:26PM +0800, Mao Zhongyi wrote:
> ioh3420_interrupts_init() pass error message to local_err, then
> propagate it to errp by error_propagate(), which is not necessary.
> So eliminate it and pass errp directly instead of local_err.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com> 
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v4:
> it not apply clearly on HEAD, so rebase it and modify the commit
> message.
> ---
> 
>  hw/pci-bridge/ioh3420.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
