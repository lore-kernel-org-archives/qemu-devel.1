Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDD8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EBC2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgCfZpfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EBC2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyepN-0003Ur-R0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyeog-0002v6-Bn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:15:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyeoc-0008QU-Qd
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595524530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Fpt/TbyJxV7qRUlIQu9EO7VuLBHeRHePoE5O5C/nQs=;
 b=cgCfZpfmsbSKNtE8uApxzPAAK2TrSLZK5AsIU1ow9wu1MUi457gUIw/lZXJlmZ9j8T9kEY
 Q25hbBzjqgHXmGMTJhwkceMo5jnvJKhH11+fbkeinPW9+A3T5FSXrNw1xui8+s08UDxwGr
 XzqwWSdV9FUjqenMmHFopQJ4GpYglCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-7GUBW3xMPTWkuAHRpAJr2w-1; Thu, 23 Jul 2020 13:15:27 -0400
X-MC-Unique: 7GUBW3xMPTWkuAHRpAJr2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7224800C64;
 Thu, 23 Jul 2020 17:15:25 +0000 (UTC)
Received: from gondolin (ovpn-112-228.ams2.redhat.com [10.36.112.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5185B5F7D8;
 Thu, 23 Jul 2020 17:15:21 +0000 (UTC)
Date: Thu, 23 Jul 2020 19:15:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] s390x/protvirt: allow to IPL secure execution
 guests with -no-reboot
Message-ID: <20200723191518.247063b9.cohuck@redhat.com>
In-Reply-To: <20200721103202.30610-1-borntraeger@de.ibm.com>
References: <20200721103202.30610-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 06:32:02 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Right now -no-reboot does prevent secure execution guests from running.
> This is right from an implementation aspect, as we have modeled the
> transition from non-secure to secure as a program directed IPL.
> From a user perspective, this is not the behavior of least surprise.
> 
> We should implement the IPL into secure mode similar to the functions
> that we use for kdump/kexec. In other words we do not stop here when
> -no-reboot is specified on the command line. Like function 0 or function
> 1 Function 10 is not a classic reboot. For example it can only be called
> once. To call it a 2nd time a real reboot/reset must happen in-between.
> So function code 10 is more or less a state transition reset, but not a
> "standard" reset or reboot.
> 
> Fixes: 4d226deafc44 ("s390x: protvirt: Support unpack facility")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/ipl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ce21494c08..e312a35133 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -633,7 +633,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>          }
>      }
>      if (reset_type == S390_RESET_MODIFIED_CLEAR ||
> -        reset_type == S390_RESET_LOAD_NORMAL) {
> +        reset_type == S390_RESET_LOAD_NORMAL ||
> +        reset_type == S390_RESET_PV) {
>          /* ignore -no-reboot, send no event  */
>          qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
>      } else {

Thanks, queued to s390-fixes.


