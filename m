Received: from eggs.gnu.org ([2001:4830:134:3::10]:48146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8poO-0001OY-2r
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8poK-0000T8-55
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:20:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
	<1524061685-83305-4-git-send-email-imammedo@redhat.com>
	<20180418145603.GN29865@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aa061208-6177-7397-b710-9f9ad93e78da@amsat.org>
Date: Wed, 18 Apr 2018 13:19:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180418145603.GN29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.13 v2 3/5] pc: simplify
 MachineClass::get_hotplug_handler handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com

On 04/18/2018 11:56 AM, Eduardo Habkost wrote:
> On Wed, Apr 18, 2018 at 04:28:03PM +0200, Igor Mammedov wrote:
>> By default MachineClass::get_hotplug_handler is NULL and concrete board
>> should set it to it's own handler.
>> Considering there isn't any default handler, drop saving empty
>> MachineClass::get_hotplug_handler in child class and make PC code
>> consistent with spapr/s390x boards.
>>
>> We can bring this back when actual usecase surfaces and do it
>> consistently across boards that use get_hotplug_handler().
>>
>> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> 
> [...]
>> @@ -2344,7 +2341,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>      NMIClass *nc = NMI_CLASS(oc);
>>  
>> -    pcmc->get_hotplug_handler = mc->get_hotplug_handler;
> 
> What about assert(!mc->get_hotplug_handler) just before
> overwriting it?

Good idea.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
