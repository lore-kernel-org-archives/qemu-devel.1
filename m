Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24966C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DBE2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DBE2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF0T5-0007NP-UV
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 14:00:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF0SH-00073q-37
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF0SF-0002J6-7x
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hF0SE-0002Ih-SB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:59:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9EE0307D854
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:59:09 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AC719C65;
	Fri, 12 Apr 2019 17:59:08 +0000 (UTC)
Date: Fri, 12 Apr 2019 18:59:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412175905.GQ2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-8-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 12 Apr 2019 17:59:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/17] block/qapi: Clean up how we print to
 monitor or stdout
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412175906.I--dgpUxETmpZlfrG7YVlrH32sNw9eLSe82x8Z4frug@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> bdrv_snapshot_dump(), bdrv_image_info_specific_dump(),
> bdrv_image_info_dump() and their helpers take an fprintf()-like
> callback and a FILE * to pass to it.
> 
> hmp.c passes monitor_printf() cast to fprintf_function and the current
> monitor cast to FILE *.
> 
> qemu-img.c and qemu-io-cmds.c pass fprintf and stdout.
> 
> The type-punning is technically undefined behaviour, but works in
> practice.  Clean up: drop the callback, and call qemu_printf()
> instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  block/qapi.c         | 120 ++++++++++++++++++++-----------------------
>  hmp.c                |  12 ++---
>  include/block/qapi.h |  10 ++--
>  qemu-img.c           |   6 +--
>  qemu-io-cmds.c       |   2 +-
>  5 files changed, 67 insertions(+), 83 deletions(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index 21edab34fc..e3e74f898f 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -36,6 +36,7 @@
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qemu/qemu-print.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/cutils.h"
>  
> @@ -660,8 +661,7 @@ static char *get_human_readable_size(char *buf, int buf_size, int64_t size)
>      return buf;
>  }
>  
> -void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
> -                        QEMUSnapshotInfo *sn)
> +void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
>  {
>      char buf1[128], date_buf[128], clock_buf[128];
>      struct tm tm;
> @@ -669,9 +669,8 @@ void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
>      int64_t secs;
>  
>      if (!sn) {
> -        func_fprintf(f,
> -                     "%-10s%-20s%7s%20s%15s",
> -                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
> +        qemu_printf("%-10s%-20s%7s%20s%15s",
> +                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
>      } else {
>          ti = sn->date_sec;
>          localtime_r(&ti, &tm);
> @@ -684,50 +683,46 @@ void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
>                   (int)((secs / 60) % 60),
>                   (int)(secs % 60),
>                   (int)((sn->vm_clock_nsec / 1000000) % 1000));
> -        func_fprintf(f,
> -                     "%-10s%-20s%7s%20s%15s",
> -                     sn->id_str, sn->name,
> -                     get_human_readable_size(buf1, sizeof(buf1),
> -                                             sn->vm_state_size),
> -                     date_buf,
> -                     clock_buf);
> +        qemu_printf("%-10s%-20s%7s%20s%15s",
> +                    sn->id_str, sn->name,
> +                    get_human_readable_size(buf1, sizeof(buf1),
> +                                            sn->vm_state_size),
> +                    date_buf,
> +                    clock_buf);
>      }
>  }
>  
> -static void dump_qdict(fprintf_function func_fprintf, void *f, int indentation,
> -                       QDict *dict);
> -static void dump_qlist(fprintf_function func_fprintf, void *f, int indentation,
> -                       QList *list);
> +static void dump_qdict(int indentation, QDict *dict);
> +static void dump_qlist(int indentation, QList *list);
>  
> -static void dump_qobject(fprintf_function func_fprintf, void *f,
> -                         int comp_indent, QObject *obj)
> +static void dump_qobject(int comp_indent, QObject *obj)
>  {
>      switch (qobject_type(obj)) {
>          case QTYPE_QNUM: {
>              QNum *value = qobject_to(QNum, obj);
>              char *tmp = qnum_to_string(value);
> -            func_fprintf(f, "%s", tmp);
> +            qemu_printf("%s", tmp);
>              g_free(tmp);
>              break;
>          }
>          case QTYPE_QSTRING: {
>              QString *value = qobject_to(QString, obj);
> -            func_fprintf(f, "%s", qstring_get_str(value));
> +            qemu_printf("%s", qstring_get_str(value));
>              break;
>          }
>          case QTYPE_QDICT: {
>              QDict *value = qobject_to(QDict, obj);
> -            dump_qdict(func_fprintf, f, comp_indent, value);
> +            dump_qdict(comp_indent, value);
>              break;
>          }
>          case QTYPE_QLIST: {
>              QList *value = qobject_to(QList, obj);
> -            dump_qlist(func_fprintf, f, comp_indent, value);
> +            dump_qlist(comp_indent, value);
>              break;
>          }
>          case QTYPE_QBOOL: {
>              QBool *value = qobject_to(QBool, obj);
> -            func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "false");
> +            qemu_printf("%s", qbool_get_bool(value) ? "true" : "false");
>              break;
>          }
>          default:
> @@ -735,8 +730,7 @@ static void dump_qobject(fprintf_function func_fprintf, void *f,
>      }
>  }
>  
> -static void dump_qlist(fprintf_function func_fprintf, void *f, int indentation,
> -                       QList *list)
> +static void dump_qlist(int indentation, QList *list)
>  {
>      const QListEntry *entry;
>      int i = 0;
> @@ -744,17 +738,16 @@ static void dump_qlist(fprintf_function func_fprintf, void *f, int indentation,
>      for (entry = qlist_first(list); entry; entry = qlist_next(entry), i++) {
>          QType type = qobject_type(entry->value);
>          bool composite = (type == QTYPE_QDICT || type == QTYPE_QLIST);
> -        func_fprintf(f, "%*s[%i]:%c", indentation * 4, "", i,
> -                     composite ? '\n' : ' ');
> -        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
> +        qemu_printf("%*s[%i]:%c", indentation * 4, "", i,
> +                    composite ? '\n' : ' ');
> +        dump_qobject(indentation + 1, entry->value);
>          if (!composite) {
> -            func_fprintf(f, "\n");
> +            qemu_printf("\n");
>          }
>      }
>  }
>  
> -static void dump_qdict(fprintf_function func_fprintf, void *f, int indentation,
> -                       QDict *dict)
> +static void dump_qdict(int indentation, QDict *dict)
>  {
>      const QDictEntry *entry;
>  
> @@ -769,18 +762,17 @@ static void dump_qdict(fprintf_function func_fprintf, void *f, int indentation,
>              key[i] = entry->key[i] == '-' ? ' ' : entry->key[i];
>          }
>          key[i] = 0;
> -        func_fprintf(f, "%*s%s:%c", indentation * 4, "", key,
> -                     composite ? '\n' : ' ');
> -        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
> +        qemu_printf("%*s%s:%c", indentation * 4, "", key,
> +                    composite ? '\n' : ' ');
> +        dump_qobject(indentation + 1, entry->value);
>          if (!composite) {
> -            func_fprintf(f, "\n");
> +            qemu_printf("\n");
>          }
>          g_free(key);
>      }
>  }
>  
> -void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *f,
> -                                   ImageInfoSpecific *info_spec)
> +void bdrv_image_info_specific_dump(ImageInfoSpecific *info_spec)
>  {
>      QObject *obj, *data;
>      Visitor *v = qobject_output_visitor_new(&obj);
> @@ -788,13 +780,12 @@ void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *f,
>      visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
>      visit_complete(v, &obj);
>      data = qdict_get(qobject_to(QDict, obj), "data");
> -    dump_qobject(func_fprintf, f, 1, data);
> +    dump_qobject(1, data);
>      qobject_unref(obj);
>      visit_free(v);
>  }
>  
> -void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
> -                          ImageInfo *info)
> +void bdrv_image_info_dump(ImageInfo *info)
>  {
>      char size_buf[128], dsize_buf[128];
>      if (!info->has_actual_size) {
> @@ -804,49 +795,48 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
>                                  info->actual_size);
>      }
>      get_human_readable_size(size_buf, sizeof(size_buf), info->virtual_size);
> -    func_fprintf(f,
> -                 "image: %s\n"
> -                 "file format: %s\n"
> -                 "virtual size: %s (%" PRId64 " bytes)\n"
> -                 "disk size: %s\n",
> -                 info->filename, info->format, size_buf,
> -                 info->virtual_size,
> -                 dsize_buf);
> +    qemu_printf("image: %s\n"
> +                "file format: %s\n"
> +                "virtual size: %s (%" PRId64 " bytes)\n"
> +                "disk size: %s\n",
> +                info->filename, info->format, size_buf,
> +                info->virtual_size,
> +                dsize_buf);
>  
>      if (info->has_encrypted && info->encrypted) {
> -        func_fprintf(f, "encrypted: yes\n");
> +        qemu_printf("encrypted: yes\n");
>      }
>  
>      if (info->has_cluster_size) {
> -        func_fprintf(f, "cluster_size: %" PRId64 "\n",
> -                       info->cluster_size);
> +        qemu_printf("cluster_size: %" PRId64 "\n",
> +                    info->cluster_size);
>      }
>  
>      if (info->has_dirty_flag && info->dirty_flag) {
> -        func_fprintf(f, "cleanly shut down: no\n");
> +        qemu_printf("cleanly shut down: no\n");
>      }
>  
>      if (info->has_backing_filename) {
> -        func_fprintf(f, "backing file: %s", info->backing_filename);
> +        qemu_printf("backing file: %s", info->backing_filename);
>          if (!info->has_full_backing_filename) {
> -            func_fprintf(f, " (cannot determine actual path)");
> +            qemu_printf(" (cannot determine actual path)");
>          } else if (strcmp(info->backing_filename,
>                            info->full_backing_filename) != 0) {
> -            func_fprintf(f, " (actual path: %s)", info->full_backing_filename);
> +            qemu_printf(" (actual path: %s)", info->full_backing_filename);
>          }
> -        func_fprintf(f, "\n");
> +        qemu_printf("\n");
>          if (info->has_backing_filename_format) {
> -            func_fprintf(f, "backing file format: %s\n",
> -                         info->backing_filename_format);
> +            qemu_printf("backing file format: %s\n",
> +                        info->backing_filename_format);
>          }
>      }
>  
>      if (info->has_snapshots) {
>          SnapshotInfoList *elem;
>  
> -        func_fprintf(f, "Snapshot list:\n");
> -        bdrv_snapshot_dump(func_fprintf, f, NULL);
> -        func_fprintf(f, "\n");
> +        qemu_printf("Snapshot list:\n");
> +        bdrv_snapshot_dump(NULL);
> +        qemu_printf("\n");
>  
>          /* Ideally bdrv_snapshot_dump() would operate on SnapshotInfoList but
>           * we convert to the block layer's native QEMUSnapshotInfo for now.
> @@ -862,13 +852,13 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
>  
>              pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
>              pstrcpy(sn.name, sizeof(sn.name), elem->value->name);
> -            bdrv_snapshot_dump(func_fprintf, f, &sn);
> -            func_fprintf(f, "\n");
> +            bdrv_snapshot_dump(&sn);
> +            qemu_printf("\n");
>          }
>      }
>  
>      if (info->has_format_specific) {
> -        func_fprintf(f, "Format specific information:\n");
> -        bdrv_image_info_specific_dump(func_fprintf, f, info->format_specific);
> +        qemu_printf("Format specific information:\n");
> +        bdrv_image_info_specific_dump(info->format_specific);
>      }
>  }
> diff --git a/hmp.c b/hmp.c
> index 8eec768088..4bb3af748e 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -580,8 +580,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>          monitor_printf(mon, "\nImages:\n");
>          image_info = inserted->image;
>          while (1) {
> -                bdrv_image_info_dump((fprintf_function)monitor_printf,
> -                                     mon, image_info);
> +                bdrv_image_info_dump(image_info);
>              if (image_info->has_backing_image) {
>                  image_info = image_info->backing_image;
>              } else {
> @@ -1586,7 +1585,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
>      monitor_printf(mon, "List of snapshots present on all disks:\n");
>  
>      if (total > 0) {
> -        bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, NULL);
> +        bdrv_snapshot_dump(NULL);
>          monitor_printf(mon, "\n");
>          for (i = 0; i < total; i++) {
>              sn = &sn_tab[global_snapshots[i]];
> @@ -1594,7 +1593,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
>               * overwrite it.
>               */
>              pstrcpy(sn->id_str, sizeof(sn->id_str), "--");
> -            bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, sn);
> +            bdrv_snapshot_dump(sn);
>              monitor_printf(mon, "\n");
>          }
>      } else {
> @@ -1608,11 +1607,10 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon,
>                         "\nList of partial (non-loadable) snapshots on '%s':\n",
>                         image_entry->imagename);
> -        bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, NULL);
> +        bdrv_snapshot_dump(NULL);
>          monitor_printf(mon, "\n");
>          QTAILQ_FOREACH(snapshot_entry, &image_entry->snapshots, next) {
> -            bdrv_snapshot_dump((fprintf_function)monitor_printf, mon,
> -                               &snapshot_entry->sn);
> +            bdrv_snapshot_dump(&snapshot_entry->sn);
>              monitor_printf(mon, "\n");
>          }
>      }
> diff --git a/include/block/qapi.h b/include/block/qapi.h
> index a891f43b9c..cd9410dee3 100644
> --- a/include/block/qapi.h
> +++ b/include/block/qapi.h
> @@ -27,7 +27,6 @@
>  
>  #include "block/block.h"
>  #include "block/snapshot.h"
> -#include "qemu/fprintf-fn.h"
>  
>  BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>                                          BlockDriverState *bs, Error **errp);
> @@ -38,10 +37,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
>                             ImageInfo **p_info,
>                             Error **errp);
>  
> -void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
> -                        QEMUSnapshotInfo *sn);
> -void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *f,
> -                                   ImageInfoSpecific *info_spec);
> -void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
> -                          ImageInfo *info);
> +void bdrv_snapshot_dump(QEMUSnapshotInfo *sn);
> +void bdrv_image_info_specific_dump(ImageInfoSpecific *info_spec);
> +void bdrv_image_info_dump(ImageInfo *info);
>  #endif
> diff --git a/qemu-img.c b/qemu-img.c
> index 55201fb913..ab5e3a2f23 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2483,11 +2483,11 @@ static void dump_snapshots(BlockDriverState *bs)
>      if (nb_sns <= 0)
>          return;
>      printf("Snapshot list:\n");
> -    bdrv_snapshot_dump(fprintf, stdout, NULL);
> +    bdrv_snapshot_dump(NULL);
>      printf("\n");
>      for(i = 0; i < nb_sns; i++) {
>          sn = &sn_tab[i];
> -        bdrv_snapshot_dump(fprintf, stdout, sn);
> +        bdrv_snapshot_dump(sn);
>          printf("\n");
>      }
>      g_free(sn_tab);
> @@ -2536,7 +2536,7 @@ static void dump_human_image_info_list(ImageInfoList *list)
>          }
>          delim = true;
>  
> -        bdrv_image_info_dump(fprintf, stdout, elem->value);
> +        bdrv_image_info_dump(elem->value);
>      }
>  }
>  
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 09750a23ce..8826bebaf6 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1699,7 +1699,7 @@ static int info_f(BlockBackend *blk, int argc, char **argv)
>      }
>      if (spec_info) {
>          printf("Format specific information:\n");
> -        bdrv_image_info_specific_dump(fprintf, stdout, spec_info);
> +        bdrv_image_info_specific_dump(spec_info);
>          qapi_free_ImageInfoSpecific(spec_info);
>      }
>  
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

