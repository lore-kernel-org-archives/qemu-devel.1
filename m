Received: from eggs.gnu.org ([2001:4830:134:3::10]:49924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rene@exactcode.com>) id 1dkX72-0004XE-TO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rene@exactcode.com>) id 1dkX6x-0004QW-3J
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:58:32 -0400
Received: from [144.76.154.42] (port=36766 helo=exactco.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rene@exactcode.com>) id 1dkX6w-0004OO-QO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:58:27 -0400
References: <85cdeb9f-a6ea-5530-edcd-10ed3853026f@exactcode.com>
	<20170818143707.GE2222@work-vm> <1503498982.16071.25.camel@redhat.com>
From: =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.com>
Message-ID: <12022d3e-25dc-90d0-3c05-f3e3f2642bd8@exactcode.com>
Date: Wed, 23 Aug 2017 16:58:04 +0200
MIME-Version: 1.0
In-Reply-To: <1503498982.16071.25.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] QXL: always show default cursor,
 even for unsupported chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

Hi,

On 08/23/2017 04:36 PM, Gerd Hoffmann wrote:
> On Fri, 2017-08-18 at 15:37 +0100, Dr. David Alan Gilbert wrote:
>> cc'ing in Gerd
>>
>> * René Rebe (rene@exactcode.com) wrote:
>>> Hi,
>>>
>>> I was testing a Windows 10 guest with HiDPI scaling which
>>>
>>> actually made the cursor disappear and only multiple chunks
>>>
>>> warnings being printed.
>>>
>>> When the cursor is using currently unsupported multiple chunks, the
>>> builtin-left cursor is better than none.
> 
> Better: add support for chunks.  Can you try
> 
> https://www.kraxel.org/cgit/qemu/log/?h=work/qxl-chunked-cursor
> 
> ?
> 
> cheers,
>    Gerd
> 

I applied that change on top of the current -rc3 tarball, and it works 
beautifully so far.

Thanks!

	René
-- 
   René Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10117 Berlin
   http://exactcode.com | http://t2-project.org | http://rene.rebe.de
