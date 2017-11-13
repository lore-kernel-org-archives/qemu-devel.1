Received: from eggs.gnu.org ([2001:4830:134:3::10]:35767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eEGED-000535-SB
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eEGEC-0001IT-W8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:00:49 -0500
Date: Mon, 13 Nov 2017 23:00:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171113145942.GA29617@lemon>
References: <151056619347.390.15270351875314848925@bafd83ae6430>
	<0241ad8e-dd22-a029-5918-62ed4c49cf47@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0241ad8e-dd22-a029-5918-62ed4c49cf47@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/make-release: No need to delete
 pixman/.git anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org

On Mon, 11/13 10:48, Thomas Huth wrote:
> > 077         - output mismatch (see 077.out.bad)
> > --- /tmp/qemu-test/src/tests/qemu-iotests/077.out	2017-11-13 09:38:59.000000000 +0000
> > +++ /tmp/qemu-test/build/tests/qemu-iotests/077.out.bad	2017-11-13 09:41:20.601278693 +0000
> > @@ -56,9 +56,9 @@
> >  wrote XXX/XXX bytes at offset XXX
> >  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  blkdebug: Resuming request 'B'
> > +blkdebug: Resuming request 'A'
> >  wrote XXX/XXX bytes at offset XXX
> >  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -blkdebug: Resuming request 'A'
> >  wrote XXX/XXX bytes at offset XXX
> >  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  wrote XXX/XXX bytes at offset XXX
> That's certainly *not* caused by my patch. Is this already a known
> problem? Otherwise, Fam, could you please have a look at this?

I will try to fix the test.

Fam
