Received: from eggs.gnu.org ([2001:4830:134:3::10]:42819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez5jA-0002IZ-Oj
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez5j8-0002FW-Sk
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:18:20 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez5j8-0002El-M8
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:18:18 -0400
Received: by mail-ot0-x234.google.com with SMTP id 108-v6so10697656otv.3
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 12:18:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6137f1be-98a0-1b3f-6bed-ca94be1b5d1a@redhat.com>
References: <20180322161226.29796-1-lvivier@redhat.com>
	<152174145840.240.3926671265619235661@71c20359a636>
	<CAFEAcA_Uxhrh2L+FghG7y2r7n36rfo41jKw9vdGZYo32nk28cg@mail.gmail.com>
	<6137f1be-98a0-1b3f-6bed-ca94be1b5d1a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 19:17:57 +0000
Message-ID: <CAFEAcA8K=dBh1SJUWCZtPGphDngiYMjqeVJG5LurSXOZ-KDk+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] coccinelle: re-run scripts from
 scripts/coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 22 March 2018 at 19:12, Eric Blake <eblake@redhat.com> wrote:
> Or if we don't patch the false negative, you can bypass checkpatch with an
> ugly hack:
>
> return 0 + (...) | (...);
>
> (I'm NOT going to do that bypass - it's too ugly for my taste)

Yeah, that's definitely not something we should be doing.
checkpatch has plenty of false positives anyway, ignoring one
more is no big deal.

thanks
-- PMM
