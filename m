Received: from eggs.gnu.org ([2001:4830:134:3::10]:53556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW588-0004dQ-Rq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW57a-0003cp-Kn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:43:40 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
	<3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
	<87r33saa6p.fsf@dusky.pond.sub.org>
	<4cd45561-60e9-2cd2-e317-880ba9eb2f86@redhat.com>
	<87fuk82x48.fsf@dusky.pond.sub.org>
	<CAFEAcA_oBmrMGsuT8=a51eOkBDQ-Rrr4tAhi5oMGxMzb-PiVwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d55bfe0-20f3-d153-910b-7c28fd74f6ab@redhat.com>
Date: Tue, 24 Jan 2017 18:40:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_oBmrMGsuT8=a51eOkBDQ-Rrr4tAhi5oMGxMzb-PiVwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>



On 24/01/2017 18:24, Peter Maydell wrote:
> On 24 January 2017 at 17:20, Markus Armbruster <armbru@redhat.com> wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 24/01/2017 13:56, Markus Armbruster wrote:
>>>> So, what do we want to deprecate?
>>>>
>>>> I think the onboard SCSI HBA adopting if=scsi drives should stay,
>>>> because it matches what we do for other interface types.  Unless we
>>>> wanted to deprecate interface types other than none entirely.
>>>
>>> Yes, of course.
>>>
>>>> What about realview and versatile auto-creating lsi53c895a?
>>>
>>> That should go.
>>
>> Peter, do you agree?
> 
> I'm not sure what you're suggesting deprecation of -- will
> command lines like
>  "qemu-system-arm -M versatilepb -hda somedisk.qcow2"
> still work (ie auto-create the LSI scsi adaptor and plug
> the disk into it) ?

No, I was confusing with the boards that Markus is fixing in patch 4.
But is really lsi53c895a the best we can provide for
versatilepb/versatileab/realview-eb/realview-eb-mpcore? Could virtio-pci
work well too?...

Paolo
