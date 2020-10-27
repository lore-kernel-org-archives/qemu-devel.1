Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F041C5DF9E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D8320723
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cioy99S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D8320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSD7-0004HJ-2o
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXSB7-0002qZ-J6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXSB5-0004O0-HF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603817430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIMti6JKnkbcZN+X9FTdxLi4RUuzLsh6v4HUXZxhOrw=;
 b=cioy99S3R96BR/JICiz6FeK/VugXwUeo+0CsgLSRcEg8NHrgThqR4Q/Y8BwmzoKw8Mjz0f
 QxOaax74Y52qmk3JsU8VdvDk69+ZAfZ7iqamoiQGW2xRvS9QQUppmwpqd+VB2iDyXui6Cl
 wuv5Jj/lHZPEhy2KtT61hF77QvCg7IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-c_tCu_CgPa-mNDH-uCYb9g-1; Tue, 27 Oct 2020 12:48:44 -0400
X-MC-Unique: c_tCu_CgPa-mNDH-uCYb9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27FB1019635;
 Tue, 27 Oct 2020 16:48:42 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BFB55C1C2;
 Tue, 27 Oct 2020 16:48:42 +0000 (UTC)
Subject: Re: [PATCH 3/3] iotests: Use Python 3 style super()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20201027163806.290960-1-kwolf@redhat.com>
 <20201027163806.290960-4-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <886ac7e5-3191-e4a3-b689-1e9dfd2bdf26@redhat.com>
Date: Tue, 27 Oct 2020 12:48:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027163806.290960-4-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> pylint complains about the use of super with the current class and
> instance as arguments in VM.__init__():
> 
> iotests.py:546:8: R1725: Consider using Python 3 style super() without arguments (super-with-arguments)
> 
> No reason not to follow the advice and make it happy, so let's do this.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 28388a0fbc..814804a4c6 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -543,10 +543,10 @@ class VM(qtest.QEMUQtestMachine):
>   
>       def __init__(self, path_suffix=''):
>           name = "qemu%s-%d" % (path_suffix, os.getpid())
> -        super(VM, self).__init__(qemu_prog, qemu_opts, name=name,
> -                                 test_dir=test_dir,
> -                                 socket_scm_helper=socket_scm_helper,
> -                                 sock_dir=sock_dir)
> +        super().__init__(qemu_prog, qemu_opts, name=name,
> +                         test_dir=test_dir,
> +                         socket_scm_helper=socket_scm_helper,
> +                         sock_dir=sock_dir)
>           self._num_drives = 0
>   
>       def add_object(self, opts):
> 

Reviewed-by: John Snow <jsnow@redhat.com>


