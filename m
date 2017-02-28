Received: from eggs.gnu.org ([2001:4830:134:3::10]:47561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cijBE-0001I7-6j
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cijBA-0005VC-0q
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:55:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:53638)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cijB9-0005Ue-PZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:55:03 -0500
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
	<2a8da4e5-d66d-502c-322b-ec942f250f40@msgid.tls.msk.ru>
	<20170228152240.6efc1fbc@bahia.lan>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <4e9eeab8-faca-b6ba-d53e-a8fbf5848c0f@msgid.tls.msk.ru>
Date: Tue, 28 Feb 2017 17:55:02 +0300
MIME-Version: 1.0
In-Reply-To: <20170228152240.6efc1fbc@bahia.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/28] 9p CVE-2016-9602 fixes 2017-02-28 for
 2.9 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

28.02.2017 17:22, Greg Kurz wrote:
> On Tue, 28 Feb 2017 17:02:44 +0300
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>> 28.02.2017 13:30, Greg Kurz wrote:
>>> The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:
>>>
>>>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/gkurz/qemu.git tags/cve-2016-9602-for-upstream
>>>
>>> for you to fetch changes up to c23d5f1d5bc0e23aeb845b1af8f996f16783ce98:  
>>
>> Greg, did you forget to push maybe? There's no tag "cve-2016-9602-for-upstream"
>> and no object c23d5f1d5bc0e23aeb845b1af8f996f16783ce98.
>>
> 
> I had pushed actually and...
> 
> https://github.com/gkurz/qemu/commits/cve-2016-9602-for-upstream
> https://github.com/gkurz/qemu/commit/c23d5f1d5bc0e23aeb845b1af8f996f16783ce98

Interesting. Perhaps I've never worked with github before.
It works when referring to particular commit like this.
but the tag isn't visible in github UI, and neither the
tag nor this commit ID is visible when cloning github
repository locally. I wonder where's that.

$ git remote -v | grep gkurz
gkurz	git://github.com/gkurz/qemu.git (fetch)
gkurz	git://github.com/gkurz/qemu.git (push)
$ git remote update gkurz
Fetching gkurz
$ git show c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
fatal: bad object c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
$ git show cve-2016-9602-for-upstream --
fatal: bad revision 'cve-2016-9602-for-upstream'

that's now.  I'll dig into that later, there's apparently
nothing wrong on your side, I'm sorry for the noise.

Thanks,

/mjt
