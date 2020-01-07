Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6193CC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9DA2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi/AT32p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9DA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iox55-0004gY-8j
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 17:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iox4R-0004GL-90
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iox4P-0004DF-UZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:11:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iox4P-0004Cj-Q8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578435085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMngpDUiI1jVVbhfSCQ2moPGKOHeq5hcpyHEKWQSPbA=;
 b=Zi/AT32phRmPngFgWIJ22rGlTqTyVwejiJiH5RCi0Uuc7kg8A17JS0iLPTQfiP+KWwnxr9
 okYFWOzMmD6NPzTmqF9Qc1WO8R05MzOrPTFHiq51UGzwLjGvlmkN/MjgNvkLGvWuz7X3H6
 vYdV1Oo+jXzbx/Oixm6VkEw26hX2+1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-OWGB2ya2MXqQsWqJN8eNug-1; Tue, 07 Jan 2020 17:11:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA7A1800D41;
 Tue,  7 Jan 2020 22:11:22 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3580E5C1BB;
 Tue,  7 Jan 2020 22:11:22 +0000 (UTC)
Subject: Re: [PATCH 2/2] qcow2: dump QCOW2 metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1577447039-400109-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d87d183d-cd69-1994-11d0-5767ec72589e@redhat.com>
Date: Tue, 7 Jan 2020 16:11:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577447039-400109-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OWGB2ya2MXqQsWqJN8eNug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/27/19 5:43 AM, Andrey Shinkevich wrote:
> Let QEMU-IMG CHECK command show QCOW2 structure to inform a user about
> metadata allocations on disk. Introduce '-M'('--dump-meta') key option.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

> +++ b/qemu-img.c
> @@ -173,6 +173,7 @@ static void QEMU_NORETURN help(void)
>              "       '-r leaks' repairs only cluster leaks, whereas '-r all' fixes all\n"
>              "       kinds of errors, with a higher risk of choosing the wrong fix or\n"
>              "       hiding corruption that has already occurred.\n"
> +           "  '-M' Dump QCOW2 metadata to stdout in JSON format.\n"

Should QCOW2 be all caps?


>   }
> @@ -701,9 +710,10 @@ static int img_check(int argc, char **argv)
>               {"object", required_argument, 0, OPTION_OBJECT},
>               {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>               {"force-share", no_argument, 0, 'U'},
> +            {"dump-meta", no_argument, 0, 'M'},
>               {0, 0, 0, 0}
>           };
> -        c = getopt_long(argc, argv, ":hf:r:T:qU",
> +        c = getopt_long(argc, argv, ":hf:r:T:qU:M",

We are already inconsistent, but I tend to add options in alphabetical 
order, both here...

>                           long_options, &option_index);
>           if (c == -1) {
>               break;
> @@ -745,6 +755,9 @@ static int img_check(int argc, char **argv)
>           case 'U':
>               force_share = true;
>               break;
> +        case 'M':

...and here, as it is then easier to find a given option for later editing.

> +            fix |= BDRV_DUMP_META;
> +            break;
>           case OPTION_OBJECT: {
>               QemuOpts *opts;
>               opts = qemu_opts_parse_noisily(&qemu_object_opts,
> @@ -772,6 +785,11 @@ static int img_check(int argc, char **argv)
>           return 1;
>       }
>   
> +    if ((fix & BDRV_DUMP_META) && output_format != OFORMAT_JSON) {
> +        error_report("Metadata output in JSON format only");
> +        return 1;

Why this restriction?

> +    }
> +
>       if (qemu_opts_foreach(&qemu_object_opts,
>                             user_creatable_add_opts_foreach,
>                             qemu_img_object_print_help, &error_fatal)) {
> @@ -792,6 +810,15 @@ static int img_check(int argc, char **argv)
>       bs = blk_bs(blk);
>   
>       check = g_new0(ImageCheck, 1);
> +
> +    if (fix & BDRV_DUMP_META) {
> +        if (strcmp(bs->drv->format_name, "qcow2")) {
> +            error_report("Metadata output supported for QCOW2 format only");
> +            ret = -ENOTSUP;

This one makes sense, I guess - we may relax it in later versions if 
more file formats gain the ability to dump extra metadata.


> +++ b/qemu-img.texi
> @@ -230,7 +230,7 @@ specified as well.
>   For write tests, by default a buffer filled with zeros is written. This can be
>   overridden with a pattern byte specified by @var{pattern}.
>   
> -@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
> +@item check [--object @var{objectdef}] [--image-opts] [-M] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}

This mentions that -M is valid, but has no further documentation on what 
-M means.  Without that, it's anyone's guess.

>   
>   Perform a consistency check on the disk image @var{filename}. The command can
>   output in the format @var{ofmt} which is either @code{human} or @code{json}.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


