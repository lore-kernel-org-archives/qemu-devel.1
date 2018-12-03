Received: from eggs.gnu.org ([2001:4830:134:3::10]:39979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpgv-0003FV-3z
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpgt-0008PQ-Bo
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:59:21 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTpgs-0008OC-Px
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:59:19 -0500
Received: by mail-ot1-x341.google.com with SMTP id e12so11840948otl.5
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20181203101045.27976-1-kraxel@redhat.com>
	<20181203101045.27976-2-kraxel@redhat.com>
In-Reply-To: <20181203101045.27976-2-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 14:59:06 +0000
Message-ID: <CAFEAcA9ToxMAjKBzKfs-1UhhLk0Dr_cTa31EcA+SrMJqt6v9dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v3 1/2] usb-mtp: fix utf16_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, public@hansmi.ch

On Mon, 3 Dec 2018 at 10:15, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Make utf16_to_str return an allocated string.  Remove the assumtion that
> the number of string bytes equals the number of utf16 chars (which is
> only true for ascii chars).  Instead call wcstombs twice, once to figure
> the storage size and once for the actual conversion (as suggested by the
> wcstombs manpage).
>
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
