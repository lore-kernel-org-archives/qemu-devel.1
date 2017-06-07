Received: from eggs.gnu.org ([2001:4830:134:3::10]:60853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIdxE-0005zV-Ly
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIdxB-0006wM-Iz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:37:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIdxB-0006w4-Cn
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:37:05 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170607112252.GD2099@work-vm> (David Alan Gilbert's message of
	"Wed, 7 Jun 2017 12:22:53 +0100")
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-4-pasic@linux.vnet.ibm.com>
	<20170607112252.GD2099@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 18:37:02 +0200
Message-ID: <87shjbdaa9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] s390x/css: add hint for devno
 missmatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> This one has to be fixed up to 's390x: vmstatify config migration for
>> virtio-ccw' provided we want to achieve the same as 's390x/css: catch
>> section mismatch on load' does.
>> 
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>> 
>> This is on tom of 's390x: vmstatify config migration for virtio-ccw'
>                p
>> which ain't on top of 's390x/css: catch section mismatch on load' but on
>> top of master.  I kind of have a circular dependency here. This is why
>> the series is RFC. 
>> 
>> Wanted to provide an usage example. Faked 'Re: ' so patchew does not
>> try to apply this on top of current master.
>> ---
>>  hw/s390x/css.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 348129e1b2..de277d6a3d 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -134,6 +134,10 @@ static const VMStateDescription vmstate_sense_id = {
>>  static int subch_dev_post_load(void *opaque, int version_id);
>>  static void subch_dev_pre_save(void *opaque);
>>  
>> +const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
>> +    " Likely reason: some sequences of plug and unplug  can break"
>> +    " migration for machine versions prior to  2.7 (known design flaw).";
>> +
>
> That's ok, but I suggest:
>    * 'bug' rather than 'design flaw' - it sounds a bit less scary to
>      endusers.

If we are being politically correct:

(known limitation)?

O:-)

Reviewed-by: Juan Quintela <quintela@redhat.com>


Later, Juan.
