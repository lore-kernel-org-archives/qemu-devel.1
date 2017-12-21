Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRvGc-0001xi-NX
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRvGb-0007SW-Sy
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:27:46 -0500
References: <1513617273-7988-1-git-send-email-thuth@redhat.com>
	<11b989ad-59bb-7417-1ce1-2decb079d3e0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6a629fcc-e7d7-b4d7-0c78-9a9a2e229326@redhat.com>
Date: Thu, 21 Dec 2017 08:27:30 +0100
MIME-Version: 1.0
In-Reply-To: <11b989ad-59bb-7417-1ce1-2decb079d3e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block: Deprecated options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 20.12.2017 22:40, John Snow wrote:
> 
> 
> On 12/18/2017 12:14 PM, Thomas Huth wrote:
>> Remove the deprecated "-drive boot" and "-hdachs" options and properly
>> mark some other deprecated options in the deprecation chapter.
>>
>> Thomas Huth (3):
>>   block: Remove the obsolete -drive boot=on|off parameter
>>   block: Remove the deprecated -hdachs option
>>   block: Mention -drive cyls/heads/secs/trans/serial/addr in deprecation
>>     chapter
>>
>>  blockdev.c      | 11 --------
>>  qemu-doc.texi   | 29 +++++++++----------
>>  qemu-options.hx | 19 ++-----------
>>  vl.c            | 86 ++-------------------------------------------------------
>>  4 files changed, 19 insertions(+), 126 deletions(-)
>>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

> So long, farewell: however, since we forgot to document them, can we
> remove them already?

The are documented in
https://qemu.weilnetz.de/doc/qemu-doc.html#Block-device-options so I
doubt that we can simply drop them without announcing it first?

 Thomas
