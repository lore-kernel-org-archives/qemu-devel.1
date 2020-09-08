Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4FC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B287321D81
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDkybgc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B287321D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcMP-0004h2-QV
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFcLf-0003nP-Ck
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:03:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFcLd-0004WX-SB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599566621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnNxmmJCEHovj+jxeCQrNN4ORE/fPi7Vmdiu6Bz+PCQ=;
 b=QDkybgc/7F//dlaongK4LmEEjlnm//ka957AyL/ebdpyYdy4h9ETEmJi+qJvxwN4jcsTDY
 ZLqLt+dtm70NiXga8pPinOD58XaIJKJ9Qu6POPwMUqg4pLje0At/PWK58QUtXdcB36/FAx
 +Etna4dMg9wXUOAr3j0IvF/NP9+SJFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-rSdyn_9yOe-8cO6K0qS0FA-1; Tue, 08 Sep 2020 08:03:39 -0400
X-MC-Unique: rSdyn_9yOe-8cO6K0qS0FA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7490718BA285;
 Tue,  8 Sep 2020 12:03:38 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2A010013C4;
 Tue,  8 Sep 2020 12:03:34 +0000 (UTC)
Subject: Re: [PATCH 1/4] docs: lift block-core.json rST header into parents
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-2-stefanha@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f5de1038-5bf3-8bd4-d664-45d6f201ae9b@redhat.com>
Date: Tue, 8 Sep 2020 14:03:34 +0200
MIME-Version: 1.0
In-Reply-To: <20200908093113.47564-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 09/08/20 11:31, Stefan Hajnoczi wrote:
> block-core.json is included from several places. It has no way of
> knowing what header level (h1, h2, ...) is appropriate. Sphinx reports
> errors when it encounters an h2 header where it expects an h1 header.
> This issue prevents the next patch from generating documentation for
> qemu-storage-daemon QMP commands.
> 
> Move the header into parents so that the correct header level can be
> used. Note that transaction.json is not updated since it doesn't seem to
> need a header.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/firmware.json | 4 ++++
>  qapi/block-core.json       | 4 ----
>  qapi/block.json            | 1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 989f10b626..48af327f98 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -15,6 +15,10 @@
>  ##
>  
>  { 'include' : 'machine.json' }
> +
> +##
> +# == Block devices
> +##
>  { 'include' : 'block-core.json' }
>  
>  ##

I think "docs/interop/firmware.json" deserves the same treatment as
"transaction.json".

It's been a long time since I last looked at a rendered view of
"docs/interop/firmware.json", but it only includes "block-core.json" so
it can refer to some block-related types (@BlockdevDriver seems like the
main, or only, one).

I wouldn't expect the rendered view of "firmware.json" to have a section
header saying "Block devices".

I think it should be fine to drop this hunk (and my CC along with it ;))

Thanks!
Laszlo

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 55b58ba892..e986341997 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1,10 +1,6 @@
>  # -*- Mode: Python -*-
>  # vim: filetype=python
>  
> -##
> -# == Block core (VM unrelated)
> -##
> -
>  { 'include': 'common.json' }
>  { 'include': 'crypto.json' }
>  { 'include': 'job.json' }
> diff --git a/qapi/block.json b/qapi/block.json
> index c54a393cf3..473b294a3b 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -3,6 +3,7 @@
>  
>  ##
>  # = Block devices
> +# == Block core (VM unrelated)
>  ##
>  
>  { 'include': 'block-core.json' }
> 


