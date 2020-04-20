Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B298EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BAB208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjx8Z0Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BAB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSGt-0007ZK-Jg
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32918 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jQSGG-00076v-TW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:58:41 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jQSGG-00025y-Bl
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:58:40 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:33324)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jQSGF-00022L-F5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:58:40 -0400
Received: by mail-ed1-x533.google.com with SMTP id j20so6744405edj.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=l12LqyTH4YgL3udx+mMMxH3mer6k55ySqu3cyDYdhec=;
 b=Qjx8Z0Ed/kKdXep5rDdvFhr5KVGQog4BiWtrplRP6hSSskyzCXPWh0sTr+5Pl3MOKW
 ot1j5t9vUjdC0xTr8FtSt3a6gMHp2ZK/lgqqQrWc3Tl8GaQ5jnu4b2zKzyGNLQ+zo+Si
 gELZtGQTjhMNVtGgM8fHjEtyd2YvM7QfwVBVm9JFk4aenWBS5GwmmoSHSAzXnGwnYk9V
 e+7sWwg19gPqG43omTfeUJG0GSTPj1tkb/ATOvzk3I40JxqseDUZ8F8I5WZpP07IYKAw
 8ujUjxBCyM9jH1e08GsCk6PBoTzW/YI9MNngOH7sOudKp5IhcLccjUg3RvQAu/dj0jLf
 mYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=l12LqyTH4YgL3udx+mMMxH3mer6k55ySqu3cyDYdhec=;
 b=rZH7z0uRnxB1xtueBb1h0Q7PnVurZMf37Z5g14LgplGTzze455kX8lV3A2zPJZyrTt
 /g5sScs28zIT+hPpkJNO5OYTRoe3+/xfAZR7WVHU7EdyJiEjtSoH4Ejff8Gg6MAK7PRj
 s6db9eDvlSut27IQweWnXvp/27P3xgMBoQQPHh15O3s7nBlOsqnZAj+0SrdO93cteB7R
 n+7KKDuitEakWChOibkdhQ649R+9aV1if7GhPX4h0PFzwfzI8aTCkhMCUEgwwiPVPdmr
 vFVev9n6pFXRIRf0PX0AQ4qIhTdCr3Fw24Gp4FNBmKHw2itKZPVQgXkgoLqopLZuy0nT
 3wtw==
X-Gm-Message-State: AGi0PuaUwePfJK5RmRtRp435FXnlr9iAKbwrCboAQkjZavpbB6LKB6XF
 3pYRkmY7flrx4bZNCJ4VUjw=
X-Google-Smtp-Source: APiQypIKPCo2plSHpjjzSAMNGT9aA4e3L7shMprjSVglVHH/8jSrvmcyN8rO+29d1JFDuoXpyr19cQ==
X-Received: by 2002:a05:6402:310b:: with SMTP id
 dc11mr12798473edb.143.1587373117743; 
 Mon, 20 Apr 2020 01:58:37 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.186])
 by smtp.gmail.com with ESMTPSA id dm15sm21184edb.84.2020.04.20.01.58.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Apr 2020 01:58:37 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Markus Armbruster'" <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-10-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-10-armbru@redhat.com>
Subject: RE: [PATCH 09/11] xen/pt: Fix flawed conversion to realize()
Date: Mon, 20 Apr 2020 09:58:35 +0100
Message-ID: <002201d616f1$e1057910$a3106b30$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIW6PbL/TFzdKd45gQwHtYhr73cEQJR6tGlp+2CVEA=
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::533
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
Reply-To: paul@xen.org
Cc: 'Anthony Perard' <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, 'Stefano Stabellini' <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: 20 April 2020 09:33
> To: qemu-devel@nongnu.org
> Cc: Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>; Paul
> Durrant <paul@xen.org>; xen-devel@lists.xenproject.org
> Subject: [PATCH 09/11] xen/pt: Fix flawed conversion to realize()
> 
> The conversion of xen_pt_initfn() to xen_pt_realize() blindly replaced
> XEN_PT_ERR() by error_setg().  Several error conditions that did not
> fail xen_pt_initfn() now fail xen_pt_realize().  Unsurprisingly, the
> cleanup on these errors looks highly suspicious.
> 
> Revert the inappropriate replacements.
> 
> Fixes: 5a11d0f7549e24a10e178a9dc8ff5e698031d9a6
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Paul Durrant <paul@xen.org>


