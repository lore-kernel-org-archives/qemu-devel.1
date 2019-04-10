Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B00C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 17:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E092063F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 17:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E092063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEHRh-0007M3-Mt
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 13:55:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEHQw-0006zV-2D
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEHQu-00038y-4a
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEHQq-00035w-BU
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:54:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CF7870008
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 17:54:42 +0000 (UTC)
Received: from work-vm (ovpn-117-246.ams2.redhat.com [10.36.117.246])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC40608A4;
	Wed, 10 Apr 2019 17:54:40 +0000 (UTC)
Date: Wed, 10 Apr 2019 18:54:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190410175437.GH2980@work-vm>
References: <20190403114958.3705-1-quintela@redhat.com>
	<20190403114958.3705-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190403114958.3705-7-quintela@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 10 Apr 2019 17:54:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 6/8] migration: Add multifd-compress
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410175438.h_a_3k_ER1oOv8HQggcwkxUFgaCVfgQY7s-ydTjgEww@z>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> Rename it to NONE
> ---
>  hmp.c                        | 17 +++++++++++++++++
>  hw/core/qdev-properties.c    | 11 +++++++++++
>  include/hw/qdev-properties.h |  1 +
>  migration/migration.c        | 16 ++++++++++++++++
>  qapi/common.json             | 13 +++++++++++++
>  qapi/migration.json          | 19 +++++++++++++++----
>  tests/migration-test.c       | 13 ++++++++++---
>  7 files changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 8eec768088..02fbe27757 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -435,6 +435,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
>              params->multifd_channels);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS),
> +            MultifdCompress_str(params->multifd_compress));
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> @@ -1737,6 +1740,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
>      uint64_t valuebw = 0;
>      uint64_t cache_size;
> +    int compress_type;
>      Error *err = NULL;
>      int val, ret;
>  
> @@ -1822,6 +1826,19 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_multifd_channels = true;
>          visit_type_int(v, param, &p->multifd_channels, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
> +        p->has_multifd_compress = true;
> +        visit_type_enum(v, param, &compress_type,
> +                        &MultifdCompress_lookup, &err);
> +        if (err) {
> +            break;
> +        }
> +        if (compress_type < 0 || compress_type > MULTIFD_COMPRESS__MAX) {

I still think that needs to be >= rather than > ?

Dave

> +            error_setg(&err, "Invalid multifd_compress option %s", valuestr);
> +            break;
> +        }
> +        p->multifd_compress = compress_type;
> +        break;
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size = true;
>          visit_type_size(v, param, &cache_size, &err);
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5da1439a8b..7c8e71532f 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -645,6 +645,17 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>      .set_default_value = set_default_value_enum,
>  };
>  
> +/* --- MultifdCompress --- */
> +
> +const PropertyInfo qdev_prop_multifd_compress = {
> +    .name = "MultifdCompress",
> +    .description = "multifd_compress values",
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
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..7248172792 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -193,3 +193,16 @@
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> +
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
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 9cfbaf8c6c..629795fd30 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -580,6 +580,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
>  #
> +# @multifd-compress: What compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -592,7 +595,7 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle', 'multifd-compress' ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -680,7 +683,10 @@
>  #                     (Since 3.0)
>  #
>  # @max-cpu-throttle: maximum cpu throttle percentage.
> -#                    The default value is 99. (Since 3.1)
> +#                    The default value is 99. (Since 4.0)
> +#
> +# @multifd-compress: What compression method to use.
> +#                    Defaults to none. (Since 4.1)
>  #
>  # Since: 2.4
>  ##
> @@ -707,7 +713,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -	    '*max-cpu-throttle': 'int' } }
> +	    '*max-cpu-throttle': 'int',
> +            '*multifd-compress': 'MultifdCompress' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -817,6 +824,9 @@
>  #                    Defaults to 99.
>  #                     (Since 3.1)
>  #
> +# @multifd-compress: What compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> @@ -840,7 +850,8 @@
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>  	    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +            '*max-cpu-throttle': 'uint8',
> +            '*multifd-compress': 'MultifdCompress' } }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 65d5e256a7..8a1ccc2516 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -449,7 +449,6 @@ static void migrate_check_parameter_str(QTestState *who, const char *parameter,
>      g_free(result);
>  }
>  
> -__attribute__((unused))
>  static void migrate_set_parameter_str(QTestState *who, const char *parameter,
>                                        const char *value)
>  {
> @@ -1065,7 +1064,7 @@ static void test_precopy_tcp(void)
>      g_free(uri);
>  }
>  
> -static void test_multifd_tcp(void)
> +static void test_multifd_tcp(const char *method)
>  {
>      char *uri;
>      QTestState *from, *to;
> @@ -1087,6 +1086,9 @@ static void test_multifd_tcp(void)
>      migrate_set_parameter_int(from, "multifd-channels", 2);
>      migrate_set_parameter_int(to, "multifd-channels", 2);
>  
> +    migrate_set_parameter_str(from, "multifd-compress", method);
> +    migrate_set_parameter_str(to, "multifd-compress", method);
> +
>      migrate_set_capability(from, "multifd", "true");
>      migrate_set_capability(to, "multifd", "true");
>      /* Wait for the first serial output from the source */
> @@ -1112,6 +1114,11 @@ static void test_multifd_tcp(void)
>      test_migrate_end(from, to, true);
>  }
>  
> +static void test_multifd_tcp_none(void)
> +{
> +    test_multifd_tcp("none");
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -1166,7 +1173,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
>      /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
>      qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
> -    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
> +    qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
>  
>      ret = g_test_run();
>  
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

