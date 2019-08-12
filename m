Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5212EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 20:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1479220679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 20:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1479220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxGlb-0000q0-6S
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 16:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hxGl0-0000Ly-Tr
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 16:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hxGkz-0005ms-Fd
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 16:17:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hxGkw-0005jg-BS; Mon, 12 Aug 2019 16:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E94D7BDA5;
 Mon, 12 Aug 2019 20:17:25 +0000 (UTC)
Received: from [10.18.17.169] (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 059D1808AB;
 Mon, 12 Aug 2019 20:17:24 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-3-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7d00fbea-5762-9e0f-199f-c3886727d937@redhat.com>
Date: Mon, 12 Aug 2019 16:17:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725155735.11872-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 12 Aug 2019 20:17:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] vmdk: Use bdrv_dirname()
 for relative extent paths
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/25/19 11:57 AM, Max Reitz wrote:
> This makes iotest 033 pass with e.g. subformat=monolithicFlat.  It also
> turns a former error in 059 into success.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Seems roughly correct, but I only really gave it a cursory look; my
trust in you knowing the exact semantics of filename and path variables
because of those lengthy series is doing the heavy lifting here:

Reviewed-by: John Snow <jsnow@redhat.com>

(And if it breaks, it's for 4.2, and it's just vmdk, we'll figure it out.)

> ---
>  block/vmdk.c               | 54 ++++++++++++++++++++++++--------------
>  tests/qemu-iotests/059     |  7 +++--
>  tests/qemu-iotests/059.out |  4 ++-
>  3 files changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index bd36ece125..db6acfc31e 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1076,8 +1076,7 @@ static const char *next_line(const char *s)
>  }
>  
>  static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
> -                              const char *desc_file_path, QDict *options,
> -                              Error **errp)
> +                              QDict *options, Error **errp)
>  {
>      int ret;
>      int matches;
> @@ -1087,6 +1086,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
>      const char *p, *np;
>      int64_t sectors = 0;
>      int64_t flat_offset;
> +    char *desc_file_dir = NULL;
>      char *extent_path;
>      BdrvChild *extent_file;
>      BDRVVmdkState *s = bs->opaque;
> @@ -1130,16 +1130,23 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
>              continue;
>          }
>  
> -        if (!path_is_absolute(fname) && !path_has_protocol(fname) &&
> -            !desc_file_path[0])
> -        {
> -            bdrv_refresh_filename(bs->file->bs);
> -            error_setg(errp, "Cannot use relative extent paths with VMDK "
> -                       "descriptor file '%s'", bs->file->bs->filename);
> -            return -EINVAL;
> -        }
> +        if (path_is_absolute(fname) || path_has_protocol(fname)) {
> +            extent_path = g_strdup(fname);
> +        } else {
> +            if (!desc_file_dir) {
> +                desc_file_dir = bdrv_dirname(bs->file->bs, errp);
> +                if (!desc_file_dir) {
> +                    bdrv_refresh_filename(bs->file->bs);
> +                    error_prepend(errp, "Cannot use relative paths with VMDK "
> +                                  "descriptor file '%s': ",
> +                                  bs->file->bs->filename);
> +                    ret = -EINVAL;
> +                    goto out;
> +                }
> +            }
>  
> -        extent_path = path_combine(desc_file_path, fname);
> +            extent_path = g_strconcat(desc_file_dir, fname, NULL);
> +        }
>  
>          ret = snprintf(extent_opt_prefix, 32, "extents.%d", s->num_extents);
>          assert(ret < 32);
> @@ -1149,7 +1156,8 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
>          g_free(extent_path);
>          if (local_err) {
>              error_propagate(errp, local_err);
> -            return -EINVAL;
> +            ret = -EINVAL;
> +            goto out;
>          }
>  
>          /* save to extents array */
> @@ -1160,7 +1168,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
>                              0, 0, 0, 0, 0, &extent, errp);
>              if (ret < 0) {
>                  bdrv_unref_child(bs, extent_file);
> -                return ret;
> +                goto out;
>              }
>              extent->flat_start_offset = flat_offset << 9;
>          } else if (!strcmp(type, "SPARSE") || !strcmp(type, "VMFSSPARSE")) {
> @@ -1175,24 +1183,27 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
>              g_free(buf);
>              if (ret) {
>                  bdrv_unref_child(bs, extent_file);
> -                return ret;
> +                goto out;
>              }
>              extent = &s->extents[s->num_extents - 1];
>          } else if (!strcmp(type, "SESPARSE")) {
>              ret = vmdk_open_se_sparse(bs, extent_file, bs->open_flags, errp);
>              if (ret) {
>                  bdrv_unref_child(bs, extent_file);
> -                return ret;
> +                goto out;
>              }
>              extent = &s->extents[s->num_extents - 1];
>          } else {
>              error_setg(errp, "Unsupported extent type '%s'", type);
>              bdrv_unref_child(bs, extent_file);
> -            return -ENOTSUP;
> +            ret = -ENOTSUP;
> +            goto out;
>          }
>          extent->type = g_strdup(type);
>      }
> -    return 0;
> +
> +    ret = 0;
> +    goto out;
>  
>  invalid:
>      np = next_line(p);
> @@ -1201,7 +1212,11 @@ invalid:
>          np--;
>      }
>      error_setg(errp, "Invalid extent line: %.*s", (int)(np - p), p);
> -    return -EINVAL;
> +    ret = -EINVAL;
> +
> +out:
> +    g_free(desc_file_dir);
> +    return ret;
>  }
>  
>  static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char *buf,
> @@ -1228,8 +1243,7 @@ static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char *buf,
>      }
>      s->create_type = g_strdup(ct);
>      s->desc_offset = 0;
> -    ret = vmdk_parse_extents(buf, bs, bs->file->bs->exact_filename, options,
> -                             errp);
> +    ret = vmdk_parse_extents(buf, bs, options, errp);
>  exit:
>      return ret;
>  }
> diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
> index 279aee6815..fbed5f9483 100755
> --- a/tests/qemu-iotests/059
> +++ b/tests/qemu-iotests/059
> @@ -114,9 +114,12 @@ $QEMU_IMG convert -f qcow2 -O vmdk -o subformat=streamOptimized "$TEST_IMG.qcow2
>  
>  echo
>  echo "=== Testing monolithicFlat with internally generated JSON file name ==="
> +# Should work, because bdrv_dirname() works fine with blkdebug
>  IMGOPTS="subformat=monolithicFlat" _make_test_img 64M
> -$QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.image.filename=$TEST_IMG,file.inject-error.0.event=read_aio" 2>&1 \
> -    | _filter_testdir | _filter_imgfmt
> +$QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.image.filename=$TEST_IMG,file.inject-error.0.event=read_aio" \
> +         -c info \
> +    2>&1 \
> +    | _filter_testdir | _filter_imgfmt | _filter_img_info
>  _cleanup_test_img
>  
>  echo
> diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
> index 77d8984428..120cddd207 100644
> --- a/tests/qemu-iotests/059.out
> +++ b/tests/qemu-iotests/059.out
> @@ -2050,7 +2050,9 @@ wrote 512/512 bytes at offset 10240
>  
>  === Testing monolithicFlat with internally generated JSON file name ===
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> -qemu-io: can't open: Cannot use relative extent paths with VMDK descriptor file 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "inject-error.0.event": "read_aio"}'
> +format name: IMGFMT
> +cluster size: 0 bytes
> +vm state offset: 0 bytes
>  
>  === Testing version 3 ===
>  image: TEST_DIR/iotest-version3.IMGFMT
> 



