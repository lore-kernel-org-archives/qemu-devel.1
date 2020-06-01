Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5BEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF82206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIKddao/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF82206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jffUU-0002LN-Fa
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 04:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jffTq-0001ow-69
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 04:07:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jffTo-0006Nt-Jc
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 04:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590998850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cqn/+oCqCDOsPXDEw+nqqcFn1owjVnj7bHKeyOuO38U=;
 b=IIKddao/Fg15HK+a7iLo5VRzlYgVuDg3KeXbvH6YJIF38UY8cjmYmejXE52VuwOKr/Cwtt
 dQBpTDvjJSfFVs1W/sAolFn3Wq4QZhAwRf65Lt9WIRqIcHPv9FEsla0oywthJHUy8R+0hz
 SjJUrhjuvCJXcAT7a8kh2uJwy6Wy/E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-THQpFcpbNg25J_-cSO8iZA-1; Mon, 01 Jun 2020 04:07:29 -0400
X-MC-Unique: THQpFcpbNg25J_-cSO8iZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F36D8108BD15;
 Mon,  1 Jun 2020 08:07:27 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF7E5C1BB;
 Mon,  1 Jun 2020 08:07:23 +0000 (UTC)
Date: Mon, 1 Jun 2020 10:07:18 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: About the kvm-no-adjvtime CPU property
Message-ID: <20200601080718.jul5r4qebpeieyfl@kamzik.brq.redhat.com>
References: <b4389848-10fd-a906-9901-d1d354ce4842@huawei.com>
MIME-Version: 1.0
In-Reply-To: <b4389848-10fd-a906-9901-d1d354ce4842@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:19:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wu.wubin@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 30, 2020 at 04:56:26PM +0800, Ying Fang wrote:
> About the kvm-no-adjvtime CPU property
> 
> Hi Andrew,
> To adjust virutal time, a new kvm cpu property kvm-no-adjvtime
> was introduced to 5.0 virt machine types. However the cpu
> property was enabled only for host-passthrough and max cpu model.
> As for other cpu model like cortex-a57, cortex-a53, cortex-a72,
> this kvm-adjvtime is not enabled by default, which means the
> virutal time can not be adjust for them.
> 
> Here, for example, if VM is configured with kvm enabled:
> 
>   <cpu mode='custom' match='exact' check='partial'>
>     <model fallback='allow'>cortex-a72</model>
>     <topology sockets='2' dies='1' cores='2' threads='1'/>
>     <numa>
>       <cell id='0' cpus='0-1' memory='16777216' unit='KiB'/>
>       <cell id='1' cpus='2-3' memory='16777216' unit='KiB'/>
>     </numa>
>   </cpu>
> 
> We cannot adjust virtual time even if 5.0 virt machine is used.
> So i'd like to add it to other cpu model, do you have any
> suggestions here ?
> 
>

Hi Fang,

The cpu feature only requires kvm.  If a cpu model may be used with kvm,
then the feature can be allowed to be used with the model.  What I find
interesting is that the cpu model is being used with kvm instead of 'host'
or 'max'.  Can you explain the reasons for that?  Currently, when using
kvm, the guest will always effectively get 'host' anyway, even when a
model is provided. Indeed, for a model to work, kvm requires it to exactly
match the host cpu and even then the ID registers are passed through from
the host CPU, not taken from QEMU's model.

Thanks,
drew


