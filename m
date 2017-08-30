Received: from eggs.gnu.org ([2001:4830:134:3::10]:48507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn0wl-0000ls-Rw
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn0wh-0000jX-PG
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn0wh-0000jJ-Ip
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:14:07 -0400
Date: Wed, 30 Aug 2017 13:14:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170830131403.57042d42.cohuck@redhat.com>
In-Reply-To: <20170829204759.6853-1-richard.henderson@linaro.org>
References: <20170829204759.6853-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/8] tcg/s390 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de

On Tue, 29 Aug 2017 13:47:51 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> This finally converts s390 to the tcg_target_op_def function, which
> allows constraints to vary at runtime.  Once we have that, we can
> 
> (1) Perform some facilities checks once during startup instead of
>     every time we evaluate the constraint,
> (2) Use the distinct-operands facility from z196.
> 
> In addition, two cleanups to the setcond expansion
> 
> (3) Use the load-on-condition-2 facility from z13,
> (4) Use a smaller expansion for LE/LEU using SLBGR.
> 
> I wrote these after soft freeze and before I changed jobs, so it has
> seen some testing.  Unfortunately, I no longer have access to s390
> hardware, so I'd appreciate it if someone could re-test this rebase.

FWIW, this passes my smoketests.

Looking at the patches now...
