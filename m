Received: from eggs.gnu.org ([209.51.188.92]:33030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK5c0-0002A4-2M
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK5bz-0004ju-0D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:30:16 -0400
References: <20190422221714.7630-1-jsnow@redhat.com>
	<9b85bfbf-44c1-5b6b-8aca-c1354c9e3f05@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8141f68d-6221-f854-e2d7-a9c41a2a7cf7@redhat.com>
Date: Fri, 26 Apr 2019 14:29:53 -0400
MIME-Version: 1.0
In-Reply-To: <9b85bfbf-44c1-5b6b-8aca-c1354c9e3f05@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] docs/interop/bitmaps: rewrite and
 modernize doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, "aliang@redhat.com" <aliang@redhat.com>, "kchamart@redhat.com" <kchamart@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>



On 4/23/19 2:10 PM, Vladimir Sementsov-Ogievskiy wrote:
> 23.04.2019 1:17, John Snow wrote:
>> The documentation as written in the 4.0 release is not quite correct as
>> of the 4.0 release; though thanks to backwards compatibility it's not
>> quite wrong either. It is suitable for inclusion in 4.0.1, or any
>> downstream that packages 4.0.
>>
>> This patch is an attempt at a nearly full rewrite that revitalizes this
>> document to address frequent questions I encounter when discussing the
>> API.
>>
>> V2:
>>    - Split off makefile change into its own little patch.
>>
>>    - Addressed (almost) all comments from Vladimir.
>>      - Example styling was not reworked.
>>    - Renamed all filenames to be consistent throughout the document,
>>      fixing a few more file extensions in the process
>>    - Reflowed almost all paragraphs to 78 columns for consistency.
>>    - Changed a few bulleted lists to paragraphs instead
>>    - Changed the big ascii text diagram to a more compact version
>>      and clarified its language
>>    - While in general I prefer to use en_US spellings, I have
>>      replaced "canceled" with "cancelled" so it does not look
>>      out of place juxtaposed with BLOCK_JOB_CANCELLED...
>>
>> Future work that remains to be done:
>>
>> - Paying heed to blockdev-backup workflows
>> - Adding a small migration section explaining the options there
>> - Possibly reworking some of the sections that all make their own
>>    repeated attempts to clarify time interval discretization and adding
>>    a proper treatment of the idea start to finish; this may be neccessary
>>    to explain the two below items properly:
>> - Differential Backups
>> - Pull Backups and NBD
> 
> This all looks a bit more than just "bitmaps.rst". I think at least most of things
> about backups should be separated into backup.rst. (But, please, as a follow-up, if
> you agree).
> 

Yeah, it could certainly be refactored a bit, but the core goal was
"bitmap objects, and the ways you can use them."

It has obviously grown a bit since then, but the push and pull backup
relating parts could go in their own document, maybe.

I'll worry about it later.

Thanks for your help with the reviews!
