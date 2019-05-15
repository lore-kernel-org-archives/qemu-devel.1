Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E46CC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BEB20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BEB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvwk-0007ZT-AL
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:35:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQvvO-0006MZ-PL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQvvN-0002SM-2E
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQvvM-0002Rv-QC
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25CBC30018F6
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 15:34:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98A2760BE5;
	Wed, 15 May 2019 15:34:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1B9FF11385E4; Wed, 15 May 2019 17:34:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-6-quintela@redhat.com>
Date: Wed, 15 May 2019 17:34:27 +0200
In-Reply-To: <20190515121544.4597-6-quintela@redhat.com> (Juan Quintela's
	message of "Wed, 15 May 2019 14:15:41 +0200")
Message-ID: <87zhnn3f5o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 15 May 2019 15:34:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/8] migration: Add multifd-compress
 parameter
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> ---
> Rename it to NONE
> Fix typos (dave)
> ---
>  hmp.c                        | 17 +++++++++++++++++
>  hw/core/qdev-properties.c    | 13 +++++++++++++
>  include/hw/qdev-properties.h |  1 +
>  migration/migration.c        | 16 ++++++++++++++++
>  qapi/migration.json          | 30 +++++++++++++++++++++++++++---
>  tests/migration-test.c       | 13 ++++++++++---
>  6 files changed, 84 insertions(+), 6 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index 56a3ed7375..5732c34249 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -38,6 +38,7 @@
>  #include "qapi/qapi-commands-run-state.h"
>  #include "qapi/qapi-commands-tpm.h"
>  #include "qapi/qapi-commands-ui.h"
> +#include "qapi/qapi-visit-migration.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/string-input-visitor.h"
> @@ -435,6 +436,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
>              params->multifd_channels);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS),
> +            MultifdCompress_str(params->multifd_compress));
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> @@ -1736,6 +1740,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
>      uint64_t valuebw = 0;
>      uint64_t cache_size;
> +    MultifdCompress compress_type;
>      Error *err = NULL;
>      int val, ret;
>  
> @@ -1821,6 +1826,18 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_multifd_channels = true;
>          visit_type_int(v, param, &p->multifd_channels, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
> +        p->has_multifd_compress = true;
> +        visit_type_MultifdCompress(v, param, &compress_type, &err);
> +        if (err) {
> +            break;
> +        }
> +        if (compress_type < 0 || compress_type >= MULTIFD_COMPRESS__MAX) {
> +            error_setg(&err, "Invalid multifd_compress option %s", valuestr);
> +            break;
> +        }

This should never happen.  If you want to check anyway, make it an
assertion.

Just in case you don't believe me, or are curious:

visit_type_MultifdCompress() wraps around visit_type_enum(), passing it
&MultifdCompress_lookup.

Since @v is an input visitor, visit_type_enum() wraps around
input_type_enum().

input_type_enum() computes the value to store in @compress_type with
qapi_enum_parse().

To get here, visit_type_MultifdCompress() must have succeeded,
i.e. visit_type_enum(), input_type_enum() and qapi_enum_parse() all
succeded.

On success, qapi_enum_parse() returns one of the values in
MultifdCompress_lookup, i.e. a member of enum MultifdCompress other than
MULTIFD_COMPRESS__MAX.

> +        p->multifd_compress = compress_type;
> +        break;
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size = true;
>          visit_type_size(v, param, &cache_size, &err);
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5da1439a8b..ebeeb5c88d 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -5,6 +5,7 @@
>  #include "hw/pci/pci.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-types-migration.h"
>  #include "hw/block/block.h"
>  #include "net/hub.h"
>  #include "qapi/visitor.h"
> @@ -645,6 +646,18 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>      .set_default_value = set_default_value_enum,
>  };
>  
> +/* --- MultifdCompress --- */
> +
> +const PropertyInfo qdev_prop_multifd_compress = {
> +    .name = "MultifdCompress",
> +    .description = "multifd_compress values, "
> +                   "none",

This looks weird now, but it'll make sense when PATCH 7 adds the second
value.

> +    .enum_table = &MultifdCompress_lookup,
> +    .get = get_enum,
> +    .set = set_enum,
> +    .set_default_value = set_default_value_enum,
> +};
> +
>  /* --- pci address --- */
>  
>  /*
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index b6758c852e..ac452d8f2c 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -23,6 +23,7 @@ extern const PropertyInfo qdev_prop_tpm;
>  extern const PropertyInfo qdev_prop_ptr;
>  extern const PropertyInfo qdev_prop_macaddr;
>  extern const PropertyInfo qdev_prop_on_off_auto;
> +extern const PropertyInfo qdev_prop_multifd_compress;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>  extern const PropertyInfo qdev_prop_bios_chs_trans;
> diff --git a/migration/migration.c b/migration/migration.c
> index 609e0df5d0..d6f8ef342a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -82,6 +82,7 @@
>  /* The delay time (in ms) between two COLO checkpoints */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
> +#define DEFAULT_MIGRATE_MULTIFD_COMPRESS MULTIFD_COMPRESS_NONE
>  
>  /* Background transfer rate for postcopy, 0 means unlimited, note
>   * that page requests can still exceed this limit.
> @@ -769,6 +770,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->block_incremental = s->parameters.block_incremental;
>      params->has_multifd_channels = true;
>      params->multifd_channels = s->parameters.multifd_channels;
> +    params->has_multifd_compress = true;
> +    params->multifd_compress = s->parameters.multifd_compress;
>      params->has_xbzrle_cache_size = true;
>      params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
>      params->has_max_postcopy_bandwidth = true;
> @@ -1268,6 +1271,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_multifd_channels) {
>          dest->multifd_channels = params->multifd_channels;
>      }
> +    if (params->has_multifd_compress) {
> +        dest->multifd_compress = params->multifd_compress;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          dest->xbzrle_cache_size = params->xbzrle_cache_size;
>      }
> @@ -1364,6 +1370,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_multifd_channels) {
>          s->parameters.multifd_channels = params->multifd_channels;
>      }
> +    if (params->has_multifd_compress) {
> +        s->parameters.multifd_compress = params->multifd_compress;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
> @@ -3353,6 +3362,9 @@ void migration_global_dump(Monitor *mon)
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], false)
>  
> +#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, MultifdCompress)
> +

Did you forget to move this?

>  static Property migration_properties[] = {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>                       store_global_state, true),
> @@ -3392,6 +3404,9 @@ static Property migration_properties[] = {
>      DEFINE_PROP_UINT8("multifd-channels", MigrationState,
>                        parameters.multifd_channels,
>                        DEFAULT_MIGRATE_MULTIFD_CHANNELS),
> +    DEFINE_PROP_MULTIFD_COMPRESS("multifd-compress", MigrationState,
> +                      parameters.multifd_compress,
> +                      DEFAULT_MIGRATE_MULTIFD_COMPRESS),
>      DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
>                        parameters.xbzrle_cache_size,
>                        DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
> @@ -3481,6 +3496,7 @@ static void migration_instance_init(Object *obj)
>      params->has_x_checkpoint_delay = true;
>      params->has_block_incremental = true;
>      params->has_multifd_channels = true;
> +    params->has_multifd_compress = true;
>      params->has_xbzrle_cache_size = true;
>      params->has_max_postcopy_bandwidth = true;
>      params->has_max_cpu_throttle = true;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 9cfbaf8c6c..8ec1944b7a 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -482,6 +482,19 @@
>  ##
>  { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
>  
> +##
> +# @MultifdCompress:
> +#
> +# An enumeration of multifd compression.
> +#
> +# @none: no compression.
> +#
> +# Since: 4.1
> +#
> +##
> +{ 'enum': 'MultifdCompress',
> +  'data': [ 'none' ] }
> +
>  ##
>  # @MigrationParameter:
>  #
> @@ -580,6 +593,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
>  #
> +# @multifd-compress: Which compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -592,7 +608,7 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle', 'multifd-compress' ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -682,6 +698,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    The default value is 99. (Since 3.1)
>  #
> +# @multifd-compress: Which compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#
>  # Since: 2.4
>  ##
>  # TODO either fuse back into MigrationParameters, or make
> @@ -707,7 +726,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -	    '*max-cpu-throttle': 'int' } }
> +	    '*max-cpu-throttle': 'int',
> +            '*multifd-compress': 'MultifdCompress' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -817,6 +837,9 @@
>  #                    Defaults to 99.
>  #                     (Since 3.1)
>  #
> +# @multifd-compress: Which compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> @@ -840,7 +863,8 @@
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>  	    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +            '*max-cpu-throttle': 'uint8',
> +            '*multifd-compress': 'MultifdCompress' } }
>  
>  ##
>  # @query-migrate-parameters:

QAPI schema part:
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]

