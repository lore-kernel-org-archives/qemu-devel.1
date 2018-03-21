Received: from eggs.gnu.org ([2001:4830:134:3::10]:47854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyiew-0004cW-G4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyiet-0006n6-Dk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:40:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyiet-0006mX-9L
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:40:23 -0400
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
	<CAHNT7NvJ42AApKcprrZ+s7bMxxbL1S1ZdX9aTjQTwd=fbFQU6w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c3c9825-1df1-ec9e-a9a5-bae1c5152d5d@redhat.com>
Date: Wed, 21 Mar 2018 13:40:15 -0500
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvJ42AApKcprrZ+s7bMxxbL1S1ZdX9aTjQTwd=fbFQU6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 03/21/2018 01:27 PM, Michael Clark wrote:

>> for future PULL request, could you please send out all patches again
>> that should be pulled, and not send the cover letter alone? I.e. do a
>> "git format-patch --subject-prefix PULL ..." and then replace the
>> contents of the cover letter with the output of "git request-pull".
>>
> 
> No problem. Thanks for the advice. I was grappling with this part of the
> process. This is now very clear and makes complete sense.

You'll notice that some maintainers send a full PULL request the first 
time, but if they have to send a v2, they only include the patches that 
changed from v1.  That's also okay (there's still an email for each 
patch in the series as it eventually got committed, even if it is now 
split across threads; but that is sufficient for someone performing a 
bisect to have an easy email to reply to when reporting a regression 
caused by the final version that ended up getting pulled).  For an 
example of that, see my QAPI v4 request:

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05160.html

and the regression report against the v1 request (since that particular 
patch did not change between v1 and v4):

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03611.html
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05709.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
