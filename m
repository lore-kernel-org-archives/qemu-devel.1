Received: from eggs.gnu.org ([2001:4830:134:3::10]:48012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dZTsE-0002A9-Sq
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dZTsB-0000D7-PQ
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:17:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dZTsB-0000Ch-J5
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:17:31 -0400
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
	<6d89f581-fc89-3455-60c8-439702d7bba6@redhat.com>
	<1fe9110c-ae57-41e3-b479-66daa6d6cb3c@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <39230299-a86d-da7a-9950-5243f436862c@redhat.com>
Date: Mon, 24 Jul 2017 11:17:25 +0800
MIME-Version: 1.0
In-Reply-To: <1fe9110c-ae57-41e3-b479-66daa6d6cb3c@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Unified Datagram Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B407=E6=9C=8821=E6=97=A5 12:25, Anton Ivanov wrote:
>
>
> On 21/07/17 04:55, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B407=E6=9C=8821=E6=97=A5 03:12, anton.ivanov@cambridgegr=
eys.com wrote:
>>> Hi all,
>>>
>>> This addresses comments so far except Eric's suggestion to use
>>> InetSocketAddressBase. If I understand correctly its intended use,
>>> it will not be of help for protocols which have no port (raw
>>> sockets - GRE, L2TPv3, etc).
>>>
>>> It also includes a port of the original socket.c transport to
>>> the new UDST backend. The relevant code is ifdef-ed so there
>>> should be no effect on other systems.
>>
>> This looks sub-optimal. If you want to do this, I would rather=20
>> suggest you just extend the socket dgram backend like what udst did no=
w.
>
> Apologies, do you mean extend it further to handle the tcp form?=20

Not that far, since you try to convert net_dgram_socket_info, I'm=20
thinking just do the all udst in net_dgram_socket. For recvmmsg you can=20
have transport specific callback for this.

Thanks
