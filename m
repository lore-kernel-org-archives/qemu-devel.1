Received: from eggs.gnu.org ([2001:4830:134:3::10]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinog-0001O5-Ld
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinog-0000Xd-04
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:10 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cinof-0000Vl-PG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:09 -0500
Received: by mail-wm0-x236.google.com with SMTP id v77so93585755wmv.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:52:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227104956.24729-1-marcandre.lureau@redhat.com>
References: <20170227104956.24729-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 19:51:47 +0000
Message-ID: <CAFEAcA_MwmSr-8FP0wzSiYMikyPi1XN1QcOF6tQ5+ym7x2ctqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] vhost-user: delay vhost_user_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 27 February 2017 at 10:49, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
> may trigger a disconnect events, calling vhost_user_stop() and clearing
> all the vhost_dev strutures holding data that vhost.c functions expect
> to remain valid. Delay the cleanup to keep the vhost_dev structure
> valid during the vhost.c functions.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> v3:
>  - use aio_bh_schedule_oneshot(), as suggest by Paolo
> v2:
>  - fix reconnect race

Applied to master as a buildfix (I haven't seen the test failures
but others on IRC were complaining).

thanks
-- PMM
