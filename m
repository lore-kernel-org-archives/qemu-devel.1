Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f9HnT-0003KO-Qw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f9HnO-00031v-SC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:12:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f9HnO-000305-Mx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:12:50 -0400
Received: by mail-it0-f66.google.com with SMTP id h143-v6so277450ita.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:12:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419220914.959-3-f4bug@amsat.org>
References: <20180419220914.959-1-f4bug@amsat.org>
	<20180419220914.959-3-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 20 Apr 2018 00:12:49 +0200
Message-ID: <CAMxuvaw1sobCX+rM1OXWjo9cxxtt27jPY1Fstuq3f=fhfH3wyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] Revert "Revert "mux: fix ctrl-a b
 again"" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

Hi

On Fri, Apr 20, 2018 at 12:09 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> This reverts commit 6f660996f1623034344cc37a1d430099067b755b to
> reintroduce commit 1b2503fcf7b5932c5a3779ca2ceb92bd403c4ee7.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I think we agreed this would go after 2.12.

I was going to send an updated patch with additional tests. I can take
your patch for the next series perhaps, instead of doing the double
revert ;)

> ---
>  chardev/char-mux.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 1b925c8dec..6055e76293 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
>      }
>
>      d->focus =3D focus;
> +    chr->be =3D d->backends[focus];
>      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
>  }
>
> --
> 2.17.0
>
