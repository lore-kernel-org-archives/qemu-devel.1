Received: from eggs.gnu.org ([2001:4830:134:3::10]:39123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dNZbX-0005AY-7U
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dNZbU-0001Qo-5h
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:59:07 -0400
Received: from chuckie.co.uk ([82.165.15.123]:39677
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dNZbT-0001Ll-VF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:59:04 -0400
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170619142852.GS5016@thinpad.lan.raisama.net>
	<7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
	<08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
	<1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
	<9d24bf00-cf82-717a-eccd-f51e2c80dd6f@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <eaa2cd40-0d64-6843-7e39-c0f94c7e797f@ilande.co.uk>
Date: Wed, 21 Jun 2017 07:58:43 +0100
MIME-Version: 1.0
In-Reply-To: <9d24bf00-cf82-717a-eccd-f51e2c80dd6f@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, imammedo@redhat.com

On 19/06/17 23:43, Laszlo Ersek wrote:

> It looks good to me, but please await Eduardo's reply as well.
> 
> In particular, it should be confirmed that object_resolve_path_type()
> matches instances of *subclasses* as well (as I expect it would). Your
> test results confirm that; let's make sure it is intentional behavior.
> Eduardo (or someone else on the CC list), can you please comment on that?

Thanks Laszlo. Eduardo, can you confirm this is the correct behaviour?

I now have a v7 patchset ready to go (currently hosted at
https://github.com/mcayland/qemu/tree/fwcfg7 for the curious). Laszlo,
I've currently left off your Tested-by tag since I'm not sure it's still
valid for less-than-trivial changes - if you're happy for me to re-add
it before I send the v7 patchset to the list, please let me know.


ATB,

Mark.
