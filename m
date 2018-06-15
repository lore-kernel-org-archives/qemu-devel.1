Received: from eggs.gnu.org ([2001:4830:134:3::10]:34070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTvQY-0005ji-2n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTvQT-00079h-7E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTvQT-000798-0l
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:34:29 -0400
Date: Fri, 15 Jun 2018 17:34:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180615203425.GF7451@localhost.localdomain>
References: <20180614154357.20132-1-tamiko@43-1.org>
	<20180614154357.20132-2-tamiko@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614154357.20132-2-tamiko@43-1.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Maier <tamiko@43-1.org>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

On Thu, Jun 14, 2018 at 10:43:56AM -0500, Matthias Maier wrote:
> This commit removes the PYTHON_UTF8 workaround. The problem with setting
> 
>   LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8
> 
> is that the en_US.UTF-8 locale might not be available. In this case
> setting above locales results in build errors even though another UTF-8
> locale was originally set [1]. The only stable way of fixing the
> encoding problem is by explicitly annotating encoding/decoding in the
> python script.

Thanks for the patches.  It's nice to see that hack go away.

Patch 2/2 is necessary to make the removal of PYTHON_UTF8 safe,
correct?  In that case, I plan to reverse the order of the
patches before applying.

> 
> [1] https://bugs.gentoo.org/657766
[...]

-- 
Eduardo
