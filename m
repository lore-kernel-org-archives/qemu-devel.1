Received: from eggs.gnu.org ([2001:4830:134:3::10]:45820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4jQK-0000iS-4e
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4jQF-0004DP-5b
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e4jQE-0004Cn-Uu
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:09:51 -0400
Date: Wed, 18 Oct 2017 16:09:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171018080947.GC9443@lemon>
References: <20170922074659.30097-1-famz@redhat.com>
	<20170922074659.30097-7-famz@redhat.com>
	<4c054496-5c79-e56f-cd23-4f27694b2934@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c054496-5c79-e56f-cd23-4f27694b2934@redhat.com>
Subject: Re: [Qemu-devel] [PULL 06/36] docker: Enable features explicitly in
 test-full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Mon, 10/02 16:21, Paolo Bonzini wrote:
> On 22/09/2017 09:46, Fam Zheng wrote:
> > Also avoid "set -e".
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Message-Id: <20170907141245.31946-3-famz@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>

Sorry for late reply, I've had a backlog due to holiday and KVM Forum.

> 
> This broke docker-test-full with at least Fedora and CentOS 6 images.  I
> wouldn't be surprised if some required packages do not even exist on
> CentOS 6.  Should it be reverted?

Packages not existing on CentOS 6 are supposed to be handled by "FEATURES" in
dockerfile and "requires" in test, but I suspect in this case the method scales,
the list will be cluttered and unmaintainable.

I'll send a reverting patch and continue hoping ./configure to detect features
automatically as before.

Fam
