Received: from eggs.gnu.org ([2001:4830:134:3::10]:44958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVRv4-0007sc-Ou
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVRv3-0006gJ-I0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dVRv3-0006fX-9e
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:23:49 -0400
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712145121.GF6020@localhost.localdomain>
	<20170712181652-mutt-send-email-mst@kernel.org>
	<20170712201550.GN6020@localhost.localdomain>
	<20170712232214-mutt-send-email-mst@kernel.org>
	<20170712205646.GQ6020@localhost.localdomain>
	<20170713003116-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <91a1c7c2-0e87-4023-c960-5078267abf95@redhat.com>
Date: Thu, 13 Jul 2017 02:23:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170713003116-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07/13/17 00:27, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 05:56:46PM -0300, Eduardo Habkost wrote:
>> On Wed, Jul 12, 2017 at 11:31:59PM +0300, Michael S. Tsirkin wrote:
>>> On Wed, Jul 12, 2017 at 05:15:50PM -0300, Eduardo Habkost wrote:
>>>> On Wed, Jul 12, 2017 at 06:17:55PM +0300, Michael S. Tsirkin wrote:
>>>>> On Wed, Jul 12, 2017 at 11:51:21AM -0300, Eduardo Habkost wrote:
>>>>>> On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
>>>>>>> We don't want to carry along old machine types forever. If we are able to
>>>>>>> remove the pc machines up to 0.13 one day for example, this would allow
>>>>>>> us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
>>>>>>> BARs directly to low memory). Everything up to pc-1.2 is also known to
>>>>>>> have issues with migration.  So let's start with a deprecation message
>>>>>>> for the old machine types so that the (hopefully) few users of these old
>>>>>>> systems start switching over to newer machine types instead.
>>>>>>>
>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>
>>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>>
>>>>>> I suggest changing "-machine help" too.  Today it looks like this:
>>>>>>
>>>>>>   Supported machines are:
>>>>>>   pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.8        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.7        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.3        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.2        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-2.10)
>>>>>>   pc-i440fx-2.10       Standard PC (i440FX + PIIX, 1996) (default)
>>>>>>   pc-i440fx-2.1        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-2.0        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-1.7        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-1.6        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-1.5        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-i440fx-1.4        Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-1.3               Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-1.2               Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-1.1               Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-1.0               Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-0.15              Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-0.14              Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-0.13              Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-0.12              Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-0.11              Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-0.10              Standard PC (i440FX + PIIX, 1996)
>>>>>>   pc-q35-2.9           Standard PC (Q35 + ICH9, 2009)
>>>>>>   pc-q35-2.8           Standard PC (Q35 + ICH9, 2009)
>>>>>>   pc-q35-2.7           Standard PC (Q35 + ICH9, 2009)
>>>>>>   pc-q35-2.6           Standard PC (Q35 + ICH9, 2009)
>>>>>>   pc-q35-2.5           Standard PC (Q35 + ICH9, 2009)
>>>>>>   pc-q35-2.4           Standard PC (Q35 + ICH9, 2009)
>>>>>>   q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-2.10)
>>>>>>   pc-q35-2.10          Standard PC (Q35 + ICH9, 2009)
>>>>>>   isapc                ISA-only PC
>>>>>>   none                 empty machine
>>>>>
>>>>> Any chance we can sort them reasonably too?
>>>>
>>>> If we use strverscmp(), it will be sorted in a more reasonable
>>>> way.  We could copy the gnulib version on systems without glibc.
>>>> Life is too short for writing configure checks by hand, though; I
>>>> will add this to the end of my wish-todo list.  If somebody wants
>>>> to volunteer, be my guest.
>>>>
>>>> I'm CCing Eric in case he has suggestions that would help import
>>>> the gnulib module in an easy way.
>>>>
>>>> -- 
>>>> Eduardo
>>>
>>> As we never have leading zeroes, and input comes from QEMU so
>>> it's safe, it's probably easier to just open-code it:
>>>
>>> /* compare string numerically: shorter strings give smaller numbers */
>>> int mstcmp(const char *s1, const char *s2)
>>> {
>>> 	int l1, l2;
>>>
>>> 	l1 = strlen(s1);
>>> 	l2 = strlen(s2);
>>> 	return l1 == l2 ? strcmp(s1, s2) : l1 - l2;
>>> }
>>>
>>
>> This doesn't work because strlen("pc-0.10") > strlen("pc-1.0").
> 
> Oh right. So you need to find dots and split at these points.
> Something like the below? Completely untested.
> 
> int mstcmp(const char *s1, const char *s2)
> {
> 	const char *e1, *e2;
>  	int l1, l2, c;
> 
> 	do {
> 		e1 = strchr(s1, '.');
> 		e2 = strchr(s2, '.');
> 
> 		l1 = e1 ? e1 - s1 + 1 : strlen(s1);
> 		l2 = e2 ? e2 - s2 + 1 : strlen(s2);
> 
> 		/* compare numerically: shorter strings give smaller numbers */
> 		if (l1 != l2) {
> 			break;
> 		}
> 		c = strncmp(s1, s2, l1);
> 		if (c) {
> 			return c;
> 		}
> 		s1 += l1;
> 		s2 += l1;
> 	} while (l1);
> 
> 	return l1 - l2;
> }

QEMU already has machine type sorting code:

  1  2709f263952b well-defined listing order for machine types
  2  562542b6aee2 i386/pc: add piix and q35 machtypes to sorting
                  families for -M \?

I guess it should be possible to refine machine_class_cmp() in "vl.c",
so that some numeric sorting is applied to machine types in the same
"family".

Thanks
Laszlo
