Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772EFC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4871720815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4871720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIR0-0004u0-Vr
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFINZ-0001IX-98
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFINV-0004Pe-EQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFINV-0004Ni-8w
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:39:45 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D0E6BCFE0
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 13:39:43 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 124so880012wmz.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mJ1vZ2IgU021iQiANKrtx1JtMBnDDg1nJShflutE3u4=;
 b=QUiZarF7VJeHD+Zmmaaq3QSifATWiny7LvDymZ/nnbUMJDxMOSXb6er9oWJmORsoeu
 GOkUwT4Wu5QD0CJb5TK1l10HvC4w46atZDQu+Ddc7hiDA7J9lwFrMxmLHIOlqMkt4EG6
 GSjbnZyZppg66leQ98NRGg3SB9p4/2Zk2ddf+4Gp4rUxqpKmEDgoniNJRvQVgGKPfaMh
 TD87BBdP7TK3+hHxzsJMTamgdcnJ8g45ZUixEnobwnjDRTDJ5+iBCcXXQJGi2OMY1i6v
 dK7EAf0SDYWh+5vCH4hKKe6GkaH1oGaqE57yPqsbECvwYp+zF4n2nxVon6gtZESvB/Sx
 xcmg==
X-Gm-Message-State: APjAAAVDhKmjEb/fq3yAUWsAnk48OEtMqxxJyGymVp/2+EkXNehvA3xB
 Whn/68cuqVRUG1/xO2SXg00oq9+MteQR61xMllVu8meGitSN5/WKsZ3s3Fdk8qFT3mxA4gZ/ZZv
 JbcxsbOYJtt7nggM=
X-Received: by 2002:adf:f343:: with SMTP id e3mr17933442wrp.268.1569937181736; 
 Tue, 01 Oct 2019 06:39:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxjfxY7dXxnhUjTv7FXsXFzWqClVXETOp5AfbbMeUkVuGlJlhEKHmknwujN545KDnyuIuVCpQ==
X-Received: by 2002:adf:f343:: with SMTP id e3mr17933424wrp.268.1569937181460; 
 Tue, 01 Oct 2019 06:39:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dd94:29a5:6c08:c3b5?
 ([2001:b07:6468:f312:dd94:29a5:6c08:c3b5])
 by smtp.gmail.com with ESMTPSA id q66sm1915005wme.39.2019.10.01.06.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:39:40 -0700 (PDT)
Subject: Re: [PATCH 0/3] Some win32 fixes
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8bc51230-963b-e9e2-25ea-9719223c5c79@redhat.com>
Date: Tue, 1 Oct 2019 15:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001132609.23184-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: sw@weilnetz.de, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/19 15:26, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> Here are a few patches that should fix some busy looping issues
> already reported >2y ago
> (https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00420.html),
> and fixing test-char on win32.

Queued thanks (with s/fix/work around/ in the commit subject of
patch 3).

> hmm, do we have any automated testing/CI on Windows (beside just
> cross-compilation)?

Nope. :(

Paolo

