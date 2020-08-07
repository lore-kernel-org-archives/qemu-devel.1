Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA25C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B6420748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TM8Ik2vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B6420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zFV-00005U-Bi
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3zDV-0004up-Dq
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:03:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3zDT-0006WE-Kc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596794590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=upucBznWtiYhhuTXzAqRV329zbtbSZSoCut6Cs0pFhE=;
 b=TM8Ik2vj1sTUr1XvAkHKqgl71ipxRyXBxDs5IeX9ESWsI3n0K/MJ+bNpxX22+K6k+IGAMC
 q97CJxu0rWHzD/2OidABnlpoeZu+fUbSe1c5wpdJggJZK0V6Y2bs34LbtmI6JS/UPF4Mh6
 +/rPHOeNCGZUK557mGGqTmsaUJ5gFCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-NCRzaQ_WMbe6xzegMJCaPQ-1; Fri, 07 Aug 2020 06:03:07 -0400
X-MC-Unique: NCRzaQ_WMbe6xzegMJCaPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA2361800D4A;
 Fri,  7 Aug 2020 10:03:06 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-31.ams2.redhat.com [10.36.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D139D5DA33;
 Fri,  7 Aug 2020 10:03:00 +0000 (UTC)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <4a79a167-ccd6-159a-0f67-072192b54b0d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f4233923-f82e-6edf-8a56-2e4f62038d0e@redhat.com>
Date: Fri, 7 Aug 2020 12:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4a79a167-ccd6-159a-0f67-072192b54b0d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2020 11.51, Paolo Bonzini wrote:
> On 07/08/20 11:45, Thomas Huth wrote:
>> On 07/08/2020 11.31, Paolo Bonzini wrote:
>>> On 07/08/20 10:51, Thomas Huth wrote:
>>>> 2) With --meson=git added, I also do not get much further:
>>>>  "./ui/meson.build:77:0: ERROR: Program 'keycodemapdb/tools/keymap-gen'
>>>> not found"
>>>>
>>>>  https://gitlab.com/huth/qemu/-/jobs/675546229
>>>>
>>>> Any idea what's going wrong here?
>>>
>>> This is also a submodule not being initialized,
>>> ui/keycodemapdb/tools/keymap-gen comes from a submodule.
>>
>> Ok. I've added a hack to my configure script to checkout the submodules,
>> but still, it does not compile yet:
>>
>>  ../tools/virtiofsd/meson.build:1:0: ERROR: Unknown variable
>> "libvhost_user".
>>  https://gitlab.com/huth/qemu/-/jobs/675665455
> 
> Fixed, thanks:
> 
> diff --git a/meson.build b/meson.build
> index 38f1f40..cc96d07 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1091,9 +1091,10 @@ if have_tools
>      subdir('contrib/ivshmem-client')
>      subdir('contrib/ivshmem-server')
>    endif
> +
> +  subdir('tools')
>  endif
> 
> -subdir('tools')
>  subdir('scripts')
>  subdir('pc-bios')
>  subdir('tests')

Thanks! With the fix, it now gets a little bit further, but then stops with:

  ../meson.build:1258:3: ERROR: Key CONFIG_QEMU_PRIVATE_XTS is not in dict
 https://gitlab.com/huth/qemu/-/jobs/675699330#L130

 Thomas


