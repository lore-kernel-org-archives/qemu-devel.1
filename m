Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F4C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 22:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1756C21850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruaD24BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1756C21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEi1W-0005aQ-8E
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 18:18:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhzw-0004gP-Ug
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhzv-0002R0-Ht
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:16:44 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hEhzt-0002OR-Ke
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:16:41 -0400
Received: by mail-ed1-x544.google.com with SMTP id k45so6613600edb.6
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=8zPlCQu41gsMMCDYOfWbvczbElzdxO2bXuiBN2CkMcQ=;
	b=ruaD24BRR4NlDk2tK/MgqXjojSRJUHoqP14KLq7TBz6G1SWALf9SN3NRyB1G4Z426s
	YmjiRQQN+CgIOmzzU/Ug2uzWCZiZjY4Wf7wLF5vweKbm3i7W4C8Pov/jkAlee3C4aXAW
	7Ivc+GdxCgxkEvyasrAK1CJDQtX/6BbFYKxkzag24f3OHB+62t3308RJn+tS6bsA6UGW
	goXFGJWyfwfJpCkYSovHetQ7B/e6FFDZWqoILWvZ3f3M8/hcvTfLyF+UiGTOV1uvD7pC
	ZwQikVFuzDXGdXlHC//vf7+bgb1v60ypKRDvnkm4F81rJ1HSDAmDAEefgyrAj9Q6UC7r
	Oeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=8zPlCQu41gsMMCDYOfWbvczbElzdxO2bXuiBN2CkMcQ=;
	b=Kt0d23Qxs3TQwo4KvxRvTPqhRU80LMqmEW0mWSY/LhJXnAdtSidzFvDxFyoxJ6K4Qw
	dGVipv9hojLNJPOYz2/OBmYbw9UVDw/gVOGI6B2PSG/1YMFzEFXEBZULcvW9QDkdcTly
	spfTsgped/kDL6Utc2eVnLS7vQAp+0y+yEOIosvIxaK0qHl/KUj2l3ba0p4onT4/7hti
	bwZRZ1YjrPTjAPnQZflVRguRC+bzpUVrCJRxpJCdS85cW8wFKgNszqoXpHOA9PEnSoB1
	fusPRIUMI1ozdI6kX7PSW4izCwmMngalHVStUmRaNN/UXNePksxHjjBt8ksnjMdB856n
	Dd1A==
X-Gm-Message-State: APjAAAWAQUORJ6oBJ3OVeRrg50t5HwpVq4lTcz17WefNpjUl9YRY9gFz
	pQ4AlxWgHSmFYrhxJKd8aoE=
X-Google-Smtp-Source: APXvYqzCcZMVUN0e5brEQbrvjf2zUbOYVwO4y3AcJCMNsL/piXiDRk7eOHIIfpgDsIcwTj9BVgC+qQ==
X-Received: by 2002:a17:906:3e91:: with SMTP id
	a17mr28877750ejj.73.1555020999788; 
	Thu, 11 Apr 2019 15:16:39 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id 25sm7155978ejv.27.2019.04.11.15.16.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Apr 2019 15:16:39 -0700 (PDT)
Date: Thu, 11 Apr 2019 22:16:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190411221638.wiok2e7eik5btwq2@master>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
	richardw.yang@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411221638.v3lc-uERaPUJKkbR717NJiFOWM0IlKioeX-nT0N3yws@z>

On Tue, Apr 09, 2019 at 05:00:37PM +0200, Igor Mammedov wrote:
>Dummy table (with signature "QEMU") creation came from original SeaBIOS
>codebase. And QEMU would have to keep it around if there were Q35 machine
>that depended on keeping ACPI tables blob constant size. Luckily there
>were no versioned Q35 machine types before commit:
>  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
>which obsoleted need to keep ACPI tables blob the same size on source/destination.
>
>Considering the 1st versioned machine is pc-q35-2.4, the dummy table
>is not really necessary and it's safe to drop it without breaking
>cross version migration in both directions unconditionally.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> hw/i386/acpi-build.c | 18 ++++--------------
> 1 file changed, 4 insertions(+), 14 deletions(-)
>
>diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>index 416da31..8671e25 100644
>--- a/hw/i386/acpi-build.c
>+++ b/hw/i386/acpi-build.c
>@@ -2401,7 +2401,6 @@ static void
> build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> {
>     AcpiTableMcfg *mcfg;
>-    const char *sig;
>     int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> 
>     mcfg = acpi_data_push(table_data, len);
>@@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>     mcfg->allocation[0].start_bus_number = 0;
>     mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
> 
>-    /* MCFG is used for ECAM which can be enabled or disabled by guest.
>-     * To avoid table size changes (which create migration issues),
>-     * always create the table even if there are no allocations,
>-     * but set the signature to a reserved value in this case.
>-     * ACPI spec requires OSPMs to ignore such tables.
>-     */
>-    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
>-        /* Reserved signature: ignored by OSPM */
>-        sig = "QEMU";
>-    } else {
>-        sig = "MCFG";
>-    }
>-    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
>+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> }
> 
> /*
>@@ -2592,6 +2579,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>     }
>     mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
>     qobject_unref(o);
>+    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
>+        return false;
>+    }
> 
>     o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
>     assert(o);
>-- 
>2.7.4
>

-- 
Wei Yang
Help you, Help me

