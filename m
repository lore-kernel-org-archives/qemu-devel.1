Received: from eggs.gnu.org ([2001:4830:134:3::10]:42068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUxlI-0007Ri-KL
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUxlE-0007uv-5U
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:48:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUxlD-0007ri-UI
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:48:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so1339098wrs.8
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 09:48:27 -0800 (PST)
References: <20181130140615.19937-1-berrange@redhat.com>
	<20181130140615.19937-10-berrange@redhat.com>
	<868aa668-c882-3392-ee10-2afc28a51f7e@redhat.com>
	<5d9b6cdf-3d6b-a424-daa1-e5a498920f59@redhat.com>
	<d7e633c1-2216-fd2b-dd36-41df5c264f0a@redhat.com>
	<5a0b8acd-2906-2ee7-1ef2-0035af9af811@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <28a41967-e327-ed9b-4be7-870ba722718d@redhat.com>
Date: Thu, 6 Dec 2018 18:48:23 +0100
MIME-Version: 1.0
In-Reply-To: <5a0b8acd-2906-2ee7-1ef2-0035af9af811@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 12/6/18 6:07 PM, Eric Blake wrote:
> On 12/6/18 9:58 AM, Philippe Mathieu-Daudé wrote:
> 
>>>>>          "refresh": "yes"
>>>>
>>>> I had to use "refresh": yes (value unquoted) to avoid:
>>>
>>> Do you mean "refresh":true?  (bare yes is not valid JSON, but bare true
>>> is the correct way for a JSON bool).
>>
>> I first tried 'true' then was curious and tried 'yes' and it worked
>> too...
> 
> Ah, so you're using a python wrapper rather than direct QMP, and
> benefitting from a rather-forgiving parser that turns yes into the
> correct QMP true over the wire to the actual monitor.

I'm not sure I'm using a python wrapper, I use rlwrap following:

https://wiki.qemu.org/Documentation/QMP#Trying_it

Regardless, let's use the correct JSON bool for the documentation.
