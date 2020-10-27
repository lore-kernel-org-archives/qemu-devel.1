Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DDFC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0128520790
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oe5QzDZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0128520790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSAV-00021M-S0
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXS98-0000pF-0T
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXS96-00041E-2T
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603817306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7mlzUpWUurGfSEh1srKOodSwnqCtKLTNG/2KB0lbBs=;
 b=Oe5QzDZspiwxz6HxWL7JS6noW0DnMjcd69kqNAPSS42Jc6UKn9uydBY5dklFqZ1+qV9Ct4
 eX2vmK03xAAkUfmJda4g0zFBK0Zw9diLfWaqZ69J1QsBd14oOnZwuTrzqVPF9+fIIz9D0K
 Wk94ddDlr8B7/3uhkvEbFpeZ6sUTkEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-h7AYo5jFP0OnRn0oNoq2DA-1; Tue, 27 Oct 2020 12:48:24 -0400
X-MC-Unique: h7AYo5jFP0OnRn0oNoq2DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED3F1019624;
 Tue, 27 Oct 2020 16:48:23 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43F361992F;
 Tue, 27 Oct 2020 16:48:23 +0000 (UTC)
Subject: Re: [PATCH 2/3] iotests: Disable unsubscriptable-object in pylint
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20201027163806.290960-1-kwolf@redhat.com>
 <20201027163806.290960-3-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <90b7da54-5ada-c86d-29cb-fa97e2ff9360@redhat.com>
Date: Tue, 27 Oct 2020 12:48:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027163806.290960-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 12:38 PM, Kevin Wolf wrote:
> When run with Python 3.9, pylint incorrectly warns about things like
> Optional[foo] because it doesn't recognise Optional as unsubscriptable.
> This is a known pylint bug:
> 
>      https://github.com/PyCQA/pylint/issues/3882
> 
> Just disable this check to get rid of the warnings.
> 
> Disabling this shouldn't make us miss any real bug because mypy also
> has a similar check ("... is not indexable").
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/pylintrc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> index 5481afe528..cd3702e23c 100644
> --- a/tests/qemu-iotests/pylintrc
> +++ b/tests/qemu-iotests/pylintrc
> @@ -17,6 +17,8 @@ disable=invalid-name,
>           too-many-lines,
>           too-many-locals,
>           too-many-public-methods,
> +        # pylint warns about Optional[] etc. as unsubscriptable in 3.9
> +        unsubscriptable-object,
>           # These are temporary, and should be removed:
>           missing-docstring,
>   
> 

Reviewed-by: John Snow <jsnow@redhat.com>


