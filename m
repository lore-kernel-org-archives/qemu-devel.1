Received: from eggs.gnu.org ([2001:4830:134:3::10]:48270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT0mz-0004tf-04
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT0mt-0001jE-BQ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:05:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fT0mt-0001im-72
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:05:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-3-peterx@redhat.com>
Date: Wed, 13 Jun 2018 10:05:49 +0200
In-Reply-To: <20180524044454.11792-3-peterx@redhat.com> (Peter Xu's message of
	"Thu, 24 May 2018 12:44:54 +0800")
Message-ID: <87r2lbkt5u.fsf@dusky.pond.sub.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Peter Xu <peterx@redhat.com> writes:

> Replace existing trace_vtd_err() with error_report_once() then stderr
> will capture something if any of the error happens, meanwhile we don't
> suffer from any DDOS.  Then remove the trace point.  Since at it,
> provide more information where proper (now we can pass parameters into
> the report function).
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 59 ++++++++++++++++++++++++-------------------
>  hw/i386/trace-events  |  1 -
>  2 files changed, 33 insertions(+), 27 deletions(-)

Michael, would you give your Reviewed-by or Acked-by?  I'd take the
series through my tree then.

[...]
