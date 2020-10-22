Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95955C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7875223C7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaVXJFiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7875223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSdQ-0007Fx-HW
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 00:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVScl-0006ot-BU
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 00:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVSci-0006DF-K1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 00:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603342486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i8y5mmfkHJKb4cW3tgc9RYANXX8MX0T0NyDwfxpS48=;
 b=ZaVXJFiKS1v8y0FsynMrFbBZGo6QUMsePwO/ERZFsfwT1L3vw6HW5DqpdfX+omL4VbXzTb
 l9/KVgALraO/dSqeP8A3iypsxeST/i6BgWWCvzjw92/v8gI+SjFlQJkpVSoGYsUnqMgJmR
 EF3fIGgnUdrI/TB5xKG6wybK26zEP1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-IUM0zjWPOHGL4kYGEkTNOg-1; Thu, 22 Oct 2020 00:54:41 -0400
X-MC-Unique: IUM0zjWPOHGL4kYGEkTNOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB5F91006C97;
 Thu, 22 Oct 2020 04:54:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05EC150B44;
 Thu, 22 Oct 2020 04:54:35 +0000 (UTC)
Subject: Re: [PATCH v1 4/6] gitlab: skip checkpatch.pl checks if no commit
 delta on branch
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201021163136.27324-1-alex.bennee@linaro.org>
 <20201021163136.27324-5-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b11e8fca-da19-7e1a-74ba-c3b8c396468d@redhat.com>
Date: Thu, 22 Oct 2020 06:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021163136.27324-5-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 18.31, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> If the current branch is synced to the current upstream git master,
> there are no commits that need checking. This causes checkpatch.pl
> to print an error that it found no commits. We need to avoid calling
> checkpatch.pl in this case.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20201019143537.283094-2-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/check-patch.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
> index 5a14a25b13..0ff30ee077 100755
> --- a/.gitlab-ci.d/check-patch.py
> +++ b/.gitlab-ci.d/check-patch.py
> @@ -33,8 +33,16 @@ ancestor = subprocess.check_output(["git", "merge-base",
>  
>  ancestor = ancestor.strip()
>  
> +log = subprocess.check_output(["git", "log", "--format=%H %s",
> +                               ancestor + "..."],
> +                              universal_newlines=True)
> +
>  subprocess.check_call(["git", "remote", "rm", "check-patch"])
>  
> +if log == "":
> +    print("\nNo commits since %s, skipping checks\n" % ancestor)
> +    sys.exit(0)
> +
>  errors = False
>  
>  print("\nChecking all commits since %s...\n" % ancestor)
> 

Acked-by: Thomas Huth <thuth@redhat.com>


