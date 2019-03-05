Received: from eggs.gnu.org ([209.51.188.92]:44661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14KW-0006tt-UW
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14KW-00040N-6y
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:17:36 -0500
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-5-armbru@redhat.com>
	<9218d2e9-5519-055b-dfb9-e78f99559b80@redhat.com>
	<87mum9x136.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <233045ac-e990-bf8c-9a3b-ae0036d65b9b@redhat.com>
Date: Tue, 5 Mar 2019 08:17:24 +0100
MIME-Version: 1.0
In-Reply-To: <87mum9x136.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] sysbus: Fix latent bug with
 onboard devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 05/03/2019 07.54, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 25/02/2019 19.37, Markus Armbruster wrote:
[...]
>>> diff --git a/vl.c b/vl.c
>>> index e3fdce410f..6ce3d2d448 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -3990,6 +3990,10 @@ int main(int argc, char **argv, char **envp)
>>>      }
>>>      object_property_add_child(object_get_root(), "machine",
>>>                                OBJECT(current_machine), &error_abort);
[...]
>>
>> PS: Not directly related to your patch, but in a separate patch we
>> should also object_unref(current_machine) here to drop the superfluous
>> second reference to current_machine after we added it as a child of the
>> root object.
> 
> Just for cleanliness.  Makes sense.

Not only for cleanliness ... there is a TODO at the very end of vl.c
which we should fix one day, and for that we'd need the unref here.

 Thomas
