Received: from eggs.gnu.org ([2001:4830:134:3::10]:49382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fQEJl-000323-9D
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fQEJi-0004el-7u
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:56:17 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fQEJi-0004eM-0d
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:56:14 -0400
Received: by mail-wr0-x244.google.com with SMTP id d2-v6so2975477wrm.10
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 08:56:13 -0700 (PDT)
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<53c37321-52d2-732c-19fb-8f6a9542c714@gmail.com>
	<20180605132948.GH32286@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0952e6da-a75f-914a-857e-40a6704cad33@gmail.com>
Date: Tue, 5 Jun 2018 18:56:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180605132948.GH32286@redhat.com>
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 06/05/2018 04:29 PM, Daniel P. Berrangé wrote:
> On Tue, Jun 05, 2018 at 04:20:46PM +0300, Marcel Apfelbaum wrote:
>>
>> On 06/05/2018 11:43 AM, Daniel P. Berrangé wrote:
>>> On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
>>>>     Hi,
>>>>
>>>>>>     Add to that shortcuts like -cdrom
>>>>>> stop working,
>>>>> Maybe is fixable.
>>>> Already fixed for ages.
>>>>
>>>>> I see marking Q35 as the default machine a first step.
>>>> Maybe the better option is to go the arm route:  Just don't define a
>>>> default, so users have to specify pc or q35.  That will make them notice
>>>> there is a world beside 'pc', and we also avoid breaking things
>>>> silently.
>> It can work, sure. And we can add user hints: "Use q35 for ...., select pc
>> if..."
>>
>>> If QEMU removes the default, then libvirt will have to hardcode
>>> 'pc' as the default to maintain back compatibility, so I don't
>>> think that ends up as a net win
>> Can't libvirt preserve 'pc' for existing domains, while defaulting to q35
>> the creation of new domains ? This way it aligns with Gerd's proposal of no
>> default x86 machine.
> Existing domains wasn't the case I was concerned about. Consider you have
> libvirt 4.4.0 intsalled and you deploy a *new* domain from a prebuilt
> disk image "foo".

Using Laszlo idea (I think):
  1) disk image "foo"/no info -> use 'pc' machine.
  2) no prebuild image (clean install?) ->  use q35 and add this info to 
xml
In the meantime find a way to embed the supported machine type(s) in the 
image.
(I think the above idea was already discussed, not sure what was the 
conclusion )


Thanks,
Marcel

>   Now update to a libvirt or QEMU which changes to q35
> and try to deploy another new domain from the same prebuilt disk
> image "foo". It may not work now if that disk image doesn't support
> q35. That would be a regression from the user's POV, whether libvirt or
> qemu has changed the default.
>
> Regards,
> Daniel
