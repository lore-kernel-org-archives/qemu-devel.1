Received: from eggs.gnu.org ([209.51.188.92]:60834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggeR1-0000UB-W6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 18:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggeQz-0000pY-Iv
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 18:35:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ggeQx-0000mY-SU
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 18:35:53 -0500
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-5-git-send-email-lizhijian@cn.fujitsu.com>
	<20181221110913-mutt-send-email-mst@kernel.org>
	<20181227203118.GA19442@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f2b416c-2f29-b33c-0b0e-f6598df67c4e@redhat.com>
Date: Tue, 8 Jan 2019 00:35:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181227203118.GA19442@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/4] i386: allow to load initrd
 below 4G for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com, philmd@redhat.com, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 27/12/18 21:31, Eduardo Habkost wrote:
> All that said, I miss one piece of information here: is
> XLF_CAN_BE_LOADED_ABOVE_4G really supposed to override
> header+0x22c?  linux/Documentation/x86/boot.txt isn't clear about
> that.  Is there any reference that can help us confirm this?

Linux has supported initrd up to 4 GB for a very long time (2007, long
before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013), though it
only sets initrd_max to 2 GB to "work around bootloader bugs".  So I
guess the flag can be taken as a hint that you can load at any address,
and perhaps could be renamed.

Paolo
