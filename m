Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92220C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4732809B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4732809B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXkBH-0000Za-1V
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 06:27:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXkAR-0000Az-P8
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXkAP-0003X6-8q
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:26:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hXkAI-00031D-Uz
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DFE72F8BCF;
	Mon,  3 Jun 2019 10:25:53 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-13.rdu2.redhat.com
	[10.10.121.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60682104B4C2;
	Mon,  3 Jun 2019 10:25:46 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190528204838.21568-1-kraxel@redhat.com>
	<bf45adf2-1594-89b4-6a4d-9af6d9e8ac6e@redhat.com>
	<20190528224810-mutt-send-email-mst@kernel.org>
	<20190529044701.skqpsdna3c5yvbnm@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d8b99f5b-301c-317a-2a8a-db687ebd1e52@redhat.com>
Date: Mon, 3 Jun 2019 12:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190529044701.skqpsdna3c5yvbnm@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 03 Jun 2019 10:25:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: split memory at 2G
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/29/19 06:47, Gerd Hoffmann wrote:
> On Tue, May 28, 2019 at 10:49:55PM -0400, Michael S. Tsirkin wrote:
>> On Wed, May 29, 2019 at 03:21:16AM +0200, Paolo Bonzini wrote:
>>> On 28/05/19 22:48, Gerd Hoffmann wrote:
>>>> Original q35 behavior was to split memory 2.75 GB, leaving space for the
>>>> mmconfig bar at 0xb000000 and pci I/O window starting at 0xc0000000.
>>>>
>>>> Note: Those machine types have been removed from the qemu codebase
>>>> meanwhile because they could not be live-migrated so there was little
>>>> value in keeping them around.
>>>>
>>>> With the effort to allow for gigabyte-alignment of guest memory that
>>>> behavior was changed:  The split was moved to 2G, but only in case the
>>>> memory didn't fit below 2.75 GB.
>>>>
>>>> So today the address space between 2G and 2,75G is not used for guest
>>>> memory in typical use cases, where the guest memory sized at a power of
>>>> two or a gigabyte number.  But if you configure your guest with some odd
>>>> amout of memory (such as 2.5G) the address space is used.
>>>
>>> Wasn't it done to ensure pre-PAE OSes could use as much memory as
>>> possible?  (If you run pre-PAE OSes with more RAM than can fit below 4G,
>>> you can just reduce the amount of memory and get all the 2.75G).
>>>
>>> Paolo
>>
>> Absolutely. Gerd is just saying the configuration is rare enough that
>> it's not worth worrying about. I don't know myself - why do
>> we bother making this change? What's the advantage?
> 
> Some ovmf versions place the mmconfig @ 2G.  Which works fine in 99% of
> the cases, but with memory sizes between 2G and 2.75G it doesn't.

Here's the stages of PCIEXBAR placement in OVMF:

#1 Commit 7b8fe63561b4 ("OvmfPkg: PlatformPei: enable PCIEXBAR (aka
MMCONFIG / ECAM) on Q35", 2016-03-10): places the PCIEXBAR at 2GB.
Behaves according to your description.

#2 Commit 75136b29541b ("OvmfPkg/PlatformPei: reorder the 32-bit PCI
window vs. the PCIEXBAR on q35", 2019-05-16): made for the 1% of cases
(according to your description) where the previous logic would fail,
namely with RAM between 2G and 2.75G. Places the PCIEXBAR at
0xE000_0000, and the 32-bit MMIO window below it. Unfortunately, this
causes a regression for end-users, because this ordering of areas
triggers a bug in QEMU's ACPI generator somewhere. The 32-bit MMIO
window will be clamped *above* 0xF000_0000, when it should actually end
at 0xE000_0000. Causes confusion for some guest OSes (the mildest
symptom is PCI resource reassignment).

#3 Patch series linked in
<https://bugzilla.tianocore.org/show_bug.cgi?id=1859#c1>: restores the
original order (so as to pacify the ACPI generator in QEMU). Places the
PCIEXBAR at 0xB000_0000. Places the 32-bit MMIO window at 0xC000_0000.
This wastes a bit of 32-bit MMIO space, but it has the best
compatibility. The cases under which the waste occurs are: (a) pre-4.1
Q35 machine types with low RAM side *outside* of 2GB..2.75GB, and (b)
4.1+ Q35 machine types (with this patch applied), regardless of low RAM
size. Effectively this patch set returns to the first variant, except it
bumps the PCIEXBAR base from 2GB to 2.75GB.

Once all pre-4.1 Q35 machine types can be considered obsolete, we can
return OVMF to option#1 again. Until then, it's best to fix the host
side and the guest side both, for best compatibility for end-users.
(This is generally what we do, i.e. fix both sides, when there is a
host-guest disagreement.)

So, for this patch:

Acked-by: Laszlo Ersek <lersek@redhat.com>

I'll also push (soon) the edk2 patches for option#3 above.

(

Things I haven't discussed here: (a) why we'd like to continue
specifying the PXIEXBAR base in OVMF as a build-time constant (because
making it dynamic might introduce complications for module dispatch
order), (b) MTRR aspects (both the PCIEXBAR and the 32-bit MMIO window
should be marked UC through variable MTRRs, and while SeaBIOS currently
ignores the first, I wouldn't like to, in OVMF). All of options #1
through #3 can be made work correctly wrt. variable MTRRs, but *some*
OVMF patches are necessary for either of those.

)

Thanks
Laszlo

