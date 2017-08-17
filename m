Received: from eggs.gnu.org ([2001:4830:134:3::10]:36445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diK7O-0006bJ-Ef
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diK7L-0000Lo-TM
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diK7L-0000LV-NI
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:41:43 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-11-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8511f043-aafb-77b4-cce4-9290451d25a9@redhat.com>
Date: Thu, 17 Aug 2017 14:41:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 10/10] target/s390x: cleanup
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 17.08.2017 11:22, David Hildenbrand wrote:
> Let's reshuffle the function prototypes so we get a cleaner outline
> of the files.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 140 ++++++++++++++++++++++++++-------------------=
--------
>  1 file changed, 69 insertions(+), 71 deletions(-)

Not sure whether this code churn here is really worth the effort ... I'd
prefer to introduce file-specific headers for the prototypes instead,
e.g. helper.h, mmu_helper.h, etc. ... but that's just my 0.02 =E2=82=AC .=
.. I
also won't object if this patch gets included as is.

 Thomas
