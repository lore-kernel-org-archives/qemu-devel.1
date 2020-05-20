Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120E62065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw9u4cvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120E62065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbWRy-0005LO-4r
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbWRD-0004ax-2w
 for qemu-devel@nongnu.org; Wed, 20 May 2020 17:39:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbWRB-0001CK-DP
 for qemu-devel@nongnu.org; Wed, 20 May 2020 17:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590010780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JogmCHLicPIRsLyeDXvVfpaRDW4HLICqSj+xGkc+4xY=;
 b=Pw9u4cvo5q2G1MvfaurjInrx+0co9XrNzTChh15tGIC5gmIU5CizdumIXjghW3zJ82dIVA
 rKD6Yjm5swm3IcsX6LwEr+jYYORc40M+vy9u/7trHGnt1OVNViqcOfUt9EXgCwZDAe/XWW
 nnXOLWtcX99MMxrnkEq9OaraSXfK+q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-udJg0nVOPnqUlM2aqLqTfA-1; Wed, 20 May 2020 17:39:34 -0400
X-MC-Unique: udJg0nVOPnqUlM2aqLqTfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E47107ACCD;
 Wed, 20 May 2020 21:39:33 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF0DC6EA19;
 Wed, 20 May 2020 21:39:32 +0000 (UTC)
Subject: Re: [PULL 2/6] qemu_img: add cvtnum_full to print error reports
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200518163218.649412-1-eblake@redhat.com>
 <20200518163218.649412-3-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3a03c86e-94af-317a-09d1-30ae6abc640d@redhat.com>
Date: Wed, 20 May 2020 16:39:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518163218.649412-3-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 17:39:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Moscovici <eyal.moscovici@oracle.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 11:32 AM, Eric Blake wrote:
> From: Eyal Moscovici <eyal.moscovici@oracle.com>
> 
> All calls to cvtnum check the return value and print the same error
> message more or less. And so error reporting moved to cvtnum_full to
> reduce code duplication and provide a single error
> message. Additionally, cvtnum now wraps cvtnum_full with the existing
> default range of 0 to MAX_INT64.
> 
> Acked-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> Message-Id: <20200513133629.18508-2-eyal.moscovici@oracle.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> [eblake: fix printf formatting, avoid trailing space, change error wording,
> reformat commit message]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

> @@ -572,16 +584,8 @@ static int img_create(int argc, char **argv)
>       if (optind < argc) {
>           int64_t sval;
> 
> -        sval = cvtnum(argv[optind++]);
> +        sval = cvtnum("image size", argv[optind++]);
>           if (sval < 0) {
> -            if (sval == -ERANGE) {
> -                error_report("Image size must be less than 8 EiB!");

This change broke iotest 178:

--- /home/eblake/qemu/tests/qemu-iotests/178.out.qcow2	2020-05-20 
16:33:20.065710365 -0500
+++ /home/eblake/qemu/build/tests/qemu-iotests/178.out.bad	2020-05-20 
16:35:28.924512423 -0500
@@ -13,7 +13,7 @@
  qemu-img: Invalid parameter 'snapshot.foo'
  qemu-img: Failed in parsing snapshot param 'snapshot.foo'
  qemu-img: --output must be used with human or json as argument.
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified. Must be between 0 and 
9223372036854775807.
  qemu-img: Unknown file format 'foo'

  == Size calculation for a new file (human) ==

I'll post a followup patch shortly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


