Received: from eggs.gnu.org ([209.51.188.92]:50158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1go4KG-00083Z-Vb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1go4KG-0005uP-9J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:39:36 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1go4KF-0005ox-SX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:39:36 -0500
Date: Mon, 28 Jan 2019 11:39:00 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190128103900.ea6nxhm45u4p5mpd@function>
References: <20190127114659.12881-1-samuel.thibault@ens-lyon.org>
	<8736pdnk7a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736pdnk7a.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] slirp: replace QEMU_BUILD_BUG_ON with
 G_STATIC_ASSERT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com, jan.kiszka@siemens.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, zhangckid@gmail.com

Alex Bennée, le lun. 28 janv. 2019 10:35:37 +0000, a ecrit:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Is there a rationale as to why we should replace QEMU_BUILD_BUG_ON with
> G_STATIC_ASSERT or is it particular to these QEMU_BUILD_BUG_ON
> instances? It would be nice to have a little more context in the commit
> message.

It is yet more work towards moving slirp/ to a separately-maintained
libslirp.

Samuel
