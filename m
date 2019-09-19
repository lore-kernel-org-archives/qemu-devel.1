Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91110C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C9B2196E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C9B2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAua1-0007pI-TW
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAuY0-0005s6-I3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAuSc-0005jz-UJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAuSc-0005jh-PN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:18:54 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2B98C04AC69
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:18:53 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w8so910733wrm.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6t1EyRsJugVbFVs+NalSvbZU/PDV4M+CkZL9piu3b7c=;
 b=sijjyUuXnJC2HpvTfZDEQEeol8YOlNW7OK5F7oYjJoWS0KBrOjtZbzU/SDM6qV4RF4
 w4neTtqKXNnE+EStmRbPRjyfHc4KKA1qp3tLeTkoV1sdWq4QlBhyONlaQgy+CNrvXlBL
 vjXNwLyKOUhJPsWpKe0v8oqEr6aAxDs8IBqVUVwD/p14G3ac12aCJgmG6dpSBrL/eylY
 gQEIegGqpluRFMVpl1GHk47e7NTLJ6naP8pjqzZjEcyOu8ZZzvFPaRmhcwAyb42tTEk5
 uOo1bMCD/7xg3ME9qoAT0uCkVQfTWWPJLuCPWVswc8MuiH/W/ME52kFEIXR2mmxsW3cG
 lWWQ==
X-Gm-Message-State: APjAAAVOIp9W91HnqL58sAeF+UqqbFsi/Kmcc7XgeA61KdLtS5ufyes/
 ksswil39ua95m8ssS1AfiKDrDA3CgWJR3+TLAxi3YlzW+8m0x5fYDoBhbR7JMNvahDDbtYmUvyx
 hqNQufW97uBIJYHo=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr2452359wmk.49.1568891932490; 
 Thu, 19 Sep 2019 04:18:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyO5FIdiPn9Sc8nMEN2yQLT84K802Uo1nUYekcS4xFqDVtAHFgz/EGDKwwwu9Sboqcm4H9PBw==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr2452337wmk.49.1568891932244; 
 Thu, 19 Sep 2019 04:18:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id l13sm4343038wmj.25.2019.09.19.04.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:18:51 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-6-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a2ac1b44-8a93-8b81-c44d-133f7eefe944@redhat.com>
Date: Thu, 19 Sep 2019 13:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918231846.22538-6-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 05/22] libqtest: Add a layer of
 abstraciton to send/recv
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
Cc: Laurent Vivier <lvivier@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 01:19, Oleinik, Alexander wrote:
> +static GString *qtest_client_inproc_recv_line(void *);

This is not defined as of this patch, please move it to patch 14.

>  
> +    qtest_client_set_rx_handler(s, qtest_client_socket_recv_line, s);
> +    qtest_client_set_tx_handler(s, qtest_client_socket_send, &(s->fd));
> +

I think you can pass "s" to the tx handler as well, and remove the
send_opaque and recv_opaque fields?

Paolo

