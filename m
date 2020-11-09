Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379BFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F83206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WM3Yxrc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F83206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc6CH-0004sV-Cg
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 07:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc6AN-0002uw-Ds
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc6AL-0006xJ-BU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604924456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKdEsAFfLbSar00OBaqmfBo3+Q3tCpC7JnuOX0hdL98=;
 b=WM3Yxrc6MtcSgOLEAUVIb4i68yqArnxOYrVKL7vD4oAThjbJS/kgylXlsJoyHhb8VuFGTU
 ey1f8cKPu1d85g4c0o79Rh53glIQsGf0yTNjV14+BMyYYYVmbAYb2PZk4rrMeYDp3evAWs
 h6bfwsnWrPHBLWbVRRpp9lc6PWsALeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-R2e1LjMVP8CHm1vJbEmH5w-1; Mon, 09 Nov 2020 07:20:52 -0500
X-MC-Unique: R2e1LjMVP8CHm1vJbEmH5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0903C1868410;
 Mon,  9 Nov 2020 12:20:51 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 287AB5C5AF;
 Mon,  9 Nov 2020 12:20:48 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] docs/fuzz: update make and run command lines
To: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel@nongnu.org
References: <cover.1604920905.git.dimastep@yandex-team.ru>
 <b7ae9363e9e32d0d608eab92cd48fe6f6db8a5ce.1604920905.git.dimastep@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6c8cb35d-84b4-4a8c-bff0-28446c0028d0@redhat.com>
Date: Mon, 9 Nov 2020 13:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b7ae9363e9e32d0d608eab92cd48fe6f6db8a5ce.1604920905.git.dimastep@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@gmail.com, alxndr@bu.edu, yc-core@yandex-team.ru,
 darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/2020 12.25, Dima Stepanov wrote:
> After meson and some other build changes the qemu fuzz target should be
> build as:
>   make qemu-fuzz-i386
> And also update the run path command line.
> 
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  docs/devel/fuzzing.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
> index 03585c1..590900c 100644
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
>  Internally, libfuzzer parses all arguments that do not begin with "--".
>  Information about these is available by passing -help=1

This conflicts with Alexander's "docs/fuzz: update fuzzing documentation
post-meson" patch ... which one should be used? One is better for people who
do in-tree builds, the other is better for people who do out-of-tree builds
... I'll go with Alexander's version for now for my next pull-request, since
the text in this file says "/path/to/configure" which rather indicate
out-of-tree builds, but in the long run, it would maybe be good to add some
clarifying sentences here...

 Thomas



