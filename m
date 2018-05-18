Received: from eggs.gnu.org ([2001:4830:134:3::10]:49083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fJk48-00048q-JK
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fJk45-0004Rb-EJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:25:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fJk45-0004RF-9H
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:25:17 -0400
From: Bandan Das <bsd@redhat.com>
References: <20180507094448.32386-1-kraxel@redhat.com>
	<20180507094448.32386-2-kraxel@redhat.com>
	<CAFEAcA9Edg2pk0x05mvfDwa8F4OjKmG-WTcnt9v17o3YVPQiWg@mail.gmail.com>
	<jpgr2maq7rs.fsf@linux.bootlegged.copy>
Date: Fri, 18 May 2018 14:25:14 -0400
In-Reply-To: <jpgr2maq7rs.fsf@linux.bootlegged.copy> (Bandan Das's message of
	"Thu, 17 May 2018 17:41:59 -0400")
Message-ID: <jpg603kyg6t.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 1/3] usb-mtp: Add some NULL checks for
 issues pointed out by coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Bandan Das <bsd@redhat.com> writes:

>> If this is a "can't happen" situation we can mark it as a false
>> positive in coverity.

I posted a patch with an assert added in usb_mtp_get_data. I believe CID 1390604 can be
marked as a false positive.

Thanks,
Bandan

> The protocol ofcourse won't let this happen but the guest can't be
> trusted. It can easily send a packet with TYPE_DATA without sending
> OBJECT_INFO first that allocates memory for data_out. I will submit a
> fix.
>
> Thanks for clearing out the confusion.
>
> Bandan
>
>> thanks
>> -- PMM
