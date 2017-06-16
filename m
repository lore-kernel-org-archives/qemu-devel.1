Received: from eggs.gnu.org ([2001:4830:134:3::10]:52565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLtmJ-00012a-9F
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLtmI-0000iB-Cy
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:07:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dLtmI-0000i2-6Z
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:07:18 -0400
Date: Sat, 17 Jun 2017 00:07:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170616160711.GA20922@lemon.lan>
References: <20170615152852.GB2399@work-vm>
	<6e150052-91ca-d260-b0e9-6894f93fc15d@redhat.com>
	<CAFEAcA_pEkfR9w9+oES=965dkDBCo=2yAyWEQ_eujfcyu1XQ-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_pEkfR9w9+oES=965dkDBCo=2yAyWEQ_eujfcyu1XQ-w@mail.gmail.com>
Subject: Re: [Qemu-devel] ahci-test failures with 'Failed to get "write"
 lock'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 06/16 10:23, Peter Maydell wrote:
> On 15 June 2017 at 17:16, John Snow <jsnow@redhat.com> wrote:
> > On 06/15/2017 11:28 AM, Dr. David Alan Gilbert wrote:
> >> Hi,
> >>   Peter noticed that there were some hangs in the ahci-test;
> >> I can reproduce them on my laptop as long as the laptop has
> >> some other load on it (a few md5sum /dev/zero's help).
> >>
> >> /x86_64/ahci/flush/migrate: qemu-system-x86_64: Failed to get "write" lock
> >> Is another process using the image?
> >> OK
> >> /x86_64/ahci/migrate/sanity: qemu-system-x86_64: Failed to get "write" lock
> >> Is another process using the image?
> >>
> >> and that hangs in sanity.
> >>
> >> That seems to be the common case, I've also had one:
> >>
> >> /x86_64/ahci/migrate/ncq/halted: qemu-system-x86_64: Failed to get "write" lock
> >> Is another process using the image?
> >> qemu-system-x86_64: /home/dgilbert/git/qemu/block/io.c:1352: bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed.
> >>
> >>
> >> Neither of these always fail.
> 
> > Haven't observed myself and I run the tests pretty frequently. I'll keep
> > an eye out. I see many similar problems in iotests for other areas, too.
> 
> If we can figure out this quickly that would be good -- it's
> causing my build tests to fail often enough that I'm a bit
> reluctant to try to merge more pull requests until we've
> squished this bug...

I have posted a patch:

[PATCH] migration: Fix race of image locking between src and dst

(You are Cc'ed)

Fam
