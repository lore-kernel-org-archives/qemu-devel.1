Received: from eggs.gnu.org ([2001:4830:134:3::10]:50860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKWcZ-00082O-Ig
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKWcW-0004oP-EE
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:11:35 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40041
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKWcW-0004mr-6d
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:11:32 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612134328.76c5a352@nial.brq.redhat.com>
	<84a176fb-0d57-09f5-15c3-8e2bd4c66f48@ilande.co.uk>
	<0799bedf-d1af-49e3-4d18-81957b9240c3@redhat.com>
	<b7ee6bf2-6437-ca8a-e2a9-80a800bca2bd@ilande.co.uk>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <73e92706-416c-df0c-592d-4c87a8156f91@ilande.co.uk>
Date: Mon, 12 Jun 2017 22:11:13 +0100
MIME-Version: 1.0
In-Reply-To: <b7ee6bf2-6437-ca8a-e2a9-80a800bca2bd@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] fw_cfg: move qdev_init_nofail() out
 from fw_cfg_init1() into callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com

On 12/06/17 20:50, Mark Cave-Ayland wrote:

> Now I understand this much better, let me try a v2 of this which fixes
> (1) and moves fw_cfg_init1() to a QOM method in the parent as suggested
> by Igor and see what you think.

Experimenting with this some more, if the aim is to try and minimise
code movement/reorganisation then I don't think the QOM method will give
that much benefit for the work involved.

I've just created a v2 with the aim of minimising code churn which I'll
send along shortly.


ATB,

Mark.
