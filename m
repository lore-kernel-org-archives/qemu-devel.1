Received: from eggs.gnu.org ([2001:4830:134:3::10]:44592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCd6d-000054-8C
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 22:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCd6a-0003Vz-3S
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 22:02:15 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:45314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eCd6Z-0003Vk-Rw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 22:02:12 -0500
Received: by mail-pg0-x22f.google.com with SMTP id l19so1009603pgo.2
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 19:02:10 -0800 (PST)
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <354b203c-e051-78ef-c60a-0a1004ba0615@ozlabs.ru>
Date: Thu, 9 Nov 2017 14:02:04 +1100
MIME-Version: 1.0
In-Reply-To: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

On 08/11/17 20:57, Thomas Huth wrote:
> 
> That automatic git submodule stuff now broke my workflow again. I
> usually keep the git repository on my laptop and then simply rsync the
> sources (without .git directories) to my target machine to compile it
> there. Used to work great for years. Now it's broken, the build process
> complains:
> 
> GIT submodule checkout is out of date. Please run
>   scripts/git-submodule.sh update
> from the source directory checkout /home/thuth/devel/qemu
> 
> Running "scripts/git-submodule.sh update" did not fix the issue at all -
> I first had to tinker with it for a while to find out that I simply have
> to delete ".git-submodule-status" in my git tree to fix the issue.
> 
> I've got the feeling that all this submodule crap is constantly causing
> pain ... do we really need this? Can't we find another solution instead?
> Or at least stop modifying files automatically in the $SRC_PATH ?
> 
> ... ok, sorry for the harsh words, ... but now that I've written this
> down, I feel at least a little bit better ...


Since there is resistance to add a way to disable changing $SRC_PATH, I
guess the way to go is simply move .git folder outside of source tree and
use $GIT_DIR or --work-dir only when you want git to manage the sources -
this should make $git_submodules empty in ./configure and git-submodule.sh
not to touch anything.


-- 
Alexey
