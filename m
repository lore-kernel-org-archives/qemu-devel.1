Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A566C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FA720815
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uotHlmcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FA720815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEyN0-00069P-RU
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 12:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1iEyL6-0005OD-AK
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1iEyL5-0002YA-Fb
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:15:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>)
 id 1iEyL3-0002XI-Gy; Mon, 30 Sep 2019 12:15:53 -0400
Received: by mail-pf1-x443.google.com with SMTP id h195so5888000pfe.5;
 Mon, 30 Sep 2019 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hrsxb9shmqjuLgoyRHrpfj1dyfrKbam6K5QABnrnzaM=;
 b=uotHlmcJ0et/mZ7C4no8ocTyFbHnw4zXYt1PatnNAWBPgecyUUyqBN0lDQQgpaQGIu
 Gd9GzaB74WQQkTVqLtJvJEKaCeur7ETHqTuIFmZPlL5sYxfu7jLChwyPX8BsorHLCtMm
 l4IUl/Lwmiy0krkbf3lbKWO9UWOzHB36Jpizon9pyG5Yy8JvUXjdAg7KdEj6WauOwWMi
 Xpb3kWX5c+SmMdpjussNDrZUFtt7gn2oQkUrvHwxrPidRgkgbHsD/Z2p+/XLZgS4WNe4
 Ty0HdNuLm1///oP2QgpNuWun4/cewpbui30VzZa41dYTSpJmQUUDLYAH9RsEn3x0ymMy
 05hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Hrsxb9shmqjuLgoyRHrpfj1dyfrKbam6K5QABnrnzaM=;
 b=Ua0ktE/O+/4zqKvoMu9oBpLwwAkyrftx1EQmkybz1A889BEOExTbl3t7vt7KgX26pi
 WYI7NBR8F0IB24oy6zwP6nzZVtXt8o3nFA/9Hz7DA+8MCcWTB6n/JynkiTiMb9r1p/Xb
 hgRkHn1qw3n/pzTzN71gUcup3NSabQtsDSIajeFkZ1WLdFZybiIYjMUCGKBww6nRk1xg
 LPR8Ox8ZHkJKsEuptsr9N1yVCtoFZ2lZXox3W//+3rNPpHNEo37eWjXTo+D/8WhKMqdk
 VxVpWVl44ZrUP/RQd95alEkwyFcVUtBINomy4erTH41iIRzZXOsyOCJMGsSUR2X7GWRV
 eq8A==
X-Gm-Message-State: APjAAAWmTfqI7ogOQzI85HlmNchzWQ76zfZ0tpZr7wkCNEvQQipTmiim
 2kEO3SU6EIFzhnNFa76hNPQ+X3tK
X-Google-Smtp-Source: APXvYqwk/X+J/CiVn8AGIqJYDNGI+VFeeaIEEiKyGfreEn0xtLnTCicqYZ0qnJLrbTrjNCUVVHAXrQ==
X-Received: by 2002:a65:4002:: with SMTP id f2mr25321298pgp.447.1569860151857; 
 Mon, 30 Sep 2019 09:15:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.googlemail.com with ESMTPSA id s1sm12299201pjs.31.2019.09.30.09.15.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Sep 2019 09:15:50 -0700 (PDT)
Subject: Re: [PATCH v3 02/18] target/s390x: Add ilen to unwind data
To: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190926162615.31168-1-richard.henderson@linaro.org>
 <20190926162615.31168-3-richard.henderson@linaro.org>
 <4d1f9fbc-a6b3-cb7d-63a7-8d9568bc7406@redhat.com>
 <164856f8-fc7e-7a97-65b8-e1be2cf354be@linaro.org>
 <6557ae81-1e25-38bc-dff5-2d15b45284c5@redhat.com>
 <1ab7a5b3-40e8-c3ae-0877-07b8b50b90d1@twiddle.net>
 <db4233d2-607a-5d37-50a8-bda57234a6c7@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Message-ID: <98872765-9f61-abc6-863e-63e7c540d351@twiddle.net>
Date: Mon, 30 Sep 2019 09:15:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <db4233d2-607a-5d37-50a8-bda57234a6c7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/19 8:42 AM, David Hildenbrand wrote:
>> Of course, but it's no different with this case than any other.  If the
>> interrupt has already been handled, then we will simply restart the next TB as
>> per normal.
> Yeah, I was mostly concerned that "the next TB" will be "the next
> instruction" and not "the original instruction again".

Ah, well, that's easy.  The next TB will start from psw.addr, and when we
cpu_loop_exit_restore(), psw.addr will be set to the current instruction.

This is exactly the same as when we raise a PGM_ADDRESSING exception which
needs to be restarted after the kernel swaps in the page.


r~


