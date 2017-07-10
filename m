Received: from eggs.gnu.org ([2001:4830:134:3::10]:47820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dUTvj-0007BE-1U
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dUTvf-0004FV-TM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:20:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37512 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dUTvf-0004Ds-L5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:20:27 -0400
References: <1499234355-138591-1-git-send-email-agraf@suse.de>
	<87bmozb7hj.fsf@dusky.pond.sub.org>
	<a58a7cf7-a079-2799-ac99-696b85ecc654@suse.de>
	<1499671202.23551.10.camel@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <ac29f599-5468-501d-c549-78bb6411d412@suse.de>
Date: Mon, 10 Jul 2017 10:20:25 +0200
MIME-Version: 1.0
In-Reply-To: <1499671202.23551.10.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vnc: Set default kbd delay to 10ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/10/2017 09:20 AM, Gerd Hoffmann wrote:
> On Thu, 2017-07-06 at 09:08 +0200, Alexander Graf wrote:
>> On 05.07.17 10:42, Markus Armbruster wrote:
>>> Alexander Graf <agraf@suse.de> writes:
>>>
>>>> The default keyboard delay time in the input layer is 10ms. I
>>>> don't know
>>> Do you mean "is 1ms"?
>> Yes, of course :). Sorry.
> Given the last paragraph of the commit message 10ms looks correct.  If

Wow, I guess I wrote the message so confusingly that I even confused 
myself. Yes, of course 10ms is correct. There is an "input layer" delay 
and a "vnc" delay. Today "input layer" delay defaults to 10ms while 
"vnc" delay defaults to 1ms.

> you change it to 1ms you also want to change "input layer" to "vnc
> server" ...
>
> Or, better, move the last paragraph (which points out the inconsistency
>   between input layer and vnc server defaults) to the top, then it's
> easier to read I guess.

Yeah, I agree.


Alex
