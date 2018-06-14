Received: from eggs.gnu.org ([2001:4830:134:3::10]:34905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRj5-0005Hq-2K
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRj1-0001Hl-3c
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:51:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTRj0-0001HV-Uv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:51:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-3-peterx@redhat.com>
	<87r2lbkt5u.fsf@dusky.pond.sub.org>
	<dfb61dcd-c180-1307-bf9d-086aa15478ec@redhat.com>
Date: Thu, 14 Jun 2018 14:51:30 +0200
In-Reply-To: <dfb61dcd-c180-1307-bf9d-086aa15478ec@redhat.com> (Auger Eric's
	message of "Wed, 13 Jun 2018 11:36:05 +0200")
Message-ID: <874li5leel.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] intel-iommu: start to use
 error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Auger Eric <eric.auger@redhat.com> writes:

> Hi,
> On 06/13/2018 10:05 AM, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>>> Replace existing trace_vtd_err() with error_report_once() then stderr
>>> will capture something if any of the error happens, meanwhile we don't
>>> suffer from any DDOS.  Then remove the trace point.  Since at it,
>>> provide more information where proper (now we can pass parameters into
>>> the report function).
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  hw/i386/intel_iommu.c | 59 ++++++++++++++++++++++++-------------------
>>>  hw/i386/trace-events  |  1 -
>>>  2 files changed, 33 insertions(+), 27 deletions(-)
>>=20
>> Michael, would you give your Reviewed-by or Acked-by?  I'd take the
>> series through my tree then.
>>=20
>> [...]
>>=20
> Sorry to enter this thread at this late stage. Just one question: on the
> smmuv3 emulation code, Peter (Maydell) urged me to use
> qemu_log_mask(LOG_GUEST_ERROR, ...) whenever the error was triggered by
> a guest bad behavior. So what is the final guidance to avoid the DOS you
> mention?

Does the user need to know about the error condition?

If yes, we should tell him.  Logging is not telling.

Peter, what do you think?
