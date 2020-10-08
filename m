Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4CDC04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABD720657
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABD720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXuJ-0000CZ-3A
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kQXrd-0007GA-2e
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:29:53 -0400
Received: from relay64.bu.edu ([128.197.228.104]:34604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kQXrb-0007fo-EM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:29:52 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 098FStti014997
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 8 Oct 2020 11:28:58 -0400
Date: Thu, 8 Oct 2020 11:28:55 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Dima Stepanov <dimastep@yandex-team.ru>
Subject: Re: [PATCH v1 2/2] docs/fuzz: update make and run command lines
Message-ID: <20201008152855.gexfo4q4hul4mq6n@mozz.bu.edu>
References: <cover.1602078083.git.dimastep@yandex-team.ru>
 <341c0f5346459669223f1720136e3ee7e9b1a949.1602078083.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341c0f5346459669223f1720136e3ee7e9b1a949.1602078083.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 11:29:48
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.903, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201007 1647, Dima Stepanov wrote:
> After meson and some other build changes the qemu fuzz target should be
> build as:
>   make qemu-fuzz-i386
> And also update the run path command line.
> 
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  docs/devel/fuzzing.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
> index 96d71c9..7846b9e 100644
> --- a/docs/devel/fuzzing.txt
> +++ b/docs/devel/fuzzing.txt
> @@ -32,15 +32,15 @@ such as out-of-bounds accesses, use-after-frees, double-frees etc.
>  
>  Fuzz targets are built similarly to system/softmmu:
>  
> -    make i386-softmmu/fuzz
> +    make qemu-fuzz-i386
>  
> -This builds ./i386-softmmu/qemu-fuzz-i386
> +This builds ./build/qemu-fuzz-i386
>  
>  The first option to this command is: --fuzz-target=FUZZ_NAME
>  To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
>  
>  For example:
> -    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
> +    ./build/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
>  

TIL that in-tree configures now happen in ./build/

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thanks

>  Internally, libfuzzer parses all arguments that do not begin with "--".
>  Information about these is available by passing -help=1
> -- 
> 2.7.4
> 

