Received: from eggs.gnu.org ([2001:4830:134:3::10]:44546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vicviq@gmail.com>) id 1gAGXQ-0000Yc-HO
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vicviq@gmail.com>) id 1gAGXP-0005ZI-92
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:36:40 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:46541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vicviq@gmail.com>) id 1gAGXP-0005Ya-1c
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:36:39 -0400
Received: by mail-ot1-x334.google.com with SMTP id o21so5765308otb.13
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 08:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALF8MVHZSWutrbc-X04OMLQA1WZ1rSznbrxS68Z7eRRxL8YPqg@mail.gmail.com>
	<325a30bd-d62d-b846-4e23-fdd5d0089944@comstyle.com>
	<CALF8MVH-Uwd8toWwKwUVviHSa93q9MOSEgOsL7UUA_Zw4DsUTg@mail.gmail.com>
	<2039d7b0-5f46-36b1-b44d-7ebe4b2f1d4c@comstyle.com>
In-Reply-To: <2039d7b0-5f46-36b1-b44d-7ebe4b2f1d4c@comstyle.com>
From: viq <vicviq@gmail.com>
Date: Wed, 10 Oct 2018 17:36:25 +0200
Message-ID: <CALF8MVFy4YjUxvJBoTwk=ZjR56PyZXFC6v+FiGwmHWWtEAoqCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] OpenBSD with VirtIO networking causes QEMU to crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad <brad@comstyle.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 10, 2018 at 5:35 PM Brad Smith <brad@comstyle.com> wrote:

> On 10/10/2018 8:29 AM, viq wrote:
>
> On Wed, Oct 10, 2018 at 1:54 PM Brad Smith <brad@comstyle.com> wrote:
>
>> On 10/9/2018 2:42 PM, viq wrote:
>>
>> > (please CC me as I'm not subscribed to the list)
>> > I verified the behaviour on two different machines, both running
>> archlinux
>> > with QEMU 3.0.0 and reported it on
>> https://bugs.archlinux.org/task/60141
>> > where it was suggested I bring it to the list.
>> >
>> > So what happens: if you try to run OpenBSD with VirtIO networking
>> enabled,
>> > the moment OpenBSD brings up network the QEMU process crashes. Easiest
>> > steps to reproduce:
>> > Download for example
>> > https://ftp.halifax.rwth-aachen.de/pub/OpenBSD/6.3/amd64/install63.iso
>> > Create new VM under libvirt as OpenBSD 6.3, create disk, "change options
>> > before installation", change disk and network types to virtio
>> > Proceed with installation (basically enter-enter-enter-...)
>> > Observe qemu crash when network is brought up.
>> >
>> > Sorry, I don't really know how to proceed further with that.
>>
>> A regression with 3.0.0.
>>
>> https://marc.info/?l=qemu-devel&m=153635729122442&w=2
>>
>>
> Thank you Brad!
> With that find, should I keep debugging, or is this information sufficient?
>
> No need to do anything more. Just provide the URL in your Arch bug report
> so the diff is rolled into their package.
>

Already done, thank you!
-- 
viq
