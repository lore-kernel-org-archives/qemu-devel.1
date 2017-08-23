Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkUZd-0003RJ-D8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkUZX-0006Jd-La
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:15:53 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkUZX-0006JN-5Y
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:15:47 -0400
Received: by mail-wr0-x236.google.com with SMTP id a47so5052612wra.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 05:15:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
References: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Aug 2017 13:15:25 +0100
Message-ID: <CAFEAcA_D6MyFdGqnPE5UOtiQ9j0TFu_azJ1s0WfwLLt8cC4G0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10???] fix build failure in
 nbd_read_reply_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 17 August 2017 at 17:14, Igor Mammedov <imammedo@redhat.com> wrote:
> travis builds fail at HEAD at rc3 master with
>
>   block/nbd-client.c: In function =E2=80=98nbd_read_reply_entry=E2=80=99:
>   block/nbd-client.c:110:8: error: =E2=80=98ret=E2=80=99 may be used unin=
itialized in this function [-Werror=3Duninitialized]
>
> fix it by initializing 'ret' to 0
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> --

Applied to master for 2.10, since we needed to run an rc4 anyway.

thanks
-- PMM
