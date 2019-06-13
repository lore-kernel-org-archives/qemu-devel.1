Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715FDC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431DC21473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431DC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbLdJ-00085S-9h
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbLcV-0007eH-8Q
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbLcQ-00027j-ID
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:02:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbLcJ-0001li-QU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:01:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so9247780wmj.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 02:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fK7MdgNfjkynSgg7EyuScLMh6XLw9kzVZhSooapuSC8=;
 b=S0A8BbZIVFhymKQAvQbgTSMDQQDTzHl6L9vDpON0mfvhu0nH+MaLzdZZQFdqG8a5vR
 JXy2HBi3su0Ah4KKl+JnNYp+wkefFaBZ25N02WNy3ZyC7MBkfi9h8IsrY8Btov0sbptn
 pU22oSVo5ftz/pUNmo9ND7aMbDareDhxVdBZ+KXg+oSBT5z2v2GDKxCQ+kRwCev73NCA
 OnNcUoDSy34bQffE/jGeEi49dUjoin072rM8ReNDxvItQE7TB4cWYtKDHU8FTy47PSQL
 nvsQmoxXKM8ZN/DU8AvyG65n0GwvkCdsIflNfrRKATVFSHcwahKICY4DoDJHW3VLl1/g
 r3cg==
X-Gm-Message-State: APjAAAUDPbgobhgLAix8nf3tnbdeDe9L0uubJgZIWY0b+YtYzCMbPUvS
 eMgamMHNOZCv2qrmrgAXzPX52Q==
X-Google-Smtp-Source: APXvYqxZfwnm8Gmf3Y6G2FcMwzvF3dQ3ctvLsgLLK+xQs7F3TBGqwi1NbYxioozFev/kN8oWiA3r9g==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192mr2726887wmb.152.1560416481387; 
 Thu, 13 Jun 2019 02:01:21 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l12sm1547422wrb.81.2019.06.13.02.01.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 02:01:20 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>, crosa@redhat.com,
 qemu-devel@nongnu.org, arikalo@wavecomp.com, aurelien@aurel32.net,
 ehabkost@redhat.com
References: <20190613060728.26955-1-david@gibson.dropbear.id.au>
 <20190613060728.26955-3-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <617a8179-7dcc-7c51-1239-6e4893090d43@redhat.com>
Date: Thu, 13 Jun 2019 11:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613060728.26955-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/acceptance: Handle ppc64le host
 arch correctly
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/19 8:07 AM, David Gibson wrote:
> ppc64 and ppc64le are different archs from the host kernel point of view
> and are advertised as such in uname.  But these cover the same set of CPUs,
> just in different endianness modes.  qemu-system-ppc64 handles both modes,
> so make sure we select the correct binary when running on ppc64le host
> architecture.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 2b236a1cf0..0ba9c536f4 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -39,6 +39,8 @@ def pick_default_qemu_bin(arch=None):
>      """
>      if arch is None:
>          arch = os.uname()[4]
> +        if arch == 'ppc64le':
> +            arch = 'ppc64'

I prefer the generic patch from Cleber:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03418.html
(I guess remember another version with a json file)

>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)
>      if is_readable_executable_file(qemu_bin_relative_path):
> 

