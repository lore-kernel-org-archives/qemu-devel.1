Received: from eggs.gnu.org ([2001:4830:134:3::10]:59467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chEpS-0007rw-73
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chEpP-0004JI-24
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:18:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1chEpO-0004IF-Qh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:18:26 -0500
References: <20170223105922.22989-1-berrange@redhat.com>
	<57a2a646-cce2-2b65-bce5-793ffaa1ec9b@redhat.com>
	<20170223120720.GM10047@redhat.com>
	<bbca2b55-aeba-8e46-cdfc-2552af587c47@redhat.com>
	<20170224092416.GE3702@redhat.com> <20170224121217.GH2435@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64d3da43-9ff6-e448-fb40-13fbe367e27a@redhat.com>
Date: Fri, 24 Feb 2017 13:18:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170224121217.GH2435@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 24/02/2017 13:12, Dr. David Alan Gilbert wrote:
>> Ok, yeah, it makes sense that the compiler can optimize that away without
>> volatile. I wonder if adding volatile has much of a performance impact on
>> this loop...
> I don't think we have anything else in QEMU to do it (other than atomic's
> but we don't need this to be atomic).   I don't think the use of memset()
> helps, because the compiler is free to optimise that out as well; so
> I think 'volatile' is a reasonable use (although I seem to have a soft-spot
> for volatile and I know everyone else tells me I'm mad).

Yes, I think it is fine to use volatile here.

Paolo
