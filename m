Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1F9C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203E92084D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203E92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqgj-0000QF-VX
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hxqfz-0008QJ-Le
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxqfy-0006Eb-Dp
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:38:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxqfy-0006EI-7Z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:38:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so8342039wrr.8
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 03:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vkh/GOtoSE3Dqi6lQTuIlQIa2cLxX4RjFq2T+SQ+Amc=;
 b=KE0eEcRSSHiWokioOO1d6kfPD1BUHJUcjJ1aRuVqNW1LGYopOShZIxB06zdINtkS8G
 ntpOFB9PlJKt6azE76FwdujhP3CX5EcsYYNq8sFVgLNS1Kx5t7s1XQu3NCab5DuR8GXY
 ltvl5hwEMeK98HE7NowOkaaDn9YNw6Fh4KRxngpf8V3pNyUGwcPCd6F5DkKYUF6xPL+o
 FUu8xGuU4EcQe8EuGDg2zzpqC4x1W76sjXqlPVpsWMs0vWpil3MdkJVmvcCBf6m1zHQp
 gcll7zWWw4d3zKaflpz+z9DaU+6zyGAnw2ropLqle+ZY9cUSImwXRcpp/7Z5ivYSp5p+
 okow==
X-Gm-Message-State: APjAAAWfLL8TND11yhtyCdPRSTLdFbqEXB5f3M0FIxlWn9d/3ppl6UlM
 dj41VQjIaFyGdaqsUqxMwFY5Xw==
X-Google-Smtp-Source: APXvYqxjHeFlQRUM7azVHxODCgDf3IJzPnolv6QRkmMnPK5yndnOVKJjhZJEwHlN1hroU3jYjrlPmA==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr50317690wro.337.1565779120907; 
 Wed, 14 Aug 2019 03:38:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cae:66cd:dd43:92d9?
 ([2001:b07:6468:f312:2cae:66cd:dd43:92d9])
 by smtp.gmail.com with ESMTPSA id t63sm5246626wmt.6.2019.08.14.03.38.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 03:38:40 -0700 (PDT)
To: P J P <ppandit@redhat.com>
References: <20190809063835.6717-1-ppandit@redhat.com>
 <20190809063835.6717-2-ppandit@redhat.com>
 <nycvar.YSQ.7.76.1908131534020.10397@xnncv>
 <b2944559-264e-cb48-8a04-4f238197f835@redhat.com>
 <3a48e557-985d-7274-81d9-fe963f74e59a@redhat.com>
 <nycvar.YSQ.7.76.1908141450520.30613@xnncv>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d55edea0-46ed-6cfc-7700-20a32b269428@redhat.com>
Date: Wed, 14 Aug 2019 12:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1908141450520.30613@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 1/2] scsi: lsi: exit infinite loop while
 executing script (CVE-2019-12068)
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
Cc: Fam Zheng <fam@euphon.net>, Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Bugs SysSec <bugs-syssec@rub.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/08/19 12:25, P J P wrote:
> +-- On Tue, 13 Aug 2019, Paolo Bonzini wrote --+
> | After the first instruction is processed, "again" is only reached if 
> | s->waiting == LSI_NOWAIT.  Therefore, we could move the Windows hack to the 
> | beginning and remove the s->waiting condition.  The only change would be 
> | that it would also be triggered by all zero instructions, like this:
> | 
> | diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> | index 10468c1..9d714af 100644
> | --- a/hw/scsi/lsi53c895a.c
> | +++ b/hw/scsi/lsi53c895a.c
> | @@ -185,6 +185,9 @@ static const char *names[] = {
> |  /* Flag set if this is a tagged command.  */
> |  #define LSI_TAG_VALID     (1 << 16)
> |  
> | +/* Maximum instructions to process. */
> | +#define LSI_MAX_INSN    10000
> | +
> |  typedef struct lsi_request {
> |      SCSIRequest *req;
> |      uint32_t tag;
> | @@ -1132,7 +1135,19 @@ static void lsi_execute_script(LSIState *s)
> |  
> |      s->istat1 |= LSI_ISTAT1_SRUN;
> |  again:
> | -    insn_processed++;
> | +    if (++insn_processed > LSI_MAX_INSN) {
> | +        /* Some windows drivers make the device spin waiting for a memory
> | +           location to change.  If we have been executed a lot of code then
> | +           assume this is the case and force an unexpected device disconnect.
> | +           This is apparently sufficient to beat the drivers into submission.
> | +         */
> | +        if (!(s->sien0 & LSI_SIST0_UDC)) {
> | +            qemu_log_mask(LOG_GUEST_ERROR,
> | +                          "lsi_scsi: inf. loop with UDC masked");
> | +        }
> | +        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
> | +        lsi_disconnect(s);
> ...
> |
> | Does it make sense? 
> 
> Yes, this'd also work, but need to return after lsi_disconnect(s), otherwise 
> loop would continue.
> 
> Should I send a revised patch? (with above change)

Yes, please.

Paolo

