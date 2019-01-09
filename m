Received: from eggs.gnu.org ([209.51.188.92]:41833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghLNL-0006MC-KU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghLNH-0001AY-Uf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:26:58 -0500
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-3-git-send-email-thuth@redhat.com>
	<f1d83216-d9a8-605b-d87b-be6b96f42557@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c965133d-f26d-3dba-81ed-1c87038e9b35@redhat.com>
Date: Wed, 9 Jan 2019 22:26:27 +0100
MIME-Version: 1.0
In-Reply-To: <f1d83216-d9a8-605b-d87b-be6b96f42557@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] configure: Force the C standard to
 gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

On 09/01/19 19:10, Philippe Mathieu-Daud=C3=A9 wrote:
> Using '-std=3Dgnu++98' for g++ v4.8 looks like a good compromise to the
> issues Daniel mentioned (still 'experimental').
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

C++11 has many new features that almost make it an entirely different
language (the main being rvalue references, and type inference with auto
and decltype).  If it works for GCC 4.8, I would prefer using that
instead of g++98.

Paolo
