Received: from eggs.gnu.org ([2001:4830:134:3::10]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fQBtO-0000vS-Ug
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fQBtL-00077E-Pp
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:54 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fQBtL-00076a-Ie
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:51 -0400
Received: by mail-wm0-x241.google.com with SMTP id m129-v6so5060863wmb.3
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 06:20:51 -0700 (PDT)
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <53c37321-52d2-732c-19fb-8f6a9542c714@gmail.com>
Date: Tue, 5 Jun 2018 16:20:46 +0300
MIME-Version: 1.0
In-Reply-To: <20180605084300.GF32286@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>



On 06/05/2018 11:43 AM, Daniel P. Berrangé wrote:
> On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
>>    Hi,
>>
>>>>    Add to that shortcuts like -cdrom
>>>> stop working,
>>> Maybe is fixable.
>> Already fixed for ages.
>>
>>> I see marking Q35 as the default machine a first step.
>> Maybe the better option is to go the arm route:  Just don't define a
>> default, so users have to specify pc or q35.  That will make them notice
>> there is a world beside 'pc', and we also avoid breaking things
>> silently.

It can work, sure. And we can add user hints: "Use q35 for ...., select 
pc if..."

> If QEMU removes the default, then libvirt will have to hardcode
> 'pc' as the default to maintain back compatibility, so I don't
> think that ends up as a net win

Can't libvirt preserve 'pc' for existing domains, while defaulting to q35
the creation of new domains ? This way it aligns with Gerd's proposal of 
no default
x86 machine.

Thanks,
Marcel

>
> Regards,
> Daniel
