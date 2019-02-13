Received: from eggs.gnu.org ([209.51.188.92]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtodH-0003SP-QC
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtoYO-0003ev-Si
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:01:57 -0500
Date: Wed, 13 Feb 2019 15:01:27 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190213070127.GA9131@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190212052224.GA4839@richard>
	<20190212003414-mutt-send-email-mst@kernel.org>
	<20190213062638.GA8835@richard>
	<49b44562-8d21-29de-f979-0b491fc7dc99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49b44562-8d21-29de-f979-0b491fc7dc99@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu, imammedo@redhat.com

On Wed, Feb 13, 2019 at 07:32:23AM +0100, Philippe Mathieu-Daudé wrote:
>Hi Wei,
>
>On 2/13/19 7:26 AM, Wei Yang wrote:
>> On Tue, Feb 12, 2019 at 12:34:31AM -0500, Michael S. Tsirkin wrote:
>>> On Tue, Feb 12, 2019 at 01:22:24PM +0800, Wei Yang wrote:
>>>> On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
>>>>> There are several functions/variable which are not used anymore.
>>>>>
>>>>> This serials just remove those without functional change.
>>>>>
>>>>> v3: add ack and repost in a new thread
>>>>> v2: change commit log from "is now used in no place" to "in not used anymore"
>>>>
>>>> Michael,
>>>>
>>>> Looks this serials is not merged yet.
>>>>
>>>> Is there any problem I need to fix?
>>>
>>> Yes pls repost with fixed reviewed-by tags.
>>>
>> 
>> I tried to use git-sendemail to send those patches again.
>> 
>> The character 茅 looks good in patch file, while after git-sendemail this is
>> changed.
>> 
>> My encoding property in mail is :
>> 
>>     MIME-Version: 1.0
>>     Content-Type: text/plain; charset=UTF-8
>>     Content-Language: en-US
>>     Content-Transfer-Encoding: 8bit
>
>I'm not sure but you can try:
>
>      Content-Transfer-Encoding: base64
>

Looks not work.

git send-email will detect the file's encoding is 8bit, so manually change to
base64 doesn't work.

>> 
>> Looks the same as Philippe's.
>> 
>> Any hint on how to send out a correct character with git-sendemail?
>
>If it doesn't work, then use my ASCII-reduced lastname, I can live with
>that:
>
>"Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>"
>
>Thanks for trying,

Thanks :-)

Let's wait a while to see whether someone else has an idea on that.

>
>Phil.
>
>> 
>>>
>>>>>
>>>>> Wei Yang (3):
>>>>>  hw/i386/pc.c: remove unused function pc_acpi_init()
>>>>>  hw/acpi: remove unused function acpi_table_add_builtin()
>>>>>  hw/acpi: remove unnecessary variable acpi_table_builtin
>>>>>
>>>>> hw/acpi/core.c         | 10 +---------
>>>>> hw/i386/pc.c           | 27 ---------------------------
>>>>> include/hw/acpi/acpi.h |  1 -
>>>>> include/hw/i386/pc.h   |  1 -
>>>>> 4 files changed, 1 insertion(+), 38 deletions(-)

-- 
Wei Yang
Help you, Help me
