Received: from eggs.gnu.org ([2001:4830:134:3::10]:45586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQB2Z-0007ME-Ku
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQB2W-0007bx-EP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:21:47 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:58664 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQB2W-0007aB-0f
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:21:44 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
	<20170627175815.GA17639@flamenco>
Date: Wed, 28 Jun 2017 14:21:29 +0300
In-Reply-To: <20170627175815.GA17639@flamenco> (Emilio G. Cota's message of
	"Tue, 27 Jun 2017 13:58:15 -0400")
Message-ID: <878tkce4sm.fsf@frigg.lan>
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

> On Tue, Jun 27, 2017 at 12:52:00 +0300, Llu=C3=ADs Vilanova wrote:
>> Changes in v9
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Rebase on 931892e8a6.
>> * Undo renaming of tb->trace_vcpu_dstate to the shorter tb->trace_ds.
>> * Add measurements to commit enabling all guest events.

> I wanted to save you some time and sent a v9 yesterday with these
> same changes -- although I see some changes in my v8 didn't make it
> to your v9. For this iteration I only added more perf numbers to the
> last patch, see here:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05764.html

> 		E.

Woops, sorry about the duplicate effort.

I just dropped the rename of variable trace_ds, since I prefer names whose
purpose can be more easily understood. Other than that, I sent a new series=
 to
try to get a final review on the comments.


Thanks a lot,
  Lluis
