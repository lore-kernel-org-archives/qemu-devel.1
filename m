Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10503C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEB920787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqV0WB+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEB920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabxP-0003pj-VQ
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabwB-0002Nd-BU
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:19:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabwA-00010a-EE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589793592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZ6+mVL/n/8Gz9SckLvTC6fPATZRuj9QWoQ5aId9N3c=;
 b=JqV0WB+qyj0AxZGBuK9YbX1iHZFV72Fe8u3jIKnHetdfzAomhy1vCvvGC2l0vaX44MYqrb
 wkY8f4+S+UnkaHP6+4XC+dsJB8AhI0JH4B5BUXGF8ywfIguuh63urickK6rjhV2dlo7Drl
 sCywMIL0j4aC8sxiMod5Tbd9FY2e3Qk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-smhXdW51MfiFhH2P7uqnQw-1; Mon, 18 May 2020 05:19:51 -0400
X-MC-Unique: smhXdW51MfiFhH2P7uqnQw-1
Received: by mail-wm1-f69.google.com with SMTP id f9so2007942wml.9
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GZ6+mVL/n/8Gz9SckLvTC6fPATZRuj9QWoQ5aId9N3c=;
 b=bI5dG8E0ORXlF3nmAhEnPKKDxKo+QuYqeySzbs5np/1lPgLvO8+4OIgnc+KDisyC8c
 S8csUlNR3UOeoklyTf0KggmcIX+7zaXrlM0sw1LdmYWVso3ZJBfsXYsJZB5Ou8RTo4fr
 fwhk6puFTDEbihHeW5TRgEdtFGKBWHHwjexpGl0e1eKczrurFyKbNWbrHSaLJ9lHC1xF
 S15XFIWmilG0p0hNi/w4XyN0Vqc7cxAf6NDF5RU40MAKc876RkCk9s2gAqY0kzHv07Mq
 b4oLtoxZjx3c4U0XUzBOu0Ah0jT7OhyBb0cJ501PnpZjPbbAuj2VfsrFbi6YL3HoD1iD
 S69g==
X-Gm-Message-State: AOAM5339yZT1WSmv/VwDVv9YfgQ06bgPn+N8zI2bpHYlMuAKdizR1Qtr
 GItn7JDo1wf2y+k8yXi/sOFYBl/IoWNB27RHtUrDmEJxE2kw6+zeWX7GX5aG12rktxoWcXGI+uq
 TjUh0w3geG8a3AFc=
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr18559614wrt.411.1589793590118; 
 Mon, 18 May 2020 02:19:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+mkIBUvk/G3Z0NV99b/NIYef/oBrhe5PLL/MbJrS10BtUZkEr44YkicKaRSIuy4PJ9BTtzg==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr18559595wrt.411.1589793589928; 
 Mon, 18 May 2020 02:19:49 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id l12sm17072298wrh.20.2020.05.18.02.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 02:19:49 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] virtio-balloon: unref the iothread when unrealizing
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-4-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f6b1036-db76-c753-36e5-b3a471f4412d@redhat.com>
Date: Mon, 18 May 2020 11:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518083704.52646-4-david@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Wei Wang <wei.w.wang@intel.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:37 AM, David Hildenbrand wrote:
> We took a reference when realizing, so let's drop that reference when
> unrealizing.
> 
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/virtio-balloon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4fcf2d777..3f8fc50be0 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
>   
>       if (s->free_page_bh) {
>           qemu_bh_delete(s->free_page_bh);
> +        object_unref(OBJECT(s->iothread));
>           virtio_balloon_free_page_stop(s);
>           precopy_remove_notifier(&s->free_page_report_notify);
>       }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


