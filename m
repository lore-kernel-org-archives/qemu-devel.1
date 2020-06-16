Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17056C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF465208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUF2Pvl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF465208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDbh-0002eQ-4L
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlDYq-0000em-LK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:31:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlDYo-0005kr-TE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592321496;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1mArf70cq3kt9VTnGq1LlFUC5kV+mUFrG23lW7qcb4=;
 b=iUF2Pvl4EtUljtYk3hLjHCwESDRtLB2jsJIZR981w2/66cIpHF3GlLRVGp6d9w23T4UDXw
 0wQHo8i5BMZMTopBWLwu2/uLhEWvC8QZ04368uHX6VRDaSG8FAjU/nHy4vs9iqVtszwmcd
 gd2z0pm7K1CcJs+9rjaVPNJBx4yMV3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-SmN6JNedNCufLd3x2GJILA-1; Tue, 16 Jun 2020 11:31:34 -0400
X-MC-Unique: SmN6JNedNCufLd3x2GJILA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C5738730E8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 15:31:33 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD24B100164C;
 Tue, 16 Jun 2020 15:31:26 +0000 (UTC)
Date: Tue, 16 Jun 2020 16:31:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v9 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
Message-ID: <20200616153122.GN550360@redhat.com>
References: <20200615103457.25282-1-philmd@redhat.com>
 <20200615103457.25282-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615103457.25282-2-philmd@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 12:34:53PM +0200, Philippe Mathieu-Daudé wrote:
> The FW_CFG_DATA_GENERATOR allows any object to produce
> blob of data consumable by the fw_cfg device.
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  docs/specs/fw_cfg.txt     |  9 ++++++-
>  include/hw/nvram/fw_cfg.h | 52 +++++++++++++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c         | 36 +++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> index 8f1ebc66fa..bc16daa38a 100644
> --- a/docs/specs/fw_cfg.txt
> +++ b/docs/specs/fw_cfg.txt
> @@ -219,7 +219,7 @@ To check the result, read the "control" field:
>  
>  = Externally Provided Items =
>  
> -As of v2.4, "file" fw_cfg items (i.e., items with selector keys above
> +Since v2.4, "file" fw_cfg items (i.e., items with selector keys above
>  FW_CFG_FILE_FIRST, and with a corresponding entry in the fw_cfg file
>  directory structure) may be inserted via the QEMU command line, using
>  the following syntax:
> @@ -230,6 +230,13 @@ Or
>  
>      -fw_cfg [name=]<item_name>,string=<string>
>  
> +Since v5.1, QEMU allows some objects to generate fw_cfg-specific content,
> +the content is then associated with a "file" item using the 'gen_id' option
> +in the command line, using the following syntax:
> +
> +    -object <generator-type>,id=<generated_id>,[generator-specific-options] \
> +    -fw_cfg [name=]<item_name>,gen_id=<generated_id>
> +
>  See QEMU man page for more documentation.
>  
>  Using item_name with plain ASCII characters only is recommended.
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 25d9307018..ca69666847 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -9,11 +9,43 @@
>  #define TYPE_FW_CFG     "fw_cfg"
>  #define TYPE_FW_CFG_IO  "fw_cfg_io"
>  #define TYPE_FW_CFG_MEM "fw_cfg_mem"
> +#define TYPE_FW_CFG_DATA_GENERATOR_INTERFACE "fw_cfg-data-generator"
>  
>  #define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
>  #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
>  #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
>  
> +#define FW_CFG_DATA_GENERATOR_CLASS(class) \
> +    OBJECT_CLASS_CHECK(FWCfgDataGeneratorClass, (class), \
> +                       TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
> +#define FW_CFG_DATA_GENERATOR_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(FWCfgDataGeneratorClass, (obj), \
> +                     TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
> +
> +typedef struct FWCfgDataGeneratorClass {
> +    /*< private >*/
> +    InterfaceClass parent_class;
> +    /*< public >*/
> +
> +    /**
> +     * get_data:
> +     * @obj: the object implementing this interface
> +     *
> +     * Returns: pointer to start of the generated item data
> +     *
> +     * The returned pointer is a QObject weak reference, @obj owns
> +     * the reference and may free it at any time in the future.

This description is a bit odd. We're just returning a plain byte
array pointer, not a QObject, nor a reference, not will it be
free'd at any time.

> +     */
> +    const void *(*get_data)(Object *obj);
> +    /**
> +     * get_length:
> +     * @obj: the object implementing this interface
> +     *
> +     * Returns: the size of the generated item data in bytes
> +     */
> +    size_t (*get_length)(Object *obj);

I'd be inclined to have a single method that returns a GByteArray,
instead of separate methods for data & length.

That gives you a sized byte array, with a well define lifetime,
which is what the caller really wants here. ie

    /**
      * get_data:
      * @obj: the object implementing this interface
      *
      * Returns: reference to a byte array containing the data.
      * The caller should release the reference when no longer
      * required.
      */
     GByteArray *(*get_data)(Object *obj);

> +} FWCfgDataGeneratorClass;
> +

....


> +size_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
> +                                 const char *gen_id, Error **errp)
> +{
> +    FWCfgDataGeneratorClass *klass;
> +    Object *obj;
> +    size_t size;
> +
> +    obj = object_resolve_path_component(object_get_objects_root(), gen_id);
> +    if (!obj) {
> +        error_setg(errp, "Cannot find object ID '%s'", gen_id);
> +        return 0;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
> +        error_setg(errp, "Object ID '%s' is not a '%s' subclass",
> +                   gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
> +        return 0;
> +    }
> +    klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);

...then the following:

> +    size = klass->get_length(obj);
> +    if (size == 0) {
> +        error_setg(errp, "Object ID '%s' failed to generate fw_cfg data",
> +                   gen_id);
> +        return 0;
> +    }
> +    fw_cfg_add_file(s, filename, g_memdup(klass->get_data(obj), (guint)size),
> +                    size);

Can be replaced with:

   g_autoptr(GByteArray) data = klass->get_data(obj);

   fw_cfg_add_file(s, filename, g_byte_array_steal(data, NULL),
                   (guint)g_byte_array_get_size(data));


If there's a real possibility of failure, then an 'Error **errp' should
be added  to the 'get_data' method, so this code doesn't have to invent
a error message with no useful info on the real failure.

> +
> +    return size;
> +}
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


