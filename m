Received: from eggs.gnu.org ([2001:4830:134:3::10]:47197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1co90W-0004vs-7M
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1co90T-0002PT-4u
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:30:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33339
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1co90S-0002PF-Tl
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:30:25 -0400
References: <1489496187-624-1-git-send-email-peterx@redhat.com>
	<20170315032001-mutt-send-email-mst@kernel.org>
	<20170315031550.GG12964@pxdev.xzpeter.org>
	<20170315052418-mutt-send-email-mst@kernel.org>
	<20170315040427.GH12964@pxdev.xzpeter.org>
	<20170315061900-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8730ce95-6422-efab-bbba-31013b4644dd@ilande.co.uk>
Date: Wed, 15 Mar 2017 13:30:05 +0000
MIME-Version: 1.0
In-Reply-To: <20170315061900-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: info mtree check mr range overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 15/03/17 04:23, Michael S. Tsirkin wrote:

>>>> Could you help elaborate in what case will we really need that 128 bit
>>>> address?
>>>
>>> This is how memory API works. It uses 128 bit addresses (in reality
>>> it typically only needs 64 bit addresses but 128 means it can do
>>> math without worrying about it too much).
>>
>> Yes. To be more specific, could I ask why do we need 128 bits here
>> when doing "info mtree"?
> 
> Because when you add two 64 bit addresses you sometimes get a 67
> bit one. info mtree shows some fictitious data: base/end addresses
> that region would have had if it was fully visible in a flatview.
> 67 bit addresses are never visible there, that is true,
> but that is not the only kind of address that is not visible
> in flatview yet shown by info mtree.

Note that I'm going to send a PR for the OpenBIOS fix hopefully later
today which means the original test case shouldn't occur anymore.

However I will manually test any patches that are submitted to verify
that they work correctly for this particular case.


ATB,

Mark.
