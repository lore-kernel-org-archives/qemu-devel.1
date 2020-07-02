Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28295C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC03D20760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHtVbkNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC03D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr34t-0005xB-Od
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr33e-0004LG-V1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:31:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr33S-000508-1j
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593711081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYMrZeBox+8jsIjMFmt5UxNmNQxITXCQHcboOcbDNiE=;
 b=iHtVbkNpFOP6fPMhUjzv+P6WPHDKD2wU2uQyh5RXqDrJwiqKj//jFW1XjvaqojEMngZoi0
 40aFDhkScB7iNIRWfE37hbHpsqNBWtcnyOo9U1un1rBu9NNmgTJrANXcC8y3EmhDLrivEE
 I/cPdUt7BDqbPl1Ys6NsO98Ev/HSf7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-sAXJvyXNNiOVJ1uaR-C-lQ-1; Thu, 02 Jul 2020 13:31:19 -0400
X-MC-Unique: sAXJvyXNNiOVJ1uaR-C-lQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB50107ACCD;
 Thu,  2 Jul 2020 17:31:17 +0000 (UTC)
Received: from [10.3.112.202] (ovpn-112-202.phx2.redhat.com [10.3.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 953D55C1C5;
 Thu,  2 Jul 2020 17:31:16 +0000 (UTC)
Subject: Re: [PATCH v2 28/44] qom: Use returned bool to check for failure,
 Coccinelle part
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-29-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bb85eae8-04da-5872-d696-a3e86af6566f@redhat.com>
Date: Thu, 2 Jul 2020 12:31:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702155000.3455325-29-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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

On 7/2/20 10:49 AM, Markus Armbruster wrote:
> The previous commit enables conversion of
> 
>      foo(..., &err);
>      if (err) {
> 	...
>      }
> 
> to
> 
>      if (!foo(..., errp)) {
> 	...
>      }
> 
> for QOM functions that now return true / false on success / error.
> Coccinelle script:
> 
>      @@
>      identifier fun = {object_apply_global_props, object_initialize_child_with_props, object_initialize_child_with_propsv, object_property_get, object_property_get_bool, object_property_parse, object_property_set, object_property_set_bool, object_property_set_int, object_property_set_link, object_property_set_qobject, object_property_set_str, object_property_set_uint, object_set_props, object_set_propv, user_creatable_add_dict, user_creatable_complete, user_creatable_del};
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      @@
>      -    fun(args, &err, args2);
>      -    if (err)
>      +    if (!fun(args, &err, args2))
>           {
>               ...
>           }
> 
> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Convert manually.
> 
> Line breaks tidied up manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


