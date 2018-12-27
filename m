Received: from eggs.gnu.org ([208.118.235.92]:39828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gcTjd-0008Nb-MT
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gcTjZ-0004DI-OK
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:21:53 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:37719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gcTjZ-00046m-Ei
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:21:49 -0500
Received: by mail-lj1-x22c.google.com with SMTP id t18-v6so15992379ljd.4
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 03:21:49 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 27 Dec 2018 14:21:34 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201812271421.34926.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] Qemu the right way -[Subthread Cores]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liebrecht@grossmann-venter.com, qemu-devel@nongnu.org

> Since I do not have networking sorted out yet I cannot update win7 pro, and it 
might be the updates which are needed for allowing more than two cpus.

hm, brief search on my side resulted in this tip:

https://answers.microsoft.com/en-us/windows/forum/windows_7-hardware/windows-7-professional-x64-only-showing-2-of-8/0155f525-df73-4642-a828-21b80d1564b0

----------
Some recommendations (in Windows, make sure you are running as Administrator):
 
- Run MSConfig -> Change to Boot tab -> Advanced Options -> "Number of 
Processors", make sure there is no check mark.
- Delete processor entries listed in Device Manager, then reboot.

-------------

(I don't think BIOS options from this answer really apply directly to qemu case)

also, if win (or some applications inside it) keep crashing with -cpu host, you 
can try to reload host (Linux) kvm module with additional option:

"options kvm ignore_msrs=1" line (without quotes) should be added to
 /etc/modprobe.d/kvm.conf

from 
https://www.passmark.com/forum/performancetest/4748-startup-error-number-4-on-qemu-bsod
