Received: from eggs.gnu.org ([209.51.188.92]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj42Z-0006V5-TM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj42Z-0005Lz-4Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:20:39 -0500
Date: Mon, 14 Jan 2019 16:20:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190114162003.274d5921.cohuck@redhat.com>
In-Reply-To: <1547470346-18416-1-git-send-email-thuth@redhat.com>
References: <1547470346-18416-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] configure: Only build the s390-ccw bios
 if the compiler supports -march=z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 14 Jan 2019 13:52:26 +0100
Thomas Huth <thuth@redhat.com> wrote:

> We want to build our s390-ccw bios with -march=z900 so that it also
> works with the oldest s390x CPU that we support with TCG. However,
> Clang on s390x does not support -march=z900 anymore, so we can not
> use this compiler to build the s390-ccw bios. Thus add a proper test
> to the configure script to see whether the compiler is usable.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use compile_prog as suggested by Peter
> 
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

With this, the fpu/softfloat patch, and Marcel's rdma patches, I can
compile with clang on my Fedora 29 s390x system. Yeah!

Should this patch go through the s390 tree, or take some other path?
