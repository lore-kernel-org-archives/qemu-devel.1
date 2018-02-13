Received: from eggs.gnu.org ([2001:4830:134:3::10]:41709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1elgPJ-0005sj-DJ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1elgPI-0005eX-Hs
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:38:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1elgPI-0005eF-E2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:38:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1175AEB705
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 19:38:24 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
References: <20180212222705.12718-1-bsd@redhat.com>
	<20180212222705.12718-6-bsd@redhat.com>
	<20180213122017.ware2jke5rfwypgm@sirius.home.kraxel.org>
Date: Tue, 13 Feb 2018 14:38:23 -0500
In-Reply-To: <20180213122017.ware2jke5rfwypgm@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Tue, 13 Feb 2018 13:20:17 +0100")
Message-ID: <jpg7ergfzo0.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/5] usb-mtp: Advertise SendObjectInfo
 for write support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

>> +/*
>> + * ObjectInfo dataset received from initiator
>> + * Fields we don't care about are ignored
>> + */
>> +typedef struct {
>> +    char __pad1[4];
>
> So, is this really padding or a field we don't care about?
>
> If the latter I'd suggest to give them proper names nevertheless,
> maybe append /* unused */.
>

Ok, will do.

>> +static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
>> +{
>> +    int count;
>> +
>> +    for (count = 0; count < len; count++) {
>> +        /* Check for valid ascii */
>> +        assert(!(arr[count] & 0xFF80));
>> +        name[count] = arr[count];
>> +    }
>> +}
>
> This should do the reverse of usb_mtp_add_str, i.e. first copy uint16_t
> array to wchar_t array, then use wcstombs to translate it into a
> (multi-)byte string of the current locale.

Ah, this is what I was missing. Thank you for the tip, will fix in the next
version.

Bandan

> cheers,
>   Gerd
