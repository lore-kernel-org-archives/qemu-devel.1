Received: from eggs.gnu.org ([209.51.188.92]:44915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2wmy-0007ij-2s
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2wmu-0002QC-R3
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:38:44 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:33766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2wmu-0002Or-JS
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:38:40 -0400
Received: by mail-ot1-x334.google.com with SMTP id q24so1613177otk.0
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 04:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190308173958.20618-1-eblake@redhat.com>
In-Reply-To: <20190308173958.20618-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Mar 2019 11:38:28 +0000
Message-ID: <CAFEAcA8xGwePhFV7UVqLXr6nRAoecGTsTq4wTO=fsAz5DHoezg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] NBD patches for 2019-03-08,
 4.0 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 8 Mar 2019 at 17:41, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit c557a8c7b755d8c153fc0f5be00688228be96e=
76:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2019=
0306a' into staging (2019-03-06 14:50:33 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-03-08
>
> for you to fetch changes up to 054be3605459d4342e9ee5a82ae0fcffeeb09e4d:
>
>   iotests: Wait for qemu to end in 223 (2019-03-06 11:05:27 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2019-03-08
>
> - support TLS client authorization in NBD servers
> - iotest 223 race fix
>
> ----------------------------------------------------------------
> Daniel P. Berrang=C3=A9 (3):
>       qemu-nbd: add support for authorization of TLS clients
>       nbd: allow authorization with nbd-server-start QMP command
>       nbd: fix outdated qapi docs syntax for tls-creds
>
> Eric Blake (1):
>       iotests: Wait for qemu to end in 223

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
