Received: from eggs.gnu.org ([2001:4830:134:3::10]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4qB-0002Mc-MW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4qA-0000ln-MU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:25:07 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:34495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW4qA-0000kV-JI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:25:06 -0500
Received: by mail-vk0-x234.google.com with SMTP id r136so116678278vke.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:25:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87fuk82x48.fsf@dusky.pond.sub.org>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
	<3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
	<87r33saa6p.fsf@dusky.pond.sub.org>
	<4cd45561-60e9-2cd2-e317-880ba9eb2f86@redhat.com>
	<87fuk82x48.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 17:24:45 +0000
Message-ID: <CAFEAcA_oBmrMGsuT8=a51eOkBDQ-Rrr4tAhi5oMGxMzb-PiVwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 24 January 2017 at 17:20, Markus Armbruster <armbru@redhat.com> wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 24/01/2017 13:56, Markus Armbruster wrote:
>>> So, what do we want to deprecate?
>>>
>>> I think the onboard SCSI HBA adopting if=scsi drives should stay,
>>> because it matches what we do for other interface types.  Unless we
>>> wanted to deprecate interface types other than none entirely.
>>
>> Yes, of course.
>>
>>> What about realview and versatile auto-creating lsi53c895a?
>>
>> That should go.
>
> Peter, do you agree?

I'm not sure what you're suggesting deprecation of -- will
command lines like
 "qemu-system-arm -M versatilepb -hda somedisk.qcow2"
still work (ie auto-create the LSI scsi adaptor and plug
the disk into it) ?

thanks
-- PMM
