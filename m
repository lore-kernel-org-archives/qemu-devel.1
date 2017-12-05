Received: from eggs.gnu.org ([2001:4830:134:3::10]:52179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMEwa-0000Xy-0H
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMEvV-00086a-VG
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:15:32 -0500
Date: Tue, 5 Dec 2017 16:14:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171205161424.0e51ce1b.cohuck@redhat.com>
In-Reply-To: <20171204140150.20483-8-david@redhat.com>
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 7/9] s390x/tcg: implement
 extract-CPU-time facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon,  4 Dec 2017 15:01:48 +0100
David Hildenbrand <david@redhat.com> wrote:

> It only provies the EXTRACT CPU TIME instruction. We can reuse the stpt

s/provies/provides/

> helper, which calculates the CPU timer value.
> 
> As the instruction is not priviledged, but we don't have a CPU timer

s/priviledged/privileged/

> value in case of linux user, we simply fake the CPU timer to be 0.

There's probably nothing else we could do.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c  |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/translate.c   | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
