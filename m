Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E486C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E1022CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E1022CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i575l-0008JD-Ac
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i574p-0007lv-IZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i574n-0005l3-U9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i574n-0005kc-Kk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4D4285539;
 Tue,  3 Sep 2019 11:34:20 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5F645D9E1;
 Tue,  3 Sep 2019 11:34:18 +0000 (UTC)
Date: Tue, 3 Sep 2019 12:34:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190903113416.GG2744@work-vm>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827120221.15725-2-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 03 Sep 2019 11:34:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add x-validate-uuid
 capability
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> This capability realizes simple source validation by UUID.
> It's useful for live migration between hosts.
> 
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

So, ignoring the question of whether it should be a capaibility or not,
I'm actually OK with this; I would remove the x- - it's simple enough
not to need to go through experimental I think.

Dave

> ---
>  migration/migration.c |  9 +++++++++
>  migration/migration.h |  1 +
>  migration/savevm.c    | 45 +++++++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json   |  5 ++++-
>  4 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8b9f2fe30a..910e11b7d7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2140,6 +2140,15 @@ bool migrate_ignore_shared(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_X_IGNORE_SHARED];
>  }
>  
> +bool migrate_validate_uuid(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_X_VALIDATE_UUID];
> +}
> +
>  bool migrate_use_events(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 3e1ea2b5dc..4f2fe193dc 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -290,6 +290,7 @@ bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
>  bool migrate_dirty_bitmaps(void);
>  bool migrate_ignore_shared(void);
> +bool migrate_validate_uuid(void);
>  
>  bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4a86128ac4..493dc24fd2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -256,6 +256,7 @@ typedef struct SaveState {
>      uint32_t target_page_bits;
>      uint32_t caps_count;
>      MigrationCapability *capabilities;
> +    QemuUUID uuid;
>  } SaveState;
>  
>  static SaveState savevm_state = {
> @@ -307,6 +308,7 @@ static int configuration_pre_save(void *opaque)
>              state->capabilities[j++] = i;
>          }
>      }
> +    state->uuid = qemu_uuid;
>  
>      return 0;
>  }
> @@ -464,6 +466,48 @@ static const VMStateDescription vmstate_capabilites = {
>      }
>  };
>  
> +static bool vmstate_uuid_needed(void *opaque)
> +{
> +    return qemu_uuid_set && migrate_validate_uuid();
> +}
> +
> +static int vmstate_uuid_post_load(void *opaque, int version_id)
> +{
> +    SaveState *state = opaque;
> +    char uuid_src[UUID_FMT_LEN + 1];
> +    char uuid_dst[UUID_FMT_LEN + 1];
> +
> +    if (!qemu_uuid_set) {
> +        /*
> +         * It's warning because user might not know UUID in some cases,
> +         * e.g. load an old snapshot
> +         */
> +        qemu_uuid_unparse(&state->uuid, uuid_src);
> +        warn_report("UUID is received %s, but local uuid isn't set",
> +                     uuid_src);
> +        return 0;
> +    }
> +    if (!qemu_uuid_is_equal(&state->uuid, &qemu_uuid)) {
> +        qemu_uuid_unparse(&state->uuid, uuid_src);
> +        qemu_uuid_unparse(&qemu_uuid, uuid_dst);
> +        error_report("UUID received is %s and local is %s", uuid_src, uuid_dst);
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_uuid = {
> +    .name = "configuration/uuid",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_uuid_needed,
> +    .post_load = vmstate_uuid_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY_V(uuid.data, SaveState, sizeof(QemuUUID), 1),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_configuration = {
>      .name = "configuration",
>      .version_id = 1,
> @@ -478,6 +522,7 @@ static const VMStateDescription vmstate_configuration = {
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_target_page_bits,
>          &vmstate_capabilites,
> +        &vmstate_uuid,
>          NULL
>      }
>  };
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 9cfbaf8c6c..b7a8064745 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -415,6 +415,9 @@
>  #
>  # @x-ignore-shared: If enabled, QEMU will not migrate shared memory (since 4.0)
>  #
> +# @x-validate-uuid: Check whether the UUID is the same on both sides or not.
> +#                   (since 4.2)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> @@ -422,7 +425,7 @@
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>             'block', 'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> -           'x-ignore-shared' ] }
> +           'x-ignore-shared', 'x-validate-uuid' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.22.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

