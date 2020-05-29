Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7E2207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goOMgYZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7E2207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeb2Y-0000nf-7j
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 05:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jeb1P-0008A4-RC
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:09:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jeb1O-0005va-8Z
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590743384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoPOrOHa2WQtHis70AW148H3nYSH49HRUL5DGW/MzaU=;
 b=goOMgYZzxStCpVqiUPgVaIhDU/cKWDDxhuZFwhavb2MVguDUZQC5njFw/78qyh72Fx9+dM
 bsZJknZ1dZwH9APXSWlzB0CZqzwoCqQ3kuwbOl6fX8WFWB43nX5gKlsjJmDJYXcL9GKh/0
 LxLc9KwObI0pP/I0V5oh4ootfrvBnqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-RpO9IJXhNrm0OGH8ZyKh_g-1; Fri, 29 May 2020 05:09:42 -0400
X-MC-Unique: RpO9IJXhNrm0OGH8ZyKh_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E738015D1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 09:09:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F2F01002382;
 Fri, 29 May 2020 09:09:37 +0000 (UTC)
Subject: Re: [PATCH v7 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ebb5eb9b-042c-5377-90d4-cea09b79de77@redhat.com>
Date: Fri, 29 May 2020 11:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200528173141.17495-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
> The FW_CFG_DATA_GENERATOR allows any object to produce
> blob of data consumable by the fw_cfg device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v7: addressed Laszlo's comments
> - fixed typos in description
> - return size_t instead of ssize_t; 0 for error
> - do not use 1-letter variable names
> - do not open-code 'fw_cfg-data-generator'
> - cast g_memdup() size argument as 'guint'
> - improved documentation
> ---
>  docs/specs/fw_cfg.txt     |  9 ++++++-
>  include/hw/nvram/fw_cfg.h | 52 +++++++++++++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c         | 31 +++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
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

I've looked at this hunk with a larger context, and I think it's really
good.

> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 25d9307018..8fbf2446c1 100644
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
> +     */
> +    const void *(*get_data)(Object *obj);
> +    /**
> +     * get_length:
> +     * @obj: the object implementing this interface
> +     *
> +     * Returns: the size of the generated item data in bytes
> +     */
> +    size_t (*get_length)(Object *obj);
> +} FWCfgDataGeneratorClass;
> +
>  typedef struct fw_cfg_file FWCfgFile;
>  
>  #define FW_CFG_ORDER_OVERRIDE_VGA    70
> @@ -263,6 +295,26 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
>                           size_t len);
>  
> +/**
> + * fw_cfg_add_from_generator:
> + * @s: fw_cfg device being modified
> + * @filename: name of new fw_cfg file item
> + * @gen_id: name of object implementing FW_CFG_DATA_GENERATOR interface
> + * @errp: pointer to a NULL initialized error object
> + *
> + * Add a new NAMED fw_cfg item with the content generated from the
> + * @gen_id object. The data generated by the @gen_id object/ is copied

(1) typo: "object/" (possibly a copy-paste error from my v6 review)

> + * into the data structure of the fw_cfg device.
> + * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
> + * will be used; also, a new entry will be added to the file directory
> + * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
> + * data size, and assigned selector key value.
> + *
> + * Returns: the size of the device tree image on success, or 0 on errors.

(2) typo (probably another copy-paste error):

s/device tree image/generated item data/

> + */
> +size_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
> +                                 const char *gen_id, Error **errp);
> +
>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as);
>  FWCfgState *fw_cfg_init_io(uint32_t iobase);
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 8dd50c2c72..6d2fa13042 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1032,6 +1032,31 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>      return NULL;
>  }
>  
> +size_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
> +                                 const char *gen_id, Error **errp)
> +{
> +    FWCfgDataGeneratorClass *klass;
> +    Object *obj;
> +    size_t size;
> +
> +    obj = object_resolve_path_component(object_get_objects_root(), gen_id);
> +    if (!obj) {
> +        error_setg(errp, "Cannot find object ID %s", gen_id);
> +        return 0;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
> +        error_setg(errp, "Object '%s' is not a '%s' subclass",
> +                   TYPE_FW_CFG_DATA_GENERATOR_INTERFACE, gen_id);

(3) the order of the last two arguments is wrong; please reverse it.

> +        return 0;
> +    }
> +    klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
> +    size = klass->get_length(obj);

(4) I think we should not call fw_cfg_add_file() if get_length() returns
zero.

AFAICS, fw_cfg_add_file() will happily create a useless zero-size fw_cfg
entry, but then the same zero size that we return from
fw_cfg_add_from_generator() will indicate failure to the caller (and we
will also not have set "errp").

I think we need something like:

    if (size == 0) {
        error_setg(errp, "Object '%s' failed to generate fw_cfg data",
                   gen_id);
        return 0;
    }

That will also prevent an awkward call to g_memdup() with size==0.


Now, looking at patches #4 and #5, I think if no suitable cipher suite
is found, then qcrypto_tls_cipher_suites_get_data() will return NULL,
and qcrypto_tls_cipher_suites_get_length() will return zero. In turn, my
suggestion (4) here will prevent QEMU from starting up.

And I think that is just fine. The corresponding firmware function is
SetCipherSuites() in
"OvmfPkg/Library/TlsAuthConfigLib/TlsAuthConfigLib.c", and if it sees a
zero-sized "etc/edk2/https/ciphers" fw_cfg file, it will hang the
firmware, *on purpose*. (See the reason explained in comments there.)

Thus, it's much better if we prevent QEMU from starting up in the first
place.

> +    fw_cfg_add_file(s, filename, g_memdup(klass->get_data(obj), (guint)size),
> +                    size);
> +
> +    return size;
> +}
> +
>  static void fw_cfg_machine_reset(void *opaque)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> @@ -1333,12 +1358,18 @@ static const TypeInfo fw_cfg_mem_info = {
>      .class_init    = fw_cfg_mem_class_init,
>  };
>  
> +static const TypeInfo fw_cfg_data_generator_interface_info = {
> +    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
> +    .parent = TYPE_INTERFACE,
> +    .class_size = sizeof(FWCfgDataGeneratorClass),
> +};
>  
>  static void fw_cfg_register_types(void)
>  {
>      type_register_static(&fw_cfg_info);
>      type_register_static(&fw_cfg_io_info);
>      type_register_static(&fw_cfg_mem_info);
> +    type_register_static(&fw_cfg_data_generator_interface_info);
>  }
>  
>  type_init(fw_cfg_register_types)
> 

With (1) through (4) fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


