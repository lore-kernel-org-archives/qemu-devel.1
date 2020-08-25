Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4419E20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWlJ5iaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4419E20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAS4V-0006LH-Ie
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 02:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAS3t-0005i3-SC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:04:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAS3s-0000ti-6X
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598335439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hileqYC8/RVBiqefMX381AkDKqA/jyGsHB4ewOii3gM=;
 b=ZWlJ5iafwcyJYQnrzpqb3VJ0aw2A9VEqEURZ2nshKdu2bA4K0nIEvh+Hs8KdAAEtQdF5p+
 TnOSjHjt+doZTQJbrOABYk3ckvp8lB1wH8/P3CIQp6Bcc33+9Y74AGwQI0jkSbusJPVnum
 crv7OA2+00SXrvLnMM3mX7rv6ma50d4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-mo40i8j7P02XhM-NjT_GzQ-1; Tue, 25 Aug 2020 02:03:55 -0400
X-MC-Unique: mo40i8j7P02XhM-NjT_GzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1683F801AEA;
 Tue, 25 Aug 2020 06:03:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA346100239B;
 Tue, 25 Aug 2020 06:03:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CD34112D737; Tue, 25 Aug 2020 08:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Rohit Shinde <rohit.shinde12194@gmail.com>
Subject: Re: [PATCH v5] qapi/opts-visitor: Added missing fallthrough
 annotations
References: <20200818105021.4998-1-rohit.shinde12194@gmail.com>
Date: Tue, 25 Aug 2020 08:03:52 +0200
In-Reply-To: <20200818105021.4998-1-rohit.shinde12194@gmail.com> (Rohit
 Shinde's message of "Tue, 18 Aug 2020 06:50:21 -0400")
Message-ID: <87o8mzjm7r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rohit Shinde <rohit.shinde12194@gmail.com> writes:

> Added fallthrough comment on line 270 to prevent the compiler from
> throwing an error while compiling with the -Wimplicit-fallthrough flag

None of the compilers I know warns there.  Which one are you using?

Commit message style tip: use the imperative mood
https://chris.beams.io/posts/git-commit/#imperative

> Signed-off-by: Rohit Shinde <rohit.shinde12194@gmail.com>
> ---
>  qapi/opts-visitor.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 7781c23a42..3422ff265e 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>          }
>          ov->list_mode = LM_IN_PROGRESS;
>          /* range has been completed, fall through in order to pop option */
> +        /* fallthrough */
>  
>      case LM_IN_PROGRESS: {
>          const QemuOpt *opt;


