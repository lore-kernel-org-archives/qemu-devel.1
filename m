Received: from eggs.gnu.org ([2001:4830:134:3::10]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfDnF-0004OW-B5
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 19:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfDnC-0001SJ-3G
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 19:20:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-2-jsnow@redhat.com>
	<c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e792d8d7-4aac-3a01-ca06-02899d068e50@amsat.org>
Date: Tue, 8 Aug 2017 20:20:01 -0300
MIME-Version: 1.0
In-Reply-To: <c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] IDE: replace DEBUG_IDE with tracing
 system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On 08/08/2017 05:00 PM, Eric Blake wrote:
> On 08/08/2017 01:32 PM, John Snow wrote:
>> Out with the old, in with the new.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> 
>>   hw/ide/piix.c             | 11 ++++----
>>   hw/ide/trace-events       | 33 ++++++++++++++++++++++++
>>   hw/ide/via.c              | 10 +++-----
> 
> Hmm - should we tweak scripts/git.orderfile to prioritize trace-events
> over .c files? Then again, right now it prioritizes all .c files before
> anything that didn't match, so that things like trace-events will at
> least avoid falling in the middle of a patch if you use the project's
> orderfile.

It sounds like a good idea, although I'd rather prioritize .c, having 
trace-events at bottom. At least we can agree about top-to-bottom 
scripting here :)
