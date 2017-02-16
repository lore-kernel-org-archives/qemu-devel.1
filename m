Received: from eggs.gnu.org ([2001:4830:134:3::10]:39209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cePXc-0000z8-Dg
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cePXY-0004Lc-6a
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:08:24 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cePXX-0004KP-Vb
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:08:20 -0500
Received: by mail-wr0-x241.google.com with SMTP id c4so2802099wrd.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:08:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAJSP0QWX0_stkyrkyL42QFFnnBTaqYD+XYmpMBO0gY2pWFD53g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e09a1327-cf6b-0b65-5f66-591481fbfb34@redhat.com>
Date: Thu, 16 Feb 2017 18:08:22 +0100
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org



On 16/02/2017 16:30, Stefan Hajnoczi wrote:
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

Yes, it's possible.  The existing rules cover URLs that start with
uppercase, linking them to either the handful of pages in the website,
or to wiki.qemu-project.org as a fallback.

Paolo
