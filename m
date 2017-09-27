Received: from eggs.gnu.org ([2001:4830:134:3::10]:43547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dx6cy-0000ZK-S5
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dx6cv-0006lK-O2
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:19:28 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:45234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dx6cv-0006kr-Io
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:19:25 -0400
Received: by mail-wm0-f52.google.com with SMTP id q124so14669339wmb.0
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 00:19:24 -0700 (PDT)
References: <20170926111757.3628-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f50b7bb-bbf7-7e0e-754a-234d4244fb72@redhat.com>
Date: Wed, 27 Sep 2017 09:19:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170926111757.3628-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] qemu-firmware repo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 26/09/2017 13:17, Gerd Hoffmann wrote:
> 
> Ok, we want for varios reasons separate the firmware from the main
> qemu repo.  Here is my attempt to create such a repo.  For starters
> only seabios has been added here.
> 
> You can find the repo with currently three patches here:
>     https://www.kraxel.org/cgit/qemu-firmware/
> 
> This "series" is only patch #2 of the repo.  Havn't found a way to
> convince git-format-patch to include the initial commit of a repo.
> But patch #1 (the initial commit) only adds the seabios submodule,
> patch #3 adds the binary blobs, so patch #2 actually is the most
> interesting one.

Are you planning to include only submodules, or also "QEMU-native"
firmware such as linuxboot, kvmvapic, s390-ccw, spapr-rtas, etc.?

Thanks,

Paolo
