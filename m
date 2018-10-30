Received: from eggs.gnu.org ([2001:4830:134:3::10]:38457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHUmM-0005Y6-Gw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHUmG-0006jc-I1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:13:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHUmE-0006hf-II
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:13:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so11466154wmf.1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:13:49 -0700 (PDT)
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6fd9e9f8-838a-a13c-e957-a8e6bcb74c42@redhat.com>
Date: Tue, 30 Oct 2018 15:13:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 30/10/18 15:00, Gerd Hoffmann wrote:
> On Tue, Oct 30, 2018 at 02:32:40PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Gerd,
>>
>> On 30/10/18 12:13, Gerd Hoffmann wrote:
>>> Indicates support state for somerhing (device, backend, subsystem, ...)
>>
>> "something"
> 
> Oops, I'll fix.
> 
>>> +##
>>> +# @SupportState:
>>> +#
>>> +# Indicate Support level of qemu devices, backends, subsystems, ...
>>> +#
>>> +# Since: 3.2
>>> +##
>>> +{ 'enum': 'SupportState',
>>> +  'data': [ 'unknown',
>>
>> 'unknown' is scary and should be fixed.
> 
> 'unknown' maps to "0" due to being first in list, so this is what you
> get when it isn't explicitly set to something else.  Which make sense
> IMHO.

Yes, I understand in your next patch, this case won't display warning to 
the user.

I wanted to say "we should fix those entries in the MAINTAINERS file".

> 
>>> +            'supported',
>>> +            'maintained',
>>> +            'odd-fixes',
>>
>> All those fit in 'supported'
>>
>>> +            'orphan',
>>> +            'obsolete',
>>> +            'deprecated' ] }
>>
>> And all those should appear as 'deprecated' IMHO.
> 
> See minutes on deprecation discussion.  Seems there is agreement we
> need something more finegrained than "supported" and "deprecated".

I read again the "Minutes of KVM Forum BoF on deprecating stuff" thread 
and don't find details on finegrains, can you point it to me?

I think these are fine in the MAINTAINERS entries, but don't give useful 
information to a QEMU user that is not custom to MAINTAINERS.

As a user I'd expect anything not "supported" to be eventually "deprecated".

Should we continue this discussion on the "Minutes of KVM Forum BoF on 
deprecating stuff" thread?

Thanks,

Phil.

> 
> cheers,
>    Gerd
> 
> 
