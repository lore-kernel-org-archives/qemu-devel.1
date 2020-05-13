Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE32CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E5F205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXYLi0g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E5F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtmU-0001dN-SR
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYtlc-00018h-UV
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:57:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29902
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYtlc-0008KZ-7K
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589385475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJTd407ABJyq1baJ27C85ivdAyt9zotwEVfYgY5Mgrk=;
 b=bXYLi0g+LGIvVTngfu5OP8Pr1OY+dnK8eAyogF5ODrBuAZ/UN7y3M8dZYf3478aZB2kCPO
 p966IzIzoz2fn6jwUsFENR2VNjIMkYEXEw7vri9OUSFjbN4QB7HoKmehknaWcnd+FA83u9
 8mGtdYV3AE+JfUT4Owlh7o2Yleh2CEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-ec3Lid9_NvWNi3xKW8ncdQ-1; Wed, 13 May 2020 11:57:49 -0400
X-MC-Unique: ec3Lid9_NvWNi3xKW8ncdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26BA310CE78A;
 Wed, 13 May 2020 15:57:48 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 751E36A94A;
 Wed, 13 May 2020 15:57:47 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu_img: add cvtnum_full to print error reports
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <20200513133629.18508-1-eyal.moscovici@oracle.com>
 <20200513133629.18508-2-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3360d9b8-89cf-04be-3da3-3463d99e4808@redhat.com>
Date: Wed, 13 May 2020 10:57:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513133629.18508-2-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

The new common message is in terms of bytes, even though not all callers 
are specifically related to bytes.  I don't think it's a show-stopper, 
though, merely a quality of error message, and I don't have any ideas 
for how to improve it.

> @@ -4506,10 +4508,9 @@ static int img_dd_count(const char *arg,
>                           struct DdIo *in, struct DdIo *out,
>                           struct DdInfo *dd)
>   {
> -    dd->count = cvtnum(arg);
> +    dd->count = cvtnum("count", arg);
>   
>       if (dd->count < 0) {
> -        error_report("invalid number: '%s'", arg);

For example, the count argument to dd is not really about bytes, but 
repetitions.  So the error message is now more informative (what 
suffixes you can use) but also less accurate ("invalid number" was vague 
but at least correct).

I think the common code is worth the corner case regressions, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


