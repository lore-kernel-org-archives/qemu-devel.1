Received: from eggs.gnu.org ([2001:4830:134:3::10]:60345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gD7eO-0006dX-Tb
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gD7eK-0005oB-Rt
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:43:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gD7eI-0005hq-Vc
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:43:35 -0400
Date: Thu, 18 Oct 2018 08:43:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181018124328.GA1040@flamenco>
References: <20181011192513.63634-1-dgilbert@redhat.com>
	<20181011192513.63634-3-dgilbert@redhat.com>
	<20181017192826.GA7385@flamenco>
	<286c9ba0-05d9-02ec-7f59-34b34a66be2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286c9ba0-05d9-02ec-7f59-34b34a66be2c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 2/7] tests/migration: Enable the migration
 test on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, wei@redhat.com, i.maximets@samsung.com, den@openvz.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, Oct 18, 2018 at 14:38:01 +0200, Thomas Huth wrote:
> On 2018-10-17 21:28, Emilio G. Cota wrote:
> > Can anyone reproduce this? Otherwise, let me know what other info
> > I could provide.
> 
> I've finally been able to reproduce it - seems like it only happens here
> when the host is under heavy load.
> 
> ... not sure whether I've got time to debug this before KVM forum, so if
> it bugs you, feel free to send a patch to disable the test in
> tests/Makefile.include for s390x again.

Glad you could reproduce! I'll disable the test locally for now.

Thanks,

		Emilio
