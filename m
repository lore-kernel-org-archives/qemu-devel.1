Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB8DC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 21:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A025E222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 21:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1blAxhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A025E222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2iSt-0004MH-Q5
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 16:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j2iSF-0003T9-NR
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 16:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j2iSD-0000Ht-C3
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 16:24:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j2iSB-0000FX-IY
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 16:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581715490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XfOz1oKC/G968G5c9w6af6IytGBJo6pJOCZTROgVXI=;
 b=Y1blAxhGxbXw9bcc935L9D8xH9ORocJx4Ft+UND4ms+6rwwzd9+57CFns0FiOR3Hq10kyC
 WIUB7jwSLOec0cnJp+ZFkySzcg2KMovR4zz1Btq3uYgWRay2jwzAPg4v1k+s/idxoeulB5
 Hs1bqAc6WRUygriMtlDfPGyNyKcc3vE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-AXfk4rvwO7atbssyYMqWqw-1; Fri, 14 Feb 2020 16:24:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75EF0477;
 Fri, 14 Feb 2020 21:24:44 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-153.ams2.redhat.com
 [10.36.116.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B6545DA7D;
 Fri, 14 Feb 2020 21:24:40 +0000 (UTC)
Subject: Re: How do UEFI on Windows host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Jerry Geis <jerry.geis@gmail.com>
References: <CABr8-B4_mEkOkodKVVe=U_eiMemWictNSQj4T5R6nEynVXCEGw@mail.gmail.com>
 <58491266-962f-4c4f-9a51-829ec30f008b@redhat.com>
 <CABr8-B6xARb1iuD7M_i9Pgs7OXF+EQQBxKDDC-o_imbiEDbMJw@mail.gmail.com>
 <6aad5b16-53c5-4485-381c-1cb990c8b766@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <146b553d-cbe7-ac87-9423-bd07602e3e01@redhat.com>
Date: Fri, 14 Feb 2020 22:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6aad5b16-53c5-4485-381c-1cb990c8b766@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: AXfk4rvwO7atbssyYMqWqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/14/20 19:12, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/14/20 5:37 PM, Jerry Geis wrote:
>> I dont know how to get all files listing on windows. But, I cd
>> \program files\qemu
>> dir *.fd
>> edk2-x86_64-code.fd
>> edk2-x86_64-secure-code.fd
>>
>> It seems like from other posts these might be the files - but still
>> not sure how to do "boot" a command line for UEFI.
>
> I tested/added these files in commit e54ecc70c34:
>
>     NSIS: Add missing firmware blobs
>
>     Various firmwares has been added in the pc-bios/ directory:
>
>     - CCW     (since commit 0c1fecdd523)
>     - skiboot (since commit bcad45de6a0)
>     - EDK2    (since commit f7fa38b74c3)
>
> Stefan can you describe how you generate the binaries in
> https://qemu.weilnetz.de/w64/ ? Maybe the bunzip2 step is not called?
>

Thank you, Phil! The following line from your patch:

+    File "${BINDIR}\*.fd"

should hopefully cover everything that Jerry needs. So I guess the only
missing piece is the right QEMU command line.

Jerry:

(1) You will have to manage the virtual machine's private variable store
file manually.

You have to create the varstore manually first, from the varstore
template: copy "edk2-i386-vars.fd" to a new file; for example, to
"my-guest.vars.fd".

Then you have to treat "my-guest.vars.fd" like another data disk, for
the guest.

Never use the "edk2-i386-vars.fd" template file itself on any QEMU
command line.


(2) Next step, choose one of the following firmware binaries:

(2a) edk2-x86_64-code.fd
(2b) edk2-x86_64-secure-code.fd

The (2a) firmware binary runs on both the i440fx ("pc") machine type,
and the q35 machine type. It does not include the Secure Boot UEFI
feature. It also does not include the edk2 SMM stack. Use this binary if
you don't care about Secure Boot for your guest, or insist on using
"pc".

The (2b) firmware binary runs only on "q35". It's strongly recommended
to use the latest version of the "q35" machine type available in your
QEMU executable, with this firmware binary. This firmware binary
includes both the Secure Boot feature, and the edk2 SMM stack. (The
latter is used to protect the former, but that's not really important
now.) The "q35" machine type restriction actually comes from the SMM
stack. Use this firmware binary if you want the Secure Boot feature.

In case you pick (2b), note that the Secure Boot *operational mode* is
not automatically enabled in your guest. You will have to enroll SB keys
/ certificates manually. You can do that e.g. in the firmware setup TUI
in the guest. You can find resources about this on the net.


(3) Assuming you've picked your firmware binary, here are the
*additional* command line options for qemu-system-x86_64 (that is, these
options should be appended after your usual options):

- For (2a):

  -machine pflash0=3Dfirmware-executable,pflash1=3Dvariable-store \
  -blockdev node-name=3Dfirmware-executable,read-only=3Don,driver=3Dfile,fi=
lename=3Dedk2-x86_64-code.fd \
  -blockdev node-name=3Dvariable-store,read-only=3Doff,driver=3Dfile,filena=
me=3Dmy-guest.vars.fd \

- For (2b): everything you see under (2a), *plus*

  -machine type=3Dq35,smm=3Don \
  -global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don \

(Don't forget to change the filename in the "firmware-executable"
blockdev, from "edk2-x86_64-code.fd" to "edk2-x86_64-secure-code.fd"!)


(4) If you'd like a progress bar (a bit of time) at the OVMF splash
screen, you can append (in either case):

  -boot menu=3Don,splash-time=3D5000 \


(5) In order to capture the firmware debug log, append:

  -global isa-debugcon.iobase=3D0x402 \
  -debugcon file:ovmf_log.txt \


(6) Note that firmware-specific options that you may be used to with
SeaBIOS are not guaranteed to behave identically (or at all) with OVMF.
Some examples (not an exhaustive list):

- with the "-boot" option, only "menu" and "splash-time" are supported,
  and they don't work identically to SeaBIOS

- "-boot strict=3Don" is always assumed

- to highlight boot order setting, "-boot order=3D..." does not (cannot)
  work with UEFI; you have to use the device-specific "bootindex"
  properties. For example, to place a virtio-scsi CD-ROM first in the
  boot order, use:

  -device virtio-scsi-pci,id=3Dscsi0 \
  -device scsi-cd,bus=3Dscsi0.0,drive=3DBlockDevName,bootindex=3D0 \
                                                 ^^^^^^^^^^^

  If you specify at least one "bootindex" property, then you should
  specify bootindex properties with *all* devices that you want to
  attempt booting from. (See "strict" above.)

- Avoid switches like "-hda"; use the full-blown blockdev (backend) +
  device (frontend) syntax.

(Note that libvirt would automate away almost all of the above for you.
But I'm unsure if you can, or are willing to, use libvirt on a Windows
host.)


(7) In the general case, you can't boot a 64-bit OS on a 32-bit UEFI
firmware, nor vice versa. The "bitnesses" must match. (People forget
this frequently.)

Hope this helps,
Laszlo


