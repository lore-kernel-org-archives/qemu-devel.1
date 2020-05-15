Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7FCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2A7205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIXQJ3Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2A7205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZV8N-0007mf-Go
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZV7W-0007LP-6b
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:51:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZV7U-0005Rz-Oj
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589529059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=56jiwixpgg9jNo55GQoPJP2xKPgT7j5dmInaRJV33Z8=;
 b=WIXQJ3XiludUkqGR0EA+c5aZZ8BULFhckeAhcwECnzj3GBrtpPfYOnYxw1bEtk5WGFKPlm
 CQvHerO9yExat0TIC+rRbVH0TgwJFt63/m2PjYNukCUVRPL//vO6+QO8eOlUcVXvoN5jkO
 xNds8fTCrVuhWTm8XbGGhrUh62GTepU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-JU-PCIhzMHCE6X9X9kQbZA-1; Fri, 15 May 2020 03:50:52 -0400
X-MC-Unique: JU-PCIhzMHCE6X9X9kQbZA-1
Received: by mail-wr1-f70.google.com with SMTP id z5so752307wrt.17
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 00:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=56jiwixpgg9jNo55GQoPJP2xKPgT7j5dmInaRJV33Z8=;
 b=lj+foivv6UwUNCuR9gefyqqX5bXFEeBLR+AmprfXxs/t6dJJr4CvcVybtmeqPiDMhG
 ZWsjoAZ7FEAkJiop9jCRKUZ+VKoilhvYBea27QMF2FY55/4hcCESut+nAckh8VrzjYr2
 dS+4qF9C1VGl7NtsDtzblreRfotBgJc+JbW4afXHi2Fh4p3Y2b/w13Jb88/Fzwor8eGL
 vr5YWDdG9kDq94ZUFY4Vgo5YsNCqIlmLV9hZ1G8EMGa8jYaniXZhZwwb9Zd0jxdQtcS8
 5D5yh9989RTOrFZc1r/yJNCPc011kV3kgtFauYvsqfYgFEyz7VLAZDKUmzMZo2PCZKpx
 nlbA==
X-Gm-Message-State: AOAM530OoNP3tEM+aM8Ng+Gvx926/f6GnEZFEPJm39ORfT0iVZyt2SBt
 kZCpYt69el1OOsSOLu8I4dq7oMetL5rbWDNSOSyrP2hGkaJy6TmG0lEi2Ta++RX/InEOajQD/n3
 XMSDGPAzi+AmBPsI=
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr2433292wmj.146.1589529051526; 
 Fri, 15 May 2020 00:50:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqWyzI1M2PT2mCgFXR3C2pyMeVzy/5rgvttUk3F/6OwG/otEX1YpN/uUsXD8Rc688++wlGYA==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr2433267wmj.146.1589529051265; 
 Fri, 15 May 2020 00:50:51 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s2sm2265258wme.33.2020.05.15.00.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 00:50:50 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Makefile: libfdt: build only the strict necessary
To: Claudio Fontana <cfontana@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200514193811.6798-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be9d37e8-ea14-c42d-b8e6-405840e75b45@redhat.com>
Date: Fri, 15 May 2020 09:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514193811.6798-1-cfontana@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Claudio,

On 5/14/20 9:38 PM, Claudio Fontana wrote:
> v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU yet)
> 
> * changed the approach to leverage new upstream dtc Makefile,
>    needs dtc submodule update to include upstream dtc commit
>    85e5d839847af54efab170f2b1331b2a6421e647.

I don't have this commit locally:

fatal: bad object 85e5d839847af54efab170f2b1331b2a6421e647

My remote is https://git.qemu.org/git/dtc.git, might it be de-synchronized?

> 
> * LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
>    not used anymore.

Why not include the submodule update in the first patch?

> 
> * LIBFDT_lib: need to avoid building libfdt.so at least for now, so pass as
>    empty to avoid building the .so. This is to avoid breaking existing
>    trees with objects already compiled without -fPIC.
> 
> * clean: no need to make dtc clean target, every artifact is captured by
>    global clean rule
> 
> v2 -> v3:
> 
> * changed into a 2 patch series; in the second patch we remove the old
>    compatibility gunks that were meant for removal some time after 4.1.
> 
> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
>    existing working trees forward and backward compatible across the change.
> 
> v1 -> v2:
> 
> * fix error generated when running UNCHECKED_GOALS without prior configure,
>    for example during make docker-image-fedora. Without configure, DSOSUF is
>    empty, and the module pattern rule in rules.mak that uses this variable
>    can match too much; provide a default in the Makefile to avoid it.
> 
> * only attempt to build the archive when there is a non-empty list of objects.
>    This could be done in general for the %.a: pattern in rules.mak, but maybe
>    there are valid reasons to build an empty .a?
> 
> * removed some intermediate variables that did not add much value
>    (LIBFDT_srcdir, LIBFDT_archive)
> 
> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
> and with docker-image-fedora, docker-test-debug@fedora that failed before.
> 
> Claudio Fontana (2):
>    Makefile: libfdt: build only the strict necessary
>    Makefile: remove old compatibility gunks
> 
>   Makefile  | 32 ++++++++++++++++----------------
>   configure |  6 +-----
>   rules.mak |  2 ++
>   3 files changed, 19 insertions(+), 21 deletions(-)
> 


