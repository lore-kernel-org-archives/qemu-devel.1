Received: from eggs.gnu.org ([2001:4830:134:3::10]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNU1-0004Ht-8q
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNTy-0008Hb-3q
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:15:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezNTx-0008HS-Vr
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:15:50 -0400
Date: Fri, 23 Mar 2018 22:15:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180323141536.GR32362@xz-mi>
References: <20180323140821.28957-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180323140821.28957-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Mar 23, 2018 at 10:08:17PM +0800, Peter Xu wrote:
> Temporarily disable OOB for 2.12 since it break (a lot of) things.
> Luckily it's only a switch so not so hard. Meanwhile, revert all new
> tests that checks against it.
> 
> Tests done: all target builds and "make check" passed, but only on
> x86_64 host.  It can pass all "raw" iotests, but some "qcow2" iotests
> are still failing.  I can even reproduce many of the qcow2 fails even
> before the whole OOB series, so I suppose that's something already
> exists so I'll ignore.
> 
> More tests are really welcomed.  Thanks,

CC Eric Blake too.

-- 
Peter Xu
