Received: from eggs.gnu.org ([2001:4830:134:3::10]:53629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYAIN-0000cA-0h
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYAIJ-0004ol-QO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:15:38 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYAIJ-0004nP-IY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:15:35 -0400
Received: by mail-wm0-f43.google.com with SMTP id z13-v6so5466601wma.5
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:15:35 -0700 (PDT)
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<20180627111319.4mlws52yq5ldoxwe@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <556c60ab-8cd9-1f4c-e507-2d25fb580843@redhat.com>
Date: Wed, 27 Jun 2018 15:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180627111319.4mlws52yq5ldoxwe@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

On 27/06/2018 13:13, Gerd Hoffmann wrote:
>   Hi,
> 
>> Given the code runs under big qemu lock anyway the atomics are not
>> needed, so we could drop just them.  I left them in nevertheless because
>>
>>   (a) we might want try run the code in a thread instead of using a timer, and
>>   (b) I was too lazy to rewrite the code to drop the atomics.
>>
>> I'd prefer to keep option (a) ...
> 
> Well, experimented with that a bit. 
> 
> As long as the core audio system runs using qemu timers too moving to a
> thread doesn't buy us much as any latency spikes in qemu will hit us no
> matter what.
> 
> So, that point is moot.  I'll go drop the atomics.

Try stat64.  It should work just fine as it's made exactly for this kind
of simple counter.

Paolo
