Received: from eggs.gnu.org ([2001:4830:134:3::10]:39293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZHLJ-0003vS-HM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZHLG-00084q-0d
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:31:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZHLF-000845-O3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:31:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so3033740wmj.1
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:31:29 -0800 (PST)
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-11-philmd@redhat.com>
	<20f62f62-f677-6d0f-09dc-3759cc813d8f@redhat.com>
	<20181218152239.GB19442@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <94e8bd71-302e-bced-665d-78538ea3aba3@redhat.com>
Date: Tue, 18 Dec 2018 16:31:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181218152239.GB19442@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/12] MAINTAINERS: Orphanize the 'CPU
 (QOM)' subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi Paolo, Eduardo,

On 12/18/18 4:22 PM, Eduardo Habkost wrote:
> On Tue, Dec 18, 2018 at 01:34:52PM +0100, Paolo Bonzini wrote:
>> On 18/12/18 12:56, Philippe Mathieu-Daudé wrote:
>>> Nobody is looking at those files, downgrade this subsystem as orphan.
>>>
>>> Remove the qemu-devel@nongnu.org entry because the list is always
>>> selected by the 'All patches CC here' section.
>>>
>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  MAINTAINERS | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e50f8c6b97..e6a73820f1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1745,8 +1745,7 @@ S: Supported
>>>  F: scripts/coverity-model.c
>>>  
>>>  CPU
>>> -L: qemu-devel@nongnu.org
>>> -S: Supported
>>> +S: Orphan
>>>  F: qom/cpu.c
>>>  F: include/qom/cpu.h
>>>  
>>>
>>
>> I don't think that's accurate.  Simply there's not much going on.  If
>> patches are sent, get-maintainers's git fallback will do something
>> (probably sending the patch to Eduardo, Igor or me).

I followed Markus suggestion from
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05414.html:

  If we take the definition of S: in MAINTAINERS seriously,
  we need to appoint a maintainer (a person, not a mailing list),
  or downgrade to S: Orphan.

> 
> Should we add our names to that section, or is it OK to leave it
> as "S: Supported" even if it doesn't have any official
> maintainers?
