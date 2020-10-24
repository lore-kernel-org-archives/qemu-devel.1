Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24539C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B19122273
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IciMh1A7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B19122273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWBwu-00089I-Ld
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 01:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWBwJ-0007fv-Ew
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 01:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWBwF-0003IT-Mz
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 01:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603516679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcPJ+0dansrQEjZVEs6J/gOS9tCnbmcDDBpxk3mFcV4=;
 b=IciMh1A7HszlHmc0udi6Tjzi6lDxQ5oKo5fD9gttBPUe/wOZ3Ps8GEVKXltn8BPmRVvZlD
 57UTp71c7UQgVdDb04pXR+q3p6qd4HzDwZMOzJgE3oY/qsShmx0ZY8tvCYagEb+0FJKS9l
 Ws5W3goFiPGuiVw6tI0FEUoMGZLMBbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-n-nlHSgTOaG6uaHrZSUNQA-1; Sat, 24 Oct 2020 01:17:54 -0400
X-MC-Unique: n-nlHSgTOaG6uaHrZSUNQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59F13804B8E;
 Sat, 24 Oct 2020 05:17:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE1BF5D9D5;
 Sat, 24 Oct 2020 05:17:44 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4f779021-19c6-0203-e37d-563e17419db0@redhat.com>
Date: Sat, 24 Oct 2020 07:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:17:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-s390x <qemu-s390x@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/2020 22.06, Daniele Buono wrote:
> Clang 11 finds a couple of spots in the code that trigger new warnings:
> 
> ../qemu-base/hw/usb/dev-uas.c:157:31: error: field 'status' with variable sized type 'uas_iu' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>     uas_iu                    status;
>                               ^
> 1 error generated.
> 
> The data structure is UASStatus, which must end with a QTAILQ_ENTRY, so
> I believe we cannot have uas_iu at the end. Since this is a gnu
> extension but CLANG supports it, just add
> -Wno-gnu-variable-sized-type-not-at-end
> to remove the warning.
> 
> ../qemu-base/target/s390x/cpu_models.c:985:21: error: cast to smaller integer type 'S390Feat' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390Feat feat = (S390Feat) opaque;
>                     ^~~~~~~~~~~~~~~~~
> ../qemu-base/target/s390x/cpu_models.c:1002:21: error: cast to smaller integer type 'S390Feat' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390Feat feat = (S390Feat) opaque;
>                     ^~~~~~~~~~~~~~~~~
> ../qemu-base/target/s390x/cpu_models.c:1036:27: error: cast to smaller integer type 'S390FeatGroup' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390FeatGroup group = (S390FeatGroup) opaque;
>                           ^~~~~~~~~~~~~~~~~~~~~~
> ../qemu-base/target/s390x/cpu_models.c:1057:27: error: cast to smaller integer type 'S390FeatGroup' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390FeatGroup group = (S390FeatGroup) opaque;
>                           ^~~~~~~~~~~~~~~~~~~~~~
> 4 errors generated.
> 
> These are void * that get casted to enums, which are (or can be)
> smaller than a 64bit pointer.
> A code reorg may be better on the long term, but for now will
> fix this adding
> -Wno-void-pointer-to-enum-cast

Compiling all code with -Wno-void-pointer-to-enum-cast sounds like the wrong
approach to me, since this might hide some real bugs in other spots instead.

Could you please try to cast the value through (uintptr_t) first, e.g. :

    S390Feat feat = (S390Feat)(uintptr_t) opaque;

It's a little bit ugly, but still better than to disable the warning
globally, I think.

 Thomas


> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configure b/configure
> index e6754c1e87..9dc05cfb8a 100755
> --- a/configure
> +++ b/configure
> @@ -2000,6 +2000,8 @@ add_to nowarn_flags -Wno-shift-negative-value
>  add_to nowarn_flags -Wno-string-plus-int
>  add_to nowarn_flags -Wno-typedef-redefinition
>  add_to nowarn_flags -Wno-tautological-type-limit-compare
> +add_to nowarn_flags -Wno-gnu-variable-sized-type-not-at-end
> +add_to nowarn_flags -Wno-void-pointer-to-enum-cast
>  add_to nowarn_flags -Wno-psabi
>  
>  gcc_flags="$warn_flags $nowarn_flags"
> 


