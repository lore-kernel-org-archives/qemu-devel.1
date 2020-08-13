Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A517C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157B020781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7Qpq+yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157B020781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6FZZ-0002JU-7G
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 11:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6FYz-0001oY-O7
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:54:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6FYu-00058m-C5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597334078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdUKfmZ2GQ70m5l8BGKXO0x5GaiCskTJfVW4Ko54AOY=;
 b=A7Qpq+yNvbgLxGyOWkqipDxDV2vSofiWEdMCZvNy08M05TraI1O67MJIczRu6GHG0QMd5B
 Oa5TJJRIWKt4f2sn5NUEnFQOxyMNl/NgrBCFEappHnNpFHUFhmBB+1TuqVTOr8QhSXxCoL
 fchqvWGugZvtdf2NPjJ5J/wVG8LblK4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-JqqufRymO4OZ1Ag24rpa7g-1; Thu, 13 Aug 2020 11:54:36 -0400
X-MC-Unique: JqqufRymO4OZ1Ag24rpa7g-1
Received: by mail-wm1-f72.google.com with SMTP id c186so2117526wmd.9
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 08:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tdUKfmZ2GQ70m5l8BGKXO0x5GaiCskTJfVW4Ko54AOY=;
 b=Cp2YTUV8W3IRpIE5Kq4HXKuwXeG5g6pbx/CF7EwUTz3OpOOit7l4cAeyeoXpPDcjCv
 7C7ZwvkDdFLirbxyRJBOjciLw4LIBxR6+iVveUbXu/d/7w7XVvkavq6xI36ri4p5L7ah
 xqoNcUR0wf0A9fg4bwFV6CkVqEozSjy+JlfHh2oPfgmguDJHJJZ8bkeKppLi1AhkesqM
 BDjJGA5KnNzPl0h5VbqCMk6GgFYhWPn3CYAqk19UhG0Srch9peySyZ03x8sS16tKyrHO
 FZEetiFTcuVPxQtNrzez/C4eHXXPyHJGNgqShgouC+uAX9BbsfwMlFJRAelSiMA9ewaQ
 vYvQ==
X-Gm-Message-State: AOAM530Any10KEjrWJF6vhjdZR4ukaEAtkvfP2gz/81F/3b0AQOwyXJw
 AxIZL0z/vRBirYqs2JuKCsOdVcxldh8RBxUaFvE/Swa+EvFqSBGQgzaAPvfeu4yq44DdfInl1nb
 RmOjG9BDjntIZw4Q=
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr4563370wrp.355.1597334075409; 
 Thu, 13 Aug 2020 08:54:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0J1c0fOL1D3bn242Bdh0iF4548XaspXWpJeBNrEKhXWquKJtSfL4+YoLAsEGg7dnHugoMfA==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr4563341wrp.355.1597334075111; 
 Thu, 13 Aug 2020 08:54:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51ad:9349:1ff0:923e?
 ([2001:b07:6468:f312:51ad:9349:1ff0:923e])
 by smtp.gmail.com with ESMTPSA id h14sm9590112wml.30.2020.08.13.08.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 08:54:34 -0700 (PDT)
Subject: Re: What is bs->reqs_lock for?
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu block <qemu-block@nongnu.org>
References: <ebea1375-8bc0-2b0a-051f-28b2afa02a1c@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c237be3-7e28-f61a-d339-5765089fe65c@redhat.com>
Date: Thu, 13 Aug 2020 17:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ebea1375-8bc0-2b0a-051f-28b2afa02a1c@virtuozzo.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/20 16:57, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
> 
> Sorry my stupid question, but which kind of concurrent access
> bs->reqs_lock prevents?
> 
> In my understanding the whole logic of request tracking for the bs is
> going in the coroutine, so, we don't have parallel access anyway? How
> can parallel access to bs->tracked_requests happen?

Different iothreads can access the same BlockDriverState, and block/io.c
is not protected by the AioContext lock (in fact almost nothing, or
nothing, needs it in the I/O path).

Paolo


