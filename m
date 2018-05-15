Received: from eggs.gnu.org ([2001:4830:134:3::10]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIZ7D-0000Kt-Eq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIZ79-0004JL-GQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:31:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIZ79-0004Iu-BA
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:31:35 -0400
References: <20180514073805.44589-1-aik@ozlabs.ru>
	<87h8n96s2e.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fe400fe-5403-e414-1ce7-e49ac1e0ff2a@redhat.com>
Date: Tue, 15 May 2018 14:31:32 +0200
MIME-Version: 1.0
In-Reply-To: <87h8n96s2e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

On 15/05/2018 14:07, Markus Armbruster wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> The recently introduced qom-list-properties QMP command raised
>> a question what properties it (and its cousin - device-list-properties)
>> can possibly print - only those defined by DeviceClass::props
>> or dynamically created in TypeInfo::instance_init() so properties created
>> elsewhere won't show up and this behaviour might confuse the user.
>> For example, PIIX4 does that from piix4_pm_realize():
>>
>> hw/acpi/piix4.c|477| object_property_add_uint8_ptr(OBJECT(s),
>> ACPI_PM_PROP_ACPI_ENABLE_CMD,
> 
> I'd like to tweak this to
> 
>   For example, PIIX4 does that from piix4_pm_realize() via
>   piix4_pm_add_propeties():
> 
>       object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
>                                     &acpi_enable_cmd, NULL);
> 
> if you don't mind.
> 
>> This adds a note to the command descriptions about the limitation.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Thanks!
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo
