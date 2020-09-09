Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA509C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB4420C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ag660vMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB4420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG52K-0006FJ-Bm
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kG51R-0005EH-W8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:40:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23001
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kG51P-0007As-On
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599676841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCfXPGO28E/jRfkyD1CEGc8KrTfwTfKyaNwIwSuwhok=;
 b=ag660vMsAnZ/9lDLNq4oAe4b9ytpHdff5Az3yUPVLX3XJqNI5dVqUYe1jyo1+RtDJbiWxg
 cDz4fFUFB9rAAO/Lk7qGRbGCo8M7Xa7Ocxk5S5jCgPMewRvM8c64bJwi1TgztiH92wnX3u
 gtAKLbvLf+ZrhnChcZhl18tWVcVLnxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-oIzJ5CLUNAqatwMuu93B4g-1; Wed, 09 Sep 2020 14:40:39 -0400
X-MC-Unique: oIzJ5CLUNAqatwMuu93B4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F561882FA1;
 Wed,  9 Sep 2020 18:40:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA447E175;
 Wed,  9 Sep 2020 18:40:37 +0000 (UTC)
Subject: Re: [PATCH] configure: Do not intent to build WHPX on 32-bit host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200909182449.360472-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <357d7fe2-558f-4c3d-d178-742cb9eb6e21@redhat.com>
Date: Wed, 9 Sep 2020 20:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200909182449.360472-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/2020 20.24, Philippe Mathieu-Daudé wrote:
> Hyper-V is available on 64-bit versions of Windows,
> do not try to build its support on 32-bit versions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configure b/configure
> index 4231d56bcc0..4bd08f5469b 100755
> --- a/configure
> +++ b/configure
> @@ -2989,6 +2989,9 @@ if test "$whpx" != "no" ; then
>          fi
>          whpx="no"
>      fi
> +    if test "$whpx" = "yes" && test "$ARCH" = "i386"; then
> +      error_exit "WHPX requires 64-bit host"
> +    fi
>  fi

I think you should also add a check to the MINGW32 case (see commit
e7a222aeb813a) to prevent that the automatic detection kicks in (so that
you would end up with this error message even if you did not specify
--enable-whpx)

 Thomas


