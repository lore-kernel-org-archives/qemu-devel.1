Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3AC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5732051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUn8+UbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5732051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDbur-0001uj-RN
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbi2-00057z-ED
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbi1-0007ku-FY
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:26:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDbi1-0007dQ-5N
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:26:13 -0400
Received: by mail-pf1-x444.google.com with SMTP id c19so8799233pfo.13
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BPXxlsx2oxjN6vI36Z7TUkNqqhIU7cHyE5E356BkboQ=;
 b=IUn8+UbDawao/8BwfBR5TnRC04DUXych+gjD7va9MjsQq0SSpqRDxv1QSfoMUfFeGn
 qgmsujEpGyyIJd5TPwA57/yb+4GBtYeaGhAO99SRNFq0/GHfr4g1RSF65M9Uvaf+bi3b
 gQ20oxQsxlN1AoXuyoN8tFFRNb8hqniKmBa1ZMuvQow4oYHetSHYw0aZ2zuUGbf+B1fA
 z9sx7MUposB41/MdlDsXbKGRRSFk4HIu7p6PyON7ifFtGjk3EJGL0U077bKTjTaL/eHi
 rF2V3qp+fi5PpUlyvtsMY0DMEzurcI8yPGtYiP7JMU8UwVy6ShRNQUTsjAjyiPW6hn2u
 Y2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BPXxlsx2oxjN6vI36Z7TUkNqqhIU7cHyE5E356BkboQ=;
 b=f9wwaa8T7543Q6TA0quN3k/8rQ/8LCiTlwEN6lCColmPBJO1mOd+wPOg/9+s21CRxa
 vuISFTTgHuvIvD4mFGfQN5kJFSsqTAB2TU7LBf+mSk0V11W2Uvz1RmZfw+va6hrnm613
 fl2QXNlqBt1acf2FiKo4EzFK64ylJ8xQJjF2ggQjl3w05juAfB/FRrmmasu08EKMjRb/
 4w5GZNJ89MhAgZkGscVVw+nVDBlA62MBHoZleRjrnyDCKzruHMnhir/rUrsOvrsIJuZJ
 RNlAnQWarsOjj38JxK46TBDmgrMm+Dy1i4X0iZF1g5mFSPF/iHEMG7KIwqeKRBY9Hy+B
 CKuQ==
X-Gm-Message-State: ANhLgQ3a+/u3dKJmUw/iuSmDhvfAfdYzwH3KQqNWLIRXN7bzmiM3Duy8
 NvQNrocsVlYtw953rcig02cAlg==
X-Google-Smtp-Source: ADFU+vsCkpelvsl5Wu0M3uPOw0cXgVMdr3Vy01X6jscPnmMcdaqZVlTzz7TRRZ1xW+MqBb99bYpSyg==
X-Received: by 2002:a63:1245:: with SMTP id 5mr23679300pgs.55.1584311172357;
 Sun, 15 Mar 2020 15:26:12 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 15sm58770700pfp.125.2020.03.15.15.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:26:11 -0700 (PDT)
Subject: Re: [PATCH 4/9] hw/core/qdev-properties: Export enum-related functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8e9a1d89-7a7b-0a11-0e4c-1c9aab6c093a@linaro.org>
Date: Sun, 15 Mar 2020 15:26:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313184607.11792-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:46 AM, Philippe Mathieu-Daudé wrote:
> We are going to split this file and reuse these static functions.
> Add the local "qdev-prop-internal.h" header declaring them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/core/qdev-prop-internal.h | 19 ++++++++++++
>  hw/core/qdev-properties.c    | 58 +++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 28 deletions(-)
>  create mode 100644 hw/core/qdev-prop-internal.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

