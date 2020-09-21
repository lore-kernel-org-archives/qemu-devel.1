Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E0C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A93214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyaZOgzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A93214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHw8-0008Ep-EG
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKHvQ-0007oF-Bp
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKHvO-0008HT-12
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600679752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xnzMbR3mjGVBuHyZshldr6EVuknGnusbogq43tKvP0=;
 b=IyaZOgzRaD1AhC+Ozbn3Y+0JG1qWcIAw98BGbNlvYnU/RBsFlwxZeL8A+22NPBFxTPY4Ss
 tIcmDX7XnKVrUpga3SdZZVBWcLXh8YNHGKbG5kP1GcNo7BPObHHyz76W6HK4Qh9wyrSPB7
 b0alstu/DeNa7lJjc6Up/arRwa8XpXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-VqXeKWvPN2W18ednXV4k-w-1; Mon, 21 Sep 2020 05:15:45 -0400
X-MC-Unique: VqXeKWvPN2W18ednXV4k-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C54DAF203;
 Mon, 21 Sep 2020 09:15:44 +0000 (UTC)
Received: from redhat.com (ovpn-113-113.ams2.redhat.com [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C97242635A;
 Mon, 21 Sep 2020 09:15:42 +0000 (UTC)
Date: Mon, 21 Sep 2020 10:15:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v2] qom: code hardening - have bound checking while
 looping with integer value
Message-ID: <20200921091540.GH1942072@redhat.com>
References: <20200921090704.25353-1-ani@anisinha.ca>
MIME-Version: 1.0
In-Reply-To: <20200921090704.25353-1-ani@anisinha.ca>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 02:37:04PM +0530, Ani Sinha wrote:
> Object property insertion code iterates over an integer to get an unused
> index that can be used as an unique name for an object property. This loop
> increments the integer value indefinitely. Although very unlikely, this can
> still cause an integer overflow.
> In this change, we fix the above code by checking against INT_MAX and making

s/INT/INT16/

> sure that the interger index does not overflow beyond that value. If no
> available index is found, the code would cause an assertion failure. This
> assertion failure is necessary because the callers of the function do not check
> the return value for NULL.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  qom/object.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 387efb25eb..9962874598 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1166,11 +1166,11 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>  
>      if (name_len >= 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
>          int i;
> -        ObjectProperty *ret;
> +        ObjectProperty *ret = NULL;
>          char *name_no_array = g_strdup(name);
>  
>          name_no_array[name_len - 3] = '\0';
> -        for (i = 0; ; ++i) {
> +        for (i = 0; i < INT16_MAX; ++i) {
>              char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
>  
>              ret = object_property_try_add(obj, full_name, type, get, set,
> @@ -1181,6 +1181,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>              }
>          }
>          g_free(name_no_array);
> +        assert(ret);
>          return ret;
>      }

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


