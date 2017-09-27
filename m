Received: from eggs.gnu.org ([2001:4830:134:3::10]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx89t-0002Hc-8a
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx89o-0002hV-EV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dx89o-0002gy-9Q
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:57:28 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170925112917.21340-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 25 Sep 2017 12:29:12 +0100")
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Sep 2017 10:57:28 +0200
Message-ID: <8760c4cydj.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/6] migration: pre_save return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Modify the pre_save method on VMStateDescription to return an int
> rather than void so that it potentially can fail.
>
> Changed zillions of devices to make them return 0; the only
> case I've made it return non-0 is hw/intc/s390_flic_kvm.c that already
> had an error_report/return case.
>
> Note: If you add an error exit in your pre_save you must emit
> an error_report to say why.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
