Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD91C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E894F206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E894F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJeg-0008AT-Dw
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIJKL-000348-JM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIJKJ-0003Kr-Jv
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:16:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIJKJ-0003KQ-Ce
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:16:55 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4CAE95945B
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 21:16:54 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i10so1656412wrb.20
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 14:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wSuLv6GKvlpjZvs6trjTcT1wzyAD6I0yI9QYOc6LYts=;
 b=UPaOxRIapsWehtZxjzEH2oYU/KWNM9neJZXuB65sW/BFD/bENzkyHEAXxOzJdbHyRK
 U002hat5OvydIElqcQtXS488V36UcBO+MY5ZA89VMWrRBQbEo8qT7utmj+u43rWEQ4GW
 UtT5QbfJrGHHcQmWmiJnJMNpVK0C19CDmtDvAc6KdIyns2JW0mYUS/foiNUMNXfOButm
 6afH2jCMpNZtN6dKaAg4rO84Tvjs3zfhQhHYv4wlKlabUKBtLtTR9fMoAwAtHZzGO3Zq
 n/TtEBZHyPh6uEgwHoSaIdjcXXG7bl1uCBhm5NJsq+nhzw5ugieGDB8usCeRUpP5CSsN
 VtkQ==
X-Gm-Message-State: APjAAAU/zfjV4zUdArddTzhoJg1p4nIVQMF/5yhx1S3yI0BCcastFlcz
 5VdWy43/ebpgiA74TfOkGNdSUID5akzwXkr7WBkrAEel34jFck62wtwFPLgKqFSZiwqFQ0jcIDi
 4Iq0a/5xP/voJdow=
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr4443455wmj.154.1570655812885; 
 Wed, 09 Oct 2019 14:16:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/KzqtNoat+5xxDNXUF4leZmHYsUe+6wTNWtgMXMsMvLpVOZnxEoNsMXshwPzlO5ow057DjQ==
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr4443435wmj.154.1570655812620; 
 Wed, 09 Oct 2019 14:16:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1032:7ea1:7f8f:1e5?
 ([2001:b07:6468:f312:1032:7ea1:7f8f:1e5])
 by smtp.gmail.com with ESMTPSA id r2sm6498797wma.1.2019.10.09.14.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 14:16:52 -0700 (PDT)
Subject: Re: [PATCHv2 1/2] util/qemu-error: add guest name helper with -msg
 options
To: Mario Smarduch <msmarduch@digitalocean.com>, philmd@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com
References: <20191009164459.8209-1-msmarduch@digitalocean.com>
 <20191009164459.8209-2-msmarduch@digitalocean.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3f24a34d-de91-c996-ffd8-306d0e0ce6a0@redhat.com>
Date: Wed, 9 Oct 2019 23:16:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009164459.8209-2-msmarduch@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/19 18:44, Mario Smarduch wrote:
>  };
> @@ -1263,6 +1267,7 @@ static void realtime_init(void)
>  static void configure_msg(QemuOpts *opts)
>  {
>      enable_timestamp_msg = qemu_opt_get_bool(opts, "timestamp", true);
> +    enable_guestname_msg = qemu_opt_get_bool(opts, "name", false);
>  }

Before, the msg option certainly had a timestamp suboption, but this
might not be the case now.  So that "true" needs to become "false".
I'll fix it up when applying.

Paolo

