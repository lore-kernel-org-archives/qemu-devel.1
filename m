Received: from eggs.gnu.org ([2001:4830:134:3::10]:52046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn1Ca-0005v1-8i
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn1CZ-0006cb-Ea
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:30:32 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dn1CZ-0006bB-8B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:30:31 -0400
Received: by mail-wm0-x236.google.com with SMTP id u26so8605859wma.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 04:30:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170830075243.xo6cmihon7ikzdlr@var.youpi.perso.aquilenet.fr>
References: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
	<42fd21ab-d7ca-da12-4f15-73660f543781@redhat.com>
	<20170830075243.xo6cmihon7ikzdlr@var.youpi.perso.aquilenet.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Aug 2017 12:30:07 +0100
Message-ID: <CAFEAcA-LG=Q-k0RMrCJ+5NofzyFHeNLmWRwpy=ZY8EtAxwwsUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>, Wjjzhang <wjjzhang@tencent.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 30 August 2017 at 08:52, Samuel Thibault <samuel.thibault@gnu.org> wrote=
:
> Thomas Huth, on mer. 30 ao=C3=BBt 2017 09:50:45 +0200, wrote:
>> On 26.08.2017 00:37, Samuel Thibault wrote:
>> > The if_fastq and if_batchq contain not only packets, but queues of pac=
kets
>> > for the same socket. When sofree frees a socket, it thus has to clear =
ifq_so
>> > from all the packets from the queues, not only the first.
>>
>> I think you should CC: this to qemu-stable if it's fixing a problem that
>> can be used by the guest to crash QEMU... ?
>
> Indeed. I thought it should first go to master.

The way our cc-stable process works is that you include
a line in the commit message "Cc: qemu-stable@nongnu.org"
(in the same place as the signed-off-by and other lines)
and also cc the email address when sending the patch;
then that will go into the git history in master and can
be fished out from there. If you don't include it in the
original patch send then whoever puts the pull request
together has to include it, so it's helpful to add it from
the start if it's pretty definitely a thing that should go
into stable.

thanks
-- PMM
