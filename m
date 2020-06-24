Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C111C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385EE207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWRYewZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385EE207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joCwT-00016g-GV
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 17:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joCvo-0008Uz-EZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:27:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joCvl-0003Zl-Qj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593034060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWFZtMVCUTOa6GiN/L00lB7unztQMzqXaFruU5h2OG0=;
 b=QWRYewZARjsnhG1125NaNAupu4yCHywgGEmLNoxhoI/7KuqazcWOIX2PTtyfRx4+uadEMu
 gisUOkCA1yI89Kp4YfN4S1gpV/dVX+t+xlEpEQ4rzWOptZbAOgM0D/TgZBzls2yp8dv2mW
 SinENnYJsCSCSnaFAGIoiHjHc6sSii4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-D9L7U6S_NpOfYcxhr8VFVg-1; Wed, 24 Jun 2020 17:27:38 -0400
X-MC-Unique: D9L7U6S_NpOfYcxhr8VFVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D2CF464;
 Wed, 24 Jun 2020 21:27:37 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFE44579A3;
 Wed, 24 Jun 2020 21:27:36 +0000 (UTC)
Subject: Re: [PATCH 36/46] qom: Put name parameter before value / visitor
 parameter
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-37-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c0d8ea3d-440a-4e4e-f77a-c31448aecb3b@redhat.com>
Date: Wed, 24 Jun 2020 16:27:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-37-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 11:43 AM, Markus Armbruster wrote:
> The object_property_set_FOO() setters take property name and value in
> an unusual order:
> 
>      void object_property_set_FOO(Object *obj, FOO_TYPE value,
>                                   const char *name, Error **errp)
> 
> Having to pass value before name feels grating.  Swap them.
> 
> Same for object_property_set(), object_property_get(), and
> object_property_parse().
> 
> Convert callers with this Coccinelle script:
> 
>      @@
>      identifier fun = {object_property_get, object_property_parse, object_property_set_str, object_property_set_link, object_property_set_bool, object_property_set_int, object_property_set_uint, object_property_set, object_property_set_qobject};
>      expression obj, v, name, errp;
>      @@
>      -    fun(obj, v, name, errp)
>      +    fun(obj, name, v, errp)
> 
> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
> message "no position information".  Convert that one manually.
> 
> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Convert manually.
> 
> Fails to convert hw/rx/rx-gdbsim.c, because Coccinelle gets confused
> by RXCPU being used both as typedef and function-like macro there.
> Convert manually.  Convert that one manually.  The other files using
> RXCPU that way don't need conversion.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>   136 files changed, 702 insertions(+), 729 deletions(-)

Big but mechanical.

Reviewed-by: Eric Blake <eblake@redhat.com>

This one might be a semantic conflict magnet with patches written in the 
meantime; I guess the trick is to check that 'git grep' finds as many 
calls to any of the functions listed as conversions.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


