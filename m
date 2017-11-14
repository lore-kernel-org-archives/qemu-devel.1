Received: from eggs.gnu.org ([2001:4830:134:3::10]:36420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEXwT-0001yb-Go
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEXwP-0005LO-Is
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:55:41 -0500
Date: Tue, 14 Nov 2017 10:55:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171114095535.52dn7x5f4nsz3j2u@sirius.home.kraxel.org>
References: <cover.1510612380.git.alistair.francis@xilinx.com>
	<1743d21d4c073ae4f8aabada57692bd2e536aa8e.1510612380.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1743d21d4c073ae4f8aabada57692bd2e536aa8e.1510612380.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/29] audio: Replace AUDIO_FUNC with
 __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair23@gmail.com, armbru@redhat.com

On Mon, Nov 13, 2017 at 02:34:39PM -0800, Alistair Francis wrote:
> Apparently we don't use __MSC_VER as a compiler anymore and we always
> require a C99 compiler (which means we always have __func__) so we don't
> need a special AUDIO_FUNC macro. We can just replace AUDIO_FUNC with
> __func__ instead.
> 
> Checkpatch failures were manually fixed.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
