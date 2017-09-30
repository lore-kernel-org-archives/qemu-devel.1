Received: from eggs.gnu.org ([2001:4830:134:3::10]:52245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyBN6-0003WS-IZ
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyBN3-0008Ui-Ck
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dyBN3-0008UQ-6C
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:35:29 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<c861ba99329355f1f3096b833660d0be68b737c2.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9359b878-5629-4ad0-8d7f-10b35e26e6e8@redhat.com>
Date: Sat, 30 Sep 2017 08:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <c861ba99329355f1f3096b833660d0be68b737c2.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/47] audio: Replace AUDIO_FUNC with
 __func__
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 30.09.2017 02:15, Alistair Francis wrote:
> Apparently we don't use __MSC_VER as a compiler anymore and we always
> require a C99 compiler (which means we always have __func__) so we don't
> need a special AUDIO_FUNC macro. We can just repleace AUDIO_FUNC with

s/repleace/replace/

> __func__ instead.
> 
> Checkpatch failures where manually fixed.

s/where/were/

Reviewed-by: Thomas Huth <thuth@redhat.com>
