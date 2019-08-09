Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F346C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDE32089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDE32089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Nn-0001Ki-73
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw7NK-0000rx-8A
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw7NJ-0007lJ-Aq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:04:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw7NJ-0007i4-4a
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:04:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so98684608wrl.7
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 09:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=my6mP96CvMT4/kypSYFCgjKQrrLshhnlsr+ElDYOS8w=;
 b=nARzedjAsZaIGGmqT2odQsdoIjndzv5ttJbBlOZoaiEdW2R9hSD8JVwqsLBenbezTd
 Ow/OVNpwdULPBxthwC9dqtb4lcyXDNbfGSFaZbWxbPz0P9rbCZwVrw5P+cSVmlgsgnx6
 /E5xY/5RHva6fgLcJ5jts+fyN0VDgVs5WMzuowP33H8YIIdvkiCrIbO5vFRs7sN2SoaT
 RP1jZNE/IHNVLZXCDDe38XTkJQlhWChPmWQ+f0Lo6vDpQBeLsLonb9jcVRUNfsXG/Nh/
 1NMkR4MPZCFai5DVWF0QklfhR59H/mV8p/FzDqKaKIqG7MyDX0ytSmoRQzRndOfVtmFX
 sLfg==
X-Gm-Message-State: APjAAAUqTrYjFhTn88UfDKJbdYls+TZrbF0iMGWplPNP27oHogBCpDVJ
 +UENbqjLgBZgWCd/apnq4573xg==
X-Google-Smtp-Source: APXvYqyN04BUNO4kPP9gjlTn0zq58YWlW4Cf7ELTrFbjE9Igd3ZRZaVIV6AFYtTrLjf/5d0ooxGU9g==
X-Received: by 2002:adf:f206:: with SMTP id p6mr25714009wro.216.1565366655003; 
 Fri, 09 Aug 2019 09:04:15 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id c1sm217678362wrh.1.2019.08.09.09.04.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 09:04:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190809155047.24526-1-alex.bennee@linaro.org>
 <20190809155047.24526-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b0bb89c8-5838-bc12-ddee-ad3fe393c1fd@redhat.com>
Date: Fri, 9 Aug 2019 18:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809155047.24526-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 2/2] tests/docker: set DEF_TARGET_LIST
 for some containers
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
Cc: Fam Zheng <fam@euphon.net>, armbru@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 8/9/19 5:50 PM, Alex Bennée wrote:
> You can assume the failures most people are interested in are the
> cross-compile failures that are specific to the cross compile target.
> Set DEF_TARGET_LIST based on what we use for shippable, the user can
> always override by calling with TARGET_LIST set.

Some thoughts about this commit description:

I always wondered why .shippable.yml had this IMAGE/TARGET_LIST
relation, because while using TCG I'm always interested in the opposite,
compile for targets different than my host (except the endianess case,
where compiling for the opposite endianess might also be useful).

Now I can understand than when using KVM, one is interested in compiling
the same target than the host. However in the Docker cross-compilation
case we mostly can not test for KVM on the host...

Time for a host/os/target/feature/... CI matrix list on the wiki? :)

