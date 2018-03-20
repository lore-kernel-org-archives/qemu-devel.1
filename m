Received: from eggs.gnu.org ([2001:4830:134:3::10]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyLl4-0005fw-3N
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyLl3-00075U-AP
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:13:14 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:40381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyLl3-00074v-2e
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:13:13 -0400
Received: by mail-oi0-x231.google.com with SMTP id c12-v6so2154682oic.7
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:13:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320200257-mutt-send-email-mst@kernel.org>
References: <1521568357-114127-1-git-send-email-mst@redhat.com>
	<20180320200257-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 18:12:52 +0000
Message-ID: <CAFEAcA_o4DUvCwGXAPKnuiLmZ-AgbRM4F2mPp5go+eHAB1RHaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] linux-headers: unistd.h fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 20 March 2018 at 18:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> Cc MIPS maintainers.
> Can we drop the MIPS blacklist for kvm?
> Could you guys pls check?

My guess is that MIPS got blacklisted in 1842bdfdbac2ec4
because Marc-Andr=C3=A9 didn't want to deal with the fact that
the mips unistd.h includes another header that would also
need to be synced. Marc-Andr=C3=A9, I don't suppose you can
remember your reasoning from three years back? :-)

thanks
-- PMM
