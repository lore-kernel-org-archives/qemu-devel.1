Received: from eggs.gnu.org ([2001:4830:134:3::10]:34589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPBmB-00062h-FC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPBm4-0000bU-IH
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:33:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPBlz-0000Mx-SP
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:33:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181119154737.9840-1-liq3ea@163.com>
	<20181119154737.9840-4-liq3ea@163.com>
Date: Tue, 20 Nov 2018 20:33:09 +0100
In-Reply-To: <20181119154737.9840-4-liq3ea@163.com> (Li Qiang's message of
	"Mon, 19 Nov 2018 07:47:37 -0800")
Message-ID: <87ftvv8ryi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] fw_cfg: make qemu_extra_params_fw
 locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@163.com> writes:

> qemu_extra_params_fw[] has external linkage, but is used
> only in fw_cfg_bootsplash(), it makes sense to make it
> locally.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
