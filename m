Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5A3C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6882C2076D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FihCP5ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6882C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWS70-0000UI-HL
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 18:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWS4y-0007SU-LE
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:59:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWS4x-0006lf-Om
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588802386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YaQSWI2LmBSPqOqQwiwJ5oi8e/MgvkOI92V8guW8y80=;
 b=FihCP5ZJXwintvXlYpfn17EDcQ/gTMqLar+Z5bEtcEMMpH9iSVy41AIZadbNsDQSws0Yoz
 eCvp1v3QlrbgIPs+koDxZruLOw3bpWoLVjHlkut8tOlaYd2gE+gz78ViknJAOHtNRTal4p
 bfgWkmEAu3WfWXStNOaW25dJvKmNTtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-zXKmdekZMhm2gxDX7th_lA-1; Wed, 06 May 2020 17:59:42 -0400
X-MC-Unique: zXKmdekZMhm2gxDX7th_lA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E1348014C0;
 Wed,  6 May 2020 21:59:41 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80BB460CD0;
 Wed,  6 May 2020 21:59:40 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] qemu_img: add error report to cvtnum
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
 <20200506213459.44743-3-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b9274eb3-1e89-e9f7-d9fd-2f1c8b2e3387@redhat.com>
Date: Wed, 6 May 2020 16:59:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506213459.44743-3-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 16:22:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:34 PM, Eyal Moscovici wrote:
> All calls to cvtnum check the return value and print the same error message more
> or less. And so error reporting moved to cvtnum to reduce duplicate code and
> provide a single error message.
> 
> Acked-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> ---
>   qemu-img.c                 | 63 ++++++++++++++++----------------------
>   tests/qemu-iotests/049.out |  4 +--
>   2 files changed, 28 insertions(+), 39 deletions(-)
> 

> 
> -    err = qemu_strtosz(s, NULL, &value);
> -    if (err < 0) {
> +    err = qemu_strtosz(arg_value, NULL, &value);
> +    if (err < 0 && err != -ERANGE) {
> +        error_report("Invalid %s specified! You may use "
> +                     "k, M, G, T, P or E suffixes for ", arg_name);
> +        error_report("kilobytes, megabytes, gigabytes, terabytes, "
> +                     "petabytes and exabytes.");
>          return err;
>      }
> -    if (value > INT64_MAX) {
> +    if (err == -ERANGE || value > INT64_MAX) {
> +        error_report("Invalid %s specified! Must be less than 8 EiB!",

Copied from our pre-existing errors, but why are we shouting at our 
user?  This would be a good time to s/!/./ to tone it down a bit.

> @@ -4491,10 +4488,12 @@ static int img_dd_bs(const char *arg,
>   {
>       int64_t res;
>   
> -    res = cvtnum(arg);
> +    res = cvtnum("bs", arg);
>   
> -    if (res <= 0) {
> -        error_report("invalid number: '%s'", arg);
> +    if (res < 0) {
> +        return 1;
> +    } else if (res == 0) {
> +        error_report("Invalid bs specified! It cannot be 0.");

Maybe it's worth two functions:

int64_t cvtnum_full(const char *name, const char *value, int64_t min, 
int64_t max)

and then a common helper:

int64_t cvtnum(const char *name, const char *value) {
     return cvtnum_full(name, value, 0, INT64_MAX);
}

many existing callers remain with cvtnum(), but callers like this could 
be cvtnum("bs", arg, 1, INT64_MAX).  You'd still have to special-case 
other restrictions, such as whether a number must a power-of-2, but 
that's fewer places.

> +++ b/tests/qemu-iotests/049.out
> @@ -92,13 +92,13 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 l
>   == 3. Invalid sizes ==
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
> -qemu-img: Image size must be less than 8 EiB!
> +qemu-img: Invalid image size specified! Must be less than 8 EiB!

Nice that you checked for iotest fallout.  Is this really the only 
impacted test?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


