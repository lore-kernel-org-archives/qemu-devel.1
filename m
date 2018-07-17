Received: from eggs.gnu.org ([2001:4830:134:3::10]:58728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffOsy-0006G6-Qe
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffOsx-0006uT-T2
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:15:20 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffOsx-0006tg-EB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:15:19 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so1543781oih.11
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 05:15:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 13:14:58 +0100
Message-ID: <CAFEAcA_to+a58OaJ1Dray31wr8wg9XefE6wD8Pa0Cg9ONqZ+Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/17] Fix crashes with introspection of
 ARM devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On 16 July 2018 at 13:59, Thomas Huth <thuth@redhat.com> wrote:
> As discovered recently, you can crash QEMU with a lot of devices
> that do not get the reference counting of child objects right.
> You just have to run 'device-list-properties' and call 'info qtree'
> afterwards.
> This patch series fixes these problems in the ARM code. When all
> patches have been applied, I now do not get any more hangs or crashes
> when I add a hmp("info qtree") to the device-introspect-test.
>
> Please have a look at patch #1, #15 and #16, they still need reviews.

Everything seems to have got review now, so I'm going to apply
this set to master for rc1. Thanks very much for digging into
what was going on here and cleaning up our APIs.

-- PMM
