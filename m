Received: from eggs.gnu.org ([2001:4830:134:3::10]:49650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDVUJ-0001HU-T4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDVUG-000316-MR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:10:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDVUG-00030W-Bn
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:10:48 -0400
Date: Fri, 19 Oct 2018 10:10:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181019141046.GA7279@flamenco>
References: <1539946806-695-1-git-send-email-thuth@redhat.com>
	<4837dc8a-c4a7-9bd8-649a-3b35b0fe20fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4837dc8a-c4a7-9bd8-649a-3b35b0fe20fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/migration-test: Disable s390x test
 when running with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Wei Huang <wei@redhat.com>, david@redhat.com, Cornelia Huck <cohuck@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Fri, Oct 19, 2018 at 13:14:57 +0200, Laurent Vivier wrote:
> On 19/10/2018 13:00, Thomas Huth wrote:
> > The migration test for s390x sometimes hangs when running with TCG,
> > similar to the problems that we have already observed with TCG for
> > the ppc64 guests. Thus disable the s390x test when we are not running
> > with KVM for now until the problem with TCG has been resolved.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks!

		E.
