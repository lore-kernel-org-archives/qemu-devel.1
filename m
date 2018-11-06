Received: from eggs.gnu.org ([2001:4830:134:3::10]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKAgh-0005Vf-NF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKAXm-0000iI-Tn
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:14:02 -0500
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-3-kraxel@redhat.com>
	<20181106142611.GQ12503@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d21f46f3-0cb3-bb4f-2e4b-48752dff440a@redhat.com>
Date: Wed, 7 Nov 2018 00:12:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181106142611.GQ12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 06/11/2018 15:26, Eduardo Habkost wrote:
> On Tue, Nov 06, 2018 at 11:23:31AM +0100, Gerd Hoffmann wrote:
>> Indicates support state for something (device, backend, subsystem, ...)
>> in qemu.  Add QemuSupportState field to ObjectClass.  Add some support
>> code.
>>
>> TODO: wire up to qom-list-types
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
> [...]
>> +##
>> +# @SupportState:
>> +#
>> +# Indicate Support level of qemu devices, backends, subsystems, ...
>> +#
>> +# @unspecified: not specified (zero-initialized).
>> +#
>> +# @experimental: in development, can be unstable or incomplete.
> 
> People reading this document would ask: what would appear on
> MAINTAINERS if SupportState is `experimental`?

Probably Maintained.  It's something that is on its way towards becoming
"supported", but still too immature ("unstable or incomplete").

>> +#
>> +# @supported: works stable and is fully supported.
>> +#             (supported + maintained in MAINTAINERS).
>> +#
>> +# @unsupported: should work, support is weak or not present.
>> +#               (odd-fixes + orphan in MAINTAINERS).
> 
> What's the difference in practice between unsupported and
> experimental?
> 
>> +#
>> +# @obsolete: is obsolete, still present for compatibility reasons,
>> +#            will likely be removed at some point in the future.

I am not sure this is necessarily true.  I don't see Cirrus or adlib or
pcnet disappearing anytime soon.

Paolo

>> +#            Not deprecated (yet).
>> +#            (obsolete in MAINTAINERS).
>> +#
>> +# @deprecated: is deprecated, according to qemu deprecation policy.
> 
> I believe we want to differentiate "deprecated, but still safe to
> use in production if you have a migration plan" from "deprecated,
> and also unstable and unsafe for production".
> 
> I expect enterprise distributions to have a strict policy of not
> allowing unsupported and experimental devices to be enabled, but
> still allow deprecated devices to be enabled (but only if they
> are stable/supported).
> 
