Received: from eggs.gnu.org ([209.51.188.92]:48741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkBv5-0000WJ-Hz
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkBv4-0003VO-KY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:57:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkBv4-0003JP-Bj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:57:34 -0500
References: <20190117090259.32713-1-sgarzare@redhat.com>
	<20190117090259.32713-6-sgarzare@redhat.com>
	<0bbdcb55-27d9-7098-10f4-aa7aef0a1c24@oracle.com>
	<aa7f4f9e-90b2-c53c-9ddb-b27fd2977d2d@redhat.com>
	<8cdb60f6-4a52-f968-d498-ee9273cb69b3@oracle.com>
	<20190117150515.rr2ksgkob7t6kene@steredhat>
	<d3180f6c-8d35-4d82-4bde-ddec5116b88f@redhat.com>
	<20190117161344.xxqbtbet6bnk6imb@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5797a98c-f428-b3a1-eef3-497f86590d65@redhat.com>
Date: Thu, 17 Jan 2019 18:57:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190117161344.xxqbtbet6bnk6imb@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/5] optionrom/pvh: load initrd from
 fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 17/01/19 17:13, Stefano Garzarella wrote:
> On Thu, Jan 17, 2019 at 04:18:00PM +0100, Paolo Bonzini wrote:
>> On 17/01/19 16:05, Stefano Garzarella wrote:
>>>> That's part of what I didn't quite understand.
>>>> pc-bios/optionrom/linuxboot.bin (and the other binaries in the 'build-all'
>>>> target in pc-bios/optionrom/Makefile) are in .gitignore.
>>>>
>>>> Also, should pvh.bin be added to BLOBS in Makefile like those files?
>>> Yes, indeed I added pvh.bin to BLOBS in patch 3/5 and I committed the
>>> binary file in /pc-bios/ (note: not in /pc-bios/optionrom/ where it is
>>> compiled, maybe is here the confusion, but I following what was done for
>>> the other option roms)
>>
>> Nevermind---I was totally sure .bin files are committed.  Though perhaps
>> they should, since non-x86 binaries are.
> 
> They are committed (in /pc-bios/) but not were they are compiled
> (in /pc-bios/optionrom/).

Oh, I see.  Sorry if I'm so dumb sometimes...

Paolo
