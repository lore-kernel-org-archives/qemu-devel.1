Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B286C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1472192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+68tYoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1472192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtWz-0004qt-UE
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVtW7-00040z-RK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVtW5-0004n2-Is
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603445864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qH8RqactvSPHpsjt6azvc1zBXlxbssPGIGkLQRwOYOI=;
 b=T+68tYoj5JwZDOw9EWanPxQ8lfdzuPvymLxaNRESm5SRlPK9NZd5jiEqgivvNFDtAzXe/m
 AZFvoLFyG1IXumFLVzp11M872aYMaMoL3BYXgMfQ882Gq7isKengmJHD/+s4EIXXZ0kQIo
 RYn6GxvMh+u0RyVcv2qoNDlIaMugt20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-mZuDSVGTNZWtj_AFr2eccA-1; Fri, 23 Oct 2020 05:37:42 -0400
X-MC-Unique: mZuDSVGTNZWtj_AFr2eccA-1
Received: by mail-wm1-f69.google.com with SMTP id v14so232518wmj.6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 02:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qH8RqactvSPHpsjt6azvc1zBXlxbssPGIGkLQRwOYOI=;
 b=gheFuxANO8mbQyUvl6Fb/fwcmjcKTAcbHgHmfnVK+XzVuep7WosHhC+Bv6hg6A8m/n
 wRNfTdwKUOzxaqOeovIc4rr5h6AvFRCdPXTC58UbeDyrdfiOJh+riKEhn/syy+uRuzU8
 sCGzJUY2JJFdfImzAPd1eNQykS+7Je2Wk463GDfvBa9oXL4f+lrid1+imjkIpUYrBb9R
 efwWIBl39O9ItX/fKLNoJhvo3ZN0aAMVGVUVONaXTExsbrEPzSs+OTHpo5SkR/Ji2kWh
 kMq+g2PBlC81BQo1U9e9Yga/WPlg+mC0qDwdTPXCrmr4xindn/o93FDgqjw9tc/++MmK
 nY3w==
X-Gm-Message-State: AOAM5320csehUALynHgTdXr082n5bNSkOVgVlsy3/M9fZbiqkdvwU+xW
 Ctzj3mmIlxaP6apwGghZ/qLvBIVAKrufp4lFetl/YG86MDC/9UwRqqNDY3yjcaXsxnadfvfE/mw
 I5O6Sq8IPKG1WJek=
X-Received: by 2002:a05:600c:2888:: with SMTP id
 g8mr1377950wmd.130.1603445861493; 
 Fri, 23 Oct 2020 02:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCJF8DDsQg1xFuDsdLgxyGRWeq4UOS8V8sOcieUnhM4WGutka0y7hmjmm7iqd/rgVMBgGaNw==
X-Received: by 2002:a05:600c:2888:: with SMTP id
 g8mr1377935wmd.130.1603445861270; 
 Fri, 23 Oct 2020 02:37:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id h206sm2141383wmf.47.2020.10.23.02.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 02:37:40 -0700 (PDT)
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <9f6c63c6-599b-ac15-42e2-b9c1991fc7ee@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8090f8a-1592-0959-7bd7-0c5b18a13f11@redhat.com>
Date: Fri, 23 Oct 2020 11:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9f6c63c6-599b-ac15-42e2-b9c1991fc7ee@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/20 19:24, Eric Blake wrote:
> Does this proposal mean that pull requests would have to switch to
> gitlab merge requests, or would there be a transition period where
> submaintainers still send pull requests via whichever means desired
> (mail or gitlab merge request), but the eventual committer repackages
> that as a gitlab merge request before it is upstream?

No, all it means is that Peter would have to do "git push gitlab"
instead of "git push origin" :) and likewise for qemu-web and openbios.

I'm open to switching (later) to merge requests for qemu-web, but that's
a different story.

Paolo


