Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ronniesahlberg@gmail.com>) id 1eNBoo-0008Le-Ql
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ronniesahlberg@gmail.com>) id 1eNBon-0003bG-QA
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:07:30 -0500
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:42262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ronniesahlberg@gmail.com>)
	id 1eNBon-0003aP-Km
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:07:29 -0500
Received: by mail-qt0-x22d.google.com with SMTP id g9so23644016qth.9
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 22:07:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207184104.GA2489@work-vm>
References: <CAO1xR-zb6Eni1LD0PB80hGRKU8PCqxjbfHtVM4aUt9i+3Utq3w@mail.gmail.com>
	<20171207184104.GA2489@work-vm>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Fri, 8 Dec 2017 16:07:28 +1000
Message-ID: <CAN05THQcpCXpckxAymH00G96XdJ30RsnGAgXOA+F98vaaKWgHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] iSER transport name is not good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Charles Kelimod <lichstor@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>

David,

Yes, QEMU has supported iSER (iSCSI extensions for RDMA) via a
userspace library, libiscsi, since about a year.
Here is a nice presentation from the developer of iSER support :
https://www.google.com.au/url?sa=3Dt&rct=3Dj&q=3D&esrc=3Ds&source=3Dweb&cd=
=3D1&cad=3Drja&uact=3D8&ved=3D0ahUKEwjChpba3PnXAhXBKZQKHQa9DEYQFggpMAA&url=
=3Dhttps%3A%2F%2Fwww.snia.org%2Fsites%2Fdefault%2Ffiles%2FSDC%2F2016%2Fpres=
entations%2Fstorage_networking%2FShterman-Grimberg_Greenberg_Performance%25=
20Implications%2520Libiscsi_%2520RDMA_V6.pdf&usg=3DAOvVaw3xyvdIciRKVprboN6r=
ClTA

In QEMU, you use it the same way as you would use the userspace iSCSI
support which has been in QEMU for quite a long time.
The only difference is that instead of providing a
iscsi://<host>/<iqn>/<lun> you select iSER by specifying an url of the
form
iser://<host>/<iqn>/<lun>


I.e. the only difference is the protocol part of the URL. When QEMU
passes this URL to libiscsi, it allows the library to decide on
whether to use normal iSCSI or whether it should use iSER.

I think RDMA would be a less good name for this as RDMA is not only
used to transport iSCSI but is also used for NFS as well as SMB.



regards
ronnie sahlberg


On Fri, Dec 8, 2017 at 4:41 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Charles Kelimod (lichstor@gmail.com) wrote:
>> Hello,
>>
>>
>> I'm on the road of modifying libvirt to add iSER support, and I found qe=
mu
>> is actually support that. But, the transport name is iSER, which should =
be
>> RDMA and there libvirt already defined it.
>>
>> Best Regards,
>> Charles.
>
> Hi Charles,
>   So this is iSCSI extensions for RDMA?  I've cc'd in the qemu iSCSI
> maintainers.
>   Can you just explain what you're seeing libvirt do and what you think
> qemu is expecting it to do for iSER?
>
> Dave
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
