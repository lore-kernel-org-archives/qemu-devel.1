Received: from eggs.gnu.org ([2001:4830:134:3::10]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9s3C-0000Nm-Ri
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9s3C-0006HT-2b
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:27:50 -0400
References: <1539002382-3764-1-git-send-email-thuth@redhat.com>
	<038b8279-f8c1-4158-e750-93f981508aed@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27e18d16-4dc5-b6e5-fa79-4977203dcfe3@redhat.com>
Date: Tue, 9 Oct 2018 15:27:47 +0200
MIME-Version: 1.0
In-Reply-To: <038b8279-f8c1-4158-e750-93f981508aed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc/spapr_rng: Introduce
 CONFIG_SPAPR_RNG switch for spapr_rng.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

On 2018-10-09 13:45, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 08/10/2018 14:39, Thomas Huth wrote:
>> The spapr-rng device is suboptimal when compared to virtio-rng, so
>> users might want to disable it in their builds. Thus let's introduce
>> a proper CONFIG switch to allow us to compile QEMU without this device=
.
>> The function spapr_rng_populate_dt is required for linking, so move it
>> to a different location.
>=20
> Without CONFIG_SPAPR_RNG this function is not reachable, can you use a
> stub instead?

I'd like to avoid stubs if possible. stubs are fine if there is no easy
other solution, but they are a little bit confusing ("which of these
functions is now linked into the executable?"), so in case there is no
urgent need, it's IMHO way nicer to get along without them. In this
case, there is no real urgent need - the function is just small, and
does not have any other dependencies into the disabled code, so why
should we complicate things here and introduce a stub?

 Thomas
