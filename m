Received: from eggs.gnu.org ([2001:4830:134:3::10]:50455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMDZ4-0001PF-96
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMDZ3-0005ve-DE
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:47:14 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eMDZ3-0005vB-6e
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:47:13 -0500
Received: by mail-wm0-x242.google.com with SMTP id f206so1341557wmf.5
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 05:47:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
References: <20171205063313.GB4102@yangzhon-Virtual>
	<20171205120623.GB31150@stefanha-x1.localdomain>
	<5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Dec 2017 13:47:10 +0000
Message-ID: <CAJSP0QVn0Uq_XO-22cz1JzbgEaFfwwX9yXBk1eKKkMfknADFmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Yang Zhong <yang.zhong@intel.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Dec 5, 2017 at 1:35 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 05/12/2017 13:06, Stefan Hajnoczi wrote:
>> On Tue, Dec 05, 2017 at 02:33:13PM +0800, Yang Zhong wrote:
>>> As you know, AWS has decided to switch to KVM in their clouds. This news make almost all
>>> china CSPs(clouds service provider) pay more attention on KVM/Qemu, especially light VM
>>> solution.
>>>
>>> Below are intel solution for light VM, qemu-lite.
>>> http://events.linuxfoundation.org/sites/events/files/slides/Light%20weight%20virtualization%20with%20QEMU%26KVM_0.pdf
>>>
>>> My question is whether community has some plan to implement light VM or alternative solutions? If no, whether our
>>> qemu-lite solution is suitable for upstream again? Many thanks!
>>
>> What caused a lot of discussion and held back progress was the approach
>> that was taken.  The basic philosophy seems to be bypassing or
>> special-casing components in order to avoid slow operations.  This
>> requires special QEMU, firmware, and/or guest kernel binaries and causes
>> extra work for the management stack, distributions, and testers.
>
> I think having a special firmware (be it qboot or a special-purpose
> SeaBIOS) is acceptable.

The work Marc Mari Barcelo did in 2015 showed that SeaBIOS can boot
guests quickly.  The guest kernel was entered in <35 milliseconds
IIRC.  Why is special firmware necessary?

I'm not against additional binaries if there's no other way, but it's
important to demonstrate why special-casing is necessary.
