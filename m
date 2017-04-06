Received: from eggs.gnu.org ([2001:4830:134:3::10]:34146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw31a-0007Tv-5C
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw31W-0004u4-8T
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cw31W-0004tn-2e
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:44:10 -0400
Date: Thu, 6 Apr 2017 16:44:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170406084403.GY3981@pxdev.xzpeter.org>
References: <CAGKXQyc66XzTKFK9YsPFLiw2OqNBiYtDj33jU9-1t3tdcdGjDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGKXQyc66XzTKFK9YsPFLiw2OqNBiYtDj33jU9-1t3tdcdGjDg@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu_file_rate_limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Apr 06, 2017 at 12:43:16PM +0430, ali saeedi wrote:
> Hi
> what does 'qemu_file_rate_limit' function do?
> thanks

It returns 1 if the stream is not full (so that we can continue send
something), otherwise 0.

Generally, it's used like:

  if (qemu_file_rate_limit(f)) {
      /* we can still send something to the stream since it's not full */
  } else {
      /*
       * either the stream is broken, or we have already sent enough
       * data, so that it's reaching the limit we set via
       * qemu_file_set_rate_limit(). We should not send anything now.
       */
  }

And I would suggest avoid sending the same topic in two days. :)

-- peterx
