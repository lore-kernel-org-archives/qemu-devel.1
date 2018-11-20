Received: from eggs.gnu.org ([2001:4830:134:3::10]:34589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPBmD-00062h-7n
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPBle-0008TY-GX
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPBla-0008Kl-Dh
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:32:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181119154737.9840-1-liq3ea@163.com>
	<20181119154737.9840-3-liq3ea@163.com>
Date: Tue, 20 Nov 2018 20:32:47 +0100
In-Reply-To: <20181119154737.9840-3-liq3ea@163.com> (Li Qiang's message of
	"Mon, 19 Nov 2018 07:47:36 -0800")
Message-ID: <87k1l78rz4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] fw_cfg: fix -boot reboot-timeout error
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@163.com> writes:

> fw_cfg_reboot() gets option parameter "reboot-timeout" with
> qemu_opt_get(), then converts it to an integer by hand. It neglects to
> check that conversion for errors, and fails to reject negative values.
> Positive values above the limit get reported and replaced by the limit.
> This patch checks for conversion errors properly, and reject all valus

Spelling: all values.

> outside 0...0xffff.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
