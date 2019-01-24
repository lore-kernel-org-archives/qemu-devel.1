Received: from eggs.gnu.org ([209.51.188.92]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gmaZm-0001bv-HR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gmaNd-0003z7-OM
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:28:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gmaNd-0003u2-0W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:28:57 -0500
From: Bandan Das <bsd@redhat.com>
References: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
	<CAFEAcA9vczSpf+xd+3so1YKAW-d4RKY7iVEtMvJrgSNbRjQ+Zg@mail.gmail.com>
	<jpgd0ooc1f0.fsf@linux.bootlegged.copy>
	<jpg8szcc1ar.fsf_-_@linux.bootlegged.copy>
	<20190124080137.2upct7emowdj7n2r@sirius.home.kraxel.org>
Date: Thu, 24 Jan 2019 03:19:03 -0500
In-Reply-To: <20190124080137.2upct7emowdj7n2r@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Thu, 24 Jan 2019 09:01:37 +0100")
Message-ID: <jpg4l9yzcw8.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: replace the homebrew write with
 qemu_write_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Bug 1798780 <1798780@bugs.launchpad.net>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Tue, Jan 22, 2019 at 07:41:16AM -0500, Bandan Das wrote:
>> 
>> qemu_write_full takes care of partial blocking writes,
>> as in cases of larger file sizes
>> 
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Bandan <bsd@redhat.com>
>
> Hmm, doesn't apply, and git fails to do a 3way merge too due to unknown
> sha1.
>

Oops, sorry, I realize now this is on top of the write buffer breakup patches.

Should I resend a v2 on top of master and send a v3 for the write buffer breakup
patches ?

> cheers,
>   Gerd
