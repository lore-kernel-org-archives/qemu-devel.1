Received: from eggs.gnu.org ([2001:4830:134:3::10]:35176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxOOC-0000Ja-1k
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 21:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxOOB-0006Xn-0u
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 21:45:08 -0400
Date: Mon, 10 Apr 2017 09:44:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170410014455.GB15038@lemon>
References: <1491741460-10308-1-git-send-email-lidongchen@tencent.com>
	<20170410005142.GA14050@lemon>
	<CAOGPPbdkQnTU66wpFcuF7oF4_LcUUED2z7aaBZwMNLjqpLLdGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbdkQnTU66wpFcuF7oF4_LcUUED2z7aaBZwMNLjqpLLdGQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Mon, 04/10 09:10, 858585 jemmy wrote:
> >> +                        if (ret < 0) {
> >> +                            g_free(buf);
> >> +                            return ret;
> >> +                        }
> >
> > This if block is not necessary because...
> 
> Hi Fam:
>       It's necessary to check each cluster is written successfully.
>       if we remove this if block, it maybe ignore some error, and only check
>       the last cluster.
>       Thanks.

Yes, I missed the fact it is in the loop body. My bad. Thanks for pointint out:

Reviewed-by: Fam Zheng <famz@redhat.com>
