Received: from eggs.gnu.org ([2001:4830:134:3::10]:38453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpu71-0006oX-AU
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpu6v-0002Gu-Ux
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:37:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpu6u-0002Eq-Rz
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:37:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180815095328.32414-1-peterx@redhat.com>
	<20180815095328.32414-3-peterx@redhat.com>
Date: Wed, 15 Aug 2018 13:37:04 +0200
In-Reply-To: <20180815095328.32414-3-peterx@redhat.com> (Peter Xu's message of
	"Wed, 15 Aug 2018 17:53:27 +0800")
Message-ID: <87zhxnlv33.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/3] intel-iommu: start to use
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Replace existing trace_vtd_err() with error_report_once() then stderr
> will capture something if any of the error happens, meanwhile we don't
> suffer from any DDOS.  Then remove the trace point.  Since at it,
> provide more information where proper (now we can pass parameters into
> the report function).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

You lost
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Happy to restore it when I apply.
