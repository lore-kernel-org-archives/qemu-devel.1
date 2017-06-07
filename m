Received: from eggs.gnu.org ([2001:4830:134:3::10]:56256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIZRZ-0004Mr-59
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIZRU-0004vG-7f
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:48:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42982
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIZRU-0004v5-0k
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:48:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v57Bi0pr101839
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 07:48:02 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axd91tn12-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 07:48:02 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 12:48:00 +0100
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-4-pasic@linux.vnet.ibm.com>
	<20170607112252.GD2099@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 7 Jun 2017 13:47:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170607112252.GD2099@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <df65c8e1-8c89-c6db-7ec4-d124860d3939@linux.vnet.ibm.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org



On 06/07/2017 01:22 PM, Dr. David Alan Gilbert wrote:
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
> 

I do not think it can be changed now. Christian as already sent out a pull
request for the patch this series is re-doing with vmstate.  That patch has the
same error message. I have considered bug but decided against because
the 'bug' can't be fixed. I think it's pretty hard to hit this with normal
usage (and that's probably the reason why it went undetected until recently),
so hope not too may endusers are going to get scared by developer honesty :).

> Other than that,
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Great thanks for the review!

Halil
