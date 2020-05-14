Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B8CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2042065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxIqcNXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2042065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLH0-0006uD-Qe
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 17:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZLGO-0006QS-GE
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:19:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZLGM-0002Kz-9Z
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589491168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGM05Y78Z30fISXdPMoMuScYcVlzUPIQT3qO3FOQRCk=;
 b=SxIqcNXLkhN0gPOXJFrsX0YRk3XFsRkJ40MQ4U2rE16pfLOLw3c/PWqdPnCxwN+PRPwirC
 3rMGmHjW0oXp/TlPxjlLa82WuNpF6HwV0fKTAfz1Vp4Jp6jqxFYeJmhcczyzBrF7AUNR6W
 3mZ7v4G8iBqcoTXDr5HwDH7nPss31wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-_FKCZ3TvO_eGGFDgHso61w-1; Thu, 14 May 2020 17:19:24 -0400
X-MC-Unique: _FKCZ3TvO_eGGFDgHso61w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 917791005512;
 Thu, 14 May 2020 21:19:23 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D73575D714;
 Thu, 14 May 2020 21:19:22 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu_img: add cvtnum_full to print error reports
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <20200513133629.18508-1-eyal.moscovici@oracle.com>
 <20200513133629.18508-2-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <facc883f-08b7-1b7e-bf9b-0b582b734eaf@redhat.com>
Date: Thu, 14 May 2020 16:19:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513133629.18508-2-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:35:35
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

On 5/13/20 8:36 AM, Eyal Moscovici wrote:
> All calls to cvtnum check the return value and print the same error message more
> or less. And so error reporting moved to cvtnum_full to reduce code
> duplication and provide a single error message. Additionally, cvtnum now wraps
> cvtnum_full with the existing default range of 0 to MAX_INT64.
> 
> Acked-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> ---

> -static int64_t cvtnum(const char *s)
> +static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
> +                           int64_t max)
>   {
>       int err;
> -    uint64_t value;
> -
> -    err = qemu_strtosz(s, NULL, &value);
> -    if (err < 0) {
> +    uint64_t res;
> +
> +    err = qemu_strtosz(value, NULL, &res);
> +    if (err < 0 && err != -ERANGE) {
> +        error_report("Invalid %s specified. You may use "
> +                     "k, M, G, T, P or E suffixes for ", name);
> +        error_report("kilobytes, megabytes, gigabytes, terabytes, "
> +                     "petabytes and exabytes.");

Consecutive error_report() calls each output a newline, which means your 
new output includes a trailing space.

> @@ -572,16 +584,8 @@ static int img_create(int argc, char **argv)
>       if (optind < argc) {
>           int64_t sval;
>   
> -        sval = cvtnum(argv[optind++]);
> +        sval = cvtnum("image size", argv[optind++]);
>           if (sval < 0) {
> -            if (sval == -ERANGE) {
> -                error_report("Image size must be less than 8 EiB!");
> -            } else {
> -                error_report("Invalid image size specified! You may use k, M, "
> -                      "G, T, P or E suffixes for ");
> -                error_report("kilobytes, megabytes, gigabytes, terabytes, "
> -                             "petabytes and exabytes.");
> -            }

True, that's what some of the old code was doing, but...

> +++ b/tests/qemu-iotests/049.out

>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
> -qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
> +qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for

where it gets hairy is that our iotests _intentionally_ strip trailing 
space before comparing to expected output, because it is such a pain to 
commit files with trailing spaces into the repository.  We're better off 
making the expected output precisely match what qemu-img actually 
outputs, which means using this as an opportunity to fix qemu-img to not 
output trailing space in the first place.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


