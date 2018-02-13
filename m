Received: from eggs.gnu.org ([2001:4830:134:3::10]:41308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1elgN1-0004Vl-MZ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1elgMy-0004Vx-JM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:36:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1elgMy-0004Vp-FG
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:36:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11CB7EAE91
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 19:36:00 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
References: <20180212222705.12718-1-bsd@redhat.com>
	<20180212222705.12718-4-bsd@redhat.com>
	<20180213120722.3td5agrejd2t7hbo@sirius.home.kraxel.org>
Date: Tue, 13 Feb 2018 14:35:59 -0500
In-Reply-To: <20180213120722.3td5agrejd2t7hbo@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Tue, 13 Feb 2018 13:07:22 +0100")
Message-ID: <jpgbmgsfzs0.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/5] usb-mtp: Support delete of mtp
 objects
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

>> +#ifndef CONFIG_INOTIFY1
>> +/* Assumes that children, if any, have been already freed */
>> +static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
>> +{
>> +    assert(o->nchildren == 0);
>> +    QTAILQ_REMOVE(&s->objects, o, next);
>> +    g_free(o->name);
>> +    g_free(o->path);
>> +    g_free(o);
>> +}
>> +#endif
>
> I'd suggest to move the #ifdef into the function, so it can be called
> unconditinally.  Also #else /* not needed with inotify because ... */
> would be nice.
>
>> +#ifndef CONFIG_INOTIFY1
>> +            usb_mtp_object_free_one(s, o);
>> +#endif
>
> These ifdefs can be dropped then.
>
>> +        /* Mark store as RW */
>> +        s->flags |= (1 << MTP_FLAG_WRITABLE);
>
> Do we want a property to enable write support?

Good idea, I will add one and set it to enabled by default.

Bandan

> cheers,
>   Gerd
