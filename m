Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7C2C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB46222B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POLsGz10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB46222B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVTa-0006Ec-VZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jxVSd-0005Kz-S9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:04:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jxVSb-0008Ho-58
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595250238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5ixh/D07TIzG7wEt0bGxXgw4SmlefyXkogjA+IL8OA=;
 b=POLsGz10yoVPSqmSiZS1zJFMrNUVagGfMqF41Bm8qUmy0ByAuMaBqZb7d7PDq+k8Ol8eIz
 vFq1JxRX7sWuGpZIE0dyGF/iAmZQUaUwTafttgXi04Fpws0VSiF9bUSPZyL6qi9sIPR6+N
 /6d68395OLmSSFDtbnhzrXDT9sbCA0c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-67fkGNftMMOt7S2pW2n1rw-1; Mon, 20 Jul 2020 09:03:50 -0400
X-MC-Unique: 67fkGNftMMOt7S2pW2n1rw-1
Received: by mail-qv1-f70.google.com with SMTP id e6so10113691qva.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 06:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z5ixh/D07TIzG7wEt0bGxXgw4SmlefyXkogjA+IL8OA=;
 b=lWHtQq8rmbsZeqoAMZM1ch0f4+DeyWohknFpEueaMoTxHRqguYwaW0/FKdVyf21XSQ
 v22FruE82jIC3DNWNNAc7t8X8H2l0QJ81qt/rpA1KZjBxZZsdiu1ADCCazuna/aON0pg
 ej7ConPCE3sm0AsCP5+4xIsEh1Vut6EBCBMC7Tww4F4+Yz1K5KLjn83Ds2Wjn+Zhf0jw
 mWU1mqRWuWg58y4tKMH1UFJqOSaUQF3coVbDjr3ocgG5GKJKObsTCxq64FTmwKY/0odU
 2Al9rLnes5e0bouG7ZWkHtRAHFBTnzcykDSbGM/kPbTQXINQWZ+e/XErQr5SDkHpVSFp
 1Wpg==
X-Gm-Message-State: AOAM532p2c7ta7HKNtAbZkV1TCiL4gVzfdWEoHQ1C8Z1efJOXpKmci0A
 qBGftRLbY3abfmKYHwvsrhntnAQd0i7GCQ9jq0ynrgyemKRAnRqp5S8xfWfXlPtr1sv78nATYGs
 DAuj0vyvm2M/R0Qo=
X-Received: by 2002:ac8:5181:: with SMTP id c1mr24223099qtn.173.1595250229588; 
 Mon, 20 Jul 2020 06:03:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTxAh4c4tOR9nUXbq1BtoBl19UaL/10CvtC8lUrgEzybAgZ/3eOowvugH6KIXgxglrnz1fQg==
X-Received: by 2002:ac8:5181:: with SMTP id c1mr24223065qtn.173.1595250229364; 
 Mon, 20 Jul 2020 06:03:49 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id f18sm20757035qtc.28.2020.07.20.06.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 06:03:48 -0700 (PDT)
Date: Mon, 20 Jul 2020 09:03:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200720130346.GM535743@xz-x1>
References: <20200708141657.GA199122@xz-x1>
 <14b1ca26-448d-0feb-7529-6546809aaa59@redhat.com>
 <20200709141037.GF199122@xz-x1>
 <fb2f8d35-3f04-55ac-e0c0-7eeedbaf2429@redhat.com>
 <20200710133005.GL199122@xz-x1>
 <05bb512c-ca0a-e80e-1eed-446e918ad729@redhat.com>
 <20200716010005.GA535743@xz-x1>
 <b0319440-6e53-f274-59ba-6dbc67de69be@redhat.com>
 <20200717141806.GE535743@xz-x1>
 <d772c597-e6a2-ab88-43c5-b35b77d6c84e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d772c597-e6a2-ab88-43c5-b35b77d6c84e@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 12:02:06PM +0800, Jason Wang wrote:
> Right, so there's no need to deal with unmap in vtd's replay implementation
> (as what generic one did).

We don't even for now; see vtd_page_walk_info.notify_unmap.  Thanks,

-- 
Peter Xu


