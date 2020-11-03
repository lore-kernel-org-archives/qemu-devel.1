Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C273320757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdSFgfLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C273320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZy0B-0000Fd-Qq
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZxkb-0001J6-90
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZxkX-0005V4-Fo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604415447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmjH+RXJAKPLltutGlToEaOaDac+EnKM6h7VI2aeC48=;
 b=NdSFgfLUAYGKFT0ASVoJnOU6V92DsmJScDQYQ4IzAyhfOuT6m4R+6UK4JV3ssgWe6H98R7
 AmfYOLBjOX5Iio407uZz/nknlNkdc9AxBFf2IHTQaCPAcYuBqsW5ENE+wJ5b9NDZmYMnIs
 Ar1Qs3c2vkKxSUHxyPN5OYoyHzLPVLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-JaGi608MOrm0hbpQTpC87w-1; Tue, 03 Nov 2020 09:57:24 -0500
X-MC-Unique: JaGi608MOrm0hbpQTpC87w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E39B11009E2F;
 Tue,  3 Nov 2020 14:57:22 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4DB610AF;
 Tue,  3 Nov 2020 14:57:11 +0000 (UTC)
Date: Tue, 3 Nov 2020 15:57:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Subject: Re: [PATCH 0/1] acpi: Implement ACPI ERST support for guests
Message-ID: <20201103155709.410240e4@redhat.com>
In-Reply-To: <1603743573-9870-1-git-send-email-eric.devolder@oracle.com>
References: <1603743573-9870-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, konrad.wilk@oracle.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 16:19:32 -0400
Eric DeVolder <eric.devolder@oracle.com> wrote:

> This changeset introduces support for the ACPI Error Record
> Serialization Table, ERST.
> 
> The change to hw/acpi/meson.build simply adds in the new .c file
> for compilation.
> 
> The change to hw/i386/acpi-build.c calls out the building of the
> ERST table (and also creates the associated device).
> 
> The new file hw/acpi/erst.c contains the building of the ERST
> table, as well as the simple device for exchanging error records.
> 
> The new file include/hw/acpi/erst.h contains associated definitions
> and declarations for ERST.
> 
> The primary description of this changeset is in the patch commit
> message.
> 
> NOTES: When reviewing, I would especially appreciate feedback
> on the following topics:
> 
> - The hope is to have ERST always present if ACPI is enabled, however,
>   I have found it difficult to devise a method for passing the base
>   address that does not require the workaround at the bottom of
>   build_erst(). The issues I encountered are:
>   - desire to keep this is common ACPI code
>   - the device requires a qdev_new(), this needs to happen early,
>     thus the workaround in build_erst()
>   - the base address is machine/arch specific (eg ARM vs x86)
>   I've not found a nice way to thread this needle, so what I've settled
>   on is to simply lump ERST on to the CONFIG_ACPI (rather than a
>   separate CONFIG_ACPI_ERST), and the workaround at the bottom of
>   build_erst(). I suspect there is a better way for a built-in/
>   always present device. This does not support "-device acpi-erst,...".
> 
> - I found a base address that "worked", but would like an address
>   that would be known to be availabe, and then to document/reserve
>   it for ERST. This takes into account that the base address can be
>   different for x86 vs ARM.
> 
> - I've run this through checkpatch, and all issues addressed except
>   for the long lines in build_erst(). For readable I left the long
>   lines, but will change if asked.
> 
> - What else do I need to provide?

For now, I have just several generic comments:

1. that's quite a lot code to maintain, why not use existing UEFI vars
   as pstore storage instead? 
   Not sure ancient ACPI table is a way to go, with NVDIMMs around
   it probably possible to use pstores ram backend or make it work
   with nvdimms directly. The only benefit of ERST is that it should
   just work without extra configuration, but then UEFI backend
   would probably also just work.

2. patch is too big to review, please split it up in smaller chunks.

3. Use of packed structures is discouraged in new ACPI code,
   see build_ghes_v2() as an example for building ACPI tables.

4. Maybe instead of SYSBUS device, implement it as a PCI device and
   use its BAR/control registers for pstore storage and control interface.
   It could save you headache of picking address where to map it +
   it would take care of migration part automatically, as firmware
   would do it for you and then QEMU could pickup firmware programmed
   address and put it into ERST table.

5. instead of dealing with file for storage directly, reuse hostmem backend
   to provide it to for your device. ex: pc-dimm. i.e. split device
   on frontend and backend


> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> ---
>  hw/acpi/erst.c         | 909 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/meson.build    |   1 +
>  hw/i386/acpi-build.c   |   4 +
>  include/hw/acpi/erst.h |  97 ++++++
>  4 files changed, 1011 insertions(+)
>  create mode 100644 hw/acpi/erst.c
>  create mode 100644 include/hw/acpi/erst.h
> 


