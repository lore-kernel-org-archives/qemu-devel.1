Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D2DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E15206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiPKfUrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E15206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juux6-0000en-MX
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juuw8-0007kC-Bo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:39:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juuw6-0007zk-PX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594633186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=4czGxKsgynDTCYMFklLdXApZQ+orQG/rF8dXapck0Ew=;
 b=HiPKfUrTpKF/4wqyXB5P1OyXyGMmrUzAMt1MEiCCOkyWltJgydp5E12foyt/JQxHnfH+QI
 uLxgMjRhwh4B+Gq4JYfEkgjAvClvB5N7MT53DRA3ap5yZTgTFh6BztJYqENqRZNaDcK2gE
 YQMFIrzb6V89L2aXZk46nAsrqH7m/+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-79XbQlN-O6ikiAcC1XcFvw-1; Mon, 13 Jul 2020 05:39:42 -0400
X-MC-Unique: 79XbQlN-O6ikiAcC1XcFvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B4438015CB;
 Mon, 13 Jul 2020 09:39:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E48527DE7C;
 Mon, 13 Jul 2020 09:39:39 +0000 (UTC)
Subject: Re: [PATCH 12/12] target/cris: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594631150-36801-1-git-send-email-wang.yi59@zte.com.cn>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <454721ce-1508-dcc0-bf08-2c27fd37854f@redhat.com>
Date: Mon, 13 Jul 2020 11:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1594631150-36801-1-git-send-email-wang.yi59@zte.com.cn>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xue.zhihong@zte.com.cn, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, wang.liang82@zte.com.cn,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/07/2020 11.05, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/cris/translate.c         | 7 +++----
>  target/cris/translate_v10.inc.c | 2 --
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index aaa46b5..64a478b 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -1178,12 +1178,11 @@ static inline void t_gen_zext(TCGv d, TCGv s, int size)
>  static char memsize_char(int size)
>  {
>      switch (size) {
> -    case 1: return 'b';  break;
> -    case 2: return 'w';  break;
> -    case 4: return 'd';  break;
> +    case 1: return 'b';
> +    case 2: return 'w';
> +    case 4: return 'd';
>      default:
>          return 'x';
> -        break;
>      }
>  }
>  #endif
> diff --git a/target/cris/translate_v10.inc.c b/target/cris/translate_v10.inc.c
> index ae34a0d..7f38fd2 100644
> --- a/target/cris/translate_v10.inc.c
> +++ b/target/cris/translate_v10.inc.c
> @@ -1026,10 +1026,8 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
>          switch (dc->opcode) {
>              case CRISV10_IND_MOVE_M_R:
>                  return dec10_ind_move_m_r(env, dc, size);
> -                break;
>              case CRISV10_IND_MOVE_R_M:
>                  return dec10_ind_move_r_m(dc, size);
> -                break;
>              case CRISV10_IND_CMP:
>                  LOG_DIS("cmp size=%d op=%d %d\n",  size, dc->src, dc->dst);
>                  cris_cc_mask(dc, CC_MASK_NZVC);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


