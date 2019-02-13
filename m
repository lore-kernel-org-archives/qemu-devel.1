Received: from eggs.gnu.org ([209.51.188.92]:58162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtoJU-0000Xq-Mu
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gto5s-0007ES-Ou
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:32:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gto5r-0007DJ-9m
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:32:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so1150942wrg.1
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 22:32:27 -0800 (PST)
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190212052224.GA4839@richard>
	<20190212003414-mutt-send-email-mst@kernel.org>
	<20190213062638.GA8835@richard>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49b44562-8d21-29de-f979-0b491fc7dc99@redhat.com>
Date: Wed, 13 Feb 2019 07:32:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190213062638.GA8835@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu, imammedo@redhat.com

Hi Wei,

On 2/13/19 7:26 AM, Wei Yang wrote:
> On Tue, Feb 12, 2019 at 12:34:31AM -0500, Michael S. Tsirkin wrote:
>> On Tue, Feb 12, 2019 at 01:22:24PM +0800, Wei Yang wrote:
>>> On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
>>>> There are several functions/variable which are not used anymore.
>>>>
>>>> This serials just remove those without functional change.
>>>>
>>>> v3: add ack and repost in a new thread
>>>> v2: change commit log from "is now used in no place" to "in not used anymore"
>>>
>>> Michael,
>>>
>>> Looks this serials is not merged yet.
>>>
>>> Is there any problem I need to fix?
>>
>> Yes pls repost with fixed reviewed-by tags.
>>
> 
> I tried to use git-sendemail to send those patches again.
> 
> The character 茅 looks good in patch file, while after git-sendemail this is
> changed.
> 
> My encoding property in mail is :
> 
>     MIME-Version: 1.0
>     Content-Type: text/plain; charset=UTF-8
>     Content-Language: en-US
>     Content-Transfer-Encoding: 8bit

I'm not sure but you can try:

      Content-Transfer-Encoding: base64

> 
> Looks the same as Philippe's.
> 
> Any hint on how to send out a correct character with git-sendemail?

If it doesn't work, then use my ASCII-reduced lastname, I can live with
that:

"Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>"

Thanks for trying,

Phil.

> 
>>
>>>>
>>>> Wei Yang (3):
>>>>  hw/i386/pc.c: remove unused function pc_acpi_init()
>>>>  hw/acpi: remove unused function acpi_table_add_builtin()
>>>>  hw/acpi: remove unnecessary variable acpi_table_builtin
>>>>
>>>> hw/acpi/core.c         | 10 +---------
>>>> hw/i386/pc.c           | 27 ---------------------------
>>>> include/hw/acpi/acpi.h |  1 -
>>>> include/hw/i386/pc.h   |  1 -
>>>> 4 files changed, 1 insertion(+), 38 deletions(-)
