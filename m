Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D8C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E34F20863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E34F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTS9j-0004if-J2
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:23:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hTS8v-0004Pj-Lo
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hTS8t-0007hB-1G
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hTS8s-0007A2-6l
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:22:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 906E75947D;
	Wed, 22 May 2019 14:22:42 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-230.rdu2.redhat.com
	[10.10.120.230])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD4860928;
	Wed, 22 May 2019 14:22:32 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
	<20190521092553-mutt-send-email-mst@kernel.org>
	<20190522150642.3da34e6b@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4b230fb0-ae2c-5221-39cb-1bed7b6df8d0@redhat.com>
Date: Wed, 22 May 2019 16:22:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190522150642.3da34e6b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 22 May 2019 14:22:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/22/19 15:06, Igor Mammedov wrote:
> On Tue, 21 May 2019 09:26:16 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Tue, May 21, 2019 at 12:49:48PM +0100, Peter Maydell wrote:
>>> On Tue, 21 May 2019 at 00:10, Michael S. Tsirkin <mst@redhat.com> wrote:  
>>>>
>>>> The following changes since commit 2259637b95bef3116cc262459271de08e038cc66:
>>>>
>>>>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-05-20 17:22:05 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>>
>>>> for you to fetch changes up to 0c05ec64c388aea59facbef740651afa78e04f50:
>>>>
>>>>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-20 18:40:02 -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> pci, pc, virtio: features, fixes
>>>>
>>>> reconnect for vhost blk
>>>> tests for UEFI
>>>> misc other stuff
>>>>
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>
>>>> ----------------------------------------------------------------  
>>>
>>> Hi -- this failed 'make check' for 32-bit Arm hosts:
>>>
>>> ERROR:/home/peter.maydell/qemu/tests/acpi-utils.c:145:acpi_find_rsdp_address_uefi:
>>> code should not be reached
>>> Aborted
>>> ERROR - too few tests run (expected 1, got 0)
>>> /home/peter.maydell/qemu/tests/Makefile.include:885: recipe for target
>>> 'check-qtest-aarch64' failed
>>>
>>> thanks
>>> -- PMM  
>>
>> Nothing jumps out ... Igor?
> On 32-bit ARM host and it looks like UEFI crashes (CCing Laszlo) with:
> 
> InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 469E52C0
> ASSERT [DxeCore] /home/lacos/src/upstream/qemu/roms/edk2/MdePkg/Library/BaseLib/String.c(1090): Length < _gPcd_FixedAtBuild_PcdMaximumAsciiStringLength
> 
> CLI to reproduce:
> 
> qemu-system-aarch64  -display none -machine virt,accel=tcg -nodefaults -nographic -drive if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly -drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 -cpu cortex-a57 -serial stdio

This is very interesting. I had obviously tested booting
"bios-tables-test.aarch64.iso.qcow2" against "edk2-aarch64-code.fd",
using TCG, on my x86_64 laptop. (And, I've run the above exact command
just now, at commit a4f667b67149 -- it works 100% fine.)

However, I've never been *near* a 32-bit ARM host. Therefore my
suspicion is that the AARCH64 UEFI guest code tickles something in the
32-bit ARM code generator. It could be a bug in 32-bit ARM TCG, or it
could be a bug in edk2 that is exposed by 32-bit ARM TCG.

The direct assertion failure is mostly useless. The AsciiStrLen()
function does what you'd expect it to, except it has a kind of "safety
check" where it trips an assertion if the string length (under
measurement) exceeds a pre-set platform constant. It helps with catching
memory corruption errors.

$ git show edk2-stable201903:MdePkg/Library/BaseLib/String.c | less
1090g

UINTN
EFIAPI
AsciiStrLen (
  IN      CONST CHAR8               *String
  )
{
  UINTN                             Length;

  ASSERT (String != NULL);

  for (Length = 0; *String != '\0'; String++, Length++) {
    //
    // If PcdMaximumUnicodeStringLength is not zero,
    // length should not more than PcdMaximumUnicodeStringLength
    //
    if (PcdGet32 (PcdMaximumAsciiStringLength) != 0) {
      ASSERT (Length < PcdGet32 (PcdMaximumAsciiStringLength)); <-- HERE
    }
  }
  return Length;
}

(Never mind that the comment has a typo -- it incorrectly references
"PcdMaximumUnicodeStringLength", but the PCD that's actually checked is
(correctly) "PcdMaximumAsciiStringLength".)

The constant is set to decimal 1,000,000 in ArmVirtQemu builds
(inherited from MdePkg.dec), and that's indeed a quite unlikely length
for real-word strings seen by firmware.

I'll take a closer look once I have access to a 32-bit ARM host, but
I'll definitely need help. Basically we should compare the original
AARCH64 (dis)assembly with the QEMU-generated 32-bit ARM assembly.
Hopefully I can at least get a backtrace myself.

Thanks,
Laszlo

