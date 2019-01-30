Received: from eggs.gnu.org ([209.51.188.92]:56544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gon8z-0004BZ-K7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gon8y-00024v-T2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:30:57 -0500
Date: Wed, 30 Jan 2019 11:30:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190130113046.24c07704.cohuck@redhat.com>
In-Reply-To: <20190130004811.27372-26-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-26-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 25/73] s390x: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

On Tue, 29 Jan 2019 19:47:23 -0500
"Emilio G. Cota" <cota@braap.org> wrote:

> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/intc/s390_flic.c        |  2 +-
>  target/s390x/cpu.c         | 22 +++++++++++++++-------
>  target/s390x/excp_helper.c |  2 +-
>  target/s390x/kvm.c         |  2 +-
>  target/s390x/sigp.c        |  8 ++++----
>  5 files changed, 22 insertions(+), 14 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
