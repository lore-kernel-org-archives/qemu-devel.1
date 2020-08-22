Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D50EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5452072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccJf6UxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5452072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9UU5-00074K-35
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 10:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k9UTT-0006dD-QS
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:26:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52294
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k9UTQ-00035X-GR
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598106382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bM8s884cZddxjK1Xtu+aZjl/sWNaOI/OMaew1eNz3bM=;
 b=ccJf6UxBAuVRAqvKz+GlAmf3Yt7Ns1ZBoxliSD6zCEQbCoVwSKhT2H5rx+kaAiAM1Vc81J
 U/bin33+BUJ3FRoghEAw4lkv1GYaIxyHs2ge05wNmZmjhVmdL0o/aW4ouylf3PhS/cFktD
 y66wfNva3HbfqCOy5iyQrhQGQdgnkgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-LU7EZO2QMNONr0R-1K2XxA-1; Sat, 22 Aug 2020 10:26:16 -0400
X-MC-Unique: LU7EZO2QMNONr0R-1K2XxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7830B81F003;
 Sat, 22 Aug 2020 14:26:15 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-61.ams2.redhat.com
 [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75C965D9F7;
 Sat, 22 Aug 2020 14:25:56 +0000 (UTC)
Subject: Re: [RFC PATCH v2 0/4] Use ACPI PCI hot-plug for q35
To: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200821123007.3d390d51@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2f874496-e9a2-d52f-2c6e-0595cc3ae9cb@redhat.com>
Date: Sat, 22 Aug 2020 16:25:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200821123007.3d390d51@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 08:01:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Marcel, Laine, Daniel

On 08/21/20 12:30, Igor Mammedov wrote:
> On Tue, 18 Aug 2020 23:52:23 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
>
>> PCIe native hot-plug has numerous problems with racing events and
>> unpredictable guest behaviour (Windows).
> Documenting these misterious problems I've asked for  in previous
> review hasn't been addressed.
> Pls see v1 for comments and add requested info into cover letter at
> least or in a commit message.

Igor, I assume you are referring to

  http://mid.mail-archive.com/20200715153321.3495e62d@redhat.com

and I couldn't agree more.

I'd like to understand the specific motivation for this patch series.

- I'm very concerned that it could regress various hotplug scenarios
with at least OVMF.

So minimally I'm hoping that the work is being meticulously tested with
OVMF.

- I don't recall testing native PCIe hot-*unplug*, but we had repeatedly
tested native PCIe plug with both Linux and Windows guests, and in the
end, it worked fine. (I recall working with at least Marcel on that; one
historical reference I can find now is
<https://bugzilla.tianocore.org/show_bug.cgi?id=75>.)

I remember users confirming that native PCIe hotplug worked with
assigned physical devices even (e.g. GPUs), assuming they made use of
the resource reservation capability (e.g. they'd reserve large MMIO64
areas during initial enumeration).

- I seem to remember that we had tested hotplug on extra root bridges
(PXB) too; regressing that -- per the pxb-pcie mention in the blurb,
quoted below -- wouldn't be great. At least, please don't flip the big
switch so soon (IIUC, there is a big switch being proposed).

- The documentation at "docs/pcie.txt" and "docs/pcie_pci_bridge.txt" is
chock-full of hotplug references; we had spent days if not weeks for
writing and reviewing those. I hope it's being evaluated how much of
that is going to need an update.

In particular, do we know how this work is going to affect the resource
reservation capability?

$ qemu-system-x86_64 -device pcie-root-port,\? | grep reserve
  bus-reserve=<uint32>   -  (default: 4294967295)
  io-reserve=<size>      -  (default: 18446744073709551615)
  mem-reserve=<size>     -  (default: 18446744073709551615)
  pref32-reserve=<size>  -  (default: 18446744073709551615)
  pref64-reserve=<size>  -  (default: 18446744073709551615)

The OVMF-side code (OvmfPkg/PciHotPlugInitDxe) was tough to write. As
far as I remember, especially commit fe4049471bdf
("OvmfPkg/PciHotPlugInitDxe: translate QEMU's resource reservation
hints", 2017-10-03) had taken a lot of navel-gazing. So the best answer
I'm looking for here is "this series does not affect resource
reservation at all".

- If my message is suggesting that I'm alarmed: that's an
understatement. This stuff is a mine-field. A good example is Gerd's
(correct!) response "Oh no, please don't" to Igor's question in the v1
thread, as to whether the piix4 IO port range could be reused:

  http://mid.mail-archive.com/20200715065751.ogchtdqmnn7cxsyi@sirius.home.kraxel.org

That kind of "reuse" would have been a catastrophe, because for PCI IO
port aperture, OVMF uses [0xC000..0xFFFF] on i440fx, but
[0x6000..0xFFFF] on q35:

  commit bba734ab4c7c9b4386d39420983bf61484f65dda
  Author: Laszlo Ersek <lersek@redhat.com>
  Date:   Mon May 9 22:54:36 2016 +0200

      OvmfPkg/PlatformPei: provide 10 * 4KB of PCI IO Port space on Q35

      This can accommodate 10 bridges (including root bridges, PCIe upstream and
      downstream ports, etc -- see
      <https://bugzilla.redhat.com/show_bug.cgi?id=1333238#c12> for more
      details).

      10 is not a whole lot, but closer to the architectural limit of 15 than
      our current 4, so it can be considered a stop-gap solution until all
      guests manage to migrate to virtio-1.0, and no longer need PCI IO BARs
      behind PCIe downstream ports.

      Cc: Gabriel Somlo <somlo@cmu.edu>
      Cc: Jordan Justen <jordan.l.justen@intel.com>
      Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1333238
      Contributed-under: TianoCore Contribution Agreement 1.0
      Signed-off-by: Laszlo Ersek <lersek@redhat.com>
      Reviewed-by: Jordan Justen <jordan.l.justen@intel.com>
      Tested-by: Gabriel Somlo <somlo@cmu.edu>

- If native PCIe hot-unplug is not working well (or at all) right now,
then I guess I can't just summarily say "we had better drop this like
hot potato".

But then, if we are committed to *juggling* that potato, we should at
least document the use case / motivation / current issues meticulously,
please. Do we have a public BZ at least?

- The other work, with regard to *disabling* unplug, which seems to be
progressing in parallel, is similarly in need of a good explanation, in
my opinion:

  http://mid.mail-archive.com/20200820092157.17792-1-ani@anisinha.ca

Yes, I have read Laine's long email, linked from the QEMU cover letter:

  https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html

The whole use case "prevent guest admins from unplugging virtual
devices" still doesn't make any sense to me. How is "some cloud admins
don't want that" acceptable at face value, without further explanation?

Thanks
Laszlo

>
>
>> Switching to ACPI hot-plug for now.
>>
>> Tested on RHEL 8 and Windows 2019.
>> pxb-pcie is not yet supported.
>>
>> v2:
>>     * new ioport range for acpiphp [Gerd]
>>     * drop find_pci_host() [Igor]
>>     * explain magic numbers in _OSC [Igor]
>>     * drop build_q35_pci_hotplug() wrapper [Igor]
>>
>> Julia Suvorova (4):
>>   hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
>>   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to q35
>>   hw/i386/acpi-build: Turn off support of PCIe native hot-plug and SHPC
>>     in _OSC
>>   hw/acpi/ich9: Enable ACPI PCI hot-plug
>>
>>  hw/i386/acpi-build.h    | 12 ++++++++++
>>  include/hw/acpi/ich9.h  |  3 +++
>>  include/hw/acpi/pcihp.h |  3 ++-
>>  hw/acpi/ich9.c          | 52 ++++++++++++++++++++++++++++++++++++++++-
>>  hw/acpi/pcihp.c         | 15 ++++++++----
>>  hw/acpi/piix4.c         |  2 +-
>>  hw/i386/acpi-build.c    | 48 +++++++++++++++++++++++--------------
>>  hw/i386/pc.c            |  1 +
>>  hw/acpi/trace-events    |  4 ++++
>>  9 files changed, 114 insertions(+), 26 deletions(-)
>>
>
>


