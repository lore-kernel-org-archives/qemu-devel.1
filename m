Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A36C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF542051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBLYYG3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF542051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmhv-0005q0-TQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDlNp-0001rI-69
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDlNl-0003XM-Ly
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:46:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31833
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDlNl-0003UA-Bi
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584348356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBsw5Iijsprd4KpGuzrwbLsk4kGeiF/wJmWbgU3tRYs=;
 b=PBLYYG3wUQF1nh0fpAfzX7mZBJk5l4Y0fLVGbDC95ptPtbPjhdimDBpGknHhxioenAgDyM
 5wwF25MuGNZaQpk1uTwkJt5xsI2TGqCSrFxyoWsctvFvYLkFd/nRiosrIcHyMJr2IYMmf0
 Jhu0Tr2a16w9jTDXDtu5h1pgQGEV0HU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-eeNVMUxLM2WGMMsYspaSag-1; Mon, 16 Mar 2020 04:45:52 -0400
X-MC-Unique: eeNVMUxLM2WGMMsYspaSag-1
Received: by mail-wm1-f72.google.com with SMTP id a13so5510053wme.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UBsw5Iijsprd4KpGuzrwbLsk4kGeiF/wJmWbgU3tRYs=;
 b=U1920gu1tlA4I9iNQdI83UhcQWVz/FYOhbwTQ78EFndUVGh2vvjwrSJhoAMkNRpQ57
 73qWsz6W09c8Nlm0PHOxtGpFVYceNi8ieshnQYiOl3Hq79bQR75lSNPJ9FrT6YqwOvZ/
 lzZ+GMYjaZRCxW4BUXVb3hfLLtNiETE48TvigFD2SJbPyp7Njca5JyVZVc+0w9kfWEaL
 tvZpcLHFehY94S3M8kkuGirz/zhWInSB3tP1zLNYlNOA57yiuXjEJaO0p0ClLIsFyaSr
 Ujit49J6SAMFQGaE1tkPuDlTxqJvUXN2wPgIlwxsoeIPo1wjfycRY5eUnnWS9Io/Fyki
 T7MQ==
X-Gm-Message-State: ANhLgQ0Gi/B7oEl8xEG1p8jM0rHM48iJgqQM/MZcICwWMipK2Bom326t
 qvqaErLcZJ8sWKzpHQ7PRqitlDae4BxOS6n8K/rsaJ68qmppdxf1GFLTaDzdCuvz7xX4Tag2VMq
 +erqwcqrlNq3npso=
X-Received: by 2002:a1c:6385:: with SMTP id
 x127mr26264312wmb.141.1584348351315; 
 Mon, 16 Mar 2020 01:45:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupwyxa6fHWL0AAs226seV5xMuG7MHX6M9RYL9hbe/saoI1rj8Dh/QgAq7iJ3wQ7G0xiH0iOQ==
X-Received: by 2002:a1c:6385:: with SMTP id
 x127mr26264249wmb.141.1584348350545; 
 Mon, 16 Mar 2020 01:45:50 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.82.39])
 by smtp.gmail.com with ESMTPSA id g7sm93547836wrq.21.2020.03.16.01.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:45:50 -0700 (PDT)
Subject: Re: [PULL 132/136] mem-prealloc: optimize large guest startup
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
 <1582632454-16491-30-git-send-email-pbonzini@redhat.com>
 <7dc67896-eb79-c25c-6be6-a6b7012c9649@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e16b543-b939-e962-4d15-5ad094dcdd6e@redhat.com>
Date: Mon, 16 Mar 2020 09:45:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7dc67896-eb79-c25c-6be6-a6b7012c9649@vivier.eu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 09:42, Laurent Vivier wrote:
> Hi,
> 
> a bug has been reported in launchpad for this patch:
> 
> [Regression]Powerpc kvm guest unable to start with hugepage backed
>             memory
> https://bugs.launchpad.net/qemu/+bug/1866962

Indeed, I'm sending the pull request with the fix today.  Sorry for the
breakage.

Paolo


