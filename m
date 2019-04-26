Received: from eggs.gnu.org ([209.51.188.92]:59254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hJvkZ-0006gK-La
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hJvjT-0001My-L9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hJvjP-0001J1-NP
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:57:17 -0400
References: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
	<8a9008f1-34f7-ecb8-9ccb-c129f56236ec@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a66b5d6-165c-326b-0c68-1078ab49c80e@redhat.com>
Date: Fri, 26 Apr 2019 09:57:06 +0200
MIME-Version: 1.0
In-Reply-To: <8a9008f1-34f7-ecb8-9ccb-c129f56236ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hvf: Add missing break statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Chen Zhang <tgfbeta@me.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On 22/04/19 18:09, Philippe Mathieu-Daud=C3=A9 wrote:
> Oops... I'm surprised no compiler warned about this yet...
>=20
> This probably mean:
> - This code is not covered by Continuous Integration
> - Upstream maintainers are not building this code
> - Upstream is not running this code
>=20
> Please tell me I'm wrong!

Indeed I am not building or running this code since it requires a Mac.
I am thinking of adding a Patchew builder on macincloud, but I haven't
done it yet.

However, it is unlikely to be signaled by a compiler---maybe by
Coverity.  Probably the return value doesn't mean much to the rest of
the code, the "cpu->halted =3D 1" is what counts.  I have queued the patc=
h.

Paolo
