Received: from eggs.gnu.org ([209.51.188.92]:53673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtqLi-0007TL-7R
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtqLh-0002S3-8k
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:56:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtqLg-0002KE-W3
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:56:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so1523255wrp.7
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 00:56:40 -0800 (PST)
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190212052224.GA4839@richard>
	<20190212003414-mutt-send-email-mst@kernel.org>
	<4d6f639b-fe11-7048-3975-ee1c1875b8d3@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d700eed-5637-b05a-63c2-9f73a465bcb5@redhat.com>
Date: Wed, 13 Feb 2019 09:56:38 +0100
MIME-Version: 1.0
In-Reply-To: <4d6f639b-fe11-7048-3975-ee1c1875b8d3@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com

Hi Laurent,

On 2/13/19 9:49 AM, Laurent Vivier wrote:
> On 12/02/2019 06:34, Michael S. Tsirkin wrote:
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
> 
> Or I can take the series through the trivial branch and update manually
> Philippe's lastname?

I appreciate the help with manual update, however Wei is not the only
one having this problem (other developpers has non-ASCII in their name,
and use such tags).
I'd rather prefer we find a proper configuration setup to help the
community.

Another (fair) approach is to forbid non-ASCII chars in all part of patches.

Regards,

Phil.
