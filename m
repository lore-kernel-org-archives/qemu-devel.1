Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BEFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A10920759
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvSJnqBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A10920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtQH-00080S-5d
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMt3M-0007Fm-N3
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMt3K-0002hd-QS
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:18:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FybpakMfQz8tUuXexUBRnrsGqrrwdYiLeR0A3fLIHtI=;
 b=QvSJnqBSXfAVYJsIzYrwnMKmwqAJ3ECfvpKnm1JJKN+k9N/6mDqtDS5a0VQ07thZgAo6Wd
 DAHzLqqA8uRtIJbYk3goB+R8xOX1z6llzVGxOB7i27TwFsU4I7lMj7U1uUnolGl9MER0Y1
 u+j17E5D47WGq73G/RRLdIcRb8BfMx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-rOIdV-XhMSKbdOscP9iSDw-1; Mon, 28 Sep 2020 09:18:25 -0400
X-MC-Unique: rOIdV-XhMSKbdOscP9iSDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46A61809B66;
 Mon, 28 Sep 2020 13:18:24 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-193.ams2.redhat.com [10.36.114.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5393C78437;
 Mon, 28 Sep 2020 13:18:23 +0000 (UTC)
Date: Mon, 28 Sep 2020 15:18:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] qemu-io-cmds: Simplify help_oneline
Message-ID: <20200928131821.GG5451@linux.fritz.box>
References: <20200824102914.105619-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200824102914.105619-1-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: richard.henderson@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.08.2020 um 12:29 hat Dr. David Alan Gilbert (git) geschrieben:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> help_oneline is declared and starts as:
> 
>   static void help_oneline(const char *cmd, const cmdinfo_t *ct)
>   {
>       if (cmd) {
>           printf("%s ", cmd);
>       } else {
>           printf("%s ", ct->name);
>           if (ct->altname) {
>               printf("(or %s) ", ct->altname);
>           }
>       }
> 
> However, there are only two routes to help_oneline being called:
> 
>    help_f -> help_all -> help_oneline(ct->name, ct)
> 
>    help_f -> help_onecmd(argv[1], ct)
> 
> In the first case, 'cmd' and 'ct->name' are the same thing,
> so it's impossible for the if (cmd) to be false and then validly
> print ct->name - this is upsetting gcc
> ( https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96739 )
> 
> In the second case, cmd is argv[1] and we know we've got argv[1]
> so again (cmd) is non-NULL.
> 
> Simplify help_oneline by just printing cmd.
> (Also strengthen argc check just to be pedantic)
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks, applied to the block branch.

Kevin


