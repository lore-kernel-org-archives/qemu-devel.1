Received: from eggs.gnu.org ([2001:4830:134:3::10]:45707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYdFA-0000HU-E3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYdF6-0006Ww-P3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:05:44 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42750
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYdF6-0006Vc-Ee
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:05:40 -0400
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
	<6d89f581-fc89-3455-60c8-439702d7bba6@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <636ae5c3-d915-d1ac-6fc0-a22ad179d1d5@cambridgegreys.com>
Date: Fri, 21 Jul 2017 20:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <6d89f581-fc89-3455-60c8-439702d7bba6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Unified Datagram Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

Hi Jason, Hi Eric, hi list,

I have gone through all comments and addressed everything to which I did 
not reply separately with clarifications.

Before I resubmit I have a couple of architectural questions:

1. Is it OK in its current form: UDST client which cannot be 
instantiated and the others creating instances of it. I am aware that 
this does not quite match the current semantics, but this keeps the 
per-transport code to the minimum possible - init and (in the newest 
version) optional verify and form header functions. F.e. in the next 
submission raw will be init only and its data - nothing else.

2. I have updated the help, docs and the API.

3. I did not quite understand your comment on socket.c - what are you 
suggesting there - do you want to fold stream mode into a common 
backend? I do not think it is possible. I have tried to do surgery only 
on the datagram stuff. Also, socket.c is quite old and has a violations 
of current coding style and conventions. Should I fix those as a part of 
the submission or this can be a separate patch?

A.


On 21/07/17 04:55, Jason Wang wrote:
>
>
> On 2017年07月21日 03:12, anton.ivanov@cambridgegreys.com wrote:
>> Hi all,
>>
>> This addresses comments so far except Eric's suggestion to use
>> InetSocketAddressBase. If I understand correctly its intended use,
>> it will not be of help for protocols which have no port (raw
>> sockets - GRE, L2TPv3, etc).
>>
>> It also includes a port of the original socket.c transport to
>> the new UDST backend. The relevant code is ifdef-ed so there
>> should be no effect on other systems.
>
> This looks sub-optimal. If you want to do this, I would rather suggest 
> you just extend the socket dgram backend like what udst did now.
>
>>
>> I think that this is would be the appropriate place to stop in this
>> iteration. I would prefer to have this polished, before I start
>> looking at sendmmsg and bulk send or some of the more unpleasant
>> encapsulations like geneve.
>
> Pay attention we're softfreeze now. So the feature is for 2.11, if it 
> looks good, I can only queue it for 2.11.
>
> Btw, looks like not all comments of v1 were addressed.
>
> Thanks
>
>>
>> A.
>>
>>
>
>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
