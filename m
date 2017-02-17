Received: from eggs.gnu.org ([2001:4830:134:3::10]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cefkZ-0002Dc-Mr
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cefkY-0001p1-Q1
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:26:51 -0500
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:35062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cefkY-0001ow-Hw
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:26:50 -0500
Received: by mail-lf0-x236.google.com with SMTP id z127so20508299lfa.2
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 02:26:50 -0800 (PST)
MIME-Version: 1.0
References: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Feb 2017 10:26:37 +0000
Message-ID: <CAJ+F1CKUEh0_HFhnDvPq-zNbgb3snATM=jbMjid45WhK_eNMtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-ccid: improve sanity checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, Feb 16, 2017 at 5:14 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> Small ccid series which improves the ccid_handle_bulk_out sanity checks.
>
>

looks good,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> cheers,
>   Gerd
>
> Gerd Hoffmann (3):
>   usb-ccid: better bulk_out error handling
>   usb-ccid: move header size check
>   usb-ccid: add check message size checks
>
>  hw/usb/dev-smartcard-reader.c | 140
> +++++++++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 64 deletions(-)
>
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
