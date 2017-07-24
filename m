Received: from eggs.gnu.org ([2001:4830:134:3::10]:38266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dZWeo-0006aW-Cw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dZWei-0006dV-AW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:15:54 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42931
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1dZWei-0006d2-44
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:15:48 -0400
Date: Mon, 24 Jul 2017 08:15:31 +0200
In-Reply-To: <39230299-a86d-da7a-9950-5243f436862c@redhat.com>
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
	<6d89f581-fc89-3455-60c8-439702d7bba6@redhat.com>
	<1fe9110c-ae57-41e3-b479-66daa6d6cb3c@cambridgegreys.com>
	<39230299-a86d-da7a-9950-5243f436862c@redhat.com>
MIME-Version: 1.0
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <012FD853-B4CA-468B-9858-5A6657099D86@kot-begemot.co.uk>
Content-Type: text/plain;
 charset=utf-8
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
To: Jason Wang <jasowang@redhat.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, qemu-devel@nongnu.org

That is an option as well=2E=20

I am travelling this week and will get back to this first thing next week=
=2E

A=2E

On 24 July 2017 05:17:25 CEST, Jason Wang <jasowang@redhat=2Ecom> wrote:
>
>
>On 2017=E5=B9=B407=E6=9C=8821=E6=97=A5 12:25, Anton Ivanov wrote:
>>
>>
>> On 21/07/17 04:55, Jason Wang wrote:
>>>
>>>
>>> On 2017=E5=B9=B407=E6=9C=8821=E6=97=A5 03:12, anton=2Eivanov@cambridge=
greys=2Ecom wrote:
>>>> Hi all,
>>>>
>>>> This addresses comments so far except Eric's suggestion to use
>>>> InetSocketAddressBase=2E If I understand correctly its intended use,
>>>> it will not be of help for protocols which have no port (raw
>>>> sockets - GRE, L2TPv3, etc)=2E
>>>>
>>>> It also includes a port of the original socket=2Ec transport to
>>>> the new UDST backend=2E The relevant code is ifdef-ed so there
>>>> should be no effect on other systems=2E
>>>
>>> This looks sub-optimal=2E If you want to do this, I would rather=20
>>> suggest you just extend the socket dgram backend like what udst did
>now=2E
>>
>> Apologies, do you mean extend it further to handle the tcp form?=20
>
>Not that far, since you try to convert net_dgram_socket_info, I'm=20
>thinking just do the all udst in net_dgram_socket=2E For recvmmsg you can
>
>have transport specific callback for this=2E
>
>Thanks

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
