Received: from eggs.gnu.org ([2001:4830:134:3::10]:59945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUw32-0002TS-U4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUw2x-0007od-TB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:58:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUw2x-0007kZ-JT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:58:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so1028655wrw.1
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 07:58:39 -0800 (PST)
References: <20181130140615.19937-1-berrange@redhat.com>
	<20181130140615.19937-10-berrange@redhat.com>
	<868aa668-c882-3392-ee10-2afc28a51f7e@redhat.com>
	<5d9b6cdf-3d6b-a424-daa1-e5a498920f59@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d7e633c1-2216-fd2b-dd36-41df5c264f0a@redhat.com>
Date: Thu, 6 Dec 2018 16:58:36 +0100
MIME-Version: 1.0
In-Reply-To: <5d9b6cdf-3d6b-a424-daa1-e5a498920f59@redhat.com>
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

On 12/5/18 10:55 PM, Eric Blake wrote:
> On 12/5/18 11:23 AM, Philippe Mathieu-Daudé wrote:
>> On 11/30/18 3:06 PM, Daniel P. Berrangé wrote:
>>> Add a QAuthZListFile object type that implements the QAuthZ
>>> interface. This
>>> built-in implementation is a proxy around the QAuthZList object type,
>>> initializing it from an external file, and optionally, automatically
>>> reloading it whenever it changes.
>>>
>>> To create an instance of this object via the QMP monitor, the syntax
>>> used would be:
>>>
>>>        {
>>>          "execute": "object-add",
>>>          "arguments": {
>>>            "qom-type": "authz-list-file",
>>>            "id": "authz0",
>>>            "parameters": {
>>
>> "parameters" -> "props"
>>
>>>              "filename": "/etc/qemu/vnc.acl",
>>>         "refresh": "yes"
>>
>> I had to use "refresh": yes (value unquoted) to avoid:
> 
> Do you mean "refresh":true?  (bare yes is not valid JSON, but bare true
> is the correct way for a JSON bool).

I first tried 'true' then was curious and tried 'yes' and it worked too...
