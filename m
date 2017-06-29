Received: from eggs.gnu.org ([2001:4830:134:3::10]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQT3N-0002Aa-1r
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQT3J-00023N-U6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:35:49 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:44881)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQT3J-000239-Hc
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:35:45 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
	<20170627175815.GA17639@flamenco> <878tkce4sm.fsf@frigg.lan>
	<20170628230725.GA9893@flamenco>
Date: Thu, 29 Jun 2017 09:35:32 +0300
In-Reply-To: <20170628230725.GA9893@flamenco> (Emilio G. Cota's message of
	"Wed, 28 Jun 2017 19:07:25 -0400")
Message-ID: <87tw2z713f.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 0/7] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Emilio G Cota writes:

> On Wed, Jun 28, 2017 at 14:21:29 +0300, Llu=C3=ADs Vilanova wrote:
>> Emilio G Cota writes:
>> > I wanted to save you some time and sent a v9 yesterday with these
>> > same changes -- although I see some changes in my v8 didn't make it
>> > to your v9. For this iteration I only added more perf numbers to the
>> > last patch, see here:
>> >   https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05764.html
>>=20
>> Woops, sorry about the duplicate effort.
>>=20
>> I just dropped the rename of variable trace_ds, since I prefer names who=
se
>> purpose can be more easily understood.

> - I think trace_vcpu_dstate is way too long (IMO a short name + a comment
>   in the struct is better).

> - You missed a change I made to patch 3:
>> [cota: use CPU_TRACE_DSTATE_MAX_EVENTS instead of trace_get_vcpu_event_c=
ount()]
>   Was that intentional?

No it wasn't. I'll look into it for the next series.


> - Would be nice to include the perf numbers I got, along with yours.

I'll add them to the cover and commit message.


Thanks,
  Lluis
