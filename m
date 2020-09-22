Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED3BC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16BA21941
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16BA21941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKbam-0001Mr-Rn
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@cn.fujitsu.com>)
 id 1kKba0-0000qW-Ev
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:15:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63859
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lizhijian@cn.fujitsu.com>) id 1kKbZy-0007i5-KV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:15:08 -0400
X-IronPort-AV: E=Sophos;i="5.77,289,1596470400"; d="scan'208";a="99494283"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 22 Sep 2020 14:14:57 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
 by cn.fujitsu.com (Postfix) with ESMTP id 0454548990E9;
 Tue, 22 Sep 2020 14:14:57 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 22 Sep 2020 14:14:55 +0800
Subject: Re: [PATCH 1/4] net/colo-compare.c: Fix compare_timeout format issue
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20200918092203.20384-1-chen.zhang@intel.com>
 <20200918092203.20384-2-chen.zhang@intel.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <a266a2c5-dce4-329e-6613-fc2ddeba1335@cn.fujitsu.com>
Date: Tue, 22 Sep 2020 14:14:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918092203.20384-2-chen.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 0454548990E9.ACBFC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Received-SPF: none client-ip=183.91.158.132;
 envelope-from=lizhijian@cn.fujitsu.com; helo=heian.cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:14:59
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/18/20 5:22 PM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> This parameter need compare with the return of qemu_clock_get_ms(),
> it is uinit64_t. So we need fix this issue here.
>
> Reported-by: Derek Su <dereksu@qnap.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>

> ---
>   net/colo-compare.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 3a45d64175..7cba573dae 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -120,7 +120,7 @@ struct CompareState {
>       SendCo out_sendco;
>       SendCo notify_sendco;
>       bool vnet_hdr;
> -    uint32_t compare_timeout;
> +    uint64_t compare_timeout;
>       uint32_t expired_scan_cycle;
>   
>       /*
> @@ -1081,9 +1081,9 @@ static void compare_get_timeout(Object *obj, Visitor *v,
>                                   Error **errp)
>   {
>       CompareState *s = COLO_COMPARE(obj);
> -    uint32_t value = s->compare_timeout;
> +    uint64_t value = s->compare_timeout;
>   
> -    visit_type_uint32(v, name, &value, errp);
> +    visit_type_uint64(v, name, &value, errp);
>   }
>   
>   static void compare_set_timeout(Object *obj, Visitor *v,
> @@ -1146,9 +1146,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
>                                  Error **errp)
>   {
>       Error *local_err = NULL;
> -    uint32_t value;
> +    uint64_t value;
>   
> -    visit_type_uint32(v, name, &value, &local_err);
> +    visit_type_uint64(v, name, &value, &local_err);
>       if (local_err) {
>           goto out;
>       }
> @@ -1396,7 +1396,7 @@ static void colo_compare_init(Object *obj)
>       object_property_add_str(obj, "notify_dev",
>                               compare_get_notify_dev, compare_set_notify_dev);
>   
> -    object_property_add(obj, "compare_timeout", "uint32",
> +    object_property_add(obj, "compare_timeout", "uint64",
>                           compare_get_timeout,
>                           compare_set_timeout, NULL, NULL);
>   




