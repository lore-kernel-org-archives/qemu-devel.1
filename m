Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349E2C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F4D24653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="lpZPOQKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F4D24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituXA-0002bH-OG
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1ittEx-00067w-2O
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1ittEv-0000Yd-KC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:06:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1ittEv-0000Xk-79
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:06:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so3073781wro.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 05:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version:content-transfer-encoding;
 bh=X6IpToNerzxu/UmHRFFFZS33bFkAzW7a5xSrf8XB9Rs=;
 b=lpZPOQKItAHcba3s3sl7iOSwsN+UXgtBjLML3/+gY7uqdunLXkq0loj4PHmqeelV7D
 Za/YDnwDdiFS4hQaJaYl/vInVlX63OpGjerPrkGAmWfuzjC/99ikNY7OFI2FCIsaYfpd
 xq37Fk5YcP0KGiybyn0dozD19xuvEUBuPg1vigs7dMZ6y076VOXd7xC5f6ZcWiEPAgBm
 2O/y6E4pQPRALDy8rJ+5gRIjjIWBM6GR8hRrbPUwqUNf2yQHYTh0RIYp8JIMTSSK7pVY
 k3gyhk6/1hVqEtUnW+zGaa57lzRcYVgS/VuiKQ06oXuN7vdm0nF+fbLJedqe2cW2qm8B
 0oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version:content-transfer-encoding;
 bh=X6IpToNerzxu/UmHRFFFZS33bFkAzW7a5xSrf8XB9Rs=;
 b=DKwd5jLwUOnDtYODSgOhKT+ML9gUdGjYs3Y40IZqHl3TIMqFBrjUAg7WTPRkH176XS
 eQJH1VoqEMXVFieqW0hIR7r6MMeCudyDFj49AUMKkLS7IS9y75aILueIcFoV8Nf1r7VS
 zQj8srkhLIHMBJMtgSAx/oDfbRmnOyu/LGpAsuLnnMKysb5IUvgr8PXSdous7ZV6liWb
 0oRNJaAoXlDeXpFlJJQAEqQbItNvlYkvLYJZk5iJekoAFNRNPN7kOywA/VbX8IP3loc5
 yIQLPvh2RUegkpXVsy5dz4e4KcTPZ9KkzQFjvWnMOQKDoVJeMH4LB/CUuI0ANZOT1hfb
 KVpA==
X-Gm-Message-State: APjAAAWwctyV0usfz3zYh5DPVy7Pwf+5B9k0JJ/gGM/orax6Jcw3ozU9
 yoO9zt7SMLxeqa9d6hAIwzFADw==
X-Google-Smtp-Source: APXvYqxVVE8658QmN36ateJITM2hoXE091Euy75WtdeLUarwoV09TN5dGvP/RSVnJnI+dwPhyysRKQ==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr4931583wrr.138.1579611999713; 
 Tue, 21 Jan 2020 05:06:39 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [81.149.164.25])
 by smtp.gmail.com with ESMTPSA id t8sm52464016wrp.69.2020.01.21.05.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 05:06:38 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 1fe2b62a;
 Tue, 21 Jan 2020 13:06:38 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-img: Add --target-is-zero to convert
In-Reply-To: <8382f271-ef06-edf4-c641-bc6cc1b3c25d@redhat.com>
References: <id:m21rryz8al.fsf@dme.org>
 <20200117103434.1363985-1-david.edmondson@oracle.com>
 <8382f271-ef06-edf4-c641-bc6cc1b3c25d@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Tue, 21 Jan 2020 13:06:38 +0000
Message-ID: <m2ftg9vu01.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-01-20 at 19:33:43 -05, John Snow wrote:

> CC qemu-block and block maintainers
>
> On 1/17/20 5:34 AM, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>>=20
>
> Is there no way to convince bdrv_has_zero_init to return what we want
> already in this case?

In the current HEAD code, bdrv_has_zero_init will never be called for
=E2=80=9Cconvert -n=E2=80=9D (skip target volume creation).

If -n is not specified the host_device block driver doesn't provide a
bdrv_has_zero_init function, so it's assumed not supported.

> I cannot recall off hand, but wonder if there's an advanced syntax
> method of specifying the target image that can set this flag already.

I couldn't see one, but I'd be happy to learn of its existence. My first
approach was to add a raw specific option and add it using
--target-image-opts, resulting in something like:

qemu-img convert -n --target-image-opts sparse.qcow2 \
	driver=3Draw,file.filename=3D/dev/sdg,assume-blank=3Don

(assume-blank=3Don is the new bit). This worked, but is only useful for
raw targets.

The discussion here led me to switch to --target-is-zero.

Mark Kanda sent me some comments suggesting that I get rid of the new
target_is_zero boolean and simply set has_zero_init, which I will do
before sending out another patch if this overall approach is considered
appropriate.

>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
>> ---
>>  qemu-img.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 95a24b9762..56ca727e8c 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -70,6 +70,7 @@ enum {
>>      OPTION_PREALLOCATION =3D 265,
>>      OPTION_SHRINK =3D 266,
>>      OPTION_SALVAGE =3D 267,
>> +    OPTION_TARGET_IS_ZERO =3D 268,
>>  };
>>=20=20
>>  typedef enum OutputFormat {
>> @@ -1593,6 +1594,7 @@ typedef struct ImgConvertState {
>>      bool copy_range;
>>      bool salvage;
>>      bool quiet;
>> +    bool target_is_zero;
>>      int min_sparse;
>>      int alignment;
>>      size_t cluster_sectors;
>> @@ -1984,10 +1986,11 @@ static int convert_do_copy(ImgConvertState *s)
>>      int64_t sector_num =3D 0;
>>=20=20
>>      /* Check whether we have zero initialisation or can get it efficien=
tly */
>> -    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
>> +    s->has_zero_init =3D s->target_is_zero;
>> +
>> +    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
>> +        !s->target_has_backing) {
>>          s->has_zero_init =3D bdrv_has_zero_init(blk_bs(s->target));
>> -    } else {
>> -        s->has_zero_init =3D false;
>>      }
>>=20=20
>>      if (!s->has_zero_init && !s->target_has_backing &&
>> @@ -2076,6 +2079,7 @@ static int img_convert(int argc, char **argv)
>>          .buf_sectors        =3D IO_BUF_SIZE / BDRV_SECTOR_SIZE,
>>          .wr_in_order        =3D true,
>>          .num_coroutines     =3D 8,
>> +        .target_is_zero     =3D false,
>>      };
>>=20=20
>>      for(;;) {
>> @@ -2086,6 +2090,7 @@ static int img_convert(int argc, char **argv)
>>              {"force-share", no_argument, 0, 'U'},
>>              {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_O=
PTS},
>>              {"salvage", no_argument, 0, OPTION_SALVAGE},
>> +            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
>>              {0, 0, 0, 0}
>>          };
>>          c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
>> @@ -2209,6 +2214,9 @@ static int img_convert(int argc, char **argv)
>>          case OPTION_TARGET_IMAGE_OPTS:
>>              tgt_image_opts =3D true;
>>              break;
>> +        case OPTION_TARGET_IS_ZERO:
>> +            s.target_is_zero =3D true;
>> +            break;
>>          }
>>      }
>>=20=20
>> @@ -2247,6 +2255,11 @@ static int img_convert(int argc, char **argv)
>>          warn_report("This will become an error in future QEMU versions.=
");
>>      }
>>=20=20
>> +    if (s.target_is_zero && !skip_create) {
>> +        error_report("--target-is-zero requires use of -n flag");
>> +        goto fail_getopt;
>> +    }
>> +
>>      s.src_num =3D argc - optind - 1;
>>      out_filename =3D s.src_num >=3D 1 ? argv[argc - 1] : NULL;
>>=20=20
>>=20

dme.
--=20
Please forgive me if I act a little strange, for I know not what I do.

