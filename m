Received: from eggs.gnu.org ([2001:4830:134:3::10]:55877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <uril@redhat.com>) id 1cP5GE-0008P8-HO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <uril@redhat.com>) id 1cP5GA-0000UE-I7
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:27:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <uril@redhat.com>) id 1cP5GA-0000U6-Cz
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:27:02 -0500
Reply-To: uril@redhat.com
References: <20161213173354.jffasav66gdl7v4q@wingsuit>
	<ee97fcda99c77c62d64c1baa88fd17fed7639626.1483467324.git.msuchanek@suse.de>
From: Uri Lublin <uril@redhat.com>
Message-ID: <fe7ed4fe-94f6-ba28-371c-bb1716d7f4ac@redhat.com>
Date: Thu, 5 Jan 2017 12:26:59 +0200
MIME-Version: 1.0
In-Reply-To: <ee97fcda99c77c62d64c1baa88fd17fed7639626.1483467324.git.msuchanek@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Do endian swapping.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Suchanek <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org

On 01/03/2017 08:16 PM, Michal Suchanek wrote:
> This allows running big endian and little endian guest side by side using
> cut & paste between them.
>
> There is a general design idea that swapping should come as close to
> virtio_read/virtio_write as possible. In particular, the protocol
> between vdagent and vdagentd is guest-specific and in native endian.
> With muliple layers of headers this is a bit tricky. A few message types
> have to be swapped fully before passing through vdagentd.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Hi Michal,

Please send these patches to spice-devel mailing list.

Thanks,
     Uri.

>
> ---
> v2:
>  - introduce helper functions to swap (a portion of) a message wholesale
>  - pollute fewer places with swapping sometimes at the cost of slightly
>    more verbose code
> ---
>  src/vdagentd/vdagentd.c    | 99 +++++++++++++++++++++++++++++++++++++---------
>  src/vdagentd/virtio-port.c | 35 ++++++++++------
>  2 files changed, 102 insertions(+), 32 deletions(-)
>
