Received: from eggs.gnu.org ([2001:4830:134:3::10]:38875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dYPAO-000804-Nz
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dYPAL-0002Vs-Kp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:03:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dYPAL-0002TQ-Ex
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:03:49 -0400
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6d89f581-fc89-3455-60c8-439702d7bba6@redhat.com>
Date: Fri, 21 Jul 2017 11:55:06 +0800
MIME-Version: 1.0
In-Reply-To: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org



On 2017=E5=B9=B407=E6=9C=8821=E6=97=A5 03:12, anton.ivanov@cambridgegreys=
.com wrote:
> Hi all,
>
> This addresses comments so far except Eric's suggestion to use
> InetSocketAddressBase. If I understand correctly its intended use,
> it will not be of help for protocols which have no port (raw
> sockets - GRE, L2TPv3, etc).
>
> It also includes a port of the original socket.c transport to
> the new UDST backend. The relevant code is ifdef-ed so there
> should be no effect on other systems.

This looks sub-optimal. If you want to do this, I would rather suggest=20
you just extend the socket dgram backend like what udst did now.

>
> I think that this is would be the appropriate place to stop in this
> iteration. I would prefer to have this polished, before I start
> looking at sendmmsg and bulk send or some of the more unpleasant
> encapsulations like geneve.

Pay attention we're softfreeze now. So the feature is for 2.11, if it=20
looks good, I can only queue it for 2.11.

Btw, looks like not all comments of v1 were addressed.

Thanks

>
> A.
>
>
