Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074C0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C144F20885
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvxMFXS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C144F20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8odt-0007jJ-41
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8ocn-00070W-CH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:45:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8ock-0003t5-CH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597945513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOxcYRSY0KjnwJhGk58jeKa7XZ91h3wq6KXC0h/+QZY=;
 b=QvxMFXS+anvJNHeiAWFGjrdfKT0BJQPCsauiak/gLNrIA6AWX9+LohIUI8wBzjgWb2rxx8
 6vaTM6hyebd7RNKjxeLOOLhVbMuhYJ4JFwrSJ3GlidcOagKbQN6SL5Qmh1KpSQeO0g4UaP
 s/4AHIzSEvKcMcqL2YSfNPZEZnVr5aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-6kcZn_TYNDS04_u9ABm9Zw-1; Thu, 20 Aug 2020 13:45:11 -0400
X-MC-Unique: 6kcZn_TYNDS04_u9ABm9Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EBAE1015DD4
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 17:45:09 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76B7310013C2;
 Thu, 20 Aug 2020 17:45:07 +0000 (UTC)
Date: Thu, 20 Aug 2020 13:45:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 44/58] qom: provide convenient macros for declaring
 and defining types
Message-ID: <20200820174506.GE642093@habkost.net>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-45-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820001236.1284548-45-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 08:28:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(CCing Eric Blake, who reviewed the original patch.  Sorry for
not CCing you previously, Eric)

On Wed, Aug 19, 2020 at 08:12:22PM -0400, Eduardo Habkost wrote:
[...]
> +/**
> + * OBJECT_DECLARE_TYPE:
> + * @ModuleObjName: the object name with initial capitalization
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators

We need to decide what to do with TYPE_SWIM:

  #define TYPE_SWIM "swim"
  typedef struct SWIM SWIM;
  #define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SWIM)

Both the typedef and type checking macros are called "SWIM".
This makes usage of OBJECT_DECLARE_TYPE impossible (because the
type checking function can't have the same as the typedef).  What
should be the recommended style here?  Rename the struct to
"Swim"?

We have similar issues with RXCPU and ARMSSE, but these type
checking macros can be easily renamed to RX_CPU and ARM_SSE. so
they won't be an issue.

> + *
> + * This macro is typically used in a header file, and will:
> + *
> + *   - create the typedefs for the object and class structs
> + *   - register the type for use with g_autoptr
> + *   - provide three standard type cast functions
> + *
> + * The object struct and class struct need to be declared manually.
> + */
> +#define OBJECT_DECLARE_TYPE(ModuleObjName, module_obj_name, MODULE_OBJ_NAME) \
> +    typedef struct ModuleObjName ModuleObjName; \
> +    typedef struct ModuleObjName##Class ModuleObjName##Class; \
> +    \
> +    G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName, object_unref) \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName##Class * \
> +    MODULE_OBJ_NAME##_GET_CLASS(void *obj) \
> +    { return OBJECT_GET_CLASS(ModuleObjName##Class, obj, \
> +                              TYPE_##MODULE_OBJ_NAME); } \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName##Class * \
> +    MODULE_OBJ_NAME##_CLASS(void *klass) \
> +    { return OBJECT_CLASS_CHECK(ModuleObjName##Class, klass, \
> +                                TYPE_##MODULE_OBJ_NAME); } \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName * \
> +    MODULE_OBJ_NAME(void *obj) \
> +    { return OBJECT_CHECK(ModuleObjName, obj, \
> +                          TYPE_##MODULE_OBJ_NAME); }
[...]

-- 
Eduardo


