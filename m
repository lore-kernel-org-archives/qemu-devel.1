Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05454C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D82B22242
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRB2QvUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D82B22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWbR-0008R0-4O
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYWZ9-00066I-3i
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYWZ6-0002Ub-UO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604072622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWT52VDkYRyUP9Cm9Pr1EYZaBC+r4AWVMx0HTwT6GFk=;
 b=CRB2QvUh8pIW5mJd8WFAQxFNHw2Q4eUuV4S237AJPfk7KGw2Q/S6R/eb3ic/6I49qRSlEi
 hHPHjIdZDFuhJQrH+GrUJ+o1UeEybJcn0Tj7Zy1kTvCpNrPQyTeLm+52QZF3vlgeMAuCYZ
 px/yqpdCpsFsIqJmfiBE+KjMd2tezMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-60KQrv1hOTSMZ67uxgELtA-1; Fri, 30 Oct 2020 11:43:41 -0400
X-MC-Unique: 60KQrv1hOTSMZ67uxgELtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7702F1DDFE;
 Fri, 30 Oct 2020 15:43:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 873571A340;
 Fri, 30 Oct 2020 15:43:34 +0000 (UTC)
Subject: Re: [PATCH v2 8/8] target/ppc: replaced the TODO with LOG_UNIMP and
 add break for silence warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-9-kuhn.chenqun@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <784329cb-a46f-5b22-97a6-aab2568d8dd2@redhat.com>
Date: Fri, 30 Oct 2020 16:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201030004046.2191790-9-kuhn.chenqun@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/2020 01.40, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> target/ppc/mmu_helper.c: In function ‘dump_mmu’:
> target/ppc/mmu_helper.c:1351:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  1351 |         if (ppc64_v3_radix(env_archcpu(env))) {
>       |            ^
> target/ppc/mmu_helper.c:1358:5: note: here
>  1358 |     default:
>       |     ^~~~~~~
> 
> Use "qemu_log_mask(LOG_UNIMP**)" instead of the TODO comment.
> And add the break statement to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> v1->v2: replace the TODO by a LOG_UNIMP call and add break statement(Base on Philippe's comments)
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/ppc/mmu_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714775..12723362b7 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1349,11 +1349,12 @@ void dump_mmu(CPUPPCState *env)
>          break;
>      case POWERPC_MMU_3_00:
>          if (ppc64_v3_radix(env_archcpu(env))) {
> -            /* TODO - Unsupported */
> +            qemu_log_mask(LOG_UNIMP, "%s: the PPC64 MMU unsupported\n",

Maybe add a "is" between "MMU" and "unsupported"?

> +                          __func__);
>          } else {
>              dump_slb(env_archcpu(env));
> -            break;
>          }
> +        break;
>  #endif
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


