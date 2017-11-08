Received: from eggs.gnu.org ([2001:4830:134:3::10]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCQRH-0004CO-4f
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCQRE-0006Yd-1W
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:30:43 -0500
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:50264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCQRD-0006YH-Su
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:30:39 -0500
Received: by mail-qt0-x235.google.com with SMTP id d9so3255169qtd.7
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 05:30:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<20171108105332.etwcm4nyb6rqmprn@sirius.home.kraxel.org>
	<54cb9ffb-fa92-f07c-f0df-af589cf17b3a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <999fe337-ef3b-243e-65e7-ca4ecacb709e@amsat.org>
Date: Wed, 8 Nov 2017 10:30:35 -0300
MIME-Version: 1.0
In-Reply-To: <54cb9ffb-fa92-f07c-f0df-af589cf17b3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 11/08/2017 08:48 AM, Thomas Huth wrote:
> On 08.11.2017 11:53, Gerd Hoffmann wrote:
>> On Wed, Nov 08, 2017 at 10:57:21AM +0100, Thomas Huth wrote:
>>>
>>> That automatic git submodule stuff now broke my workflow again. I
>>> usually keep the git repository on my laptop and then simply rsync the
>>> sources (without .git directories) to my target machine to compile it
>>> there.
>>
>> How about excluding all files listed in .gitignore from rsync?  Which I
>> guess would be a good idea anyway because you don't want sync over the
>> build artifacts to the target machine if you want compile there.  Might
>> be as simple as "rsync --exclude-from .gitignore" (didn't test though).
> 
> That's a neat idea, thanks, I'll give it a try!
> 
>> Or syncronize using git instead of rsync.  This is what I am doing.
> 
> Tried that in the past already, but it didn't really feel right (I don't
> want to check in each time before syncing my files)...

TIL: git push --recurse-submodules=on-demand

GIT-PUSH(1)

       --recurse-submodules=check|on-demand|only|no

           [...] If check is used Git will verify that all submodule
           commits that changed in the revisions to be pushed are
           available on at least one remote of the submodule. If any
           commits are missing the push will be aborted and exit with
           non-zero status. If on-demand is used all submodules that
           changed in the revisions to be pushed will be pushed. If
           on-demand was not able to push all necessary revisions it
           will also be aborted and exit with non-zero status. [...]

GIT-CONFIG(1)

       push.recurseSubmodules
           Make sure all submodule commits used by the revisions to be
           pushed are available on a remote-tracking branch. If the
           value is check then Git will verify that all submodule
           commits that changed in the revisions to be pushed are
           available on at least one remote of the submodule. If any
           commits are missing, the push will be aborted and exit with
           non-zero status. If the value is on-demand then all
           submodules that changed in the revisions to be pushed will
           be pushed. If on-demand was not able to push all necessary
           revisions it will also be aborted and exit with non-zero
           status. [...]
