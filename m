Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e5Rgt-0001Oz-Ew
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e5Rgq-0002NQ-9i
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:25:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:62290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e5Rgq-0002LD-0Y
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:25:56 -0400
References: <20170925231924.31303-1-carenas@gmail.com>
	<CAPUEspg5AO_XzLa1n3cCTrz+22WYk5BZrE28ufDjPP7Y3KN2+Q@mail.gmail.com>
	<20171016123250.GB1918@kos.to>
	<CAPUEspi530ypdV0ZrKJ5b8ZbZEm-LJCwvbFAUMOmcn_FFcRHSQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8e063f00-e302-9f0b-3dec-3c40ac31b2e3@vivier.eu>
Date: Fri, 20 Oct 2017 09:25:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAPUEspi530ypdV0ZrKJ5b8ZbZEm-LJCwvbFAUMOmcn_FFcRHSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] linux-user: refactor socket.h into architecture
 specific sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carlo Arenas <carenas@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

Le 17/10/2017 à 16:35, Carlo Arenas a écrit :
> On Mon, Oct 16, 2017 at 5:32 AM, Riku Voipio <riku.voipio@iki.fi> wrote:
>> On Wed, Oct 11, 2017 at 12:10:04AM -0700, Carlo Arenas wrote:
>>> some of the patches already have a Reviewed-by as shown by :
>>>
>>>   http://patchwork.ozlabs.org/patch/818378/
>>
>> Can you send the series without the whitespace-only changes?
> 
> sure, but how would you suggest then to do the other changes which are
> the overall objective for this?
> 
> * fix any incorrect values (mostly sparc, but there are also in all
> other archs incorrect names)
> * make sure that the arch specific file mirrors as much as possible
> linux headers, so it will be straightforward to update them (even
> possible through a script)
> * update the arch specific files with latest bits from 4.14
> 
> should I send those as independent series?, or just as additional
> patches in the series, so it is obvious what the dependency is.
> 
> there is also the problem with the enum and related defines which was
> custom made and probably copy & pasted around

I think you should re-send your series without changing any indentation
and without "[PATCH v2 6/6]". So, I think they'll be applied.

Then, if you think the remaining changes are important, you could try to
submit a new patch series to do that.

Thanks,
Laurent
