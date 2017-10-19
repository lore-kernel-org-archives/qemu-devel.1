Received: from eggs.gnu.org ([2001:4830:134:3::10]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5523-0003G7-Ip
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5520-0004PG-Dn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:14:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e5520-0004O1-7r
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:14:16 -0400
Message-ID: <1508397252.10073.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Oct 2017 09:14:12 +0200
In-Reply-To: <19f64376-dcae-7185-110f-9970299666b2@redhat.com>
References: <20171016131644.9565-1-kraxel@redhat.com>
	<19f64376-dcae-7185-110f-9970299666b2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/11] Ui 20171016 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

  Hi,

> I just noticed that I now get the following warning message when I
> change to an older git branch:
> 
> warning: unable to rmdir ui/keycodemapdb: Directory not empty
> 
> ... this is kind of ugly, is there a way to fix this?

Hmm, no good idea, other than just rebasing the branch to latest
master.  It's one of the issues with submodules.

Related issue shows up if you go back to an older branch after a
firmware update.  git shows the firmware submodule as modified then and
you have to take care that you don't revert the change by accident. 
Which can easily happen with "git commit -a" ...

cheers,
  Gerd
