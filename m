Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F97DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F5C20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F5C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8HK-0003gl-PF
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kL8Dj-00011Y-UF; Wed, 23 Sep 2020 13:06:19 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kL8Dh-000796-U1; Wed, 23 Sep 2020 13:06:19 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHoZM-1kHL8u24DG-00Evlb; Wed, 23 Sep 2020 19:06:10 +0200
Subject: Re: [PATCH] vhost-vdpa: fix indentation in vdpa_ops
From: Laurent Vivier <laurent@vivier.eu>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20200916152634.56917-1-sgarzare@redhat.com>
 <ffd81fe2-ad85-61c1-ed68-0b04385da42e@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dcfa4aec-23cb-5039-2006-fd89c5e5ef00@vivier.eu>
Date: Wed, 23 Sep 2020 19:06:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ffd81fe2-ad85-61c1-ed68-0b04385da42e@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PFhZlSzQN7/ZsU920esJrQEC8ekelXn6LMj1O67bhSTDBPwu/U0
 qcfiu73Ynq0ROHWjwFRDASkeS1rF640vOPgHbexmYSs+vCBsd3vvKTAAMLqCC1CnyVtT0wM
 usZX9FDzuRSQwrLCQb2xz7er+JTQt+S5oBPOCC57miZXawkE1UyPVVeAmjy1AcwgT2Qj/C9
 YadzSxLHLlF2PLkOgNFZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vTb50qBndng=:SXfWDdEzUcknSWHI0fU0UA
 p7zQh4Vwe69pvDmTowgYQlxMK/KDfKgnb4Ly/+6lJgHbn1bLEIZWe1bZr9UB7L1fMZr1yT1eR
 MNNIJNd0Kli/sO9VwjOMTyyxdYzMqLMrIl4MAeOjRgymZ4Rcs8rDoRg9L1H1jnt3mKkEPfS4o
 yjbWYTS1tfWItNDidtg0D6wsJa5/sm0rw9R0ONW5WZU+doyH3/2e2KHwKC2PPtlSlaq80Zrym
 A9tv/KjVydDblQ7DbAQJIzbj9u7GbtethI52s2ufVJrC8EA5MDhvz4Twif23+SyHwmwmABphg
 EIvQ0i4r5qsvUqGL0kMZ1RNLvZHZ1wA1YD4fjcxhzCI+M9LGnOUvGZcgnwo/QdmXQu4vW2lL0
 SPSV7+GNaiZyJ9A1KYmmI0i0DWxvmCW6A1yzOFTYQtGsGbQHvsEOhoopvXka0lZBnVKuAUCuY
 f+VT8Nf8p+2lR6QLPOPsyVPcCGfQs5P29PlGxRAnUnc8+JK8D1mbMfCgtv7+jUslnJ51DsNzD
 g3TwcS3bnKmMKqid/g/AfN2PvPGfmBHsQZFkTZDGRL9vgcr5j61dUbqq7Gz3u7TomwZEyyrB8
 iGdP1dq91DxylzovaIADp7zoggbAGndL8Bb+BCaQmUQa7wWhu347ExH96B5e+EM3rT/PX+8p+
 lj8RGDutKxN0ynwZZjN+P5znuUGOYptsxuPPmKk9JXHq2waWgBWif6jm0UmuZkIEy1+RrR54O
 fJXzbi45FtfAbYXDKBXYtbfI+DGcVVZUen51Qltt7suXbSFOjFIUbVPsK80xZh/Q4apbJG+sf
 AvLEyvqpw/SZPnNhnz2az8paRdCLcvyLrLe5Vhr+iEJx6M8aSJq92WHqiG40TpXUexOLjM+
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 13:06:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>, lulu@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/09/2020 à 17:48, Laurent Vivier a écrit :
> Le 16/09/2020 à 17:26, Stefano Garzarella a écrit :
>> This patch fixes wrong indentation of some vdpa_ops fields introduced
>> with the initial commit 108a64818e ("vhost-vdpa: introduce vhost-vdpa
>> backend")
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  hw/virtio/vhost-vdpa.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 4580f3efd8..e123837a55 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -469,6 +469,6 @@ const VhostOps vdpa_ops = {
>>          .vhost_send_device_iotlb_msg = NULL,
>>          .vhost_dev_start = vhost_vdpa_dev_start,
>>          .vhost_get_device_id = vhost_vdpa_get_device_id,
>> -         .vhost_vq_get_addr = vhost_vdpa_vq_get_addr,
>> -         .vhost_force_iommu = vhost_vdpa_force_iommu,
>> +        .vhost_vq_get_addr = vhost_vdpa_vq_get_addr,
>> +        .vhost_force_iommu = vhost_vdpa_force_iommu,
>>  };
>>
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> CC: Jason (he already has a cleanup series for vDPA)
> 


Applied to my trivial-patches branch.

Thanks,
Laurent

