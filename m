Received: from eggs.gnu.org ([2001:4830:134:3::10]:38252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCOqr-0006gn-BB
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCOqn-0002ij-9e
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:49:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCOqn-0002iS-2n
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:48:57 -0500
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<20171108105332.etwcm4nyb6rqmprn@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54cb9ffb-fa92-f07c-f0df-af589cf17b3a@redhat.com>
Date: Wed, 8 Nov 2017 12:48:50 +0100
MIME-Version: 1.0
In-Reply-To: <20171108105332.etwcm4nyb6rqmprn@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 08.11.2017 11:53, Gerd Hoffmann wrote:
> On Wed, Nov 08, 2017 at 10:57:21AM +0100, Thomas Huth wrote:
>>
>> That automatic git submodule stuff now broke my workflow again. I
>> usually keep the git repository on my laptop and then simply rsync the
>> sources (without .git directories) to my target machine to compile it
>> there.
> 
> How about excluding all files listed in .gitignore from rsync?  Which I
> guess would be a good idea anyway because you don't want sync over the
> build artifacts to the target machine if you want compile there.  Might
> be as simple as "rsync --exclude-from .gitignore" (didn't test though).

That's a neat idea, thanks, I'll give it a try!

> Or syncronize using git instead of rsync.  This is what I am doing.

Tried that in the past already, but it didn't really feel right (I don't
want to check in each time before syncing my files)...

 Thomas
