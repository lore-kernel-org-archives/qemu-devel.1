Received: from eggs.gnu.org ([2001:4830:134:3::10]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8nA1-000459-4H
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8nA0-0005xx-Ba
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:30:09 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:40290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8nA0-0005xa-6Z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:30:08 -0400
Received: by mail-oi0-x22f.google.com with SMTP id x9-v6so1560652oig.7
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 06:30:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180418124753.GM27579@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Apr 2018 14:29:47 +0100
Message-ID: <CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18 April 2018 at 13:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> On Wed, Apr 18, 2018 at 02:38:37PM +0200, Olaf Hering wrote:
>> Since usage of g_realloc_n was introduced, glib-2.22 can not be used any=
more.
>> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
>
> Normally we expect ./include/glib-compat.h to be changed in this scenario
> to add compat for the missing symbol.
>
> IIRC, one of Peters desired build targets required 2.22, but I guess we
> missed this bug because that platform would not enable vfio functionality=
 ?

Yes, my OSX build system is on glib 2.22. It's using 'fink' for 3rd
party library installations, and they somehow seem to have got stuck
on 2.22. Looking at the website the project seems to have basically
stagnated, and I guess I need to move to homebrew at some point
(likely after we get 2.12 out the door). But for the moment this
patch would break my pullrequest testing builds.

thanks
-- PMM
