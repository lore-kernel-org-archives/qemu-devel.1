Received: from eggs.gnu.org ([2001:4830:134:3::10]:58662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbHg-0008Gq-RL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbHf-0001eR-Sa
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:53:56 -0400
Date: Mon, 23 Jul 2018 15:53:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180723135345.GF8817@localhost.localdomain>
References: <20180713071033.15938-1-kwolf@redhat.com>
	<b444806b-61da-9930-f0cb-7610d241a16e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b444806b-61da-9930-f0cb-7610d241a16e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Use host_device instead of
 file in 149
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

Am 13.07.2018 um 20:12 hat John Snow geschrieben:
> 
> 
> On 07/13/2018 03:10 AM, Kevin Wolf wrote:
> > The test case uses block devices with driver=file, which causes the test
> > to fail after commit 230ff73904 added a deprecation warning for this.
> > Fix the test case to use driver=host_device and update the reference
> > output accordingly.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> 149         [not run] requires password-less sudo access: sudo: a
> password is required
> 
> Ah, this one hides from regression scripts quite well...
> 
> This test fails both before and after this patch for me, with
> 
> +Traceback (most recent call last):
> +  File "149", line 525, in <module>
> +    test_once(config, qemu_img=False)
> +  File "149", line 336, in test_once
> +    cryptsetup_open(config)
> +  File "149", line 200, in cryptsetup_open
> +    cryptsetup(args, password)
> +  File "149", line 124, in cryptsetup
> +    raise Exception(msg)
> +Exception: Device qiotest-145-twofish-128-xts-plain64-sha1 already exists.
> +Command failed with code 17: File exists
> 
> Am I missing some prerequisite, maybe?

Hm, sounds a bit like a failed first attempt that didn't clean up behind
itself properly? Just guessing though.

Kevin
