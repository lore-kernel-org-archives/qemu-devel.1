Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B58C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C13E206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcbvj0Tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C13E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBfn-0007H7-K0
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jlBes-0006Wr-9Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:29:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jlBeq-0006pi-LY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592314183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5z1aAw3cBg6Gw+LrPo2kSM5UNSKN/NZnKhFt01VRcVM=;
 b=fcbvj0Tk5EgIGqI9KJmDmn4U+ryrdn2woyKYUNoLskDs5lG/BbZCBKXlI6N4g1d1KrliYr
 HPPvYOkDlQpUr+xAQEkCIwo+q9N/ucIeyifawh/QdUROonAzmPhD6Vv5g9ehMl+uN64K6x
 N5ntaJbNMuuxzMceNqArEtwTzWucQas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-LlHTB0pjOOOw2spZvE4TMg-1; Tue, 16 Jun 2020 09:29:36 -0400
X-MC-Unique: LlHTB0pjOOOw2spZvE4TMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D6FC109132C
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 13:29:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8D0979307;
 Tue, 16 Jun 2020 13:29:31 +0000 (UTC)
Date: Tue, 16 Jun 2020 15:29:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tests: disassemble-asm.sh: generate AML in readable format
Message-ID: <20200616152926.4e08698d@redhat.com>
In-Reply-To: <20200611165112.30979-1-mst@redhat.com>
References: <20200611165112.30979-1-mst@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 12:51:16 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

subj: s/asm/asl/

> On systems where the IASL tool exists, we can convert
> extected ACPI tables to ASL format, which is useful
> for debugging and documentation purposes.
> This script does this for all ACPI tables under tests/data/acpi/. 

for debugging I usually use V=1 env var with test/make check,
as it gives me all diffs vs current blobs.
And it's on rare occasion that I go and decompile ASL file myself,
since test already did that for tables that didn't match. 

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/data/acpi/disassemle-aml.sh | 52 +++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100755 tests/data/acpi/disassemle-aml.sh
> 
> diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
> new file mode 100755
> index 0000000000..42a1b51df0
> --- /dev/null
> +++ b/tests/data/acpi/disassemle-aml.sh
> @@ -0,0 +1,52 @@
> +#!/usr/bin/bash
> +
> +outdir=
> +while getopts "o:" arg; do
> +  case ${arg} in
> +    o )
> +        outdir=$OPTARG
> +        ;;
> +    \? )
> +        echo "Usage: ./tests/data/acpi/disassemle-aml.sh [-o <output-directory>]"
> +        exit 1
> +        ;;
> +    
> +  esac
> +done
> +
> +for machine in tests/data/acpi/*
> +do
> +    if [[ ! -d "$machine" ]];
> +    then
> +        continue
> +    fi
> +
> +    if [[ "${outdir}" ]];
> +    then
> +        mkdir -p "${outdir}"/${machine} || exit $?
> +    fi
> +    for aml in $machine/*
> +    do
> +        if [[ "$aml" == $machine/*.dsl ]];
> +        then
> +            continue
> +        fi
> +        if [[ "$aml" == $machine/SSDT*.* ]];
> +        then
> +            dsdt=${aml/SSDT*./DSDT.}
> +            extra="-e ${dsdt}"
> +        elif [[ "$aml" == $machine/SSDT* ]];
> +        then
> +            dsdt=${aml/SSDT*/DSDT};
> +            extra="-e ${dsdt}"
> +        else
> +            extra=""
> +        fi
> +        asl=${aml}.dsl
> +        if [[ "${outdir}" ]];
> +        then
> +            asl="${outdir}"/${machine}/${asl}
> +        fi
> +        iasl -d -p ${asl} ${extra} ${aml} 
> +    done
> +done


