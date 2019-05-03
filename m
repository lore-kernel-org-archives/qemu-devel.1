Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2859DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22C32070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22C32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWfy-00014p-6P
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:48:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMWSO-0005QT-KU
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMWSN-0008WH-Hw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:34:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hMWSK-0008Tk-2l; Fri, 03 May 2019 07:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3D4A308302F;
	Fri,  3 May 2019 11:34:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-70.ams2.redhat.com [10.36.116.70])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF27D608F6;
	Fri,  3 May 2019 11:34:15 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
	mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	fam@euphon.net, eblake@redhat.com
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
	<20190502130822.46858-1-shmuel.eiderman@oracle.com>
	<20190502130822.46858-2-shmuel.eiderman@oracle.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
Date: Fri, 3 May 2019 13:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502130822.46858-2-shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 03 May 2019 11:34:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to
 vmdk
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
Cc: arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503113414.xZtbqageVNTx5hAY0raolHZ0V356o2sJCiO_e50XtUI@z>

 Hi Sam,

On 02/05/2019 15.08, Sam Eiderman wrote:
> Commit b69864e ("vmdk: Support version=3 in VMDK descriptor files")
> fixed the probe function to correctly guess vmdk descriptors with
> version=3.
> 
> This solves the issue where vmdk snapshot with parent vmdk descriptor
> containing "version=3" would be treated as raw instead vmdk.
> 
> In the future case where a new vmdk version is introduced, we will again
> experience this issue, even if the user will provide "-f vmdk" it will
> only apply to the tip image and not to the underlying "misprobed" parent
> image.
> 
> The code in vmdk.c already assumes that the backing file of vmdk must be
> vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
> vmdk).
> 
> So let's make it official by supplying the backing_format as vmdk.
> 
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> Reviewed-By: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
> ---
>  block/vmdk.c           | 2 ++
>  tests/qemu-iotests/110 | 6 +++---
>  tests/qemu-iotests/126 | 4 ++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 8dec6ef767..de8cb859f8 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState *bs)
>          pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name);
>          pstrcpy(bs->backing_file, sizeof(bs->backing_file),
>                  bs->auto_backing_file);
> +        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
> +                "vmdk");
>      }

Your patch with this change has already been merged into the QEMU master
branch...

> diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
> index fad672c1ae..982569dbc5 100755
> --- a/tests/qemu-iotests/110
> +++ b/tests/qemu-iotests/110
> @@ -54,7 +54,7 @@ _make_test_img -b "$TEST_IMG_REL.base" 64M
>  # qemu should be able to reconstruct the filename, so relative backing names
>  # should work
>  TEST_IMG="json:{'driver':'$IMGFMT','file':{'driver':'file','filename':'$TEST_IMG'}}" \
> -    _img_info | _filter_img_info
> +    _img_info | _filter_img_info | grep -v "backing file format"
>  
>  echo
>  echo '=== Non-reconstructable filename ==='
> @@ -78,7 +78,7 @@ TEST_IMG="json:{
>              }
>          ]
>      }
> -}" _img_info | _filter_img_info
> +}" _img_info | _filter_img_info | grep -v "backing file format"
>  
>  echo
>  echo '=== Backing name is always relative to the backed image ==='
> @@ -110,7 +110,7 @@ TEST_IMG="json:{
>              }
>          ]
>      }
> -}" _img_info | _filter_img_info
> +}" _img_info | _filter_img_info | grep -v "backing file format"
>  
>  
>  # success, all done
> diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
> index 96dc048d59..1f7618c8a5 100755
> --- a/tests/qemu-iotests/126
> +++ b/tests/qemu-iotests/126
> @@ -63,7 +63,7 @@ TEST_IMG=$BASE_IMG _make_test_img 64M
>  TEST_IMG=$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
>  
>  # The default cluster size depends on the image format
> -TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size'
> +TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size\|backing file format'
>  
>  _rm_test_img "$BASE_IMG"
>  _rm_test_img "$TOP_IMG"
> @@ -79,7 +79,7 @@ TOP_IMG="file:image:top.$IMGFMT"
>  TEST_IMG=$BASE_IMG _make_test_img 64M
>  TEST_IMG=$TOP_IMG _make_test_img -b "$BASE_IMG"
>  
> -TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size'
> +TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size\|backing file format'
>  
>  _rm_test_img "$BASE_IMG"
>  _rm_test_img "image:top.$IMGFMT"
> 

... so please just send a patch with these fixes!

 Thanks,
  Thomas

