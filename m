Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4877C388F2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 02:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7AF22242
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 02:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PruCc6BU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7AF22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV4Eh-0006uh-FA
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 22:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4DZ-0006Dv-50
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 22:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4DW-0003UI-CU
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 22:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603248668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7UQ83lvkhz8y4yCGNFKHslN96axvC+cl56JM2KezwA=;
 b=PruCc6BUIsqzLh7LdK8J2aldCoPXnJ/JtL2lBtgn7h41xDHDmYBWKEIIs9rillJJ40WIW6
 WlMJNSY1no2eBBCUPhYUa30a/WHWLIWK2H3If7jOdk5KvCR4RaVj48z0GWX+YCs292+eWG
 MTKGUNNgIutaC7souxb7ozn0Dgymgoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-PD1Or6FcPBG_lgJb0uad5w-1; Tue, 20 Oct 2020 22:51:06 -0400
X-MC-Unique: PD1Or6FcPBG_lgJb0uad5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2883C804036;
 Wed, 21 Oct 2020 02:51:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D326D1002C0E;
 Wed, 21 Oct 2020 02:51:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A7641132A08; Wed, 21 Oct 2020 04:50:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] hw/rtc/twl92230: Silence warnings about missing
 fallthrough statements
References: <20201020105108.19733-1-thuth@redhat.com>
Date: Wed, 21 Oct 2020 04:50:59 +0200
In-Reply-To: <20201020105108.19733-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 20 Oct 2020 12:51:08 +0200")
Message-ID: <877drks358.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> When compiling with -Werror=implicit-fallthrough, gcc complains about
> missing fallthrough annotations in this file. Looking at the code,
> the fallthrough is indeed wanted here, but instead of adding the
> annotations, it can be done more efficiently by simply calculating
> the offset with a subtraction instead of increasing a local variable
> one by one.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Fixed copy-n-paste bug
>
>  hw/rtc/twl92230.c | 50 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
> index f838913b37..50b97a1fce 100644
> --- a/hw/rtc/twl92230.c
> +++ b/hw/rtc/twl92230.c
> @@ -271,37 +271,36 @@ static void menelaus_gpio_set(void *opaque, int line, int level)
>  static uint8_t menelaus_read(void *opaque, uint8_t addr)
>  {
>      MenelausState *s = (MenelausState *) opaque;
> -    int reg = 0;
>  
>      switch (addr) {
>      case MENELAUS_REV:
>          return 0x22;
>  
> -    case MENELAUS_VCORE_CTRL5: reg ++;
> -    case MENELAUS_VCORE_CTRL4: reg ++;
> -    case MENELAUS_VCORE_CTRL3: reg ++;
> -    case MENELAUS_VCORE_CTRL2: reg ++;
> +    case MENELAUS_VCORE_CTRL5:
> +    case MENELAUS_VCORE_CTRL4:
> +    case MENELAUS_VCORE_CTRL3:
> +    case MENELAUS_VCORE_CTRL2:
>      case MENELAUS_VCORE_CTRL1:
> -        return s->vcore[reg];
> +        return s->vcore[addr - MENELAUS_VCORE_CTRL1];

Suggest to count up instead of down:

       case MENELAUS_VCORE_CTRL1:
  +    case MENELAUS_VCORE_CTRL2:
  +    case MENELAUS_VCORE_CTRL3:
  +    case MENELAUS_VCORE_CTRL4:
  +    case MENELAUS_VCORE_CTRL5:
  -        return s->vcore[reg];
  +        return s->vcore[addr - MENELAUS_VCORE_CTRL1];

[...]


