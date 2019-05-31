Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFB1C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 03:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8222630B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 03:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGYe61IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8222630B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWYLi-0001zr-S4
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 23:36:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1hWYKv-0001gh-Uk
	for qemu-devel@nongnu.org; Thu, 30 May 2019 23:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1hWYKt-0003D7-H0
	for qemu-devel@nongnu.org; Thu, 30 May 2019 23:36:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1hWYKs-00034h-6H
	for qemu-devel@nongnu.org; Thu, 30 May 2019 23:36:06 -0400
Received: by mail-pg1-x543.google.com with SMTP id v11so3214025pgl.5
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=AW6Ivx/Z/EXkhdL/Y0R3ENqRyEoAbGCBN716GTS07vs=;
	b=eGYe61INvGYTk7Kh5Zzvx8jdyYCqnib8xnARukDTbTLShpQRuAnSbm0yx45ek1MEYc
	M7JrNWTnDFsa8n3F8px4o/l9cMou4BWAGLQlveDCyvq+PlLbV/dS6JGegAIlELNfFBmm
	AWyvU1Y8mIpb9Jp0BN8cEzRs37fOEldSdR8AiLXRryICbjQbPzscyaEc4hxKuBRj3Ui2
	UDV/L0Y+n+A/8jC6jFWpung8HTR/3Tet5UYaGsWgW+B+A0qhf/y9nthaSzy3xQYiP4Ry
	Lm4vM8To7dfZHzu41PwREHwSrZjOBglPlQm2QJz9WHmH7Ehya76OxQmgYR97QdYIsFyt
	gx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=AW6Ivx/Z/EXkhdL/Y0R3ENqRyEoAbGCBN716GTS07vs=;
	b=Gg/EoulqZkfdIrnQCNFIsXpNMjCPdNenzljd3TxU6PitykMp8KnQELABKkvH3Jf4Wp
	GXEXx3XYLIyCD1RQ+sXZC071sjpm7rjkwoZucaHiouuS6jZmTKu+ao2m9Vul8JCPaqMO
	XHtoV6RXW65BN+LT03RDSxL9qDDa6Hmebnc93dIUpZGYr026QXG1O0enVg0L+MOrDTpr
	DD47mcMz15IZda4lezXeb+vkvSJtpXE/CsBWBMWCCC03FHhn8Lsjs3krPddlSnKshhEW
	wWVzYosNgUXigajZZhZdeO+vnGstFT6QB4N748OsehquptBOJp/crJiK0T63fuQbwzLg
	WnnQ==
X-Gm-Message-State: APjAAAVFGxHFAvbsfI+16lCLaJ+gVVfrl224i39z3+86cmoJZY3Rc+Gl
	886cvGStYAxFXmM5/15FTks=
X-Google-Smtp-Source: APXvYqyudNrG9hPa5iZ5VG7QMWblGm1NiaTRK0WAsVRIulR3JIDNXOwZ4F1GK3mqolgHtV44mnabjA==
X-Received: by 2002:a63:fd4a:: with SMTP id m10mr6107819pgj.302.1559273763956; 
	Thu, 30 May 2019 20:36:03 -0700 (PDT)
Received: from localhost (g30.211-19-85.ppp.wakwak.ne.jp. [211.19.85.30])
	by smtp.gmail.com with ESMTPSA id w1sm6149849pfg.51.2019.05.30.20.36.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 30 May 2019 20:36:03 -0700 (PDT)
Date: Fri, 31 May 2019 12:36:01 +0900
From: Stafford Horne <shorne@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190531033601.GB3379@lianli.shorne-pla.net>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529150853.9772-3-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 05:08:52PM +0200, Markus Armbruster wrote:
> When scripts/get_maintainer.pl reports something like
> 
>     John Doe <jdoe@example.org> (maintainer:Overall)
> 
> the user is left to wonder *which* of our three "Overall" sections
> applies.  We have three, one each under "Guest CPU cores (TCG)",
> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
> 
> Rename sections under
> 
> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
> 
> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
> 
> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
> 
> * "Architecture support" from "FOO" to "FOO general architecture
>   support"
> 
> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
> 
> While there,
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 78 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 39 insertions(+), 39 deletions(-)

... 

> -OpenRISC
> +OpenRISC CPU cores (TCG)
>  M: Stafford Horne <shorne@gmail.com>
>  S: Odd Fixes
>  F: target/openrisc/
>  F: hw/openrisc/
>  F: tests/tcg/openrisc/
>  

As directories listed there I look over both target/ (TCG?) and hw/.
Would it be better to be 'OpenRISC general architecture'?

-Stafford

