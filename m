Received: from eggs.gnu.org ([2001:4830:134:3::10]:41877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ceOEJ-0005rN-9o
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ceOEG-0003qj-87
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:44:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ceOEG-0003pi-2T
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:44:20 -0500
References: <CAJSP0QWX0_stkyrkyL42QFFnnBTaqYD+XYmpMBO0gY2pWFD53g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d7ff20f6-c3e2-2464-b1c9-088b435ae30a@redhat.com>
Date: Thu, 16 Feb 2017 16:44:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWX0_stkyrkyL42QFFnnBTaqYD+XYmpMBO0gY2pWFD53g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Missing rewrite rule for qemu.org/images/ links
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, jcody@redhat.com
Cc: qemu-devel@nongnu.org

On 16.02.2017 16:30, Stefan Hajnoczi wrote:
> Hi Jeff,
> The old qemu.org/images/ links are not being rewritten to
> wiki.qemu-project.org/images/.
> 
> For example, http://www.qemu-project.org/images/4/4e/Q35.pdf no longer works:
> https://bugs.launchpad.net/qemu/+bug/1665344
> 
> I do notice that qemu.org/Features/Q35 is working.  Is it possible to
> set up a rewrite rule or HTTP redirect so existing /images/ links keep
> working?

I think at one point in time, we should likely go over the whole wiki
page with a link checker (like https://validator.w3.org/checklink) and
fix all broken links ... it's not only about the /images/, there are
likely a lot of other broken links that nobody ever updated within the
past years...

 Thomas
