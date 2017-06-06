Received: from eggs.gnu.org ([2001:4830:134:3::10]:35760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIIVD-0006Qu-3e
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIIVC-00084s-9O
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:42:47 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIIVC-00083d-26
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:42:46 -0400
Received: by mail-wr0-x22c.google.com with SMTP id v104so57389114wrb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 10:42:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170606140216.12270-1-pbonzini@redhat.com>
References: <20170606140216.12270-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 18:42:24 +0100
Message-ID: <CAFEAcA_nSQ6dXsXS8zKZusqrPTYPq4HNzFyA3XhLOW7dCM=XLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/33] Misc patches for 2017-06-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2017 at 15:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 70f31414e71250c6049a46851372ee6ea76f40=
dd:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/numa-pull-request' =
into staging (2017-06-01 10:58:47 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0c5029c963dbce627d75cd0267594224c89a6479:
>
>   Merge tag 'tags/for-upstream' into HEAD

This doesn't build when merged into current master:

/home/pm215/qemu/hw/scsi/vhost-user-scsi.c: In function
=E2=80=98vhost_user_scsi_realize=E2=80=99:
/home/pm215/qemu/hw/scsi/vhost-user-scsi.c:121:5: error: implicit
declaration of function =E2=80=98register_savevm=E2=80=99
[-Werror=3Dimplicit-function-declaration]
     register_savevm(dev, "vhost-user-scsi", vhost_user_scsi_id++, 1,
     ^
/home/pm215/qemu/hw/scsi/vhost-user-scsi.c:121:5: error: nested extern
declaration of =E2=80=98register_savevm=E2=80=99 [-Werror=3Dnested-externs]

It has crossed in the post with the ppc pullreq, which includes
a patch which removes register_savevm() as finally unnecessary.
This new device should almost certainly be using a vmstate
struct instead.

thanks
-- PMM
