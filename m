Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF79C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B276020866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyKmry8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B276020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb4pO-0008JW-FL
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hb4lx-000794-Hp
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hb4lw-0001BR-Eh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:02:45 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hb4lt-000119-SS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:02:42 -0400
Received: by mail-ed1-x543.google.com with SMTP id k8so26204606edr.11
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BSqUW13TzS18UycPNQXb0PDK/GJ5gEboSwdu5NAd8wE=;
 b=PyKmry8yI1lASplKYZjCAPdQyth82Juz91Cng1GwPC5eKuLw3Qr1rqVovL9WapYdHk
 EqPxIa5nZ8lPzHY7VPWzvIhxM7m1OguCQQVeW/tmaJLFZV2A9/VIFcyYldQBEOnl32C5
 fhEsILQD+Kry4jbMGpaH43F3VTXSz+DX6yhLAVu/kaAagcKcxmUCank6jQfBXxj9PMVb
 HNgMyvB02LjUzseMRmJaAAWs4VWMTH0Cr6gIVwNw5zRMauqi4Imx45zaDe4d8ttzAFSs
 tZ386z/SFnYUIpb6D6BAJuN2DnIOAqu5gM2VD1q7nsGESdN/Z6oJb1dxRBDLCdiykcai
 a5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=BSqUW13TzS18UycPNQXb0PDK/GJ5gEboSwdu5NAd8wE=;
 b=QE/cCqxNuwRQbvqXrhQ4NgROEX0j60EKGhck/PMlwyMKIQrv+F+KnrSAMSO5DaH8xp
 PakysFcYmCCMKTlx0gIryUOZq+K+/TpZ9SAZGCksHFbfNiLpxH94XWLJ7SJh86rsJ/rT
 THOJascWVJ0xNe/uK5Zl+BPnYrBXr9cpHYqIwWhEsceK5x6IwkORBHzuE5ztAUU70cm4
 y8MgMmAL3d1vDKhludFa+Z2ONeO0WLb3otM7A1IMTzVpzP0qeTdeOfoQyyPTCsaAqP7q
 1OLIuruwOJJwKGjeSq40SdXbfhYhwdBqJoBWDx7Uh18l7YZDgup8m0AhfAEGUzgc4rF+
 oyBg==
X-Gm-Message-State: APjAAAWAv89hgv+UsU53LlIaE5CzdY6EYXhbuNQfucHeLSMYGivN3APO
 WcQ7PEpKY4clv5qQQw+Iuik=
X-Google-Smtp-Source: APXvYqxVeWbprtx1iov99OUbGvoKl6QG1HLCiUxheC1jv1w67L7nTIFHVC0WErWszv3H5NXVrj5DRg==
X-Received: by 2002:a17:906:4c93:: with SMTP id
 q19mr23704987eju.285.1560351755793; 
 Wed, 12 Jun 2019 08:02:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id h7sm39025edi.41.2019.06.12.08.02.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Jun 2019 08:02:28 -0700 (PDT)
Date: Wed, 12 Jun 2019 15:02:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190612150227.ycohdktaf4yconpl@master>
References: <20190610030852.16039-1-richardw.yang@linux.intel.com>
 <20190610030852.16039-3-richardw.yang@linux.intel.com>
 <20190611175926.GJ2777@work-vm> <87o933m708.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o933m708.fsf@trasno.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/xbzrle: make
 xbzrle_encode_buffer little easier to read
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 12:29:27PM +0200, Juan Quintela wrote:
>"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> * Wei Yang (richardw.yang@linux.intel.com) wrote:
>>> The encoding process could be described below:
>>> 
>>>     for [content]
>>>         get length of a run
>>>         encode this run
>>> 
>>> By refactoring the code with this logic, it maybe a little easier to
>>> understand.
>>> 
>>
>> Are lines like this really making it easier to read?
>>
>> Juan: Opinion?
>
>Code is easier to understand .....
>
>For values that I understand the code.  I need to take a big breath and
>will take a deep look at it and see if it really does the same.
>

Haha, thanks for your feedback.

>Later, Juan.

-- 
Wei Yang
Help you, Help me

