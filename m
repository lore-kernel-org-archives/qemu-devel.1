Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C631C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7762086A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt8ERfLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7762086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZNq-0001sn-Mg
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdZN2-0001Ro-NL
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdZN1-0002LC-E4
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590498709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0MugPfxRAC/k5wo6R9jfn+XqNAZym1cIzrXydjnH1k=;
 b=Nt8ERfLIkwbwHBZILPA827yvgBH8MOeE8S3yvhOUgfJs49YUSbcgPHoRxM3RZBo0i9cEFd
 FWeiSV4u7jjIiu1GoWEoaUzmAF3rSS49LMzEOs0vYOWNUTSZouawXlpE98jLYveukFFUaP
 sWNzSsjcapJ3KLHcbuwJbqbAHr4pl6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-ZHynAgX4PCOXnHoUlgd7qg-1; Tue, 26 May 2020 09:11:47 -0400
X-MC-Unique: ZHynAgX4PCOXnHoUlgd7qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1339460
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 13:11:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 892D6707C6;
 Tue, 26 May 2020 13:11:45 +0000 (UTC)
Date: Tue, 26 May 2020 15:11:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 1/2] qapi: Fix comment format for @CpuInstanceProperties
Message-ID: <20200526151144.1ca61c42@redhat.com>
In-Reply-To: <e7a678664d5f384f8d4cae72755c9a887643b0c0.1590481402.git.mprivozn@redhat.com>
References: <cover.1590481402.git.mprivozn@redhat.com>
 <e7a678664d5f384f8d4cae72755c9a887643b0c0.1590481402.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 10:25:34 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> In 176d2cda0de, the @die-id attribute was introduced to
> CpuInstanceProperties type. However, it mangled the comment.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi/machine.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ff7b5032e3..39caa1d914 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -824,7 +824,8 @@
>  # @node-id: NUMA node ID the CPU belongs to
>  # @socket-id: socket number within node/board the CPU belongs to
>  # @die-id: die number within node/board the CPU belongs to (Since 4.1)
> -# @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
> +# @core-id: core number within die the CPU belongs to
> +# @thread-id: thread number within core the CPU belongs to
>  #
>  # Note: currently there are 5 properties that could be present
>  #       but management should be prepared to pass through other


