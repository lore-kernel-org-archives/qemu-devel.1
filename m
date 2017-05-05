Received: from eggs.gnu.org ([2001:4830:134:3::10]:58361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Yz0-0008CQ-Eq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Yyu-0001QM-Vw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:53:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6Yyu-0001PC-Q7
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:52:56 -0400
Date: Fri, 5 May 2017 16:52:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170505085252.GD21435@lemon.lan>
References: <20170505032340.26467-1-famz@redhat.com>
	<03beb071-ebbc-4328-3530-37b9856476cc@redhat.com>
	<20170505080513.GC21435@lemon.lan>
	<d75dec74-8cce-cad9-6e47-4fae5fa415ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75dec74-8cce-cad9-6e47-4fae5fa415ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Fri, 05/05 10:07, Paolo Bonzini wrote:
> 
> 
> On 05/05/2017 10:05, Fam Zheng wrote:
> >> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> >>
> >> For patch 5, I think we should revive the "quick" qemu-iotests group
> >> (maybe we can have support for skipping groups, and have a "slow" group
> >> with the very few tests that take >30 seconds?) and add the quick tests
> >> to "make check".
> > Sounds like a good idea, but for a separate series, IMO.
> > 
> > The idea of the new test-block is to include all qemu-iotests tests.  I only
> > added raw and qcow2 because vmdk etc. fails case 181. I could use "-x" but
> > that's a bit ugly - they can wait for the fix.
> 
> I think that would still be a bit too slow for patchew?

We have ~1 hour between each series, this one is not slower than the current
docker build tests, so I think it's fine - we can make it run in parallel, like
in the case of the s390x build.

Fam
