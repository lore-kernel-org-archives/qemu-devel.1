Received: from eggs.gnu.org ([2001:4830:134:3::10]:51775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dnSN9-0001pk-Sl
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dnSN4-0004FL-8c
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1dnSN4-0004F6-2x
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:31:10 -0400
Date: Thu, 31 Aug 2017 18:31:02 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170831163102.qqb45avu5wtz6nv6@eukaryote>
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
	<09158e7a-0c19-1573-5eaf-e90eed0b59ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09158e7a-0c19-1573-5eaf-e90eed0b59ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Aug 31, 2017 at 11:06:55AM -0500, Eric Blake wrote:
> On 08/31/2017 06:22 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/docker/test-block | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100755 tests/docker/test-block
> 
> 
> > +cd "$BUILD_DIR"
> > +
> > +build_qemu --target-list=x86_64-softmmu
> > +cd tests/qemu-iotests
> > +./check -raw
> > +./check -qcow2
> 
> Should we also run ./check -nbd?

FWIW, yes, if it's not too onerous.  Not least because many of the
NBD-using block layer features are important storage virtualization
features for management layers.

-- 
/kashyap
