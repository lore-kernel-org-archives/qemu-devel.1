Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E99D206DD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwzWw3Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E99D206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqWf-0006Jv-DB
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPqVo-0005nL-2d
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPqVl-000524-6X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602004343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+7XqSJItk+i6N1Z50T272rWJmUgTCZofcmcIEuoGZ8=;
 b=LwzWw3IxN7P4IS8RlzJXKENIG9PV8yfMxPGlU4d43mkdqQXfAW/tXO0ZFWWgVxXJEmYE3o
 uxiC15WQh1UHqRoLw7krx81CfzlnYGec2pwrGz5+z6kAb/yoF8fNc5ZC4NswQV1cstV0z5
 uu5IAavMeaZVVXHdZ1pygKUq0ttTiik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-GD-Mxxo9NbKDLUGbyGuqqQ-1; Tue, 06 Oct 2020 13:12:22 -0400
X-MC-Unique: GD-Mxxo9NbKDLUGbyGuqqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A81B8031F8
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 17:12:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EB8A55760;
 Tue,  6 Oct 2020 17:12:18 +0000 (UTC)
Subject: Re: [PATCH 3/3] docs/devel/qtest: Include libqtest API reference
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201005205228.697463-1-ehabkost@redhat.com>
 <20201005205228.697463-4-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <62336b4c-79b7-287b-8d9d-c269ce213c61@redhat.com>
Date: Tue, 6 Oct 2020 19:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201005205228.697463-4-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/2020 22.52, Eduardo Habkost wrote:
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   docs/devel/qtest.rst          |  6 ++++++
>   tests/qtest/libqos/libqtest.h | 20 ++++++++++----------
>   2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
> index 3bf9ebee7f0..075fe5f7d53 100644
> --- a/docs/devel/qtest.rst
> +++ b/docs/devel/qtest.rst
> @@ -64,3 +64,9 @@ QTest Protocol
>   
>   .. kernel-doc:: softmmu/qtest.c
>      :doc: QTest Protocol
> +
> +
> +libqtest API reference
> +----------------------
> +
> +.. kernel-doc:: tests/qtest/libqos/libqtest.h
> diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
> index a6ee1654f20..209fcf69737 100644
> --- a/tests/qtest/libqos/libqtest.h
> +++ b/tests/qtest/libqos/libqtest.h
> @@ -24,7 +24,7 @@ typedef struct QTestState QTestState;
>   
>   /**
>    * qtest_initf:
> - * @fmt...: Format for creating other arguments to pass to QEMU, formatted
> + * @fmt: Format for creating other arguments to pass to QEMU, formatted
>    * like sprintf().
>    *
>    * Convenience wrapper around qtest_init().
> @@ -87,7 +87,7 @@ void qtest_quit(QTestState *s);
>    * @s: #QTestState instance to operate on.
>    * @fds: array of file descriptors
>    * @fds_num: number of elements in @fds
> - * @fmt...: QMP message to send to qemu, formatted like
> + * @fmt: QMP message to send to qemu, formatted like
>    * qobject_from_jsonf_nofail().  See parse_escape() for what's
>    * supported after '%'.
>    *
> @@ -100,7 +100,7 @@ QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
>   /**
>    * qtest_qmp:
>    * @s: #QTestState instance to operate on.
> - * @fmt...: QMP message to send to qemu, formatted like
> + * @fmt: QMP message to send to qemu, formatted like

I think you should mention those changes to all those "fmt..." in the commit 
message?

  Thomas


