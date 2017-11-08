Received: from eggs.gnu.org ([2001:4830:134:3::10]:45993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCPQm-0008M0-DP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCPQj-0005S9-Ps
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:26:08 -0500
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:53385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCPQj-0005Ru-LQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:26:05 -0500
Received: by mail-qk0-x229.google.com with SMTP id y23so3010172qkb.10
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 04:26:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
Date: Wed, 8 Nov 2017 09:26:01 -0300
MIME-Version: 1.0
In-Reply-To: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>

On 11/08/2017 06:57 AM, Thomas Huth wrote:
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

Also yesterday on IRC:

<RaV3N> [...] I downloaded the qemu source from git and tried to compile
it. I am getting this:

./configure --static && make && sudo make install
 CC      ui/input-keymap.o
ui/input-keymap.c:8:10: fatal error: ui/input-keymap-linux-to-qcode.c:
No such file or directory

<cota> [...] you might want to do "git submodule init && git submodule
update"
