Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A9C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247A921951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247A921951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhWm-0002HA-Cb
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqhWY-0001cQ-2Z
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqhWW-0001fT-Jf
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:27:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hqhWO-0001bs-VF; Thu, 25 Jul 2019 13:27:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6EE037F41;
 Thu, 25 Jul 2019 17:27:15 +0000 (UTC)
Received: from work-vm (ovpn-117-187.ams2.redhat.com [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A82425DA9A;
 Thu, 25 Jul 2019 17:27:14 +0000 (UTC)
Date: Thu, 25 Jul 2019 18:27:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190725172712.GM2656@work-vm>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725163710.11703-3-peter.maydell@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 17:27:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1? 2/2] vmstate.h: Type check
 VMSTATE_STRUCT_VARRAY macros
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> The VMSTATE_STRUCT_VARRAY_UINT32 macro is intended to handle
> migrating a field which is an array of structs, but where instead of
> migrating the entire array we only migrate a variable number of
> elements of it.
> 
> The VMSTATE_STRUCT_VARRAY_POINTER_UINT32 macro is intended to handle
> migrating a field which is of pointer type, and points to a
> dynamically allocated array of structs of variable size.
> 
> We weren't actually checking that the field passed to
> VMSTATE_STRUCT_VARRAY_UINT32 really is an array, with the result that
> accidentally using it where the _POINTER_ macro was intended would
> compile but silently corrupt memory on migration.
> 
> Add type-checking that enforces that the field passed in is
> really of the right array type. This applies to all the VMSTATE
> macros which use flags including VMS_VARRAY_* but not VMS_POINTER.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> ---
>  include/migration/vmstate.h | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index ca68584eba4..2df333c3612 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -227,8 +227,19 @@ extern const VMStateInfo vmstate_info_bitmap;
>  extern const VMStateInfo vmstate_info_qtailq;
>  
>  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
> +/* Check that t2 is an array of t1 of size n */
>  #define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)

I'd have to admit I don't understand why that does what you say;
I'd expected something to index a t2 pointer with [n].

However, for the rest of it, from migration I'm happy:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

given it's just fixing an ARM bug, and given it'll blow up straight away
I think it's OK for 4.1; the only risk is if we find a compiler we don't
like.


>  #define type_check_pointer(t1,t2) ((t1**)0 - (t2*)0)
> +/*
> + * type of element 0 of the specified (array) field of the type.
> + * Note that if the field is a pointer then this will return the
> + * pointed-to type rather than complaining.
> + */
> +#define typeof_elt_of_field(type, field) typeof(((type *)0)->field[0])
> +/* Check that field f in struct type t2 is an array of t1, of any size */
> +#define type_check_varray(t1, t2, f)                                 \
> +    (type_check(t1, typeof_elt_of_field(t2, f))                      \
> +     + QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(((t2 *)0)->f)))
>  
>  #define vmstate_offset_value(_state, _field, _type)                  \
>      (offsetof(_state, _field) +                                      \
> @@ -253,6 +264,10 @@ extern const VMStateInfo vmstate_info_qtailq;
>      vmstate_offset_array(_state, _field, uint8_t,                    \
>                           sizeof(typeof_field(_state, _field)))
>  
> +#define vmstate_offset_varray(_state, _field, _type)                 \
> +    (offsetof(_state, _field) +                                      \
> +     type_check_varray(_type, _state, _field))
> +
>  /* In the macros below, if there is a _version, that means the macro's
>   * field will be processed only if the version being received is >=
>   * the _version specified.  In general, if you add a new field, you
> @@ -347,7 +362,7 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_UINT32|VMS_MULTIPLY_ELEMENTS,           \
> -    .offset     = offsetof(_state, _field),                          \
> +    .offset     = vmstate_offset_varray(_state, _field, _type),      \
>  }
>  
>  #define VMSTATE_ARRAY_TEST(_field, _state, _num, _test, _info, _type) {\
> @@ -376,7 +391,7 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_INT32,                                  \
> -    .offset     = offsetof(_state, _field),                          \
> +    .offset     = vmstate_offset_varray(_state, _field, _type),      \
>  }
>  
>  #define VMSTATE_VARRAY_INT32(_field, _state, _field_num, _version, _info, _type) {\
> @@ -416,7 +431,7 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_UINT16,                                 \
> -    .offset     = offsetof(_state, _field),                          \
> +    .offset     = vmstate_offset_varray(_state, _field, _type),      \
>  }
>  
>  #define VMSTATE_VSTRUCT_TEST(_field, _state, _test, _version, _vmsd, _type, _struct_version) { \
> @@ -520,7 +535,7 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .vmsd       = &(_vmsd),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_STRUCT|VMS_VARRAY_UINT8,                       \
> -    .offset     = offsetof(_state, _field),                          \
> +    .offset     = vmstate_offset_varray(_state, _field, _type),      \
>  }
>  
>  /* a variable length array (i.e. _type *_field) but we know the
> @@ -573,7 +588,7 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .vmsd       = &(_vmsd),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_STRUCT|VMS_VARRAY_INT32,                       \
> -    .offset     = offsetof(_state, _field),                          \
> +    .offset     = vmstate_offset_varray(_state, _field, _type),      \
>  }
>  
>  #define VMSTATE_STRUCT_VARRAY_UINT32(_field, _state, _field_num, _version, _vmsd, _type) { \
> @@ -583,7 +598,7 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .vmsd       = &(_vmsd),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_STRUCT|VMS_VARRAY_UINT32,                      \
> -    .offset     = offsetof(_state, _field),                          \
> +    .offset     = vmstate_offset_varray(_state, _field, _type),      \
>  }
>  
>  #define VMSTATE_STRUCT_VARRAY_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) {\
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

