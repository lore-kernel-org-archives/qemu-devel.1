Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E9CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 21:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69B3208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLiJWrvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69B3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxdJW-00020t-7q
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 17:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jxdIm-00018X-CV
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 17:26:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jxdIh-0003Is-CS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 17:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595280376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=No7lZQzyDwwCTCSVlY66jRXSByDMBXYEZrVuriujpZI=;
 b=VLiJWrvxGGouff9tuXb03qDRabaQLXPV7VTBJbKBOeyTtPjvKzdxObrRjOFN14v8tgUdIS
 HntKeeTeoFV2inVz1apymHSeYCmbnZfczi3QQpM41MLRYXWsh4e6TnCtw2hbB1MByAohY6
 GEbgnjjChkPFkt75brOC2u+kRoE6Bq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-zesbrkdVM8a-FP9SRFjmNg-1; Mon, 20 Jul 2020 17:26:09 -0400
X-MC-Unique: zesbrkdVM8a-FP9SRFjmNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2DD6801A03;
 Mon, 20 Jul 2020 21:26:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-27.ams2.redhat.com
 [10.36.115.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93FB85D9D5;
 Mon, 20 Jul 2020 21:25:59 +0000 (UTC)
Subject: Re: OVMF and PCI0 UID
To: vit9696 <vit9696@protonmail.com>
References: <56E4DCD4-DBA1-4A41-8568-1CBBB37ED320@protonmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <829eba8a-d9a7-a335-6b85-91e64462e64b@redhat.com>
Date: Mon, 20 Jul 2020 23:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <56E4DCD4-DBA1-4A41-8568-1CBBB37ED320@protonmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 17:06:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tsirkin <mtsirkin@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 mhaeuser@posteo.de, qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vitaly,

adding Igor, Michael, Marcel, and qemu-devel.

On 07/20/20 11:06, vit9696 wrote:
> Hello,
>
> I discovered an issue with inconsistent QEMU/OVMF device paths, and
> while I am unsure whether directing this e-mail is appropriate to you,
> I believe that you likely have the contacts you could forward this
> e-mail to.
>
> macOS uses ACPI UIDs to build the DevicePath for NVRAM boot options,
> while OVMF firmware gets them via an internal channel through QEMU.
> Due to a bug in QEMU (or OVMF) currently UEFI firmware and ACPI have
> different values, and this makes the underlying operating system
> unable to report its boot option.
>
> The particular node in question is the primary PciRoot (PCI0 in ACPI),
> which for some reason gets assigned 1 in ACPI UID and 0 in the
> DevicePath. To me this looks like a bug here:
> https://github.com/qemu/qemu/blob/8f06f22/hw/i386/acpi-build.c#L1511-L1515
> Which does not correspond to the primary PCI identifier here:
> https://github.com/qemu/qemu/blob/5a79d10/hw/pci/pci.c#L160-L162
>
> Reference with the device paths, OVMF startup logs, and ACPI table
> dumps (SysReport):
> https://github.com/acidanthera/bugtracker/issues/1050
>
> Would you be able to forward this to the right people or perhaps keep
> an eye on the issue itself?

I think you are right.

In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
the paragraph,

    Root PCI bridges will use the plug and play ID of PNP0A03, This will
    be stored in the ACPI Device Path _HID field, or in the Expanded
    ACPI Device Path _CID field to match the ACPI name space. The _UID
    in the ACPI Device Path structure must match the _UID in the ACPI
    name space.

(See especially the last sentence.)

Considering *extra* root bridges / root buses (with bus number > 0),
QEMU's ACPI generator actually does the right thing; since QEMU commit
c96d9286a6d7 ("i386/acpi-build: more traditional _UID and _HID for PXB
root buses", 2015-06-11).

However, the _UID values for root bridge zero (on both i440fx and q35)
have always been "wrong" (from UEFI perspective), going back in QEMU to
commit 74523b850189 ("i386: add ACPI table files from seabios",
2013-10-14).

Even in SeaBIOS, these _UID values have always been 1; see commit
a4d357638c57 ("Port rombios32 code from bochs-bios.", 2008-03-08) for
i440fx, and commit ecbe3fd61511 ("seabios: q35: add dsdt", 2012-12-01)
for q35.

Does the following patch work for you? (I can see you proposed the same
in
<https://github.com/acidanthera/bugtracker/issues/1050#issuecomment-660734139>)

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a35..7a5a8b3521b0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1496,9 +1496,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          sb_scope = aml_scope("_SB");
>          dev = aml_device("PCI0");
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>
>          build_hpet_aml(dsdt);
> @@ -1511,9 +1511,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          dev = aml_device("PCI0");
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);

If it does, I suggest submitting the above patch to qemu-devel, and/or
filing a bug for upstream QEMU at <https://bugs.launchpad.net/qemu/>.

(Note: I didn't even compile the above change.)

Thanks
Laszlo


