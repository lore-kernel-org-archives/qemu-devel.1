Received: from eggs.gnu.org ([2001:4830:134:3::10]:55245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eD9dw-0004b0-LY
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eD9dr-0006yO-KX
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:46:48 -0500
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:52235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eD9dr-0006wi-Ab
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:46:43 -0500
Received: by mail-pf0-x22f.google.com with SMTP id e64so6727720pfk.9
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 05:46:43 -0800 (PST)
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
	<20171108130102.GS12670@redhat.com>
	<fd7bb230-bbe3-ce3c-3026-d3d51544a14a@ozlabs.ru>
	<20171110104135.GB30685@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a1d39dc8-72e1-55a6-7c36-4bbe8b6142fa@ozlabs.ru>
Date: Sat, 11 Nov 2017 00:46:36 +1100
MIME-Version: 1.0
In-Reply-To: <20171110104135.GB30685@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>

On 10/11/17 21:41, Daniel P. Berrange wrote:
> On Fri, Nov 10, 2017 at 09:35:54PM +1100, Alexey Kardashevskiy wrote:
>> On 09/11/17 00:01, Daniel P. Berrange wrote:
>>> On Wed, Nov 08, 2017 at 09:26:01AM -0300, Philippe Mathieu-Daudé wrote:
>>>> On 11/08/2017 06:57 AM, Thomas Huth wrote:
>>>>>
>>>>> That automatic git submodule stuff now broke my workflow again. I
>>>>> usually keep the git repository on my laptop and then simply rsync the
>>>>> sources (without .git directories) to my target machine to compile it
>>>>> there. Used to work great for years. Now it's broken, the build process
>>>>> complains:
>>>>>
>>>>> GIT submodule checkout is out of date. Please run
>>>>>   scripts/git-submodule.sh update
>>>>> from the source directory checkout /home/thuth/devel/qemu
>>>>>
>>>>> Running "scripts/git-submodule.sh update" did not fix the issue at all -
>>>>> I first had to tinker with it for a while to find out that I simply have
>>>>> to delete ".git-submodule-status" in my git tree to fix the issue.
>>>>>
>>>>> I've got the feeling that all this submodule crap is constantly causing
>>>>> pain ... do we really need this? Can't we find another solution instead?
>>>>> Or at least stop modifying files automatically in the $SRC_PATH ?
>>>>
>>>> Also yesterday on IRC:
>>>>
>>>> <RaV3N> [...] I downloaded the qemu source from git and tried to compile
>>>> it. I am getting this:
>>>>
>>>> ./configure --static && make && sudo make install
>>>>  CC      ui/input-keymap.o
>>>> ui/input-keymap.c:8:10: fatal error: ui/input-keymap-linux-to-qcode.c:
>>>> No such file or directory
>>>
>>> I had a pull request merged yesterday later afternoon which possibly
>>> would address that problem, though hard hard to say for certain.
>>
>> wow, already? :(
>>
>> I still wonder why do not we checkout submodules into the build directory
>> and why .git-submodule-status is not there too...
> 
> That simply isn't the way submodules work, they are inherently part of
> the source tree, and the status file reflects that too.

Sorry, I am missing the point here. What precisely does prevent us from
checking out the required modules to the build directory and build them
there? git provides a submodule repository url and sha1 for the current
qemu branch.

Yes, the submodule tree inside the qemu tree might be different from the
one in the build directory but the purpose of all of this is to always
build the correct code - so this requirement is met. And it will still be
better than changing the $SRC_PATH when a user specifically asked not to do
that by calling "./configure --source-path='.



-- 
Alexey
