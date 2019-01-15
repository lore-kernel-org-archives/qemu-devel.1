Received: from eggs.gnu.org ([209.51.188.92]:55747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUUE-00052I-Kl
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUGU-00057M-8A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:20:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjUGT-0004wN-V1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:20:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id c21so2251606qkl.6
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-6-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-6-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 23:20:06 +0400
Message-ID: <CAMxuvaz79KTipyazbNo4Dj=4-o65AR4bwDApc81HbSn26x1_bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/12] chardev: ensure
 qemu_chr_parse_compat reports missing driver error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Tue, Jan 15, 2019 at 6:53 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> If no valid char driver was identified the qemu_chr_parse_compat method
> was silent, leaving callers no clue what failed.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index ccba36bafb..b99f3692f7 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -490,6 +490,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
>          return opts;
>      }
>
> +    error_report("'%s' is not a valid char driver", filename);
> +
>  fail:
>      qemu_opts_del(opts);
>      return NULL;
> --
> 2.20.1
>
