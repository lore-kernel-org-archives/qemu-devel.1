Received: from eggs.gnu.org ([209.51.188.92]:34854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTcW-00020Y-UI
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTcV-00041u-SU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGTcV-00041X-Ls
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:19:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190415141547.15444-1-berrange@redhat.com>
	<87a7gq75l6.fsf@dusky.pond.sub.org>
	<20190416090358.GF31311@redhat.com>
	<87zhoq3pn9.fsf@dusky.pond.sub.org>
	<20190416160927.GT31311@redhat.com>
Date: Tue, 16 Apr 2019 21:19:42 +0200
In-Reply-To: <20190416160927.GT31311@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 16 Apr 2019 17:09:27 +0100")
Message-ID: <87sguh3ghd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]
> I think that's fundamentally the wrong way around. Most stuff *should*
> be locale dependant, otherwise any interaction with the host OS is
> likely to use incorrect localization. It isn't practical to put a
> uselocale() call around every place that opens a filename. There are
> a few places where QEMU should be locale indepandant such as the QMP
> and guest OS ABI sensitive things, which should take account of it.

All right, you convinced me.  The problem is even bigger than I thought.
That means the return on investment in this area is even poorer than I
thought.

I don't think we should try to support anything but ASCII and UTF-8.
