Received: from eggs.gnu.org ([2001:4830:134:3::10]:34444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Afv-00058C-EO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 20:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Afs-0007do-Ap
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 20:19:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d3Afs-0007db-4r
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 20:19:16 -0400
Date: Wed, 26 Apr 2017 08:19:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170426001912.GA4275@lemon.lan>
References: <20170411122632.14050-1-famz@redhat.com>
	<20170411122632.14050-11-famz@redhat.com>
	<CAFEAcA81QghtjkwCP=KywhMx-ruxnXSRHVZ6oHpX3e5mnwZNBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA81QghtjkwCP=KywhMx-ruxnXSRHVZ6oHpX3e5mnwZNBw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 10/11] block: Fix bdrv_co_flush early return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 04/25 16:00, Peter Maydell wrote:
> 
> Coverity points out that there's a problem here -- we call
> bdrv_inc_in_flight(bs), which assumes bs is not NULL, before
> we do the test for whether bs is NULL.
> 
> Presumably the NULL check needs to be pulled up earlier in
> the function?
> 

Yes, will take care of this one.

Fam
