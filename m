Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE5C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EC420640
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EC420640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56518 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJde5-0002lP-1v
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 08:38:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJddG-0002SV-Ml
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJddE-00021p-Oh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:37:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJddC-00020H-S0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:37:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so9057415wml.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 05:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ut9TYsidq+Yk4C/o68VYnOCez53ro7JjBFo2F2yNMMk=;
	b=Qk4uy0fDcK/T9VMy9ZcNyjvPIduLaJ0Y2+WvASoylKa9bRYtm9rabbtV9ZixnG9qHd
	TUCzSBtop2iB+2qFRwnBy7e3YYZOEts2vzeUPd6hbB7XqdWfhkWzbuIJrVlXW4RGsFCU
	dftFBKwpsiAb3w39rtiQigSMBvV009FMPVxL8p65+NB1553/YE+r4mso7qJqYBfb5yJa
	seZPLD1BnRAuYXDvHh70OFf2Rqd6sEdUJOCIO+n0lm9yVP5zv74FR/ViOfCRtjhmTx+k
	S2y3DInahSTQ+dx++YqQLokhLE8xk/decCmDk2yAjk95XWUOjEng+N8zejtuOJkMzPje
	GqAA==
X-Gm-Message-State: APjAAAWuvOYlayKMsZPUfhRYxWbiK8yauQCY+yMh+y/DQkyTc4kLm7zB
	1/9T0c152SI1+Or37g/uuEJFKg==
X-Google-Smtp-Source: APXvYqw8bArtcMTUw+FwTRdlgjYkDlAYYb7vRLO9I7IbfnlvXwR4xdkioXGNkrYyybIW5y7vMm902g==
X-Received: by 2002:a1c:eb03:: with SMTP id j3mr3459570wmh.15.1556195857709;
	Thu, 25 Apr 2019 05:37:37 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	v192sm21516356wme.24.2019.04.25.05.37.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 05:37:36 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-10-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b0d3f541-ead5-830a-2536-4af67f5845da@redhat.com>
Date: Thu, 25 Apr 2019 14:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556170489-131927-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 09/13] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
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
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425123735.KNrImFwQRDcdfPhRWaa36nf9AzP9BeANUmtTbvNcSyM@z>

Hi Igor,

On 4/25/19 7:34 AM, Igor Mammedov wrote:
> once FW provides a pointer to SMBIOS entry point like it does for
> RSDP it should be possible to enable this one the same way.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v3:
>   - add ref to a uefi-test-tools feature req into comment (Laszlo)
> ---
>  tests/bios-tables-test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 0f24540..1be55a1 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -573,8 +573,15 @@ static void test_acpi_one(const char *params, test_data *data)
>          }
>      }
>  
> -    test_smbios_entry_point(data);
> -    test_smbios_structs(data);
> +    /*
> +     * TODO: make SMBIOS tests work with UEFI firmware,
> +     * Bug on uefi-test-tools to provide entry point:
> +     * https://bugs.launchpad.net/qemu/+bug/1821884
> +     */
> +    if (!use_uefi) {
> +        test_smbios_entry_point(data);
> +        test_smbios_structs(data);
> +    }

Now that Laszlo resolved this bug, you can update the SMBIOS tests :)

Without this patch I get:

ERROR:/home/phil/source/qemu/tests/bios-tables-test.c:460:test_smbios_entry_point:
assertion failed (off < 0x100000): (0x00100000 < 0x00100000)

And the UEFI console shows:

BdsDxe: failed to load Boot0001 "UEFI Misc Device" from
VenHw(93E34C7E-B50E-11DF-9223-2443DFD72085,00): Not Found
FatDiskIo: Cache Page OutBound occurred!
add-symbol-file
/home/lacos/src/upstream/qemu/tests/uefi-test-tools/Build/UefiTestTools/DEBUG_GCC5/AARCH64/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest/DEBUG/BiosTablesTest.dll
0x442C3000
Loading driver at 0x000442C2000 EntryPoint=0x000442C47AC BiosTablesTest.efi
InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 4654EE18
ProtectUefiImageCommon - 0x451AA140
  - 0x00000000442C2000 - 0x0000000000006000
SetUefiImageMemoryAttributes - 0x00000000442C2000 - 0x0000000000001000
(0x0000000000004008)
SetUefiImageMemoryAttributes - 0x00000000442C3000 - 0x0000000000003000
(0x0000000000020008)
SetUefiImageMemoryAttributes - 0x00000000442C6000 - 0x0000000000002000
(0x0000000000004008)
BdsDxe: starting Boot0002 "UEFI Misc Device 2" from
PciRoot(0x0)/Pci(0x2,0x0)
BiosTablesTest: BiosTablesTest=45100000 Rsdp10=0 Rsdp20=44020000
BiosTablesTest: Smbios21=0 Smbios30=47640000
BiosTablesTest: press any key to exit

>  
>      assert(!global_qtest);
>      qtest_quit(data->qts);
> 

