Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D1FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174A720737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD43VrQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174A720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jieki-00062O-CM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 09:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilikernel@gmail.com>)
 id 1jiek3-0005KN-SD; Tue, 09 Jun 2020 09:56:39 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:34072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yilikernel@gmail.com>)
 id 1jiek2-0004vh-H1; Tue, 09 Jun 2020 09:56:39 -0400
Received: by mail-yb1-xb43.google.com with SMTP id a80so11188969ybg.1;
 Tue, 09 Jun 2020 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=9YMnDdpKsduebgZ2lngAW8BLab3cBligQWUSvmEo8Rw=;
 b=jD43VrQLLxQefnUFmquE826io8nE6qzZgpDeBjVzRCUHBQ6OuS9O6cWlf2LAKENlOF
 2otv9B1Gjf440UezmGsd6WCWsNM/HqIjIh6BcjFCkhuSmOopv4y/9QY07M0DIieHnfJY
 D9EDZSOYnnOPP/6NhQhD6pNJbPIeAegUNWm8aMhjU4H7z2vPl3tazcuob8OR108Dpjur
 UBYw4Nkss6eHCuiQvU/kVwf0Y37fl2OsSWTQ1CWZ00cyPMTJEFjrM++bukE6CDOxa8Ct
 FHqtR4WN/SN2AoNb1U2abb+JYyhkNThvOy3CU/zafvzv2IO2Zed+YwRPLwpXV7Axby0r
 T6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=9YMnDdpKsduebgZ2lngAW8BLab3cBligQWUSvmEo8Rw=;
 b=aZoS6gXsQt9jH4pV/j4j2atMptfIk3DjqoxS6QUaWSbyKU166ZJpHcCckrIqZ6RndY
 2AbdIEsb7S00ZUnYAb58FiPFWD3l2nWe+gpmyow5leLWdviWkCaErrEXSVCUS7zym3dM
 XcfXuQvlWYCF8kumPf7Kyr/8s2k83xvrqRFkV5/jhJ/OVhnxaT3pa0YMXdnqJ7w+yOYL
 aAMxoHRaXHR3FwACHSKD+bbkT2d9GNMzYBXZuZk2wxvUEXsw0nCFkx5iUeQ8ABbWFOrr
 yAXlM+YXYFnt9/tJO3fuU6kBw04RvVtY1VJtd5Q1OLON4ytWyXuPrQPv8Qd++W/koMGO
 eTUA==
X-Gm-Message-State: AOAM531yDGYX+Q5wTVJKCfQtf9RHGQbt5BSEeSBnZEp2zUb5BehrPJsQ
 PjzsuFoJY3fl8KODw1Mk8gnRkYFDjQ4skYLtUkU=
X-Google-Smtp-Source: ABdhPJxU8OW9wk3q0lE9CvdTak+NbPykj/cOiQ0uMSuF1VQk60FLjbkh40Hz0LyGyiqwo0IDfcdCOMKfgX1Sh6tVX9s=
X-Received: by 2002:a25:c1c5:: with SMTP id r188mr6426893ybf.240.1591710997122; 
 Tue, 09 Jun 2020 06:56:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:3ca:0:0:0:0:0 with HTTP;
 Tue, 9 Jun 2020 06:56:35 -0700 (PDT)
In-Reply-To: <CA+aFP1C-BvFM+9OTvaLD0aGramXF3+dO3pJiU5xTALTC54YTyQ@mail.gmail.com>
References: <20200609073001.3668811-1-yili@winhong.com>
 <CA+aFP1C-BvFM+9OTvaLD0aGramXF3+dO3pJiU5xTALTC54YTyQ@mail.gmail.com>
From: =?UTF-8?B?5p2O5LmJ?= <yilikernel@gmail.com>
Date: Tue, 9 Jun 2020 21:56:35 +0800
Message-ID: <CAJfdMYCS7SJ66K2F7a9qyKyP9f1Tmbe9N7qvshNe6jAZZtpWBg@mail.gmail.com>
Subject: Re: [PATCH] rbd: Use RBD fast-diff for querying actual allocation
To: dillaman@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=yilikernel@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf <kwolf@redhat.com>, =?UTF-8?B?5p2O5LmJ?= <yilikernel@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 mreitz <mreitz@redhat.com>, Yi Li <yili@winhong.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20, Jason Dillaman <jdillama@redhat.com> wrote:
> On Tue, Jun 9, 2020 at 3:31 AM Yi Li <yili@winhong.com> wrote:
>>
>> Since Ceph version Infernalis (9.2.0) the new fast-diff mechanism
>> of RBD allows for querying actual rbd image usage.
>>
>> Prior to this version there was no easy and fast way to query how
>> much allocation a RBD image had inside a Ceph cluster.
>>
>> To use the fast-diff feature it needs to be enabled per RBD image
>> and is only supported by Ceph cluster running version Infernalis
>> (9.2.0) or newer.
>>
>> Without the fast-diff feature enabled qemu-img will report an allocation
>> identical to the image capacity.
>>
>> 'qemu-img info rbd:cepharm/liyi-rbd' might output for example:
>>
>>   image: json:{"driver": "raw", "file": {"pool": "cepharm",
>>   "image": "liyi-rbd", "driver": "rbd"}}
>>   file format: raw
>>   virtual size: 20 GiB (21474836480 bytes)
>>   disk size: 0 B
>>   cluster_size: 4194304
>>
>> Newly created rbds will have the fast-diff feature enabled.
>>
>> Signed-off-by: Yi Li <yili@winhong.com>
>> ---
>>  block/rbd.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>
>> diff --git a/block/rbd.c b/block/rbd.c
>> index 617553b022..f231653f7b 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -1107,6 +1107,65 @@ static int64_t qemu_rbd_getlength(BlockDriverState
>> *bs)
>>      return info.size;
>>  }
>>
>> +#if LIBRBD_VERSION_CODE > 265
>> +static int disk_usage_callback(uint64_t offset, size_t len, int exists,
>> +                               void *arg)
>> +{
>> +  uint64_t *used_size = (uint64_t *)(arg);
>> +  if (exists) {
>> +    (*used_size) += len;
>> +  }
>> +  return 0;
>> +}
>> +#endif
>> +
>> +static int64_t qemu_rbd_allocated_file_size(BlockDriverState *bs)
>> +{
>> +    BDRVRBDState *s = bs->opaque;
>> +    rbd_image_info_t info;
>> +    int r;
>> +    uint64_t used_size = 0;
>> +    uint64_t features = 0;
>> +
>> +    r = rbd_stat(s->image, &info, sizeof(info));
>> +    if (r < 0) {
>> +        return r;
>> +    }
>> +
>> +    r = rbd_get_features(s->image, &features);
>> +    if (r < 0) {
>> +        return r;
>> +    }
>
> You should probably test the flags to ensure that the
> RBD_FLAG_FAST_DIFF_INVALID flag is not set [1]. It's potentially very
> slow and expensive to calculate the disk usage w/o a fast-diff (on
> large images) since it requires iterating over every possible 4MiB
> backing data object (by default) to query its actual usage.
>

Thanks for your review and remind me of this issue.

>> +   /*
>> +    * rbd_diff_iterate2() is available in versions above Ceph 0.94
>> (Hammer)
>> +    * It uses a object map inside Ceph which is faster than
>> rbd_diff_iterate()
>> +    * which iterates all objects.
>> +    * LIBRBD_VERSION_CODE for Ceph 0.94 is 265. In 266 and upwards
>> diff_iterate2
>> +    * is available
>> +    */
>> +#if LIBRBD_VERSION_CODE > 265
>> +    if (features & RBD_FEATURE_FAST_DIFF) {
>> +
>> +        /*
>> +         * RBD image fast-diff feature enabled
>> +         * Querying for actual allocation.
>> +         */
>> +        r = rbd_diff_iterate2(s->image, NULL, 0, info.size, 0, 1,
>> +                              &disk_usage_callback,
>> +                              &used_size);
>> +        if (r < 0) {
>> +            return r;
>> +        }
>> +    } else {
>> +        used_size = info.size;
>> +    }
>> +#else
>> +    used_size = info.size;
>> +#endif
>> +    return used_size;
>> +}
>> +
>>  static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>>                                               int64_t offset,
>>                                               bool exact,
>> @@ -1316,6 +1375,7 @@ static BlockDriver bdrv_rbd = {
>>      .bdrv_get_info          = qemu_rbd_getinfo,
>>      .create_opts            = &qemu_rbd_create_opts,
>>      .bdrv_getlength         = qemu_rbd_getlength,
>> +    .bdrv_get_allocated_file_size = qemu_rbd_allocated_file_size,
>>      .bdrv_co_truncate       = qemu_rbd_co_truncate,
>>      .protocol_name          = "rbd",
>>
>> --
>> 2.25.3
>>
>>
>>
>>
>
> [1]
> https://github.com/libvirt/libvirt/commit/21deeaf02fdf216b08210fc899579736973ca81d#diff-107c5451015e5980c90048ff615becb8
>
> --
> Jason
>
>

