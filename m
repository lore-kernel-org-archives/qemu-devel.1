Received: from eggs.gnu.org ([209.51.188.92]:58682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJz63-0004UB-50
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJz61-00010p-OZ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:32:51 -0400
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-11-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <71955bba-ef04-1677-b7f0-bb1675bad12a@redhat.com>
Date: Fri, 26 Apr 2019 13:32:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190426111003.21246-11-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/10] s390x/cpumodel: wire up 8561 and
 8562 as gen15 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 26.04.19 13:10, Christian Borntraeger wrote:
> 8561 and 8562 will be gen15 machines. There is no name yet, lets us use
> the cpu id as base name. Later on we can provide aliases with the prope=
r
> name.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index d683635eb5..dd6415103f 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -83,6 +83,8 @@ static S390CPUDef s390_cpu_defs[] =3D {
>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>      CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"=
),
>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Mod=
el ZR1 GA1"),
> +    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "8561", "IBM 8561 GA1"=
),
> +    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "8562", "IBM 8562 GA1"=
),
>  };

Thinking out loud, I know that official names are not published yet.
Looking at the recent history (z13, z14), my educated guess would be
z15. I guess pretty much everybody would guess that.

So I wonder if using "z15" and e.g. "z15ZR1" or "z15s" would be easier
to have, although in the end maybe not correct (whatever names smart
people are able to come up with, history told us that consistent naming
does not seem to be one of the core strengths of CPU marketing people in
general).

So if we need aliases either way, and z15 is easier to understand than
"8561" for any user, what about going forward with that and introducing
actual alias later on? We can tag the names to be inofficial.

CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "z15", "Inofficial name for
gen15 model 1 GA1 (8561)"),
CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "z15ZR1", "Inofficial name
for gen15 model 2 GA1 (8562)"),

(please don't eat me alive)

--=20

Thanks,

David / dhildenb
