Received: from eggs.gnu.org ([2001:4830:134:3::10]:49279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dGOlW-00074A-Pl
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dGOlS-00083d-Tc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:59:46 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:41027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dGOlS-00082j-Mc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:59:42 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 13A191007D8
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 13:59:35 +0200 (CEST)
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
	<20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
	<20170601065233.GD13397@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
Date: Thu, 1 Jun 2017 13:59:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170601065233.GD13397@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 0/5] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com

On 06/01/2017 08:52 AM, David Gibson wrote:
> On Wed, May 31, 2017 at 10:58:57AM +0200, Greg Kurz wrote:
>> On Wed, 31 May 2017 12:57:48 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>> [...]
>>>> All old non-pseries machine types already complain when started with
>>>> a POWER7 or newer CPU. Providing the extra error message looks weird:
>>>>
>>>> qemu-system-ppc64 -machine ppce500 \
>>>>                   -cpu POWER7,compat=power6
>>>> qemu-system-ppc64: CPU 'compat' property is deprecated and has no effect;
>>>>  use max-cpu-compat machine property instead
>>>> MMU model 983043 not supported by this machine.
>>>>
>>>> but I guess it's better than crashing. :)  
>>>
>>> Well, sure POWER7 doesn't make sense for an e500 machine for other
>>> reasons.  But POWER7 or POWER8 _would_ make sense for powernv, where
>>> compat= doesn't.
>>>
>>
>> The powernv machine type doesn't even support CPU features at all:
>>
>>     chip_typename = g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cpu_model);
>>     if (!object_class_by_name(chip_typename)) {
>>         error_report("invalid CPU model '%s' for %s machine",
>>                      machine->cpu_model, MACHINE_GET_CLASS(machine)->name);
>>         exit(1);
>>     }
> 
> Ah, well, that's another bug, but not one that's in scope for this
> series.

PowerNV is still work in progress. I would not worry about it too much.

C. 
